package org.zerock.service;

import java.util.List;

import org.zerock.domain.ForumVO;
import org.zerock.domain.Wishlist;
import org.zerock.domain.Criteria;
import org.zerock.domain.ForumAttachVO;

public interface MypageService {
	
	
	public Wishlist wishlistget(Long wno); //내 희망도서리스트 상세내용확인
	public ForumVO getmyforum(Long bno); //내 희망도서리스트 상세내용확인

	public boolean wishlistmodify(Wishlist wishlist);//내 희망도서신청수정
	
	public boolean wishlistcancle(Long wno); //내 희망도서 신청 취소
	
	public List<Wishlist> getwishList(Criteria cri); //내 희망도서리스트
	
	public List<ForumVO> getmyforum(Criteria cri); //내가 쓴 자유게시판 글 
	

	public int getmywishlistTotal(Criteria cri); //
	
	public int getmyforumTotal(Criteria cri); //내가 쓴 자유게시판 글 갯수
	//cri 파라미터가 피룡는 없지만 목록과 전체 데이터 개수는 항상 같이 동작하는 경우가 많기 때문에 파라미터로 지정.
	
	public boolean myforummodify(ForumVO forum);
	public boolean myforumremove(Long bno);
	public List<ForumAttachVO> getAttachList(Long fno);
}
