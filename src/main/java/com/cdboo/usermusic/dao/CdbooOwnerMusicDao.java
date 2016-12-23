/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.usermusic.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cdboo.usermusic.entity.CdbooOwnerMusic;

/**
 * 用户曲库信息DAO接口
 * @author yubin
 * @version 2016-12-21
 */
@MyBatisDao
public interface CdbooOwnerMusicDao extends CrudDao<CdbooOwnerMusic> {
	public void remove(CdbooOwnerMusic cdbooOwnerMusic);
}