package com.cdboo.plan.dao;

import com.cdboo.plan.entity.PlanDefinition;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

/**
 * Created by mmzz on 2016/12/21.
 */
@MyBatisDao
public interface PlanDao extends CrudDao<PlanDefinition> {
}
