package com.fastcampus.ch4.dao;

import com.fastcampus.ch4.domain.BoardDto;

public interface BoardDao {
    BoardDto select(Integer bno) throws Exception;

    int count() throws Exception;

    int deleteAll() throws Exception;

    int delete(Integer bno, String writer) throws Exception;
}
