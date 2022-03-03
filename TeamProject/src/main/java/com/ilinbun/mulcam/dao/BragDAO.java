package com.ilinbun.mulcam.dao;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ilinbun.mulcam.dto.Bragboard;

@Mapper
@Repository
public interface BragDAO {	
	public Bragboard bragBest1() throws Exception;
}


