package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.Wishlist;
import org.zerock.domain.Criteria;
import org.zerock.domain.ForumVO;

public interface WishListMapper {
	//@Select("select * from tbl_board where bno>0") //BoardMapper.xml 에 처리함
	public List<Wishlist> getList();
	
	public List<Wishlist> getListWithPaging(Criteria cri);
	
	public void insert(Wishlist wishlist);

	public void insertSelectKey(Wishlist wishlist); //nextval 조회
	
	public Wishlist read(Long wno); //insert가 된 작업 조회작업
	//public int add_views(Long wno); //view count+1
	
	public int delete(Long wno);
	public int cancle(Long wno);
	
	public int update(Wishlist wishlist);
	public int userupdate(Wishlist wishlist);
	
	public int getTotalCount(Criteria cri); //게시물 목록과 전체 데이터수 구하기
	//getTotalCount()는 Criteria를 파라미터로 전달받도록 설계하지 않아도 문제x,
	//게시물의 목록과 전체 데이터수를 구하는 작업은 일관성 있게 Criteria를 받는 것이 좋다.

	public int getWishCount(Criteria cri); 
	public int checkwish(String user_id); 

	public List<Wishlist> getMywish(Criteria cri);

	
}
