package com.vam.mapper;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.vam.model.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardMapperTests {
 
     private static final Logger log = LoggerFactory.getLogger(BoardMapperTests.class);
     
     @Autowired
     private BoardMapper mapper;
 
     @Test
     public void testEnroll() {
         
         BoardVO vo = new BoardVO();
         
         vo.setTitle("mapper test");
         vo.setContent("mapper test");
         vo.setWriter("mapper test");
         
         mapper.enroll(vo);	//인터페이스의 함수를 호출하면 해당 id의 쿼리가 호출됨.
         
     }
     
     /* 게시판 목록 테스트 */
     @Test
     public void testGetList() {
         List list = mapper.getList();
         for(Object a : list) {
             log.info("" + a);
         }
     }
     
    /* 게시판 조회 */
    @Test
    public void testGetPage() {
        /* 실제 존재하는 페이지 */
        int bno = 8;
        log.info("" + mapper.getPage(bno));
    }
    
    @Test
    public void testModify() {
    	BoardVO board = new BoardVO();
    	//어떤놈을 = pk 데이터를 전달
    	board.setBno(1);
    	
    	//어떻게 바꿀건지
    	board.setTitle("junit으로 바꾼 제목");
    	board.setContent("junit으로 바꾼 내용");
    	
    	int result = mapper.modify(board);
    	//제대로바꼈으면 1개가 insert됐으니까 1반환.
    	//제대로 안바꼈으면 0반환
    	log.info("result : "+ result);
    }
     
 
}
 