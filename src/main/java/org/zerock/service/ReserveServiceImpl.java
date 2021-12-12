package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.ReserveVO;
import org.zerock.mapper.ReserveDAO;


@Service("reserveService")
public class ReserveServiceImpl implements ReserveService {
	@Autowired
	private ReserveDAO reserveMapper;

	@Override
	@Transactional
	public List<ReserveVO> selectReserveList() throws Exception {
		return reserveMapper.selectReserveList();
	}

}
