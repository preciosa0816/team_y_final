package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.zerock.domain.ForumVO;
import org.zerock.domain.Wishlist;
import org.zerock.domain.Criteria;
import org.zerock.domain.ForumAttachVO;
import org.zerock.domain.pageDTO;

import org.zerock.service.ForumService;
import org.zerock.service.WishlistService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/wish/*")
@AllArgsConstructor // 생성자를 만들지 않은 경우 @setter 사용
public class WishlistController { // 전체 목록을 가져오는 처리
	private WishlistService service;// @AllArgsConstructor로 생성자만들기

//	@GetMapping("/wishlist_state")
//	public void list(Model model) {// 후에 게시물의 목록을 전달해야하므로 Model을 파라미터로 지정
//		log.info("list");
//		model.addAttribute("list", service.getList());
//
//	}
	
	@GetMapping("/guide")
	public void guidetestGet() {
		log.info("wishlist guide...");
	}
	@GetMapping("/forms") //get 메소드 register와 동일
	@PreAuthorize("isAuthenticated()")
	public void formstestGet() {
		log.info("wishlist register form...");
	}
	
	@GetMapping("/index")
	public void maintestGet() {
		log.info("Teamproject index...");
	}

	@GetMapping("/wishlist_state")
	public void list(Criteria cri, Model model) {// 후에 게시물의 목록을 전달해야하므로 Model을 파라미터로 지정
		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
		// model.addAttribute("pageMaker", new pageDTO(cri, 123));

		int total = service.getTotal(cri);
		log.info("total: " + total);
		model.addAttribute("pageMaker", new pageDTO(cri, total));

	}

	@PostMapping("/register") // 등록처리
	//@PreAuthorize("isAuthenticated()") // 로그인이 성공한 사용자만 해당 기능 사용처리
	public String register(Wishlist wishlist, RedirectAttributes rttr) {
		// 등록 작업이 끝난 후 다시 목록화면으로 이동
		// RedirectAttributes를 사용하여 추가적으로 새롭게 등록된 게시물의 번호를 같이 전달
		log.info("============================================");
		log.info("register_wishlist : " + wishlist);

//		if (forum.getAttachList() != null) {
//			forum.getAttachList().forEach(attach -> log.info(attach));
//		}

		log.info("============================================");
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		String username = ((UserDetails) principal).getUsername();
		
		service.check(username);
		if (service.check(username)<10) {
			service.register(wishlist);
			rttr.addFlashAttribute("result",wishlist.getWno());
		}else {
			rttr.addFlashAttribute("result",0);
		}

		return "redirect:/wish/guide";
		// "redirect:"접두어를 이용하여 SPRING MVC가 내부적으로 response.sendRedirect()처리
	}

	

	@GetMapping({ "/get", "/modify" }) // 조회처리
	public void get(@RequestParam("wno") Long wno, @ModelAttribute("cri") Criteria cri, Model model) {
		// 후에 게시물의 목록을 전달해야하므로 Model을 파라미터로 지정 // criteria도 파라미터로 추가해서 받고 전달.
		log.info("/get or modify");
		//model.addAttribute("views", service.add_views(bno));
		model.addAttribute("wishlist", service.get(wno));

	}


	//@PreAuthorize("principal.username == #forum.user_id") // 문자열로 표현식지정가능. 로그인한 사용자와 현재 파라미터로 전달되는 작성자 일치확인.
	@PostMapping("/modify")
	// 수정작업을 시작하는 화면의 경우에는 GET방식으로 접근하지만 실작업은 POST방식으로 동작
	public String modify(Wishlist wishlist, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		// 등록 작업이 끝난 후 다시 목록화면으로 이동
		log.info("modify : " + wishlist);

		if (service.modify(wishlist)) {
			rttr.addFlashAttribute("result", "success");
		}

		// 방법1
		// 수정삭제 처리는 forumController에서 redirect 방식으로 동작하므로 type과 keyword조건을 리다이렉트 시에
		// 포함시켜야함
		// redirect는 get방식으로 이루어지기 때문.
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount",cri.getAmount());		
//		rttr.addAttribute("type",cri.getType());		
//		rttr.addAttribute("keyword",cri.getKeyword());		
//
//		return "redirect:/forum/list";

		// 방법2
		return "redirect:/wish/wishlist_state" + cri.getListLink();
		// "redirect:"접두어를 이용하여 SPRING MVC가 내부적으로 response.sendRedirect()처리
	}

	// @PreAuthorize("principal.username == #user_id") //(오류_)문자열로 표현식지정가능.-첨부파일해결후
	// 다시해보기 로그인한 사용자와 현재 파라미터로 전달되는 작성자 일치확인.
	@PostMapping("/remove")
	// 삭제작업은 반드시 POST방식으로만 처리
	public String remove(@RequestParam("wno") Long wno, Criteria cri, RedirectAttributes rttr, String writer) {
		log.info("remove..." + wno);

		// 삭제 전 먼저 해당 게시물의 첨부파일 목록 확보.	
		 //List<ForumAttachVO> attachList = service.getAttachList(wno);

		if (service.remove(wno)) {

			// delete Attach Files
			//deleteFiles(attachList);//게시물과 첨부파일 데이터 삭제

			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/wish/wishlist_state" + cri.getListLink();
		// "redirect:"접두어를 이용하여 SPRING MVC가 내부적으로 response.sendRedirect()처리
	}

//	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//	@ResponseBody // forumController는 @RestController로 작성되지 않았기때문에 직접 @ResponseBody를 적용하여 JSON데이터
//					// 반환처리
//	public ResponseEntity<List<ForumAttachVO>> getAttachList(Long fno) {
//		log.info("getAttachList " + fno);
//		return new ResponseEntity<>(service.getAttachList(fno), HttpStatus.OK);
//	}
	
//	private void deleteFiles(List<ForumAttachVO> attachList) {
//		if(attachList==null||attachList.size()==0) {
//			return;
//		}
//		
//		log.info("delete attach files...................");
//		log.info(attachList);
//		
//		attachList.forEach(attach->{
//			try {
//				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()
//										+"_"+attach.getFileName());
//				
//				Files.deleteIfExists(file);
//				//첨부파일 데이터 삭제 후 실제파일 삭제 시도.
//				if(Files.probeContentType(file).startsWith("image")) {
//					Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_"
//									+attach.getUuid()+"_"+attach.getFileName());
//					Files.delete(thumbNail);
//				}
//				
//				
//				
//			}catch(Exception e) {
//				log.error("delete file error"+e.getMessage());
//			}
//		});
//	}
	

}
