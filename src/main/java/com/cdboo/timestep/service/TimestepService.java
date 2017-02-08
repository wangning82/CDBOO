/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.timestep.service;

import java.util.List;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cdboo.timestep.dao.TimestepDao;
import com.cdboo.timestep.entity.Timestep;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 时段管理Service
 * @author 朱广成
 * @version 2016-12-13
 */
@Service
@Transactional(readOnly = true)
public class TimestepService extends CrudService<TimestepDao, Timestep> {

	public Timestep get(String id) {
		return super.get(id);
	}
	
	public List<Timestep> findList(Timestep timestep) {
		return super.findList(timestep);
	}

	public Page<Timestep> findPage(Page<Timestep> page, Timestep timestep) {
		return super.findPage(page, timestep);
	}

	public synchronized int getMaxTimestepNo(){
		List<Timestep> timesteps = dao.getMaxTimestepNo(new Timestep());
		if(CollectionUtils.isNotEmpty(timesteps)){
			Timestep timestep = timesteps.get(0);
			if(timestep!=null){
				Integer timeStepNo = timestep.getTimestepNo();
				if(timeStepNo!=null){
					return timeStepNo+1;
				}
			}
		}
		return 1;
	}
	
	@Transactional(readOnly = false)
	public void save(Timestep timestep) {
		timestep.setTimestepNo(getMaxTimestepNo());
		super.save(timestep);
	}
	
	@Transactional(readOnly = false)
	public void delete(Timestep timestep) {
		super.delete(timestep);
	}
	
}