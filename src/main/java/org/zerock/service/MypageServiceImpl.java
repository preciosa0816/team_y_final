package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.zerock.domain.Wishlist;
import org.zerock.domain.Criteria;
import org.zerock.domain.ForumAttachVO;
import org.zerock.domain.ForumVO;
import org.zerock.mapper.ForumAttachMapper;
import org.zerock.mapper.ForumMapper;
import org.zerock.mapper.WishListMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class MypageServiceImpl implements MypageService {

	// spring 4.3 이상에서 자동 처리 : Mapper들 주입
	@Setter(onMethod_ = { @Autowired })
	private WishListMapper mapper;
	
	@Setter(onMethod_ = { @Autowired })
	private ForumMapper forummapper;

	@Setter(onMethod_ = { @Autowired })
	private ForumAttachMapper attachMapper;
	
	@Override
	public Wishlist wishlistget(Long wno) {
		log.info("get..............." + wno);
		return mapper.read(wno);
	}
	
	@Override
	public ForumVO getmyforum(Long bno) {
		log.info("get..............." + bno);
		return forummapper.read(bno);
	}

	@Transactional
	@Override
	public boolean wishlistmodify(Wishlist forum) {
		log.info("modify.........." + forum);

		boolean modifyResult = mapper.userupdate(forum) == 1;

		return modifyResult;
	}
	
	@Transactional
	@Override
	public boolean myforummodify(ForumVO forum) {
		log.info("modify.........." + forum);

		attachMapper.deleteAll(forum.getFno()); // 기존 첨부파일 삭제

		boolean modifyResult = forummapper.update(forum) == 1;

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
	public boolean myforumremove(Long bno) {
		log.info("remove..........bno: " + bno);

		ForumVO vo = forummapper.read(bno); // read를 통해 fno를 알아내는 중간과정이 필요함

		attachMapper.deleteAll(vo.getFno());

		return forummapper.delete(bno) == 1;
	}
	
	@Override // 첨부파일목록 가져오기
	public List<ForumAttachVO> getAttachList(Long fno) {
		//log.info("get Attach list by bno: " + bno);
		//ForumVO vo = mapper.read(bno);// read를 통해 fno를 알아내는 중간과정이 필요함
		return attachMapper.findByFno(fno);
	}
	
	@Transactional // 첨부파일과 실제 게시물의 삭제가 같이 처리되도록함
	@Override
	public boolean wishlistcancle(Long wno) {
		log.info("wishlistcancle..........wno: " + wno);

		return mapper.cancle(wno) == 1;
	}

	@Override
	public int getmywishlistTotal(Criteria cri) {
		log.info("get my wishlist total count");
		return mapper.getWishCount(cri);
	}

	@Override
	public List<Wishlist> getwishList(Criteria cri) {
		log.info("get myList with criteria: " + cri);
		// log.info("get myList with user_id: " + user_id);
		log.info(mapper.getMywish(cri));
		return mapper.getMywish(cri);
	}
	
	@Override
	public int getmyforumTotal(Criteria cri) {
		log.info("get my forum total count");
		return forummapper.getMyforumCount(cri);
	}
	
	@Override
	public List<ForumVO> getmyforum(Criteria cri) {
		log.info("get myforum with criteria: " + cri);
		// log.info("get myList with user_id: " + user_id);
		log.info(forummapper.getMyforum(cri));
		return forummapper.getMyforum(cri);
	}

}
