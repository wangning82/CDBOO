/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.myplan.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cdboo.myplan.entity.CdbooMyPlan;

/**
 * 新计划表DAO接口
 * @author yubin
 * @version 2017-02-03
 */
@MyBatisDao
public interface CdbooMyPlanDao extends CrudDao<CdbooMyPlan> {
	
}