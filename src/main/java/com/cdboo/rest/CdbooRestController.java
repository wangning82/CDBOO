package com.cdboo.rest;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.channel.service.CdbooChannelService;
import com.cdboo.channelmusic.entity.CdbooChannelMusic;
import com.cdboo.channelmusic.service.CdbooChannelMusicService;
import com.cdboo.childchannel.entity.CdbooGroupChild;
import com.cdboo.childchannel.service.CdbooGroupChildService;
import com.cdboo.common.Constants;
import com.cdboo.music.entity.CdbooMusic;
import com.cdboo.music.service.CdbooMusicService;
import com.cdboo.myplan.entity.CdbooMyPlan;
import com.cdboo.myplan.entity.CdbooMyPlanTimestep;
import com.cdboo.myplan.entity.CdbooMyPlanTimestepChannel;
import com.cdboo.myplan.service.CdbooMyPlanService;
import com.cdboo.myplan.service.CdbooMyPlanTimestepChannelService;
import com.cdboo.myplan.service.CdbooMyPlanTimestepService;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.userchannel.service.CdbooUserChannelService;
import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.cdboo.usertimestep.service.CdbooUserTimestepService;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;

/**
 * Created by mmzz on 2016/12/22.
 */

@Controller
@RequestMapping("/cdboo-service")
public class CdbooRestController {

	@Autowired
	private SystemService systemService;

	@Autowired
	private CdbooMyPlanService myPlanService;
	
	@Autowired
	private CdbooMyPlanTimestepService myPlanTimestepService;
	
	@Autowired
	private CdbooMyPlanTimestepChannelService myPlanTimestepChannelService;
	
	@Autowired
	private CdbooUserTimestepService userTimestepService;

	@Autowired
	private CdbooChannelMusicService channelMusicService;
	
	@Autowired
	private CdbooUserChannelService cdbooUserChannelService;

	@Autowired
	private CdbooChannelService channelService;
	
	@Autowired
	private CdbooMusicService cdbooMusicService;

	@Autowired
	private OfficeService officeService;

	@Autowired
	private CdbooGroupChildService cdbooGroupChildService;

	/**
	 * 用户登录
	 * 
	 * @param userName
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "check-user/{userName}/{password}", method = RequestMethod.GET)
	@ResponseBody
	public String checkUser(@PathVariable("userName") String userName, @PathVariable("password") String password)
			throws Exception {

		User user = systemService.getUserByLoginName(userName);
		if (user == null) {
			return Constants.USER_NOT_EXIST;
		} else if (SystemService.validatePassword(password, user.getPassword())) {
			return Constants.USER_PASSWORD_CORRECT;
		} else {
			return Constants.USER_PASSWORD_NOT_CORRECT;
		}
	}

	/**
	 * 获取用户数据
	 * 
	 * @param userName
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "get-data/{userName}", method = RequestMethod.GET)
	@ResponseBody
	public RestModel getData(@PathVariable("userName") String userName) throws Exception {
		User user = new User();
		user.setName(userName);
		User userObj = systemService.getUserByLoginName(userName);
		
		CdbooMyPlan cdbooMyPlan = new CdbooMyPlan();
		cdbooMyPlan.setUser(userObj);
		List<CdbooMyPlan> list = myPlanService.findList(cdbooMyPlan);
		
		RestModel model = new RestModel();
		model.setUserName(userObj.getName());
		model.setPhoneNumber(userObj.getPhone());
		model.setAddress(userObj.getAddress());
		model.setBusinessHoursBegin(userObj.getBusinessHoursBegin());
		model.setBusinessHoursEnd(userObj.getBusinessHoursEnd());
		model.setServiceTimeBegin(userObj.getServiceTimeBegin());
		model.setServiceTimeEnd(userObj.getServiceTimeEnd());
		model.setShopOwnerName(userObj.getShopOwnerName());

		model.setPhoto(userObj.getPhoto());

		List<PlanModel> planModelList = new ArrayList<>();

		CdbooMyPlanTimestep queryMyPlanTimestepObj = new CdbooMyPlanTimestep();
		CdbooMyPlanTimestepChannel queryMyPlanTimestepChannelObj = new CdbooMyPlanTimestepChannel();
		
		for (CdbooMyPlan _cdbooPlan : list) {
			queryMyPlanTimestepObj.setPlan(_cdbooPlan);
			List<CdbooMyPlanTimestep> myPlanTimesteps = myPlanTimestepService.findList(queryMyPlanTimestepObj);
			
			for (CdbooMyPlanTimestep cdbooMyPlanTimestep : myPlanTimesteps) {
				queryMyPlanTimestepChannelObj.setMyPlanTimestep(cdbooMyPlanTimestep);
				List<CdbooMyPlanTimestepChannel> myPlanTimestepChannels = myPlanTimestepChannelService.findList(queryMyPlanTimestepChannelObj);
				
				for (CdbooMyPlanTimestepChannel cdbooMyPlanTimestepChannel : myPlanTimestepChannels) {
					
					PlanModel planModel = new PlanModel();
					planModel.setPlayName(_cdbooPlan.getPlanName());
					planModel.setMusicStyle(_cdbooPlan.getStyle());
					planModel.setWeek(_cdbooPlan.getWeek());
					planModel.setStartDate(_cdbooPlan.getStartDate() != null
							? new SimpleDateFormat("yyyy-MM-dd").format(_cdbooPlan.getStartDate()) : null);
					planModel.setEndDate(_cdbooPlan.getEndDate() != null
							? new SimpleDateFormat("yyyy-MM-dd").format(_cdbooPlan.getEndDate()) : null);
					planModel.setCycleTimes(_cdbooPlan.getCycleIndex());
					planModel.setIntervalTime(_cdbooPlan.getIntervalTime());
					String operationType = cdbooMyPlanTimestepChannel.getOperationType();
					Office office = officeService.get(operationType);
					if (office != null) {
						String photo = office.getPhoto();
						planModel.setSceneImg(photo);
						planModel.setScene(office.getName());
					}

					RestTimeStep restTimeStep = new RestTimeStep();
					if (cdbooMyPlanTimestep != null) {
						CdbooUserTimestep userTimestep = cdbooMyPlanTimestep.getUserTimestep();
						String userTimeStepId = userTimestep.getId();
						CdbooUserTimestep cdbooUserTimestep = userTimestepService.get(userTimeStepId);
						
						restTimeStep.setStarttime(cdbooUserTimestep.getStartTime());
						restTimeStep.setEndtime(cdbooUserTimestep.getEndTime());
						restTimeStep.setTimestepName(cdbooUserTimestep.getName());
					}
					planModel.setTimestep(restTimeStep);

					RestChannel restChannel = new RestChannel();
					
					if (cdbooMyPlanTimestepChannel != null) {
						
						CdbooUserChannel userChannel = cdbooMyPlanTimestepChannel.getUserChannel();
						String userChannelId = userChannel.getId();
						CdbooUserChannel cdbooUserChannel = cdbooUserChannelService.get(userChannelId);
						String channelId = cdbooUserChannel.getChannel().getId();
						CdbooChannel _channel = channelService.get(channelId);
						
						String channelType = _channel.getChannelType();
						// 如果是子频道，走下面
						if (StringUtils.equals(channelType, Constants.CHANNEL_TYPE_CHILD)) {
							BeanUtils.copyProperties(restChannel, _channel);
							convertTheme(restChannel);
							restChannel.setMusicList(getMusicList(_cdbooPlan.getUser(), _channel));
						}
						// 如果是组合频道，走下面
						if (StringUtils.equals(channelType, Constants.CHANNEL_TYPE_GROUP)) {

							BeanUtils.copyProperties(restChannel, _channel);

							/********************
							 * 根据组合频道id查询子频道列表 Start
							 ********************/
							CdbooGroupChild cdbooGroupChild = new CdbooGroupChild();
							cdbooGroupChild.setGroupChannelId(_channel);
							List<CdbooChannel> childChannelList = cdbooGroupChildService
									.findChildChannelListByConditions(cdbooGroupChild);
							/********************
							 * 根据组合频道id查询子频道列表 End
							 ********************/

							/********************
							 * 根据子频道列表组装restChannelList Start
							 ********************/
							List<RestChannel> childRestChannelList = Lists.newArrayList();
							for (CdbooChannel cdbooChannel : childChannelList) {
								RestChannel restChildChannel = new RestChannel();
								BeanUtils.copyProperties(restChildChannel, cdbooChannel);
								convertTheme(restChildChannel);
								childRestChannelList.add(restChildChannel);

								restChildChannel.setMusicList(getMusicList(_cdbooPlan.getUser(), cdbooChannel));
							}
							restChannel.setChildChannelList(childRestChannelList);
							/********************
							 * 根据子频道列表组装restChannelList End
							 ********************/
						}
					}
					planModel.setChannel(restChannel);
					planModelList.add(planModel);
				}
			}
		}
		model.setPlanModelList(planModelList);
		return model;
	}

	private void convertTheme(RestChannel restChannel) {
		String theme = restChannel.getThemeType();
		String themeConcreteType = restChannel.getThemeConcreteType();
		if (StringUtils.equals(Constants.THEMETYPE_HOLIDAY, theme)) {
			restChannel.setThemeConcreteType(DictUtils.getDictLabel(themeConcreteType, "holiday_type", ""));
		}
	}

	private List<RestMusic> getMusicList(User user, CdbooChannel channel) {
		
		List<RestMusic> musicList = Lists.newArrayList();
		
		CdbooChannelMusic cdbooChannelMusic = new CdbooChannelMusic();
		cdbooChannelMusic.setChannel(channel);
		List<CdbooChannelMusic> channelMusics = channelMusicService.findList(cdbooChannelMusic);
		for (CdbooChannelMusic cdbooChannelMusic2 : channelMusics) {
			RestMusic restMusic = new RestMusic();
			CdbooMusic cdbooMusic = cdbooMusicService.get(cdbooChannelMusic2.getMusic().getId());
			try {
				BeanUtils.copyProperties(restMusic, cdbooMusic);
				File musicFile = new File(cdbooMusicService.getMusicPath(cdbooMusic.getPath()));
				if (musicFile.exists()) {
					restMusic.setLength(musicFile.length());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			musicList.add(restMusic);
		}
		
		return musicList;
	}
}
