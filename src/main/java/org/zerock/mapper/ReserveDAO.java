package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.ReserveVO;


public interface ReserveDAO {
	List<ReserveVO> selectReserveList() throws Exception;
}
