package com.Harmoni.Master.Auth;

import com.Harmoni.Master.Auth.client.AuthClient;
import com.Harmoni.Master.Auth.dto.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import feign.FeignException;

import java.io.IOException;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    private AuthClient authClient;
    
    private final RestTemplate restTemplate = new RestTemplate();

    @Override
    public AuthResponse login(String username, String password, HttpSession session) {
        LoginRequest loginRequest = new LoginRequest(username, password);

        try {
            AuthResponse authResponse = authClient.loginLocal(loginRequest);

            if (authResponse != null && authResponse.getToken() != null) {
                session.setAttribute("userToken", authResponse.getToken());
                session.setAttribute("userEmail", authResponse.getEmail());
                session.setAttribute("userId", authResponse.getUserId());
                return authResponse;
            }
        } catch (FeignException e) {
            System.err.println("Login failed: " + e.status() + " " + e.getMessage());
            return null;
        }
        return null;
    }

    @Override
    public AuthResponse loginWithGoogle(String idToken, HttpSession session) {
        GoogleLoginRequest googleLoginRequest = new GoogleLoginRequest(idToken);
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<GoogleLoginRequest> requestEntity = new HttpEntity<>(googleLoginRequest, headers);

            ResponseEntity<AuthResponse> response = restTemplate.postForEntity("http://localhost:8081/auth/login/google", requestEntity, AuthResponse.class);
            AuthResponse authResponse = response.getBody();

            if (authResponse != null && authResponse.getToken() != null) {
                session.setAttribute("userToken", authResponse.getToken());
                session.setAttribute("userEmail", authResponse.getEmail());
                session.setAttribute("userId", authResponse.getUserId());
                return authResponse;
            }
        } catch (HttpClientErrorException e) {
            System.err.println("Google login failed: " + e.getStatusCode() + " " + e.getResponseBodyAsString());
            return null;
        }
        return null;
    }

    @Override
    public String register(RegistrationRequest registrationRequest, MultipartFile profilePhoto) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.MULTIPART_FORM_DATA);

            MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
            body.add("roleId", registrationRequest.getRoleId());
            body.add("username", registrationRequest.getUsername());
            body.add("firstName", registrationRequest.getFirstName());
            body.add("lastName", registrationRequest.getLastName());
            body.add("email", registrationRequest.getEmail());
            body.add("contactNumber", registrationRequest.getContactNumber());
            body.add("streetAddress", registrationRequest.getStreetAddress());
            body.add("stateId", registrationRequest.getStateId());
            body.add("cityId", registrationRequest.getCityId());
            if (registrationRequest.getSpecialCategory() != null) {
                body.add("specialCategory", registrationRequest.getSpecialCategory());
            }

            if (profilePhoto != null && !profilePhoto.isEmpty()) {
                ByteArrayResource fileAsResource = new ByteArrayResource(profilePhoto.getBytes()) {
                    @Override
                    public String getFilename() {
                        return profilePhoto.getOriginalFilename();
                    }
                };
                body.add("profilePhoto", fileAsResource);
            }

            HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
            
            ResponseEntity<String> response = restTemplate.postForEntity("http://localhost:8081/auth/register", requestEntity, String.class);
            return response.getBody();
            
        } catch (HttpClientErrorException e) {
            System.err.println("Registration failed: " + e.getStatusCode() + " " + e.getResponseBodyAsString());
            return e.getResponseBodyAsString();
        } catch (IOException e) {
            return "Failed to process profile photo.";
        }
    }

    @Override
    public String processForgotPassword(ForgotPasswordRequest request) {
        try {
            return authClient.forgotPassword(request);
        } catch (FeignException e) {
            System.err.println("Forgot password failed: " + e.status() + " " + e.getMessage());
            return "Failed to process request.";
        }
    }

    @Override
    public String processResetPassword(ResetPasswordRequest request) {
        try {
            return authClient.resetPassword(request);
        } catch (FeignException e) {
            System.err.println("Reset password failed: " + e.status() + " " + e.getMessage());
            return "Failed to reset password.";
        }
    }

    @Override
    public String changePassword(ChangePasswordRequest request) {
        try {
            return authClient.changePassword(request);
        } catch (FeignException e) {
            System.err.println("Change password failed: " + e.status() + " " + e.getMessage());
            return "Failed to change password.";
        }
    }
}
