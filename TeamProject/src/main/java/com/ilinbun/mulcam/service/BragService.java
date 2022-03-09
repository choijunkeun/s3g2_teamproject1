package com.ilinbun.mulcam.service;

import java.util.List;

import com.ilinbun.mulcam.dto.BragBoard;
import com.ilinbun.mulcam.dto.PageInfo;

public interface BragService {

	//게시글에서 articleNo가져오기
	//게시글에서 ID가져오기 (내가쓴글 or 남이쓴글 판별)
	BragBoard getArticleNo(int articleNo) throws Exception;
	BragBoard bragBoardQueryByID(String id) throws Exception;
	
	
	//전체 리스트 만들기
	void setInputList(BragBoard bragboard) throws Exception; 

	//게시글 리스트 가져오기
	List<BragBoard> getBragboardList(int page) throws Exception;
	PageInfo getPageInfo(PageInfo pageInfo) throws Exception; 
	//게시글 좋아요 순으로 화면에 출력(지금은 조회수로 되어있음 ㅠ)
	BragBoard bragBest1() throws Exception;
	



	//게시글 등록
	//게시글 수정
	//게시글 삭제
	void regBragBoard(BragBoard bragboard) throws Exception;
	void modifyBragBoard(BragBoard bragboard) throws Exception;
	void removeBragBoard(int articleNo) throws Exception;


	//댓글달기
	//댓글수정
	//댓글삭제
//	void regBragReply(Bragboard bragboard) throws Exception;
//	void modBragReply(Bragboard bragboard) throws Exception;	
//	void remBragReply(Bragboard bragboard) throws Exception;	


}
