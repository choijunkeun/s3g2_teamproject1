package com.ilinbun.mulcam.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ilinbun.mulcam.dto.Shareboard;

@Mapper
@Repository
public interface ShareDAO {
	public Shareboard selectShareboard() throws Exception;

	public Integer selectMaxArticleNo() throws Exception;

	public void insertShareBoard(Shareboard shareboard) throws Exception;

	public void updateReadCount(int articleNo) throws Exception;

//	public Shareboard shareBoardQueryByID(String id) throws Exception;
}
