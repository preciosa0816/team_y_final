package org.zerock.service;

import java.util.List;

import org.zerock.domain.Wishlist;
import org.zerock.domain.Criteria;

public interface WishlistService {
	
	public void register(Wishlist wishlist);
	

	public Wishlist get(Long wno);
	
	//public boolean add_views(Long wno);
	

	public boolean modify(Wishlist wishlist);
	

	public boolean remove(Long wno);

	
	public List<Wishlist> getList(Criteria cri);
	

	public int getTotal(Criteria cri);
	public int check(String user_id);
	//cri 파라미터가 피룡는 없지만 목록과 전체 데이터 개수는 항상 같이 동작하는 경우가 많기 때문에 파라미터로 지정.
	
	//public List<ForumAttachVO> getAttachList(Long fno);


}
