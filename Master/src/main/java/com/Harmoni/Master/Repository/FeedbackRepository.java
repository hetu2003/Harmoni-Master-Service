package com.Harmoni.Master.Repository;

import com.Harmoni.Master.Entity.Feedback;
import com.Harmoni.Master.Entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface FeedbackRepository extends JpaRepository<Feedback, Long> {

    /** Feedbacks for a given event (by raw integer event_id). */
    List<Feedback> findByEvent(Integer eventId);

    /** Check if a workhand already gave feedback for an event. */
    List<Feedback> findByEventAndWorkhnadId(Integer eventId, Integer workhnadId);

    /** All feedbacks submitted by a workhand (history page).
     *  Uses the @ManyToOne Users workhand navigation field. */
    List<Feedback> findByWorkhand(Users workhand);
}
