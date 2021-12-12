package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String user_id;
	private String user_pw;
	private String user_Name;
	private String tel1; //전화번호 앞자리
	private String tel2; //전화번호 중간자리
	private String tel3; //전화번호 끝자리
	private String email1; //이메일 앞부분
	private String email2; //이메일 뒷부분
	private String rrn1; //주민등록번호 앞자리
	private String rrn2; //주민등록번호 뒷자리
	
	
	private List<AuthVO> authList;

}
