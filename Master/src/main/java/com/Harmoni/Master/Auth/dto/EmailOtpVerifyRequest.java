package com.Harmoni.Master.Auth.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EmailOtpVerifyRequest {
    private String email;
    private String otp;
}
