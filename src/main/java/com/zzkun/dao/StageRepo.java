package com.zzkun.dao;

import com.zzkun.model.Stage;
import org.jetbrains.annotations.NotNull;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by kun on 2016/7/13.
 */
public interface StageRepo extends JpaRepository<Stage, Integer> {

    @Override
    List<Stage> findAll();

    @Override
    <S extends Stage> S save(S entity);

    @Override
    Stage getOne(Integer integer);

    @Override
    long count();
}
