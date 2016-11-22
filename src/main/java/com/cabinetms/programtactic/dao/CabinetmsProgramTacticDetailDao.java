/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.programtactic.dao;

import java.util.LinkedHashMap;
import java.util.List;
import com.cabinetms.programtactic.entity.CabinetmsProgramTacticDetail;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

/**
 * 节目策略一对多生成DAO接口
 * @author 于滨
 * @version 2016-10-19
 */
@MyBatisDao
public interface CabinetmsProgramTacticDetailDao extends CrudDao<CabinetmsProgramTacticDetail> {
	public List<LinkedHashMap<String, Object>> findListForPreView(CabinetmsProgramTacticDetail cabinetmsProgramTacticDetail);
}