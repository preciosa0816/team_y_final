package org.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO_forum;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
//XML방식
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//Java Config
//@ContextConfiguration(classes={org.zerock.config.RootConfig.class})
@Log4j
public class ReplyMapperTests_forum {
	
	//테스트 전에 해당 번호의 게시물이 존재하는지 반드시 확인할것
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper_forum mapper;
	

	
	private Long[] fnoArr= {2L,3L,4L,5L,6L};
//	@Test
//	public void testCreate() {
//		
//		IntStream.rangeClosed(1, 10).forEach(i->{
//			ReplyVO_forum vo = new ReplyVO_forum();
//			
//			//게시물의 번호
//			vo.setFno(fnoArr[i%5]);
//			vo.setReply("댓글 테스트 "+i);
//			vo.setReplyer("replyer"+i);
//			
//			mapper.insert(vo);
//		});
//	}
//	
//	@Test
//	public void testMapper() {
//		log.info(mapper);
//	}
	

//	@Test
//	public void testRead() {//5번 댓글의 결과 (fno, rno 기준)
//		Long targetRno = 5L;
//		ReplyVO_forum vo = mapper.read(targetRno);
//		log.info(vo);
//	}

	
//	@Test
//	public void testDelete() {
//		Long targetRno=3L;
//		mapper.delete(targetRno);
//	}
	
//
//	@Test
//	public void testUpdate() {
//		Long targetRno=8L;
//		ReplyVO_forum vo = mapper.read(targetRno);
//		vo.setReply("Update Reply ");
//		int count = mapper.update(vo);
//		log.info("UPDATE COUNT : "+count);
//		
//	}
//
//	@Test
//	public void testList() {
//		Criteria cri = new Criteria();
//		
//		//2번 글의 댓글 목록
//		List<ReplyVO_forum> replies= mapper.getListWithPaging(cri, fnoArr[0]);
//		replies.forEach(reply->log.info(reply));
//	}
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(2,10);
		
		//2번 글의 댓글 목록
		List<ReplyVO_forum> replies= mapper.getListWithPaging(cri, 6L);
		replies.forEach(reply->log.info(reply));
	}
	
}
