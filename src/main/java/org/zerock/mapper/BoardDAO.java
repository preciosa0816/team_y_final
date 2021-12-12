package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;

public interface BoardDAO {
	List<BoardVO> selectBoardList() throws Exception;
}
