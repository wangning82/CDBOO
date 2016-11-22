/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.noticetactic.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.cabinetms.noticetactic.entity.CabinetmsNoticeTactic;
import com.cabinetms.noticetactic.dao.CabinetmsNoticeTacticDao;

/**
 * 消息策略Service
 * @author 付殿东
 * @version 2016-10-11
 */
@Service
@Transactional(readOnly = true)
public class CabinetmsNoticeTacticService extends CrudService<CabinetmsNoticeTacticDao, CabinetmsNoticeTactic> {

	public CabinetmsNoticeTactic get(String id) {
		return super.get(id);
	}
	
	public List<CabinetmsNoticeTactic> findList(CabinetmsNoticeTactic cabinetmsNoticeTactic) {
		return super.findList(cabinetmsNoticeTactic);
	}
	
	public Page<CabinetmsNoticeTactic> findPage(Page<CabinetmsNoticeTactic> page, CabinetmsNoticeTactic cabinetmsNoticeTactic) {
		return super.findPage(page, cabinetmsNoticeTactic);
	}
	
	@Transactional(readOnly = false)
	public void save(CabinetmsNoticeTactic cabinetmsNoticeTactic) {
		super.save(cabinetmsNoticeTactic);
	}
	
	@Transactional(readOnly = false)
	public void delete(CabinetmsNoticeTactic cabinetmsNoticeTactic) {
		super.delete(cabinetmsNoticeTactic);
	}
	
}