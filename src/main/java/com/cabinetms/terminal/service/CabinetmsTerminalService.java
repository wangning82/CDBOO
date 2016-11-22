/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.terminal.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cabinetms.terminal.entity.CabinetmsTerminal;
import com.cabinetms.terminal.dao.CabinetmsTerminalDao;

/**
 * 终端管理Service
 * @author houyi
 * @version 2016-10-11
 */
@Service("terminalService")
@Transactional(readOnly = true)
public class CabinetmsTerminalService extends CrudService<CabinetmsTerminalDao, CabinetmsTerminal> {

	@Autowired
	private CabinetmsTerminalDao cabinetmsTerminalDao;

	public CabinetmsTerminal get(String id) {
		return super.get(id);
	}
	
	public List<CabinetmsTerminal> findList(CabinetmsTerminal cabinetmsTerminal) {
		return super.findList(cabinetmsTerminal);
	}

	public List<CabinetmsTerminal> findAllConnectedList(CabinetmsTerminal cabinetmsTerminal) {
		return cabinetmsTerminalDao.findAllConnectedList(cabinetmsTerminal);
	}

	public Page<CabinetmsTerminal> findPage(Page<CabinetmsTerminal> page, CabinetmsTerminal cabinetmsTerminal) {
		return super.findPage(page, cabinetmsTerminal);
	}
	
	@Transactional(readOnly = false)
	public void save(CabinetmsTerminal cabinetmsTerminal) {
		super.save(cabinetmsTerminal);
	}
	
	@Transactional(readOnly = false)
	public void delete(CabinetmsTerminal cabinetmsTerminal) {
		super.delete(cabinetmsTerminal);
	}

	@Transactional(readOnly = false)
	public void updateByIP(CabinetmsTerminal cabinetmsTerminal){
		cabinetmsTerminalDao.updateByIP(cabinetmsTerminal);
	}
	
}