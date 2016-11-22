package com.cabinetms.common.func;

import com.cabinetms.programtactic.entity.CabinetmsProgramTactic;
import com.cabinetms.programtactic.service.CabinetmsProgramTacticService;
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
