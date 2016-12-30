/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.childchannel.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.List;

import com.cdboo.childchannel.entity.CdbooGroupChild;

/**
 * 组合频道子表DAO接口
 * @author yubin
 * @version 2016-12-29
 */
@MyBatisDao
public interface CdbooGroupChildDao extends CrudDao<CdbooGroupChild> {
	public List<CdbooGroupChild> findGroupListByUserid(CdbooGroupChild cdbooGroupChild);
	public List<CdbooGroupChild> findGroupList(CdbooGroupChild cdbooGroupChild);
	public void remove(CdbooGroupChild cdbooGroupChild);
}