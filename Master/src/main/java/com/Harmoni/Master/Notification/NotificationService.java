package com.Harmoni.Master.Notification;

import com.Harmoni.Master.Entity.Notification;

import java.util.List;

public interface NotificationService {
    void notify(Long userId, String message, String type, Long eventId);
    List<Notification> getAll(Long userId);
    List<Notification> getUnread(Long userId);
    long countUnread(Long userId);
    void markRead(Long notificationId);
    void markAllRead(Long userId);
}
