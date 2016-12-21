/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userplan.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cdboo.userplan.entity.CdbooPlan;

/**
 * 用户计划表DAO接口
 * @author yubin
 * @version 2016-12-21
 */
@MyBatisDao
public interface CdbooPlanDao extends CrudDao<CdbooPlan> {
	
}