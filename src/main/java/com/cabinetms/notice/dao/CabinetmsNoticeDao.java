/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.notice.dao;

import com.cabinetms.notice.entity.CabinetmsNotice;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

/**
 * 消息信息DAO接口
 * @author houyi
 * @version 2016-10-11
 */
@MyBatisDao
public interface CabinetmsNoticeDao extends CrudDao<CabinetmsNotice> {


}