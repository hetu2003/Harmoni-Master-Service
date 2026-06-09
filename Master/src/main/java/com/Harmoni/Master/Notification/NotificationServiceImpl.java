package com.Harmoni.Master.Notification;

import com.Harmoni.Master.Entity.Notification;
import com.Harmoni.Master.Repository.NotificationRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService {

    private final NotificationRepository notificationRepo;

    @Override
    public void notify(Long userId, String message, String type, Long eventId) {
        Notification n = Notification.builder()
                .userId(userId)
                .message(message)
                .type(type)
                .eventId(eventId)
                .build();
        notificationRepo.save(n);
    }

    @Override
    public List<Notification> getAll(Long userId) {
        return notificationRepo.findByUserIdOrderByCreatedAtDesc(userId);
    }

    @Override
    public List<Notification> getUnread(Long userId) {
        return notificationRepo.findByUserIdAndReadFalseOrderByCreatedAtDesc(userId);
    }

    @Override
    public long countUnread(Long userId) {
        return notificationRepo.countByUserIdAndReadFalse(userId);
    }

    @Override
    @Transactional
    public void markRead(Long notificationId) {
        notificationRepo.findById(notificationId).ifPresent(n -> {
            n.setRead(true);
            notificationRepo.save(n);
        });
    }

    @Override
    @Transactional
    public void markAllRead(Long userId) {
        notificationRepo.markAllReadForUser(userId);
    }
}
