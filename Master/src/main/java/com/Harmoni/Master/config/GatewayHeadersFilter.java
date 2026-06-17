package com.Harmoni.Master.config;

import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.UserRepository;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Collections;

@Component
@RequiredArgsConstructor
public class GatewayHeadersFilter extends OncePerRequestFilter {

    private static final Logger logger = LoggerFactory.getLogger(GatewayHeadersFilter.class);

    private final UserRepository userRepository;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain chain) throws ServletException, IOException {

        String username = request.getHeader("X-User-Name");
        String path     = request.getRequestURI();

        // --- Log every request so we can trace auth state in the logs ---
        HttpSession existingSession = request.getSession(false);
        Object sessionUserId = existingSession != null ? existingSession.getAttribute("userId") : null;
        logger.debug("[MASTER-AUTH] path={} X-User-Name={} session_userId={}",
                path, username != null ? username : "none", sessionUserId != null ? sessionUserId : "MISSING");

        if (username != null) {
            Users user = null;

            // ── Spring Security context ──────────────────────────────────────
            if (SecurityContextHolder.getContext().getAuthentication() == null) {
                String grantedRole = "ROLE_WORKHAND";
                try {
                    user = userRepository.findByUsername(username).orElse(null);
                    if (user != null && user.getRoleId() != null) {
                        switch (user.getRoleId()) {
                            case 2: grantedRole = "ROLE_COMPANY"; break;
                            case 3: grantedRole = "ROLE_ADMIN";   break;
                            default: grantedRole = "ROLE_WORKHAND"; break;
                        }
                    }
                } catch (Exception e) {
                    logger.warn("[MASTER-AUTH] Could not resolve role for '{}': {}", username, e.getMessage());
                }

                UserDetails userDetails = new User(username, "",
                        Collections.singletonList(new SimpleGrantedAuthority(grantedRole)));
                UsernamePasswordAuthenticationToken auth =
                        new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                SecurityContextHolder.getContext().setAuthentication(auth);
            }

            // ── Session re-hydration ─────────────────────────────────────────
            // JWT was valid (Gateway forwarded X-User-Name), but the session may be
            // empty because the server restarted or the 8-hour inactivity timeout fired.
            // Re-populate from DB so controllers and GlobalModelAdvice work correctly.
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                try {
                    if (user == null) {
                        user = userRepository.findByUsername(username).orElse(null);
                    }
                    if (user != null) {
                        HttpSession activeSession = request.getSession(true);
                        activeSession.setAttribute("userId",    user.getUserId());
                        activeSession.setAttribute("userEmail", user.getEmail());
                        // Use the JWT cookie as the token — it was already validated by the Gateway
                        String jwt = extractCookie(request, "jwt_token");
                        activeSession.setAttribute("userToken", jwt != null ? jwt : "rehydrated");
                        logger.info("[MASTER-AUTH] SESSION REHYDRATED path={} username={} userId={}",
                                path, username, user.getUserId());
                    }
                } catch (Exception e) {
                    logger.warn("[MASTER-AUTH] Session rehydration failed for '{}': {}", username, e.getMessage());
                }
            }
        }

        chain.doFilter(request, response);
    }

    private String extractCookie(HttpServletRequest request, String name) {
        if (request.getCookies() == null) return null;
        for (Cookie c : request.getCookies()) {
            if (name.equals(c.getName())) return c.getValue();
        }
        return null;
    }
}
