package com.ilinbun.mulcam.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ilinbun.mulcam.dto.Shareboard;

@Mapper
@Repository
public interface ShareDAO {
	public Shareboard selectshareboard() throws Exception;
}
