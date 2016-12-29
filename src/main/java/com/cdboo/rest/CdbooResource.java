package com.cdboo.rest;

import com.alibaba.fastjson.JSON;
import com.cdboo.common.Constants;
import com.cdboo.userplan.entity.CdbooPlan;
import com.cdboo.userplan.service.CdbooPlanService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import flexjson.JSONSerializer;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;

import javax.ws.rs.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mmzz on 2016/12/22.
 */

@Path("cdboo-service")
public class CdbooResource {

    @Autowired
    private SystemService systemService;

    @Autowired
    private CdbooPlanService planService;


    /**
     * 保存客户
     * @param userName
     * @return
     * @throws Exception
     */
    @POST
    @Path("check-guser")
    @Produces("application/json")
    @Consumes("application/x-www-form-urlencoded")
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
     * 保存客户
     * @param userId
     * @return
     * @throws Exception
     */
    @POST
    @Path("get-mp3")
    @Produces("application/json")
    @Consumes("application/x-www-form-urlencoded")
    public String getList(@FormParam("userId")String userId) throws Exception {
        User user = new User();
        user.setId(userId);
        CdbooPlan cdbooPlan = new CdbooPlan();
        cdbooPlan.setUser(user);
        List<CdbooPlan> list = planService.findList(cdbooPlan);

        List<RestModel> modelList = new ArrayList<>();

        for (CdbooPlan cdbooPlan1 : list) {
            RestModel model = new RestModel();
            BeanUtils.copyProperties(model, cdbooPlan1);

            model.setChannel(cdbooPlan1.getChannel());
            model.setTimestep(cdbooPlan1.getTimestep());
            modelList.add(model);
        }

//        return JSON.toJSONString(list);
        return new JSONSerializer().deepSerialize(modelList);
    }

    /**
     * md5
     * */
    public static String md5Hex(String data) {
        return DigestUtils.md5Hex(data);
    }




}
