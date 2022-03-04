package com.ilinbun.mulcam.service;

import java.util.List;

import com.ilinbun.mulcam.dto.Bragboard;

public interface BragService {
	Bragboard bragBest1() throws Exception;

	//articleNo 가져와서 그 글을 보여주는 쿼리
	Bragboard bragBoardQueryByID(String id) throws Exception;
	

	
	void regBragBoard(Bragboard bragboard) throws Exception;
	List<Bragboard> getBragboardList(int articleNo) throws Exception;
	Bragboard getArticleNo(int articleNo) throws Exception;
//	void regBragReply(Bragboard bragboard) throws Exception;
	void modifyBragBoard(Bragboard bragboard) throws Exception;
//	void removeBragBoard(int articleNo) throws Exception;

}
