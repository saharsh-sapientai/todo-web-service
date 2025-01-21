package com.bmuschko.todo.webservice.repository;

import com.bmuschko.todo.webservice.model.ToDoItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Map;


public interface ToDoRepository extends JpaRepository<ToDoItem, Long> {
    // 1. SELECT * query
    @Query(value = "SELECT * FROM todo_item", nativeQuery = true)
    List<Map<String, Object>> findAllWithDetails();

    // 2. Explicit column selection
    @Query(value = "SELECT id, name, completed FROM todo_item", nativeQuery = true)
    List<Map<String, Object>> findAllBasicDetails();

    // 3. Complex selection with expressions and aliases
    @Query(value = """
            SELECT 
                id,
                name,
                completed,
                CASE WHEN completed = true THEN 'Done' ELSE 'Pending' END as status,
                LENGTH(name) as name_length,
                CONCAT(name, ' (', CASE WHEN completed = true THEN 'Done' ELSE 'Pending' END, ')') as full_description
            FROM todo_item
            """, nativeQuery = true)
    List<Map<String, Object>> findAllWithComputedFields();
}