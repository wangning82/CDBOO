package com.cdboo.usergroup.service;

import com.cdboo.userchannel.dao.CdbooUserChannelDao;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.usergroup.dao.CdbooUserGroupDao;
import com.cdboo.usergroup.entity.CdbooUserGroup;
import com.thinkgem.jeesite.common.service.CrudService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by mmzz on 2017/1/3.
 */
@Service
@Transactional(readOnly = true)
public class CdbooUserGroupService extends CrudService<CdbooUserGroupDao, CdbooUserGroup> {



}
