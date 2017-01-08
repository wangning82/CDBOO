package com.cdboo.rest;

import com.cdboo.common.Constants;
import com.cdboo.music.entity.CdbooMusic;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.userchannel.service.CdbooUserChannelService;
import com.cdboo.userplan.entity.CdbooPlan;
import com.cdboo.userplan.service.CdbooPlanService;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.ws.rs.FormParam;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

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
        } else if (StringUtils.equals(user.getCdbooPassword(), md5Hex(password))) {
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
        List<CdbooPlan> list = planService.findList(cdbooPlan);

        RestModel model = new RestModel();
        List<PlanModel> planModelList = new ArrayList<>();

        for (CdbooPlan _cdbooPlan : list) {
            PlanModel planModel = new PlanModel();
//            BeanUtils.copyProperties(planModel, _cdbooPlan);
            planModel.setPlanNo(_cdbooPlan.getPlanNo());
            planModel.setPlayName(_cdbooPlan.getPlayName());
            planModel.setMusicStyle(_cdbooPlan.getMusicStyle());
            planModel.setWeek(_cdbooPlan.getWeek());
            planModel.setStartDate(_cdbooPlan.getStartDate() != null ? new SimpleDateFormat("yyyy-MM-dd").format(_cdbooPlan.getStartDate()) : null);
            planModel.setEndDate(_cdbooPlan.getEndDate() != null ? new SimpleDateFormat("yyyy-MM-dd").format(_cdbooPlan.getEndDate()) : null);
            planModel.setStatus(_cdbooPlan.getStatus());
            planModel.setCycleTimes(_cdbooPlan.getRate());
            planModel.setCondition(_cdbooPlan.getCondition());

            RestTimeStep restTimeStep = new RestTimeStep();
            if (_cdbooPlan.getTimestep() != null) {
                restTimeStep.setStarttime(_cdbooPlan.getTimestep().getStarttime());
                restTimeStep.setEndtime(_cdbooPlan.getTimestep().getEndtime());
                restTimeStep.setTimestepNo(_cdbooPlan.getTimestep().getTimestepNo());
                restTimeStep.setTimestepName(_cdbooPlan.getTimestep().getTimestepName());
            }
            planModel.setTimestep(restTimeStep);

            RestChannel restChannel = new RestChannel();
            if (_cdbooPlan.getChannel() != null) {
                BeanUtils.copyProperties(restChannel, _cdbooPlan.getChannel());
            }

            CdbooUserChannel  cdbooUserChannel = new CdbooUserChannel();
            cdbooUserChannel.setUser(_cdbooPlan.getUser());
            cdbooUserChannel.setChannel(_cdbooPlan.getChannel());
            List<CdbooUserChannel> userChannels = cdbooUserChannelService.findList(cdbooUserChannel);

            List<RestMusic> musicList = Lists.newArrayList();
            for (CdbooUserChannel channel : userChannels) {
                RestMusic restMusic = new RestMusic();
                CdbooMusic cdbooMusic = channel.getMusic();

                BeanUtils.copyProperties(restMusic, cdbooMusic);

                musicList.add(restMusic);
            }
            restChannel.setMusicList(musicList);

            planModel.setChannel(restChannel);
            planModelList.add(planModel);

            model.setUserName(_cdbooPlan.getUser().getName());
            model.setPhoto(_cdbooPlan.getUser().getPhoto());
        }
        model.setPlanModelList(planModelList);
        return model;
    }

    /**
     * md5
     * */
    public static String md5Hex(String data) {
        return DigestUtils.md5Hex(data);
    }




}
