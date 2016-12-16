/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.business.dao;

import com.cdboo.business.entity.BusinessTimestep;
import com.cdboo.timestep.entity.Timestep;
import com.thinkgem.jeesite.common.persistence.TreeDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cdboo.business.entity.Business;

import java.util.List;

/**
 * 行业DAO接口
 * @author 朱广成
 * @version 2016-12-01
 */
@MyBatisDao
public interface BusinessDao extends TreeDao<Business> {
    public void insertBusinessTimestep(BusinessTimestep businessTimestep);
    List<BusinessTimestep> findTimestepByBusinessTimestep(BusinessTimestep businessTimestep);

    BusinessTimestep getBusinessTimestep(String id);

    void updateBusinessTimestep(BusinessTimestep businessTimestep);

    void deleteBusinessTimestep(BusinessTimestep businessTimestep);
}