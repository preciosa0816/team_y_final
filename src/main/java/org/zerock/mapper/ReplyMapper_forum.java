package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO_forum;

public interface ReplyMapper_forum {


	public int insert(ReplyVO_forum vo);

	public ReplyVO_forum read(Long fno);

	public int delete(Long rno);
	
	public int update(ReplyVO_forum reply);
	
	public List<ReplyVO_forum> getListWithPaging(
			//두개 이상 데이터를 파라미터로 전달하는 방법중 가장 간단.
			@Param("cri") Criteria cri,
			@Param("fno") Long fno);
	
	public int getCountByFno(Long fno);
	
}
