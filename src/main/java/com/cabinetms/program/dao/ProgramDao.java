/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.program.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cabinetms.program.entity.Program;

/**
 * 节目管理DAO接口
 * @author 朱广成
 * @version 2016-10-19
 */
@MyBatisDao
public interface ProgramDao extends CrudDao<Program> {
	
}