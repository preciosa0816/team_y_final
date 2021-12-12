package org.zerock.mapper;

import org.zerock.domain.MemberVO;

public interface MemberMapper {//MyBatis 이용목적
	//MyBatis의 ResultMap기능으로 tbl_member와 tbl_member_auth를 조인해서 처리하려함. MemberMapper.xml 참고
	//MyBatis의 ResultMap기능으로 하나의 쿼리를 이용하여 MemberVO와 내부의 AuthVO 리스트까지 처리가능
	public MemberVO read(String user_id);
	
}
