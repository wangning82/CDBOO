/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.channelmusic.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cdboo.channelmusic.entity.CdbooChannelMusic;

/**
 * 频道音乐中间表生成方案DAO接口
 * @author yubin
 * @version 2017-01-23
 */
@MyBatisDao
public interface CdbooChannelMusicDao extends CrudDao<CdbooChannelMusic> {
	
}