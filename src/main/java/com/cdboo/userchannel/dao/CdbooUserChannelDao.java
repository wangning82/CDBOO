/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userchannel.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.cdboo.userchannel.entity.CdbooUserChannel;

/**
 * 用户频道表DAO接口
 * @author yubin
 * @version 2016-12-21
 */
@MyBatisDao
public interface CdbooUserChannelDao extends CrudDao<CdbooUserChannel> {
	public List<CdbooUserChannel> findGroupByList(CdbooUserChannel cdbooUserChannel);//根据用户和频道分组查询，带分页
	public List<CdbooUserChannel> findChannelByUser(CdbooUserChannel cdbooUserChannel);//根据用户查询对应的频道列表，频道为不重复的
	public void remove(CdbooUserChannel cdbooUserChannel);//真实删除方法
	public void removeByUserAndChannel(CdbooUserChannel cdbooUserChannel);//根据用户和频道删除，是真实删除，不会再数据库保留
	public void removeByUser(CdbooUserChannel cdbooUserChannel);//根据用户删除，是真实删除，不会再数据库保留
}