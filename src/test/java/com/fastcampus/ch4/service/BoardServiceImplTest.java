package com.fastcampus.ch4.service;

import com.fastcampus.ch4.dao.BoardDao;
import com.fastcampus.ch4.domain.BoardDto;
import com.fastcampus.ch4.domain.SearchCondition;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class BoardServiceImplTest {
    @Autowired
    BoardService boardService;

    @Autowired
    BoardDao  boardDao;

    @Test
    public void getSearchResultPage() throws Exception {
        boardDao.deleteAll();
        for (int i = 1; i <= 20; i++) {
            BoardDto boardDto = new BoardDto("title"+i, "dafsdfasdf", "asdf");
            boardService.write(boardDto);
        }

        SearchCondition sc = new SearchCondition(1, 10, "title2", "T");
        List<BoardDto> list = boardService.getSearchResultPage(sc);
        System.out.println("list = " + list);
        assertTrue(list.size() == 2); //1~20, title2, title20
    }

    @Test
    public void getSearchResultCnt() throws Exception {
        boardDao.deleteAll();
        for (int i = 1; i <= 20; i++) {
            BoardDto boardDto = new BoardDto("title"+i, "dafsdfasdf", "asdf");
            boardService.write(boardDto);
        }

        SearchCondition sc = new SearchCondition(1, 10, "title2", "T");
        int cnt = boardService.getSearchResultCnt(sc);
        System.out.println("cnt = " + cnt);
        assertTrue(cnt == 2); //1~20, title2, title20
    }
}