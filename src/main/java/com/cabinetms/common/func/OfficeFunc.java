/**
 * 
 */
package com.cabinetms.common.func;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;

/**
 * @author yubin
 *
 */
public class OfficeFunc extends AbstractCache<Office> {

	private OfficeService officeService = SpringContextHolder.getBean("officeService");
	
	@SuppressWarnings("rawtypes")
	@Override
	protected CrudService getService() {
		return officeService;
	}

}
