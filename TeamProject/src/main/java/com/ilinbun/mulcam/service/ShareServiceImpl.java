package com.ilinbun.mulcam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ilinbun.mulcam.dao.ShareDAO;
import com.ilinbun.mulcam.dao.UserDAO;
import com.ilinbun.mulcam.dto.PageInfo;
import com.ilinbun.mulcam.dto.Shareboard;
import com.ilinbun.mulcam.dto.User;

@Service
public class ShareServiceImpl implements ShareService {

	@Autowired
	ShareDAO shareDAO;
	
	@Autowired
	UserDAO userDAO;
	
	@Override
	public Shareboard shareboard() throws Exception {
		Shareboard share = shareDAO.selectShareboard();
		return share;
	}

	@Override
	public void regShareBoard(Shareboard shareboard) throws Exception {
		Integer articleNo = shareDAO.selectMaxArticleNo();
		if(articleNo==null) articleNo = 1;
		else articleNo+=1;
		shareboard.setArticleNo(articleNo);
		shareDAO.insertShareBoard(shareboard);
	}

	@Override
	public Shareboard shareBoardQueryByID(String id) throws Exception {
		Shareboard viewDetail = shareDAO.shareBoardQueryByID(id);
		return viewDetail;
//		return null; //shareboardquery오류로 임시수정
	}

	@Override
	public Shareboard getArticleNo(int articleNo) throws Exception {
		shareDAO.updateReadCount(articleNo);
		return shareDAO.selectShareboard();
	}

	@Override
	public void modifyShareBoard(Shareboard shareboard) throws Exception {
		
	}

<<<<<<< HEAD
	@Override
	public List<Shareboard> getShareboardList(int page) throws Exception {
		int startrow=(int) ((page-1)*15+1);
		return shareDAO.selectShareBoardList(startrow);
	}

	@Override
	public PageInfo getPageInfo(PageInfo pageInfo) throws Exception {
		int listCount=shareDAO.selectShareBoardCount();
		System.out.println("리스트카운트 :"+listCount);
		int maxPage=(int)Math.ceil((double)listCount/16);
		//그 개수를 16으로 나누고 올림처리하여 페이지 수 계산
		//table에 있는 모든 row 개수
		double pagenation = pageInfo.getPage(); //? 새로 추가 
		//아래에 페이지 이동 버튼도 10개로 구성하고자 하기 위함이다.
		int startPage=(((int) ((double)pagenation/10+0.9))-1)*10+1;
		//현재 페이지에 보여줄 시작 페이지 수(1, 11, 21, ...)
		
		int endPage=startPage+10-1;
		//현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30, ...)
		if(maxPage<endPage) {
			endPage=maxPage;
		}
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setEndPage(endPage);
		pageInfo.setStartPage(startPage);
		return pageInfo;
	}

	@Override
	public Shareboard getShareboard(int articleNo) throws Exception {
		return shareDAO.selectShareboard(articleNo);
	}

	@Override
	public void setInputList(Shareboard shareboard) throws Exception {
		shareDAO.insertShareBoard(shareboard);
		
	}

	@Override
	public Shareboard getShareboard() throws Exception {
		return shareDAO.selectShareboard();
	}

	@Override
	public User selectUserDetail(int idx) throws Exception {
		return userDAO.selectUserDetail(idx);
=======
	
	//마이페이지에 뿌려줄 사용자의 반찬공유 게시글(준근)
	@Override
	public List<Shareboard> MyShareBoard(int idx) throws Exception {
		return shareDAO.selectShareBoardByIdx(idx);
>>>>>>> branch 'dev' of https://github.com/choijunkeun/s3g2_teamproject1.git
	}
}
