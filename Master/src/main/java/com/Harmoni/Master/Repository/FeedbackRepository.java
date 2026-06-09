package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Feedback;
import com.Harmoni.Master.Entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface FeedbackRepository extends JpaRepository<Feedback, Long> {

    List<Feedback> findByEvent(Events event);

    // Check if a workhand already gave feedback for an event
    List<Feedback> findByEventAndWorkhand(Events event, Users workhand);

    // All feedbacks by a workhand (for history page)
    List<Feedback> findByWorkhand(Users workhand);
}
