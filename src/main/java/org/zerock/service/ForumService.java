package org.zerock.service;

import java.util.List;

import org.zerock.domain.ForumVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ForumAttachVO;

public interface ForumService {
	
	public void register(ForumVO forum);
	

	public ForumVO get(Long bno);
	
	public boolean add_views(Long bno);
	

	public boolean modify(ForumVO forum);
	

	public boolean remove(Long bno);

	
	public List<ForumVO> getList(Criteria cri);
	

	public int getTotal(Criteria cri);
	//cri 파라미터가 피룡는 없지만 목록과 전체 데이터 개수는 항상 같이 동작하는 경우가 많기 때문에 파라미터로 지정.
	
	public List<ForumAttachVO> getAttachList(Long fno);
	
}
