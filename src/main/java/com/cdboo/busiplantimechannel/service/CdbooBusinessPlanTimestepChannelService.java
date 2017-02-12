/**
 * 
 */
package com.cdboo.busiplantimechannel.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.busiplantimechannel.dao.CdbooBusinessPlanTimestepChannelDao;
import com.cdboo.busiplantimechannel.entity.CdbooBusinessPlanTimestepChannel;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * @author yubin
 *
 */
@Service
@Transactional(readOnly=true)
public class CdbooBusinessPlanTimestepChannelService extends CrudService<CdbooBusinessPlanTimestepChannelDao, CdbooBusinessPlanTimestepChannel> {

}
