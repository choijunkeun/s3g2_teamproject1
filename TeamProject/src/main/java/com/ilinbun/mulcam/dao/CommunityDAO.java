package com.ilinbun.mulcam.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ilinbun.mulcam.dto.BragReply;
import com.ilinbun.mulcam.dto.CommBoard;
import com.ilinbun.mulcam.dto.CommReply;


@Mapper
@Repository
public interface CommunityDAO {
   
   
   //[글쓰기Service] 글 쓸때, 마지막 articleNo+1해주는 DAO
      Integer selectMaxArticleNo() throws Exception;
      
      
      // [글 보기Service] 글보기(viewform.jsp)에서 id를 받아와 내 글인지 남의 글인지 판별하는 DAO
         public CommBoard CommBoardQueryByID(String id);
      // [글 보기Service] 글보기 시 조회수 올리는 DAO
      void updateReadCount(int articleNo) throws Exception;
      
      
      // [글 목록Service] 게시글 리스트에 작성된 게시글을 넣는 쿼리
      void insertCommBoard(CommBoard commboard) throws Exception;
      // [글 목록Service] 게시글 목록 : 15개가 화면에 띄워지게 하는 DAO
      List<CommBoard> selectCommBoardList(int startrow) throws Exception;
      // [글 목록Service] 전체 게시물 조회 : 게시판 페이지 번호를 만들기 위해 저장된 글의 총 갯수의 정보를 반환하는 DAO
      int selectCommBoardCount() throws Exception;
      // 글수정
      void updateCommBoard(CommBoard commboard) throws Exception;
      
      // 마이페이지에 뿌려줄 사용자의 혼밥자랑 게시글 출력 DAO(준근)
      List<CommBoard> selectCommunityBoardByIdx(int idx) throws Exception;

      //여기서 부터는 구현아직 안함
      // 글수정(modifyForm) 시 하나의 글 정보를 select하는 DAO
      CommBoard selectCommBoard(int articleNo) throws Exception;
      // 글삭제
      void deleteCommBoard(int articleNo) throws Exception;
      
      // 아마 댓글관련 DAO
      void updateCommBoardReSeq(CommBoard commboard) throws Exception;
      
      
     //[커뮤니티 공지사항] 글 맨위로 뜨게 (종현)
   	List<CommBoard> commNotice() throws Exception;


  //좋아요 기능
  	int queryArticleLikes(int articleNo) throws Exception;
  	int addArticleLikes(Map<String, Integer> map) throws Exception;
  	int removeArticleLikes(Map<String, Integer> map) throws Exception;
  	int queryIfILikeThis(Map<String, Integer> map) throws Exception;


	//댓글쓰기
	void insertReply(Map<String, Object> map) throws Exception;

	//댓글보기
	List<CommReply> selectReplyList(Map<String, Integer> map) throws Exception;
	//해당 댓글 1개 조회
	CommReply selectReply(int commentNo) throws Exception;
	//가장 마지막 댓글번호 조회
	Integer selectMaxCommentNo() throws Exception;
	//댓글삭제
	void deleteReply(int commentNo) throws Exception;

	//댓글 수정
	void editReply(Map<String, Object> map) throws Exception;
	
	//익명댓글 처리
	void setBlind(Map<String, Object> map) throws Exception;
	
	Integer countComment(int articleNo) throws Exception;
	
	void updateCommentSeq(CommReply br) throws Exception;



}
      