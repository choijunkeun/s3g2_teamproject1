package com.ilinbun.mulcam.service;

import java.util.List;

import com.ilinbun.mulcam.dto.BragBoard;
import com.ilinbun.mulcam.dto.PageInfo;

public interface BragService {

	// 글쓰기 : 글 쓸때, 마지막 articleNo+1해주는 DAO
	void regBragBoard(BragBoard bragboard) throws Exception;

	// 글보기 : (viewDetail)에서 id를 받아와 내 글인지 남의 글인지 판별
	BragBoard bragBoardQueryByID(String id) throws Exception;
	// 글보기 :시 조회수 올리는 기능
	BragBoard getArticleNo(int articleNo) throws Exception;

	// 게시글 목록 :에 작성된 게시글을 넣는 쿼리
	void setInputList(BragBoard bragboard) throws Exception;
	// 게시글 목록 : 16개가 화면에 띄워지게 하는 DAO
	List<BragBoard> getBragboardList(int page) throws Exception;
	// 게시글 목록 :아래의 이전/목록/다음 리스트가 10개가 되도록 구성하는 쿼리(PageInfo DTO와 연결, DAO필요X)
	PageInfo getPageInfo(PageInfo pageInfo) throws Exception;
	// 게시글 목록 :게시글 좋아요 순으로 화면에 출력(지금은 조회수로 되어있음 ㅠ)
	BragBoard bragBest1() throws Exception;

	
	
	
	//구현 전 
	// 게시글 수정
	void modifyBragBoard(BragBoard bragboard) throws Exception;
	BragBoard getBragBoard(int articleNo) throws Exception;

	// 게시글 삭제
	void removeBragBoard(int articleNo) throws Exception;

	
	// 마이페이지에 사용자의 혼밥자랑 게시글 출력(준근)
	List<BragBoard> MyBragBoard(int idx) throws Exception;

	// 댓글달기
//	void regBragReply(Bragboard bragboard) throws Exception;
	// 댓글수정
//	void modBragReply(Bragboard bragboard) throws Exception;
	// 댓글삭제
//	void remBragReply(Bragboard bragboard) throws Exception;	

}
