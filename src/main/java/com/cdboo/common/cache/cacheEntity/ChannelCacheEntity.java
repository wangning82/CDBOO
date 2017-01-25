package com.cdboo.common.cache.cacheEntity;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import com.thinkgem.jeesite.modules.sys.entity.Office;

public class ChannelCacheEntity extends AbstractCache<Office>{

	@SuppressWarnings("rawtypes")
	@Override
	protected CrudService getService() {
		return SpringContextHolder.getBean("cdbooChannelService");
	}
}
