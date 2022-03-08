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
	
	
}
