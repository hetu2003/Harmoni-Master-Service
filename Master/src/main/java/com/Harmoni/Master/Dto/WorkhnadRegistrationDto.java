package com.Harmoni.Master.Dto;

import com.Harmoni.Master.Entity.EventWorkhand;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;

@Data
@AllArgsConstructor
public class WorkhnadRegistrationDto {
    private Long registrationId;
    private Users workhand;
    private EventWorkhand eventWorkhand;
    private Events event;
    private LocalDate registrationDate;
    private boolean registrationStatus;
    private boolean paymentStatus;
    private Integer rating;
    private String applicationStatus;
}
