package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO_team;
import org.zerock.domain.ReplyVO_forum;

public interface ReplyService_forum {
	
	// team project test
	public int register(ReplyVO_forum vo);
	
	public ReplyVO_forum get(Long rno);
	
	public int modify(ReplyVO_forum vo);
	
	public int remove(Long rno);
	
	public List<ReplyVO_forum> getList(Criteria cri, Long fno);
	
	public ReplyPageDTO_team getListPage(Criteria cri, Long fno); //List<ReplyVO>와 댓글의 수 같이 전달.
}
