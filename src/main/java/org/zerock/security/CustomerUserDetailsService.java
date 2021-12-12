package org.zerock.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;
import org.zerock.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomerUserDetailsService implements UserDetailsService {
	//내장 인터페이스 UserDetailsService를 구현하여 아이디와 비밀번호 뿐 아니라 이름, 이메일 등 추가적인 정보를 이용목적.
	
	@Setter(onMethod_={@Autowired})
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		//loadUserByUsername: 내부적으로 memberMapper를 이용하여 MemberVO를 조회하고 
		//						만일 MemberVO의 인스턴스를 얻을 수 있다면 CustomUser타입의 객체로 변환해서 반환함.
		log.warn("Load User By UserName : "+userName);
		
		//userName means user_id
		MemberVO vo = memberMapper.read(userName);
		
		log.warn("queried by member mapper: "+vo);
		
		return vo==null? null: new CustomUser(vo);
	}

}
