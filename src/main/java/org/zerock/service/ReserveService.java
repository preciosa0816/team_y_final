package org.zerock.service;

import java.util.List;

import org.zerock.domain.ReserveVO;


public interface ReserveService {
	List<ReserveVO> selectReserveList() throws Exception;
}
