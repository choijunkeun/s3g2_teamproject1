package com.ilinbun.mulcam.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ilinbun.mulcam.dto.BragBoard;
import com.ilinbun.mulcam.dto.BragReply;

@Mapper
@Repository
public interface BragDAO {

	
	//[글쓰기Service] 글 쓸때, 마지막 articleNo+1해주는 DAO
	Integer selectMaxArticleNo() throws Exception;
	
	
	// [글 보기Service] 글보기(viewDetail)에서 id를 받아와 내 글인지 남의 글인지 판별하는 DAO
		public BragBoard bragBoardQueryByID(String id);
	// [글 보기Service] 글보기 시 조회수 올리는 DAO
	void updateReadCount(int articleNo) throws Exception;
	
	
	// [글 목록Service] 게시글 리스트에 작성된 게시글을 넣는 쿼리
	void insertBragBoard(BragBoard bragboard) throws Exception;
	// [글 목록Service] 게시글 목록 : 16개가 화면에 띄워지게 하는 DAO
	List<BragBoard> selectBragBoardList(Map<String, Integer> map) throws Exception;
	// [글 목록Service] 전체 게시물 조회 : 게시판 페이지 번호를 만들기 위해 저장된 글의 총 갯수의 정보를 반환하는 DAO
	int selectBragBoardCount() throws Exception;
	//[글 목록Service] BEST 게시판 글 목록이 조회수 순으로 정렬 쿼리(수정요. 나중에는 좋아요 순으로)
	List<BragBoard> bragBest() throws Exception;
	//**글 삭제 후 글 목록이 빵꾸나는 것을 대비하는 코드인지 확인
	// void updateDeletedBragBoard(BragBoard bragboard) throws Exception;
	
	

	//여기서 부터는 구현아직 안함
	// 글수정
	void updateBragBoard(BragBoard bragboard) throws Exception;
	// 글수정(modifyForm) 시 하나의 글 정보를 select하는 DAO
	BragBoard selectBragBoard(int articleNo) throws Exception;
	// 글삭제
	int deleteWrite(int articleNo) throws Exception;
	
	// 아마 댓글관련 DAO
	void updateBragBoardReSeq(BragBoard bragboard) throws Exception;

	// 마이페이지에 뿌려줄 사용자의 혼밥자랑 게시글 출력 DAO(준근)
	List<BragBoard> selectBragBoardByIdx(int idx) throws Exception;

	//좋아요 기능
	int queryArticleLikes(int articleNo) throws Exception;
	int addArticleLikes(Map<String, Integer> map) throws Exception;
	int removeArticleLikes(Map<String, Integer> map) throws Exception;
	int queryIfILikeThis(Map<String, Integer> map) throws Exception;

	//댓글쓰기
	void insertReply(Map<String, Object> map) throws Exception;

	//댓글보기
	List<BragReply> selectReplyList(Map<String, Integer> map) throws Exception;
	//해당 댓글 1개 조회
	BragReply selectReply(int commentNo) throws Exception;
	//가장 마지막 댓글번호 조회
	Integer selectMaxCommentNo() throws Exception;
	//댓글삭제
	void deleteReply(int commentNo) throws Exception;

	//댓글 수정
	void editReply(Map<String, Object> map) throws Exception;
	
	//익명댓글 처리
	void setBlind(Map<String, Object> map) throws Exception;
	
	Integer countComment(int articleNo) throws Exception;
	
	void updateCommentSeq(BragReply br) throws Exception;


	List<BragBoard> selectBragBoardList(int startrow, int howManyBrag);
	
}
