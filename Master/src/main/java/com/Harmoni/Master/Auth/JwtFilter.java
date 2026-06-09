package com.Harmoni.Master.Auth;

import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.UserRepository;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Collections;

@Component
@RequiredArgsConstructor
public class JwtFilter extends OncePerRequestFilter {

    @Value("${jwt.secret}")
    private String secretKey;

    private final UserRepository userRepository;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String jwt = null;
        String username = null;

        if (session != null) {
            jwt = (String) session.getAttribute("userToken");
        }

        if (jwt != null) {
            try {
                Claims claims = Jwts.parser()
                        .verifyWith(Keys.hmacShaKeyFor(secretKey.getBytes(StandardCharsets.UTF_8)))
                        .build()
                        .parseSignedClaims(jwt)
                        .getPayload();
                username = claims.getSubject();
            } catch (Exception e) {
                if (session != null) session.invalidate();
            }
        }

        if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            // Load user from DB to get real role
            String grantedRole = "ROLE_WORKHAND"; // default
            try {
                Users user = userRepository.findByUsername(username).orElse(null);
                if (user != null && user.getRole() != null) {
                    String roleName = user.getRole().getRoleName().toUpperCase();
                    grantedRole = "ROLE_" + roleName;
                }
            } catch (Exception ignored) {}

            UserDetails userDetails = new User(username, "",
                    Collections.singletonList(new SimpleGrantedAuthority(grantedRole)));

            UsernamePasswordAuthenticationToken auth =
                    new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(auth);
        }

        filterChain.doFilter(request, response);
    }
}
