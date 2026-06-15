package com.Harmoni.Master.config;

import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.UserRepository;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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

        if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            String grantedRole = "ROLE_WORKHAND";
            try {
                Users user = userRepository.findByUsername(username).orElse(null);
                if (user != null && user.getRoleId() != null) {
                    switch (user.getRoleId()) {
                        case 2: grantedRole = "ROLE_COMPANY"; break;
                        case 3: grantedRole = "ROLE_ADMIN";   break;
                        default: grantedRole = "ROLE_WORKHAND"; break;
                    }
                }
            } catch (Exception e) {
                logger.warn("Could not resolve role for user '{}': {}", username, e.getMessage());
            }

            UserDetails userDetails = new User(username, "",
                    Collections.singletonList(new SimpleGrantedAuthority(grantedRole)));

            UsernamePasswordAuthenticationToken auth =
                    new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(auth);
        }

        chain.doFilter(request, response);
    }
}
