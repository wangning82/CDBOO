/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.businessplan.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cdboo.businessplan.entity.CdbooBusinessPlan;

/**
 * 行业计划模板表DAO接口
 * @author yubin
 * @version 2017-02-10
 */
@MyBatisDao
public interface CdbooBusinessPlanDao extends CrudDao<CdbooBusinessPlan> {
	
}