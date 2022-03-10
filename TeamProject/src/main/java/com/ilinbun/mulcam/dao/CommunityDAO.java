package com.ilinbun.mulcam.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ilinbun.mulcam.dto.CommBoard;


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
      
      

      //여기서 부터는 구현아직 안함
      // 글수정
      void updateCommBoard(CommBoard commboard) throws Exception;
      // 글수정(modifyForm) 시 하나의 글 정보를 select하는 DAO
      CommBoard selectCommBoard(int articleNo) throws Exception;
      // 글삭제
      void deleteCommBoard(int articleNo) throws Exception;
      
      // 아마 댓글관련 DAO
      void updateCommBoardReSeq(CommBoard commboard) throws Exception;
}
      