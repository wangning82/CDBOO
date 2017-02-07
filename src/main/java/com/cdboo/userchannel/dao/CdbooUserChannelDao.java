/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userchannel.dao;

import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

/**
 * 用户频道表DAO接口
 * @author yubin
 * @version 2016-12-21
 */
@MyBatisDao
public interface CdbooUserChannelDao extends CrudDao<CdbooUserChannel> {
	public void remove(CdbooUserChannel cdbooUserChannel);//真实删除方法
}