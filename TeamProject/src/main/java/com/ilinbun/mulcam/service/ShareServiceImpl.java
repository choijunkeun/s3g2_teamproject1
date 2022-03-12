package com.ilinbun.mulcam.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ilinbun.mulcam.dao.ShareDAO;
import com.ilinbun.mulcam.dto.Shareboard;

@Service
public class ShareServiceImpl implements ShareService {

	@Autowired
	ShareDAO shareDAO;
	
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
		Shareboard listform = shareDAO.shareBoardQueryByID(id);
		return listform;
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

	
	//마이페이지에 뿌려줄 사용자의 반찬공유 게시글(준근)
	@Override
	public List<Shareboard> MyShareBoard(int idx) throws Exception {
		return shareDAO.selectShareBoardByIdx(idx);
	}
}
