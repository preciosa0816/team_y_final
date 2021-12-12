package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
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
import org.zerock.domain.Criteria;
import org.zerock.domain.ForumAttachVO;
import org.zerock.domain.pageDTO;

import org.zerock.service.ForumService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/forum/*")
@AllArgsConstructor // 생성자를 만들지 않은 경우 @setter 사용
public class ForumController { // 전체 목록을 가져오는 처리
	private ForumService service;// @AllArgsConstructor로 생성자만들기

	@GetMapping("/index")
	public void maintestGet() {
		log.info("Teamproject index test...");
	}
	@GetMapping("/forms")
	public void formtestGet() {
		log.info("Teamproject index test...");
	}

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {// 후에 게시물의 목록을 전달해야하므로 Model을 파라미터로 지정
		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
		// model.addAttribute("pageMaker", new pageDTO(cri, 123));

		int total = service.getTotal(cri);
		log.info("total: " + total);
		model.addAttribute("pageMaker", new pageDTO(cri, total));

	}

	@PostMapping("/register") // 등록처리
	@PreAuthorize("isAuthenticated()") // 로그인이 성공한 사용자만 해당 기능 사용처리
	public String register(ForumVO forum, RedirectAttributes rttr) {
		// 등록 작업이 끝난 후 다시 목록화면으로 이동
		// RedirectAttributes를 사용하여 추가적으로 새롭게 등록된 게시물의 번호를 같이 전달
		log.info("============================================");
		log.info("register_forum : " + forum);

		if (forum.getAttachList() != null) {
			forum.getAttachList().forEach(attach -> log.info(attach));
		}

		log.info("============================================");

		service.register(forum);
		rttr.addFlashAttribute("result", forum.getBno());

		return "redirect:/forum/list";
		// "redirect:"접두어를 이용하여 SPRING MVC가 내부적으로 response.sendRedirect()처리
	}

	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()") // 로그인이 성공한 사용자만 해당 기능 사용처리
	public void register() {

	}

	@GetMapping({ "/get", "/modify" }) // 조회처리
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		// 후에 게시물의 목록을 전달해야하므로 Model을 파라미터로 지정 // criteria도 파라미터로 추가해서 받고 전달.
		log.info("/get or modify");
		model.addAttribute("views", service.add_views(bno));
		model.addAttribute("forum", service.get(bno));

	}

	@PreAuthorize("principal.username == #forum.user_id") // 문자열로 표현식지정가능. 로그인한 사용자와 현재 파라미터로 전달되는 작성자 일치확인.
	@PostMapping("/modify")
	// 수정작업을 시작하는 화면의 경우에는 GET방식으로 접근하지만 실작업은 POST방식으로 동작
	public String modify(ForumVO forum, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		// 등록 작업이 끝난 후 다시 목록화면으로 이동
		log.info("modify : " + forum);

		if (service.modify(forum)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/forum/list" + cri.getListLink();
		// "redirect:"접두어를 이용하여 SPRING MVC가 내부적으로 response.sendRedirect()처리
	}

	// @PreAuthorize("principal.username == #user_id") //(오류_)문자열로 표현식지정가능.-첨부파일해결후
	// 다시해보기 로그인한 사용자와 현재 파라미터로 전달되는 작성자 일치확인.
	@PostMapping("/remove")
	// 삭제작업은 반드시 POST방식으로만 처리
	public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr, String writer) {
		log.info("remove..." + bno);

		// 삭제 전 먼저 해당 게시물의 첨부파일 목록 확보.	
		 List<ForumAttachVO> attachList = service.getAttachList(bno);

		if (service.remove(bno)) {

			// delete Attach Files
			deleteFiles(attachList);//게시물과 첨부파일 데이터 삭제

			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/forum/list" + cri.getListLink();
		// "redirect:"접두어를 이용하여 SPRING MVC가 내부적으로 response.sendRedirect()처리
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody // forumController는 @RestController로 작성되지 않았기때문에 직접 @ResponseBody를 적용하여 JSON데이터
					// 반환처리
	public ResponseEntity<List<ForumAttachVO>> getAttachList(Long fno) {
		log.info("getAttachList " + fno);
		return new ResponseEntity<>(service.getAttachList(fno), HttpStatus.OK);
	}
	
	private void deleteFiles(List<ForumAttachVO> attachList) {
		if(attachList==null||attachList.size()==0) {
			return;
		}
		
		log.info("delete attach files...................");
		log.info(attachList);
		
		attachList.forEach(attach->{
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()
										+"_"+attach.getFileName());
				
				Files.deleteIfExists(file);
				//첨부파일 데이터 삭제 후 실제파일 삭제 시도.
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_"
									+attach.getUuid()+"_"+attach.getFileName());
					Files.delete(thumbNail);
				}
				
				
				
			}catch(Exception e) {
				log.error("delete file error"+e.getMessage());
			}
		});
	}


}
