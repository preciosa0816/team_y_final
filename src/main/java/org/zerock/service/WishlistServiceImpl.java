package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.zerock.domain.Wishlist;
import org.zerock.domain.Criteria;
import org.zerock.mapper.WishListMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class WishlistServiceImpl implements WishlistService {

	// spring 4.3 이상에서 자동 처리 : Mapper들 주입
	@Setter(onMethod_ = { @Autowired })
	private WishListMapper mapper;

	//@Setter(onMethod_ = { @Autowired })
	//private ForumAttachMapper attachMapper;

	@Transactional // tbl_board테이블과 tbl_attach 테이블 양쪽 모두 insert가 진행되어야함.
	@Override
	public void register(Wishlist wishlist) {
		log.info("register......." + wishlist);

		// tbl_table에 먼저 게시물을 등록하고 각 첨부파일은 생성된 게시물 번호를 세팅한 후 tbl_attach 테이블에 데이터를 추가함.
		mapper.insertSelectKey(wishlist);// currval, nextval 처리/ MyBatis의 selectkey를 이용함.
		
		//if (forum.getAttachList() == null || forum.getAttachList().size() <= 0) {
		//	return;
		//}
		Wishlist vo = mapper.read(wishlist.getWno());
		//forum.getAttachList().forEach(attach -> {
			//attach.setFno(vo.getFno());
			//attachMapper.insert(attach);
		//});

	}

	@Override
	public Wishlist get(Long wno) {
		log.info("get..............." + wno);
		return mapper.read(wno);
	}

//	@Override
//	public boolean add_views(Long bno) {
//		log.info("add views : " + bno);
//		return mapper.add_views(bno) != 0;
//	}

	@Transactional
	@Override
	public boolean modify(Wishlist wishlist) {
		log.info("modify.........." + wishlist);

		//attachMapper.deleteAll(wishlist.getFno()); // 기존 첨부파일 삭제

		boolean modifyResult = mapper.update(wishlist) == 1;

//		if (modifyResult && wishlist.getAttachList() != null && forum.getAttachList().size() > 0) {
//			wishlist.getAttachList().forEach(attach -> {
//				attach.setFno(forum.getFno());
//				attachMapper.insert(attach);
//			});
//		}

		return modifyResult;
	}

	@Transactional // 첨부파일과 실제 게시물의 삭제가 같이 처리되도록함
	@Override
	public boolean remove(Long wno) {
		log.info("remove..........wno: " + wno);

		//Wishlist vo = mapper.read(wno); // read를 통해 fno를 알아내는 중간과정이 필요함

		//attachMapper.deleteAll(vo.getWno());

		return mapper.delete(wno) == 1;
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
	@Override
	public int check(String user_id) {
		log.info("get total count");
		return mapper.checkwish(user_id);
	}

//	@Override // 첨부파일목록 가져오기
//	public List<ForumAttachVO> getAttachList(Long fno) {
//		//log.info("get Attach list by bno: " + bno);
//		//Wishlist vo = mapper.read(bno);// read를 통해 fno를 알아내는 중간과정이 필요함
//		return attachMapper.findByFno(fno);
//	}

	@Override
	public List<Wishlist> getList(Criteria cri) {
		log.info("get List with criteria: " + cri);
		log.info(mapper.getListWithPaging(cri));
		return mapper.getListWithPaging(cri);
	}

}
