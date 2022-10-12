package com.vam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vam.model.BoardVO;
import com.vam.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
    private BoardService bservice;
	
    @GetMapping("/list")
    // => @RequestMapping(value="list", method=RequestMethod.GET)
    public void boardListGET(Model model) {
    	//컨트롤러에서 리턴타입이 void이면 요청 스트링을 똑같이 리턴한다.
    	//즉, 현재는 /WEB-INF/views/list.jsp  를 반환하는 것이다.
    	//String이면 리턴을 별도로 지정할수있다.
    	System.out.println("유저가 /board/list 요청함");
        log.info("게시판 목록 페이지 진입");
        model.addAttribute("list", bservice.getList());
    }
    
    /* 게시판 등록 화면 */
    @GetMapping("/enroll")
    // => @RequestMapping(value="enroll", method=RequestMethod.GET)
    public void boardEnrollGET() {
        log.info("게시판 등록 페이지 진입");
        //return "WEB-INF/views/board/enroll.jsp"	화면 띄워줌
    }
    
    /* 게시판 등록 기능 */
    @PostMapping("/enroll")
    public String boardEnrollPOST(BoardVO board, RedirectAttributes rttr) {
        log.info("BoardVO : " + board);
        bservice.enroll(board);
        rttr.addFlashAttribute("result", "enroll success");
        //void일 경우 localhost:8080/board/enroll 요청 보냄
        return "redirect:/board/list";
    }
    
    /* 게시판 조회 화면 */
    @GetMapping("/get")
    public void boardGetPageGet(int bno, Model model) {
    	model.addAttribute("pageInfo", bservice.getPage(bno));
    }
	
}
