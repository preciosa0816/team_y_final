package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.ForumAttachVO;

public interface ForumAttachMapper {
	
	public void insert(ForumAttachVO vo);
	
	public void delete(String uuid);
	
	//특정 게시물의 번호로 첨부파일을 찾는 작업
	public List<ForumAttachVO> findByFno(Long fno);
	
	public void deleteAll(Long fno);
	
	public List<ForumAttachVO> getOldFiles();
}
