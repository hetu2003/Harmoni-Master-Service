package com.Harmoni.Master.config;

import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.UserRepository;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
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

    private final UserRepository userRepository;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain chain) throws ServletException, IOException {

        String username = request.getHeader("X-User-Name");

        if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            String grantedRole = "ROLE_WORKHAND";
            try {
                Users user = userRepository.findByUsernameWithRole(username).orElse(null);
                if (user != null && user.getRole() != null) {
                    grantedRole = "ROLE_" + user.getRole().getRoleName().toUpperCase();
                }
            } catch (Exception ignored) {}

            UserDetails userDetails = new User(username, "",
                    Collections.singletonList(new SimpleGrantedAuthority(grantedRole)));

            UsernamePasswordAuthenticationToken auth =
                    new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(auth);
        }

        chain.doFilter(request, response);
    }
}
