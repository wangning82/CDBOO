/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.timestep.service;

import java.util.List;

import com.cdboo.business.entity.BusinessTimestep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cdboo.timestep.entity.Timestep;
import com.cdboo.timestep.dao.TimestepDao;

/**
 * 时段管理Service
 * @author 朱广成
 * @version 2016-12-13
 */
@Service
@Transactional(readOnly = true)
public class TimestepService extends CrudService<TimestepDao, Timestep> {

	@Autowired
	private TimestepDao timestepDao;

	public Timestep get(String id) {
		return super.get(id);
	}
	
	public List<Timestep> findList(Timestep timestep) {
		return super.findList(timestep);
	}

	public List<Timestep> findListByBusinessTimestep(BusinessTimestep businessTimestep) {
		return timestepDao.findListByBusinessTimestep(businessTimestep);
	}

	public Page<Timestep> findPage(Page<Timestep> page, Timestep timestep) {
		return super.findPage(page, timestep);
	}

	public Page<Timestep> findPage(Page<Timestep> page, BusinessTimestep businessTimestep) {
		List<Timestep> list = this.findListByBusinessTimestep(businessTimestep);
		page.setList(list);
		return page;
	}

	@Transactional(readOnly = false)
	public void save(Timestep timestep) {
		super.save(timestep);
	}
	
	@Transactional(readOnly = false)
	public void delete(Timestep timestep) {
		super.delete(timestep);
	}
	
}