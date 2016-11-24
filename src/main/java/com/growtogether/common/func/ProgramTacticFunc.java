package com.growtogether.common.func;

import com.growtogether.programtactic.entity.CabinetmsProgramTactic;
import com.growtogether.programtactic.service.CabinetmsProgramTacticService;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;

public class ProgramTacticFunc extends AbstractCache<CabinetmsProgramTactic> {

	private CabinetmsProgramTacticService cabinetmsProgramTacticService = SpringContextHolder.getBean("cabinetmsProgramTacticService");
	
	@SuppressWarnings("rawtypes")
	@Override
	protected CrudService getService() {
		return cabinetmsProgramTacticService;
	}

}
