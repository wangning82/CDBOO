/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.music.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.cdboo.music.entity.CdbooMusic;

/**
 * 曲库管理DAO接口
 * @author yubin
 * @version 2016-12-13
 */
@MyBatisDao
public interface CdbooMusicDao extends CrudDao<CdbooMusic> {
	public List<CdbooMusic> findListFromUserId(CdbooMusic cdbooMusic);
}