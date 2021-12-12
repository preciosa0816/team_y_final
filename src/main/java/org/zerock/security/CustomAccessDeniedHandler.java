package org.zerock.security;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler{
	//접근제한이 된 경우 다양한 처리를 하고 싶은 경우 직접 AccessDeniedHnadler인터페이스를 구현하는 편이 좋음
	//ex) 쿠키나 세션에 특정작업을 하거나 HttpServletResponse에 특정한 헤더정보를 추가하는 등의 행위를 할 경우
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessException) throws IOException, ServletException {
		
		log.error("Access Denied Handler");
		log.error("Redirect....");
		
		//접근제한시 리다이렉트
		response.sendRedirect("/accessError");
	}
		
}
