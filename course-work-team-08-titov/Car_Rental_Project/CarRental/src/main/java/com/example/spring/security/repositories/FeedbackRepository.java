package com.example.spring.security.repositories;

import com.example.spring.security.models.Feedback;
import com.example.spring.security.models.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FeedbackRepository extends JpaRepository<Feedback, Integer> {
    Feedback findByScore(int score);

    Feedback findById(int id);

    Feedback findByAuthor(String author);

    Page<Feedback> findAllByOrderByScoreDesc(Pageable pageable);
    Page<Feedback> findAllByOrderByScoreAsc(Pageable pageable);
    Page<Feedback> findAllByOrderByDateDesc(Pageable pageable);

    //reports
    @Query("SELECT COUNT(f) FROM Feedback f WHERE f.score >= 4")
    Long countPositiveFeedbacks();
    @Query("SELECT COUNT(f) FROM Feedback f WHERE f.score < 4")
    Long countNegativeFeedbacks();
}
