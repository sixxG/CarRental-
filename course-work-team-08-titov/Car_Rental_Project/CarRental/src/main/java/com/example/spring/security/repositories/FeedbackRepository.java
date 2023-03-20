package com.example.spring.security.repositories;

import com.example.spring.security.models.Feedback;
import com.example.spring.security.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FeedbackRepository extends JpaRepository<Feedback, Integer> {
    Feedback findByScore(int score);

    Feedback findById(int id);

    Feedback findByAuthor(String author);
}
