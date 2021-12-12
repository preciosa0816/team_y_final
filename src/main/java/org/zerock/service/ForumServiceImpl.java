package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.zerock.domain.ForumVO;
import org.zerock.domain.ReplyVO_forum;
import org.zerock.domain.Criteria;
import org.zerock.domain.ForumAttachVO;

import org.zerock.mapper.ForumAttachMapper;
import org.zerock.mapper.ForumMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class ForumServiceImpl implements ForumService {

	// spring 4.3 이상에서 자동 처리 : Mapper들 주입
	@Setter(onMethod_ = { @Autowired })
	private ForumMapper mapper;

	@Setter(onMethod_ = { @Autowired })
	private ForumAttachMapper attachMapper;

	@Transactional // tbl_board테이블과 tbl_attach 테이블 양쪽 모두 insert가 진행되어야함.
	@Override
	public void register(ForumVO forum) {
		log.info("register......." + forum);

		// tbl_table에 먼저 게시물을 등록하고 각 첨부파일은 생성된 게시물 번호를 세팅한 후 tbl_attach 테이블에 데이터를 추가함.
		mapper.insertSelectKey(forum);// currval, nextval 처리/ MyBatis의 selectkey를 이용함.
		
		if (forum.getAttachList() == null || forum.getAttachList().size() <= 0) {
			return;
		}
		ForumVO vo = mapper.read(forum.getBno());
		forum.getAttachList().forEach(attach -> {
			attach.setFno(vo.getFno());
			attachMapper.insert(attach);
		});

	}

	@Override
	public ForumVO get(Long bno) {
		log.info("get..............." + bno);
		return mapper.read(bno);
	}

	@Override
	public boolean add_views(Long bno) {
		log.info("add views : " + bno);
		return mapper.add_views(bno) != 0;
	}

	@Transactional
	@Override
	public boolean modify(ForumVO forum) {
		log.info("modify.........." + forum);

		attachMapper.deleteAll(forum.getFno()); // 기존 첨부파일 삭제

		boolean modifyResult = mapper.update(forum) == 1;

		if (modifyResult && forum.getAttachList() != null && forum.getAttachList().size() > 0) {
			forum.getAttachList().forEach(attach -> {
				attach.setFno(forum.getFno());
				attachMapper.insert(attach);
			});
		}

		return modifyResult;
	}

	@Transactional // 첨부파일과 실제 게시물의 삭제가 같이 처리되도록함
	@Override
	public boolean remove(Long bno) {
		log.info("remove..........bno: " + bno);

		ForumVO vo = mapper.read(bno); // read를 통해 fno를 알아내는 중간과정이 필요함

		attachMapper.deleteAll(vo.getFno());

		return mapper.delete(bno) == 1;
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override // 첨부파일목록 가져오기
	public List<ForumAttachVO> getAttachList(Long fno) {
		//log.info("get Attach list by bno: " + bno);
		//ForumVO vo = mapper.read(bno);// read를 통해 fno를 알아내는 중간과정이 필요함
		return attachMapper.findByFno(fno);
	}

	@Override
	public List<ForumVO> getList(Criteria cri) {
		log.info("get List with criteria: " + cri);
		log.info(mapper.getListWithPaging(cri));
		return mapper.getListWithPaging(cri);
	}

}
