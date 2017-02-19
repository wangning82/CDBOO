/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.business.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdboo.business.dao.BusinessDao;
import com.cdboo.business.entity.Business;
import com.cdboo.business.entity.BusinessTimestep;
import com.cdboo.business.model.BusinessTimestepModel;
import com.cdboo.businessplan.dao.CdbooBusinessPlanDao;
import com.cdboo.businessplan.entity.CdbooBusinessPlan;
import com.cdboo.businessplantimestep.dao.CdbooBusinessPlanTimestepDao;
import com.cdboo.businessplantimestep.entity.CdbooBusinessPlanTimestep;
import com.cdboo.busiplantimechannel.dao.CdbooBusinessPlanTimestepChannelDao;
import com.cdboo.busiplantimechannel.entity.CdbooBusinessPlanTimestepChannel;
import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channelmusic.dao.CdbooChannelMusicDao;
import com.cdboo.channelmusic.entity.CdbooChannelMusic;
import com.cdboo.childchannel.dao.CdbooGroupChildDao;
import com.cdboo.childchannel.entity.CdbooGroupChild;
import com.cdboo.myplan.dao.CdbooMyPlanDao;
import com.cdboo.myplan.dao.CdbooMyPlanTimestepChannelDao;
import com.cdboo.myplan.dao.CdbooMyPlanTimestepDao;
import com.cdboo.myplan.entity.CdbooMyPlan;
import com.cdboo.myplan.entity.CdbooMyPlanTimestep;
import com.cdboo.myplan.entity.CdbooMyPlanTimestepChannel;
import com.cdboo.timestep.entity.Timestep;
import com.cdboo.userchannel.dao.CdbooUserChannelDao;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.usergroup.entity.CdbooUserGroup;
import com.cdboo.usergroup.service.CdbooUserGroupService;
import com.cdboo.usermusic.dao.CdbooOwnerMusicDao;
import com.cdboo.usermusic.entity.CdbooOwnerMusic;
import com.cdboo.userplan.dao.CdbooPlanDao;
import com.cdboo.userplan.entity.CdbooPlan;
import com.cdboo.usertimestep.dao.CdbooUserTimestepDao;
import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 行业Service
 * @author 朱广成
 * @version 2016-12-01
 */
@Service
@Transactional(readOnly = true)
public class BusinessService extends TreeService<BusinessDao, Business> {

	@Autowired
	private BusinessDao businessDao;

	@Autowired
	private CdbooPlanDao cdbooPlanDao;

	@Autowired
	private CdbooUserChannelDao cdbooUserChannelDao;

	@Autowired
	private CdbooUserTimestepDao cdbooUserTimestepDao;

	@Autowired
	private CdbooGroupChildDao cdbooGroupChildDao;

	@Autowired
	private CdbooUserGroupService cdbooUserGroupService;
	
	@Autowired
	private CdbooBusinessPlanDao cdbooBusinessPlanDao;
	
	@Autowired
	private CdbooBusinessPlanTimestepDao cdbooBusinessPlanTimestepDao;
	
	@Autowired
	private CdbooBusinessPlanTimestepChannelDao cdbooBusinessPlanTimestepChannelDao;
	
	@Autowired
	private CdbooMyPlanDao cdbooMyPlanDao;
	
	@Autowired
	private CdbooMyPlanTimestepDao cdbooMyPlanTimestepDao;
	
	@Autowired
	private CdbooMyPlanTimestepChannelDao cdbooMyPlanTimestepChannelDao;

	@Autowired
	private CdbooChannelMusicDao cdbooChannelMusicDao;
	
	@Autowired
	private CdbooOwnerMusicDao cdbooOwnerMusicDao;
	
	public Business get(String id) {
		return super.get(id);
	}
	
	public List<Business> findList(Business business) {
		if (StringUtils.isNotBlank(business.getParentIds())){
			business.setParentIds(","+business.getParentIds()+",");
		}
		return super.findList(business);
	}
	
	@Transactional(readOnly = false)
	public void save(Business business) {
		super.save(business);
	}
	
	@Transactional(readOnly = false)
	public void delete(Business business) {
		super.delete(business);
	}

	public Page<BusinessTimestep> findTimestepByBusinessTimestep(Page<BusinessTimestep> page, BusinessTimestep businessTimestep) {
		List<BusinessTimestep> list = businessDao.findTimestepByBusinessTimestep(businessTimestep);
		page.setList(list);
		return page;
	}

	@Transactional(readOnly = false)
	public void save(BusinessTimestepModel businessTimestepModel) {

		Business business = new Business();
		business.setId(businessTimestepModel.getBusinessId());

		for (BusinessTimestep businessTimestep : businessTimestepModel.getBusinessTimestepList()) {
			if (businessTimestep.getId() == null){
				continue;
			}

			businessTimestep.setBusiness(business);
			if (BusinessTimestep.DEL_FLAG_NORMAL.equals(businessTimestep.getDelFlag())){
				if (org.apache.commons.lang3.StringUtils.isBlank(businessTimestep.getId())) {
					businessTimestep.preInsert();
					businessDao.insertBusinessTimestep(businessTimestep);
				} else {
					businessTimestep.preUpdate();
					businessDao.updateBusinessTimestep(businessTimestep);
				}
			} else {
				businessDao.deleteBusinessTimestep(businessTimestep);
			}

		}

	}

	public BusinessTimestep getBusinessTimestep(String id) {
		return businessDao.getBusinessTimestep(id);
	}

	@Transactional(readOnly = false)
	public void initUserBusiness(User user) {
		Business business = user.getBusiness();

		CdbooBusinessPlan cdbooBusinessPlan = new CdbooBusinessPlan();
		cdbooBusinessPlan.setBusiness(business);

		List<CdbooBusinessPlan> businessPlans = cdbooBusinessPlanDao.findList(cdbooBusinessPlan);

		if (CollectionUtils.isNotEmpty(businessPlans)) {

			CdbooUserTimestep checkUserTimestep = new CdbooUserTimestep();
			CdbooUserChannel checkUserChannel = new CdbooUserChannel();

			for (CdbooBusinessPlan cdbooBusinessPlan2 : businessPlans) {

				/**********************
				 * 根据行业模板创建计划对象 Start
				 **********************/
				CdbooMyPlan cdbooMyPlan = new CdbooMyPlan(cdbooBusinessPlan2.getPlanName(), user,
						cdbooBusinessPlan2.getWeek(), cdbooBusinessPlan2.getStyle(), cdbooBusinessPlan2.getStartDate(),
						cdbooBusinessPlan2.getEndDate(), cdbooBusinessPlan2.getCycleIndex(),
						cdbooBusinessPlan2.getIntervalTime());
				cdbooMyPlan.preInsert();
				cdbooMyPlanDao.insert(cdbooMyPlan);
				/********************** 根据行业模板创建计划对象 End **********************/

				/**********************
				 * 根据行业模板id查询行业下所有的时段对象 Start
				 **********************/
				CdbooBusinessPlanTimestep cdbooBusinessPlanTimestep = new CdbooBusinessPlanTimestep();
				cdbooBusinessPlanTimestep.setBusinessPlan(cdbooBusinessPlan2);
				List<CdbooBusinessPlanTimestep> timeStepList = cdbooBusinessPlanTimestepDao
						.findList(cdbooBusinessPlanTimestep);
				/**********************
				 * 根据行业模板id查询行业下所有的时段对象 End
				 **********************/

				for (CdbooBusinessPlanTimestep cdbooBusinessPlanTimestep2 : timeStepList) {

					/**********************
					 * 将用户和时段信息关联起来，存到用户时段表中 Start
					 **********************/
					Timestep timestep = cdbooBusinessPlanTimestep2.getTimestep();

					checkUserTimestep.setUser(user);
					checkUserTimestep.setName(timestep.getTimestepName());
					List<CdbooUserTimestep> checkList = cdbooUserTimestepDao.findList(checkUserTimestep);

					CdbooUserTimestep cdbooUserTimestep = null;
					if (CollectionUtils.isEmpty(checkList)) {
						cdbooUserTimestep = new CdbooUserTimestep(user, timestep.getTimestepName(),
								timestep.getStarttime(), timestep.getEndtime());
						cdbooUserTimestep.preInsert();
						cdbooUserTimestepDao.insert(cdbooUserTimestep);
					} else {
						cdbooUserTimestep = checkList.get(0);
					}
					/**********************
					 * 将用户和时段信息关联起来，存到用户时段表中 End
					 **********************/

					/**********************
					 * 根据行业模板创建计划时段关联信息，存入数据库中 Start
					 **********************/
					CdbooMyPlanTimestep cdbooMyPlanTimestep = new CdbooMyPlanTimestep(cdbooMyPlan, cdbooUserTimestep);
					cdbooMyPlanTimestep.preInsert();
					cdbooMyPlanTimestepDao.insert(cdbooMyPlanTimestep);
					/**********************
					 * 根据行业模板创建计划时段关联信息 End
					 **********************/

					/**********************
					 * 根据行业模板下的每一个时段信息检索对应的频道信息 Start
					 **********************/
					CdbooBusinessPlanTimestepChannel businessPlanTimestepChannel = new CdbooBusinessPlanTimestepChannel();
					businessPlanTimestepChannel.setBusinessPlanTimestep(cdbooBusinessPlanTimestep2);
					List<CdbooBusinessPlanTimestepChannel> channelList = cdbooBusinessPlanTimestepChannelDao
							.findList(businessPlanTimestepChannel);
					/**********************
					 * 根据行业模板下的每一个时段信息检索对应的频道信息 End
					 **********************/

					for (CdbooBusinessPlanTimestepChannel cdbooBusinessPlanTimestepChannel : channelList) {

						CdbooChannel channel = cdbooBusinessPlanTimestepChannel.getChannel();

						CdbooChannelMusic channelMusic = new CdbooChannelMusic();
						channelMusic.setChannel(channel);
						List<CdbooChannelMusic> musicList = cdbooChannelMusicDao.findList(channelMusic);
						if(CollectionUtils.isNotEmpty(musicList)){
							for (CdbooChannelMusic cdbooChannelMusic : musicList) {
								CdbooOwnerMusic cdbooOwnerMusic = new CdbooOwnerMusic();
								cdbooOwnerMusic.setUser(user);
								cdbooOwnerMusic.setMusicId(cdbooChannelMusic.getMusic());
								cdbooOwnerMusic.preInsert();
								cdbooOwnerMusicDao.insert(cdbooOwnerMusic);
							}
						}
						
						checkUserChannel.setUser(user);
						checkUserChannel.setChannel(channel);
						List<CdbooUserChannel> checkChannelList = cdbooUserChannelDao.findList(checkUserChannel);

						CdbooUserChannel cdbooUserChannel = null;
						if (CollectionUtils.isEmpty(checkChannelList)) {
							/**********************
							 * 将用户和频道信息信息关联起来，存到用户频道表中 Start
							 **********************/
							cdbooUserChannel = new CdbooUserChannel(user, channel, channel.getChannelType());
							cdbooUserChannel.preInsert();
							cdbooUserChannelDao.insert(cdbooUserChannel);
							/**********************
							 * 将用户和频道信息信息关联起来，存到用户频道表中 End
							 **********************/
						} else {
							cdbooUserChannel = checkChannelList.get(0);
						}

						/**********************
						 * 根据行业模板创建计划时段与频道关联信息，存入数据库中 Start
						 **********************/
						CdbooMyPlanTimestepChannel cdbooMyPlanTimestepChannel = new CdbooMyPlanTimestepChannel(
								cdbooMyPlanTimestep, cdbooUserChannel, channel.getChannelType(),
								cdbooBusinessPlanTimestepChannel.getOperationType());
						cdbooMyPlanTimestepChannel.preInsert();
						cdbooMyPlanTimestepChannelDao.insert(cdbooMyPlanTimestepChannel);
						/**********************
						 * 根据行业模板创建计划时段与频道关联信息，存入数据库中 End
						 **********************/
					}
				}
			}
		}
	}

	@Transactional(readOnly = false)
	public void initUserBusiness1(User user) {
		Business business = user.getBusiness();

		
		BusinessTimestep businessTimestep = new BusinessTimestep();
		businessTimestep.setBusiness(business);

		List<BusinessTimestep> list = businessDao.findTimestepByBusinessTimestep(businessTimestep);

		for (BusinessTimestep _businessTimestep : list) {
			CdbooChannel channel = _businessTimestep.getChannel();
			Timestep timestep = _businessTimestep.getTimestep();


			CdbooUserChannel userChannel = new CdbooUserChannel();

			//0 , 简单频道 1, 组合频道 2, 插播频道
			if (StringUtils.equals(channel.getChannelType(), "1")) {

				CdbooUserGroup cdbooUserGroup = new CdbooUserGroup();
				cdbooUserGroup.setUser(user);
				cdbooUserGroup.setCdbooChannel(channel);
				cdbooUserGroupService.save(cdbooUserGroup);

				CdbooGroupChild cdbooGroupChild = new CdbooGroupChild();
				cdbooGroupChild.setGroupChannelId(channel);
				List<CdbooGroupChild> cdbooGroupChildList = cdbooGroupChildDao.findGroupList(cdbooGroupChild);

				for (CdbooGroupChild _cdbooGroupChild : cdbooGroupChildList) {
					CdbooUserChannel cdbooUserChannel = new CdbooUserChannel();
					cdbooUserChannel.setUser(user);
					cdbooUserChannel.setChannel(_cdbooGroupChild.getChildChannelId());
					cdbooUserChannel.preInsert();

					cdbooUserChannelDao.insert(cdbooUserChannel);
				}


			} else {
				userChannel.preInsert();
				userChannel.setUser(user);
				userChannel.setChannel(channel);
			}

			CdbooUserTimestep userTimestep = new CdbooUserTimestep();
			userTimestep.preInsert();
			userTimestep.setName(timestep.getTimestepName());
			userTimestep.setUser(user);
			userTimestep.setStartTime(timestep.getStarttime());
			userTimestep.setEndTime(timestep.getEndtime());

			CdbooPlan plan = new CdbooPlan();
			plan.preInsert();
			plan.setUser(user);
			plan.setMusicStyle(channel.getThemeType());
			plan.setTimestep(timestep);
			plan.setChannel(channel);
			plan.setUserTimestepId(userTimestep.getId());
			plan.setUserChannelId(userChannel.getId());

			cdbooUserChannelDao.insert(userChannel);
			cdbooUserTimestepDao.insert(userTimestep);
			cdbooPlanDao.insert(plan);
		}




	}
}