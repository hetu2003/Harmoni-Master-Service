package com.Harmoni.Master.Entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "notifications")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "notification_id")
    private Long notificationId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "message", nullable = false, length = 500)
    private String message;

    @Column(name = "type", length = 50)
    private String type; // REGISTRATION, APPROVAL, REJECTION, PAYMENT, INFO

    @Column(name = "event_id")
    private Long eventId;

    @Builder.Default
    @Column(name = "is_read", nullable = false)
    private boolean read = false;

    @Builder.Default
    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();
}
