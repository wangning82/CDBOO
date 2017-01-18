package com.cdboo.rest;

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
import com.cdboo.childchannel.entity.CdbooGroupChild;
import com.cdboo.childchannel.service.CdbooGroupChildService;
import com.cdboo.common.Constants;
import com.cdboo.music.dao.CdbooMusicDao;
import com.cdboo.music.entity.CdbooMusic;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.userchannel.service.CdbooUserChannelService;
import com.cdboo.userplan.entity.CdbooPlan;
import com.cdboo.userplan.service.CdbooPlanService;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

/**
 * Created by mmzz on 2016/12/22.
 */

@Controller
@RequestMapping("/cdboo-service")
public class CdbooRestController {

    @Autowired
    private SystemService systemService;

    @Autowired
    private CdbooPlanService planService;

    @Autowired
    private CdbooUserChannelService cdbooUserChannelService;

    @Autowired
    private CdbooMusicDao cdbooMusicDao;

    @Autowired
    private OfficeService officeService;
    
    @Autowired
    private CdbooGroupChildService cdbooGroupChildService;
    
    /**
     * 用户登录
     * @param userName
     * @return
     * @throws Exception
     */
    @RequestMapping(value="check-user/{userName}/{password}", method= RequestMethod.GET)
    @ResponseBody
    public String checkUser(@PathVariable("userName")String userName, @PathVariable("password") String password) throws Exception {

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
     * @param userName
     * @return
     * @throws Exception
     */
    @RequestMapping(value="get-data/{userName}", method= RequestMethod.GET)
    @ResponseBody
    public RestModel getData(@PathVariable("userName")String userName) throws Exception {
        User user = new User();
        user.setName(userName);
        CdbooPlan cdbooPlan = new CdbooPlan();
        cdbooPlan.setUser(user);
        List<CdbooPlan> list = planService.findMyList(cdbooPlan);

        User userObj = systemService.getUserByLoginName(userName);
        
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

        for (CdbooPlan _cdbooPlan : list) {
            PlanModel planModel = new PlanModel();
            planModel.setPlanNo(_cdbooPlan.getPlanNo());
            planModel.setPlayName(_cdbooPlan.getPlayName());
            planModel.setMusicStyle(_cdbooPlan.getMusicStyle());
            planModel.setWeek(_cdbooPlan.getWeek());
            planModel.setStartDate(_cdbooPlan.getStartDate() != null ? new SimpleDateFormat("yyyy-MM-dd").format(_cdbooPlan.getStartDate()) : null);
            planModel.setEndDate(_cdbooPlan.getEndDate() != null ? new SimpleDateFormat("yyyy-MM-dd").format(_cdbooPlan.getEndDate()) : null);
            planModel.setCycleTimes(_cdbooPlan.getRate());
            planModel.setIntervalTime(_cdbooPlan.getIntervalTime());
            String operationType = _cdbooPlan.getOperationType();
            Office office = officeService.get(operationType);
            if(office!=null){
            	String photo = office.getPhoto();
                planModel.setSceneImg(photo);
                planModel.setScene(office.getName());
            }
            
            RestTimeStep restTimeStep = new RestTimeStep();
            if (_cdbooPlan.getTimestep() != null) {
                restTimeStep.setStarttime(_cdbooPlan.getTimestep().getStarttime());
                restTimeStep.setEndtime(_cdbooPlan.getTimestep().getEndtime());
                restTimeStep.setTimestepName(_cdbooPlan.getTimestep().getTimestepName());
            }
            planModel.setTimestep(restTimeStep);

            RestChannel restChannel = new RestChannel();
            CdbooChannel _channel = _cdbooPlan.getChannel();
            if (_channel != null) {
            	String channelType = _channel.getChannelType();
            	//如果是子频道，走下面
            	if(StringUtils.equals(channelType, Constants.CHANNEL_TYPE_CHILD)){
					BeanUtils.copyProperties(restChannel, _cdbooPlan.getChannel());
					restChannel.setMusicList(getMusicList(_cdbooPlan.getUser(), _channel));
            	}
            	//如果是组合频道，走下面
            	if(StringUtils.equals(channelType, Constants.CHANNEL_TYPE_GROUP)){
            		
            		/******************** 根据组合频道id查询子频道列表 Start ********************/
            		CdbooGroupChild cdbooGroupChild = new CdbooGroupChild();
            		cdbooGroupChild.setGroupChannelId(_channel);
            		List<CdbooChannel> childChannelList = cdbooGroupChildService.findChildChannelListByConditions(cdbooGroupChild);
            		/******************** 根据组合频道id查询子频道列表 End ********************/
            		
            		/******************** 根据子频道列表组装restChannelList Start ********************/
            		List<RestChannel> childRestChannelList = Lists.newArrayList();
            		for (CdbooChannel cdbooChannel : childChannelList) {
            			RestChannel restChildChannel = new RestChannel();
            			BeanUtils.copyProperties(restChildChannel, cdbooChannel);
            			childRestChannelList.add(restChildChannel);
            			
            			restChildChannel.setMusicList(getMusicList(_cdbooPlan.getUser(), cdbooChannel));
					}
            		restChannel.setChildChannelList(childRestChannelList);
            		/******************** 根据子频道列表组装restChannelList End ********************/
            	}
            }
            planModel.setChannel(restChannel);
            planModelList.add(planModel);
        }
        model.setPlanModelList(planModelList);
        return model;
    }
    
	private List<RestMusic> getMusicList(User user, CdbooChannel channel) {
		CdbooUserChannel cdbooUserChannel = new CdbooUserChannel();
		cdbooUserChannel.setUser(user);
		cdbooUserChannel.setChannel(channel);
		List<CdbooUserChannel> userChannels = cdbooUserChannelService.findList(cdbooUserChannel);

		List<RestMusic> musicList = Lists.newArrayList();
		for (CdbooUserChannel channelObj : userChannels) {
			RestMusic restMusic = new RestMusic();
			CdbooMusic cdbooMusic = cdbooMusicDao.get(channelObj.getMusic().getId());
			try {
				BeanUtils.copyProperties(restMusic, cdbooMusic);
			} catch (Exception e) {
				e.printStackTrace();
			}
			musicList.add(restMusic);
		}

		return musicList;
	}

}
