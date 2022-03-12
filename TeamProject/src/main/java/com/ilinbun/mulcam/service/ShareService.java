package com.ilinbun.mulcam.service;

import java.util.List;

import com.ilinbun.mulcam.dto.PageInfo;
import com.ilinbun.mulcam.dto.Shareboard;
import com.ilinbun.mulcam.dto.User;

public interface ShareService {
	Shareboard shareboard() throws Exception;
	void regShareBoard(Shareboard shareboard) throws Exception;
	Shareboard shareBoardQueryByID(String id) throws Exception;
	Shareboard getArticleNo(int articleNo) throws Exception;
	void modifyShareBoard(Shareboard shareboard) throws Exception;
	void setInputList(Shareboard shareboard) throws Exception;
	List<Shareboard> getShareboardList(int page) throws Exception;
	PageInfo getPageInfo(PageInfo pageInfo) throws Exception;
	Shareboard getShareboard(int articleNo) throws Exception;
	Shareboard getShareboard() throws Exception;
	User selectUserDetail(int idx) throws Exception;
	
	//마이페이지에 뿌려줄 사용자의 반찬공유 게시글(준근)
	List<Shareboard> MyShareBoard(int idx) throws Exception;
	
}
