package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.ForumVO;
import org.zerock.domain.Criteria;

public interface ForumMapper {
	//@Select("select * from tbl_board where bno>0") //BoardMapper.xml 에 처리함
	public List<ForumVO> getList();
	
	public List<ForumVO> getListWithPaging(Criteria cri);
	
	public void insert(ForumVO forum);

	public void insertSelectKey(ForumVO forum); //nextval 조회
	
	public ForumVO read(Long bno); //insert가 된 작업 조회작업
	public int add_views(Long bno); //view count+1
	
	public int delete(Long bno);
	
	public int update(ForumVO forum);
	
	public int getTotalCount(Criteria cri); //게시물 목록과 전체 데이터수 구하기
	//getTotalCount()는 Criteria를 파라미터로 전달받도록 설계하지 않아도 문제x,
	//게시물의 목록과 전체 데이터수를 구하는 작업은 일관성 있게 Criteria를 받는 것이 좋다.

	//해당 게시물의 번호인 fno와 증가나 감소를 의미하는amount변수에 파라미터를 받음 
	public void updateReplyCnt(@Param("fno") Long fno, @Param("amount") int amount);
	
	public int getMyforumCount(Criteria cri);
	
	public List<ForumVO> getMyforum(Criteria cri);

}
