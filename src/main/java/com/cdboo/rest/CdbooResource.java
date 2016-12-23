package com.cdboo.rest;

import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import flexjson.JSONSerializer;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;

import javax.ws.rs.*;

/**
 * Created by mmzz on 2016/12/22.
 */

@Path("cdboo-service")
public class CdbooResource {

    @Autowired
    private SystemService systemService;

    /**
     * 保存客户
     * @param user
     * @return
     * @throws Exception
     */
    @POST
    @Path("check-guser")
    @Consumes("application/x-www-form-urlencoded")
    public boolean checkUser(@FormParam("userName")String userName, @FormParam("password") String password) throws Exception {

        User user = systemService.getUserByLoginName(userName);

        if (user != null && StringUtils.equals(user.getCdbooPassword(), md5Hex(password))) {
            return true;
        } else {
            return false;
        }
    }



    /**
     * md5
     * */
    public static String md5Hex(String data) {
        return DigestUtils.md5Hex(data);
    }




}
