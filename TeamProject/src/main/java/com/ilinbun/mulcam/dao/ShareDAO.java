package com.ilinbun.mulcam.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ilinbun.mulcam.dto.Shareboard;

@Mapper
@Repository
public interface ShareDAO {
	
	public Shareboard shareBoardQueryByID(String id) throws Exception;
	
	Integer selectMaxArticleNo() throws Exception;
	List<Shareboard> selectShareBoardList(int startrow) throws Exception;
	
	int selectShareBoardCount() throws Exception;
	Shareboard selectShareboard() throws Exception;
	
	void updateReadCount(int articleNo) throws Exception;
	void updateShareBoardReSeq(Shareboard shareboard) throws Exception;
	
	void insertShareBoard(Shareboard shareboard) throws Exception;
	void updateShareBoard(Shareboard shareboard) throws Exception;
	void deleteShareBoard(int articleNo) throws Exception;
	void updateDeletedShareBoard(Shareboard shareboard) throws Exception;

	
	// 마이페이지에 뿌려줄 사용자의 반찬공유 게시글 출력 DAO(준근)
	public List<Shareboard> selectShareBoardByIdx(int idx) throws Exception;
	
	Shareboard selectShareboard(int articleNo) throws Exception;
}
