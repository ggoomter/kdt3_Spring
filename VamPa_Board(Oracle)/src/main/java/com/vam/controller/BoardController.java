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
import com.vam.model.Criteria;
import com.vam.model.PageMakerDTO;
import com.vam.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
    private BoardService bservice;
	
    @GetMapping("/list")
    // => @RequestMapping(value="list", method=RequestMethod.GET)
    public void boardListGET(Model model, Criteria cri) {
    	//컨트롤러에서 리턴타입이 void이면 요청 스트링을 똑같이 리턴한다.
    	//즉, 현재는 /WEB-INF/views/list.jsp  를 반환하는 것이다.
    	//String이면 리턴을 별도로 지정할수있다.
    	//쿼리스트링에 pageNum=? 넘어오면 getPageNum()
    	System.out.println("유저가 /board/list 요청함");
        log.info("게시판 목록 페이지 진입");
        model.addAttribute("list", bservice.getListPaging(cri));

        //페이징 처리
        int total = bservice.getTotal();
        PageMakerDTO pageMake = new PageMakerDTO(cri, total);
        model.addAttribute("pageMaker", pageMake);
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
    
    /* 게시판 상세 조회 화면 */
    @GetMapping("/get")
    public void boardGetPageGet(int bno, Model model, Criteria cri) {
    	model.addAttribute("pageInfo", bservice.getPage(bno));
    	model.addAttribute("cri", cri);
    }
    
    /* 게시판 수정 화면 */
    @GetMapping("/modify")
    public void boardModifyGET(int bno, Model model, Criteria cri) {
    	//글수정 화면을 보이기위해서 필요한 정보가 뭐지? 	//백단에서 알수있는 정보와 프론트단에서 넘어와야할 정보
    	//클라이언트님. 설계자님. 화면에 어떤 정보가 보이길 원합니까?   화면에는 안보이지만 DB에 수정해야할 정보가 뭡니까?
    	//pk하나만 알면 db에서 모든 정보를 조회할수있다.
    	//글번호 하나만 알면 where bno=글번호  해서 해당글번호의 모든정보를 가져올수있음.
    	model.addAttribute("pageInfo", bservice.getPage(bno));  	
    	model.addAttribute("cri", cri);
    	
    }
    
    /* 페이지 수정 기능 */
    @PostMapping("/modify")
    public String boardModifyPOST(BoardVO board, RedirectAttributes rttr) {
    	//화면에서 넘어온 name들을 board로 getter로 담아옴
        bservice.modify(board);
        rttr.addFlashAttribute("result", "modify success");
        return "redirect:/board/list";
    }
    
    /* 페이지 삭제 기능 */
    @PostMapping("/delete")
    public String boardDeletePOST(int bno, RedirectAttributes rttr) {
        bservice.delete(bno);
        rttr.addFlashAttribute("result", "delete success");
        return "redirect:/board/list";
    }
	
}
