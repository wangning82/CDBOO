/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.businessplantimestep.entity;

import com.cdboo.businessplan.entity.CdbooBusinessPlan;
import com.cdboo.timestep.entity.Timestep;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 行业计划时段表Entity
 * @author yubin
 * @version 2017-02-10
 */
public class CdbooBusinessPlanTimestep extends DataEntity<CdbooBusinessPlanTimestep> {
	
	private static final long serialVersionUID = 1L;
	private CdbooBusinessPlan businessPlan;		// 行业计划主键
	private Timestep timestep;		// 时段主键
	
	public CdbooBusinessPlanTimestep() {
		super();
	}

	public CdbooBusinessPlanTimestep(String id){
		super(id);
	}

	public CdbooBusinessPlan getBusinessPlan() {
		return businessPlan;
	}

	public void setBusinessPlan(CdbooBusinessPlan businessPlan) {
		this.businessPlan = businessPlan;
	}
	
	public Timestep getTimestep() {
		return timestep;
	}

	public void setTimestep(Timestep timestep) {
		this.timestep = timestep;
	}
	
}