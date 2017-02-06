package com.cdboo.myplan.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.myplan.dao.CdbooMyPlanTimestepChannelDao;
import com.cdboo.myplan.entity.CdbooMyPlanTimestepChannel;
import com.thinkgem.jeesite.common.service.CrudService;

@Service
@Transactional(readOnly = true)
public class CdbooMyPlanTimestepChannelService extends CrudService<CdbooMyPlanTimestepChannelDao, CdbooMyPlanTimestepChannel>{

}
