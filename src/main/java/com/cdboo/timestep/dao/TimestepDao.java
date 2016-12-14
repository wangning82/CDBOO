/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.timestep.dao;

import com.cdboo.business.entity.BusinessTimestep;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cdboo.timestep.entity.Timestep;

import java.util.List;

/**
 * 时段管理DAO接口
 * @author 朱广成
 * @version 2016-12-13
 */
@MyBatisDao
public interface TimestepDao extends CrudDao<Timestep> {

    List<Timestep> findListByBusinessTimestep(BusinessTimestep businessTimestep);
}