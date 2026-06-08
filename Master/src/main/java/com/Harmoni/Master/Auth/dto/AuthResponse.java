package com.Harmoni.Master.Auth.dto;

// This class represents the JSON response we expect from the Auth microservice.
public class AuthResponse {
    private String token;
    private String email;
    private String userId;

    public AuthResponse() {}

    // Getters and Setters
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}
