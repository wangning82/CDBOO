package com.cdboo.usergroup.dao;

import com.cdboo.usergroup.entity.CdbooUserGroup;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

/**
 * Created by mmzz on 2017/1/3.
 */
@MyBatisDao
public interface CdbooUserGroupDao extends CrudDao<CdbooUserGroup> {
	public void remove(CdbooUserGroup cdbooUserGroup);

}
