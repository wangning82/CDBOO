/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.taluser.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cdboo.taluser.entity.TalUser;

/**
 * 首页功能DAO接口
 * @author wn
 * @version 2016-12-28
 */
@MyBatisDao
public interface TalUserDao extends CrudDao<TalUser> {
	
}