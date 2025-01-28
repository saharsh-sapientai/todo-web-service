package com.bmuschko.todo.webservice.repository;

import com.bmuschko.todo.webservice.model.ToDoItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface ToDoRepository extends JpaRepository<ToDoItem, Long> {
    // 1. SELECT * query - converted to JPQL
    @Query("SELECT t FROM ToDoItem t")
    List<ToDoItem> findAllWithDetails();

    // 2. Explicit column selection - using projection interface
    interface ToDoBasicDetails {
        Long getId();
        String getName();
        boolean isCompleted();
    }
    @Query("SELECT t FROM ToDoItem t")
    List<ToDoBasicDetails> findAllBasicDetails();

    // 3. Complex selection with computed fields - using projection interface
    interface ToDoComputedDetails {
        Long getId();
        String getName();
        boolean isCompleted();
        String getStatus();
        Integer getNameLength();
        String getFullDescription();
    }
    @Query("SELECT new map(" +
            "t.id as id, " +
            "t.name as name, " +
            "t.completed as completed, " +
            "CASE WHEN t.completed = true THEN 'Done' ELSE 'Pending' END as status, " +
            "FUNCTION('LENGTH', t.name) as nameLength, " +
            "CONCAT(t.name, ' (', CASE WHEN t.completed = true THEN 'Done' ELSE 'Pending' END, ')') as fullDescription) " +
            "FROM ToDoItem t")
    List<ToDoComputedDetails> findAllWithComputedFields();
}