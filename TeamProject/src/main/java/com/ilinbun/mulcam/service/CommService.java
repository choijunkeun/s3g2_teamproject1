package com.ilinbun.mulcam.service;

import java.util.List;

import com.ilinbun.mulcam.dto.CommBoard;
import com.ilinbun.mulcam.dto.PageInfo;
import com.ilinbun.mulcam.dto.User;

public interface CommService {
   // 글쓰기 : 글 쓸때, 마지막 articleNo+1해주는 DAO
      void regCommBoard(CommBoard commboard) throws Exception;

      // 글보기 : (viewDetail)에서 id를 받아와 내 글인지 남의 글인지 판별
      CommBoard CommBoardQueryByID(String id) throws Exception;
      // 글보기 :시 조회수 올리는 기능
      CommBoard getArticleNo(int articleNo) throws Exception;

      // 게시글 목록 :에 작성된 게시글을 넣는 쿼리
      void setInputList(CommBoard commboard) throws Exception;
      // 게시글 목록 : 15개가 화면에 띄워지게 하는 DAO
      List<CommBoard> getCommBoardList(int page) throws Exception;
      // 게시글 목록 :아래의 이전/목록/다음 리스트가 10개가 되도록 구성하는 쿼리(PageInfo DTO와 연결, DAO필요X)
      PageInfo getPageInfo(PageInfo pageInfo) throws Exception;


      
      
      
      //구현 전 
      // 게시글 수정
      void modifyCommBoard(CommBoard commboard) throws Exception;
      CommBoard getCommBoard(int articleNo) throws Exception;

      // 게시글 삭제
      void removeCommBoard(int articleNo) throws Exception;

      User selectUserDetail(int idx) throws Exception;



      // 댓글달기
//      void regCommReply(CommBoard commboard) throws Exception;
      // 댓글수정
//      void modCommReply(CommBoard commboard) throws Exception;
      // 댓글삭제
//      void remCommReply(CommBoard commboard) throws Exception;   

}