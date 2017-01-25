/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.channel.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.cdboo.channel.entity.CdbooChannel;

/**
 * 频道管理DAO接口
 * @author 于滨
 * @version 2016-12-17
 */
@MyBatisDao
public interface CdbooChannelDao extends CrudDao<CdbooChannel> {
	public List<CdbooChannel> findPageByUserId(CdbooChannel cdbooChannel);
	public List<CdbooChannel> getMaxChannelNo();
}