package org.zerock.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.zerock.domain.BoardVO;
import org.zerock.domain.ReserveVO;
import org.zerock.service.BoardService;
import org.zerock.service.ReserveService;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)//RequestMapping(): 특정 URI에 매칭되는 클래스나 매소드임을 명시하는 어노테이션
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "index";
	}
	
	@Resource(name = "boardService")
	private BoardService boardService;
	@Resource(name = "reserveService")
	private ReserveService reserveService;
	
	/* 메인화면  (HTML 파일 연결) */
	@RequestMapping(value = "/home")
	public String main() {
		return "index";
	}
	
	/* 메인화면  (HTML 파일 연결) */
	@RequestMapping(value = "/admin/main")
	public String adminmain() {
		return "/admin/main";
	}
	
	/* 메뉴2(소장 도서 관리)  */
	@RequestMapping(value = "/boardList")
	public String boardList(Model model) throws Exception {

	    List<BoardVO> list = boardService.selectBoardList();

	    logger.info(list.toString());

	    model.addAttribute("list", list);

	    return "boardList";
	}
	
	/* 메뉴 2 (소장도서관리) */
	@RequestMapping(value = "/menu2")
	public String menu2() {
		return "menu2";
	}
	
	@RequestMapping(value = "/reserveList")
	public String reserveList(Model model) throws Exception {

	    List<ReserveVO> list2 = reserveService.selectReserveList();

	    logger.info(list2.toString());

	    model.addAttribute("list2", list2);

	    return "reserveList";
	}
}
