package com.cabinetms.common.func;

import com.cabinetms.program.entity.Program;
import com.cabinetms.program.service.ProgramService;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;

public class ProgramFunc extends AbstractCache<Program> {

	private ProgramService programService = SpringContextHolder.getBean("programService");

	@SuppressWarnings("rawtypes")
	@Override
	protected CrudService getService() {
		return programService;
	}

}
