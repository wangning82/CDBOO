/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userservice.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cdboo.userservice.entity.CdbooUserService;

/**
 * 用户服务信息DAO接口
 * @author yubin
 * @version 2016-12-21
 */
@MyBatisDao
public interface CdbooUserServiceDao extends CrudDao<CdbooUserService> {
	
}