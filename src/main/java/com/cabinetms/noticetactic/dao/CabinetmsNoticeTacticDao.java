/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.noticetactic.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cabinetms.noticetactic.entity.CabinetmsNoticeTactic;

/**
 * 消息策略DAO接口
 * @author 付殿东
 * @version 2016-10-11
 */
@MyBatisDao
public interface CabinetmsNoticeTacticDao extends CrudDao<CabinetmsNoticeTactic> {
	
}