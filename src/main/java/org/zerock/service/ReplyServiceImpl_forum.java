package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;

import org.zerock.domain.ReplyPageDTO_team;
import org.zerock.domain.ReplyVO_forum;
import org.zerock.mapper.ForumMapper;
import org.zerock.mapper.ReplyMapper_forum;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class ReplyServiceImpl_forum implements ReplyService_forum {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper_forum mapper;
	
	@Setter(onMethod_ = @Autowired)
	private ForumMapper forumMapper;
	

// team project test	
	@Transactional
	@Override
	public int register(ReplyVO_forum vo) {
		//파라미터로 전달받은 ReplyVO 내에 게시물 번호가 존재하므로 이를 이용해서 댓글 추가
		log.info("register.........."+vo);
		
		forumMapper.updateReplyCnt(vo.getFno(), 1);
		
		return mapper.insert(vo);
	}
	
	@Override
	public ReplyVO_forum get(Long rno) {
		log.info("get................"+rno);
		return mapper.read(rno);
	}
	
	@Override
	public int modify(ReplyVO_forum vo) {
		log.info("modify..................."+vo);
		return mapper.update(vo);
	}
	
	@Transactional
	@Override
	public int remove(Long rno) {
		//댓글번호인 rno만 전달받으므로 해당 댓글의 게시물을 알아내는 과정이 필요함.
		log.info("remove.........."+rno);
		
		ReplyVO_forum vo = mapper.read(rno); //read를 통해 fno를 알아내는 중간과정이 필요함 
		
		forumMapper.updateReplyCnt(vo.getFno(), -1);
		
		return mapper.delete(rno);
	}
	
	@Override
	public List<ReplyVO_forum> getList(Criteria cri, Long fno) {
		log.info("get Reply_team List of a forum " +fno);
		return mapper.getListWithPaging(cri, fno);
	}
	
	@Override
	public ReplyPageDTO_team getListPage(Criteria cri, Long fno) {
		
		return new ReplyPageDTO_team(mapper.getCountByFno(fno), mapper.getListWithPaging(cri, fno));
	}
	
	
}
