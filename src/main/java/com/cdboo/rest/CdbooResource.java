package com.cdboo.rest;

import com.cdboo.common.Constants;
import com.cdboo.userplan.entity.CdbooPlan;
import com.cdboo.userplan.service.CdbooPlanService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.ws.rs.FormParam;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mmzz on 2016/12/22.
 */

@Controller
@RequestMapping("/cdboo-service")
public class CdbooResource {

    @Autowired
    private SystemService systemService;

    @Autowired
    private CdbooPlanService planService;


    /**
     * 用户登录
     * @param userName
     * @return
     * @throws Exception
     */
    @RequestMapping(value="check-user", method= RequestMethod.POST, headers="Content-Type=application/json")
    @ResponseBody
    public String checkUser(@FormParam("userName")String userName, @FormParam("password") String password) throws Exception {

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
    @RequestMapping(value="get-data", method= RequestMethod.POST, headers="Content-Type=application/json")
    @ResponseBody
    public RestModel getData(@FormParam("userName")String userName) throws Exception {
        User user = new User();
        user.setName(userName);
        CdbooPlan cdbooPlan = new CdbooPlan();
        cdbooPlan.setUser(user);
        List<CdbooPlan> list = planService.findList(cdbooPlan);

        RestModel model = new RestModel();
        List<PlanModel> planModelList = new ArrayList<>();

        for (CdbooPlan _cdbooPlan : list) {
            PlanModel planModel = new PlanModel();
            BeanUtils.copyProperties(planModel, _cdbooPlan);
            model.setUserName(_cdbooPlan.getUser().getName());
            model.setPhoto(_cdbooPlan.getUser().getPhoto());
            planModelList.add(planModel);
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
