package com.ilinbun.mulcam.service;

import java.util.List;

import com.ilinbun.mulcam.dto.BragBoard;

public interface BragService {
	BragBoard bragBest1() throws Exception;

	//articleNo 가져와서 그 글을 보여주는 쿼리
	BragBoard bragBoardQueryByID(String id) throws Exception;
	

	
	void regBragBoard(BragBoard bragboard) throws Exception;
	List<BragBoard> getBragboardList(int articleNo) throws Exception;
	BragBoard getArticleNo(int articleNo) throws Exception;
//	void regBragReply(Bragboard bragboard) throws Exception;
	void modifyBragBoard(BragBoard bragboard) throws Exception;
//	void removeBragBoard(int articleNo) throws Exception;

}
