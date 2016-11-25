/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.growtogether.taluser.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.growtogether.taluser.dao.TalUserDao;
import com.growtogether.taluser.dao.TalUserDaoImplement;
import com.growtogether.taluser.entity.TalUser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 终端用户注册后的管理功能Service
 * @author wn
 * @version 2016-11-24
 */
@Service
@Transactional(readOnly = true)
public class TalUserService extends CrudService<TalUserDao, TalUser> {

	//初始化dao的接口类
	private TalUserDao mUserDao = new TalUserDaoImplement();
	//初始化不同结果的状态位
	private static final int RESULT_NULL_USERNAME = 1,RESULT_WRONG_PASSWORD = 2;
	//结果判断并返回
	public int login(String userName, String passWord) {
		Connection connection = null;
		int result = 0;
		connection = ConnectionFactory.getInstance().makeConnection();
        try {
            //1、先判断是否有相应的用户名
            int id = mUserDao.queryUserName(connection, userName);
            if (id == 0) {
                result=RESULT_NULL_USERNAME;
                return result;
            }

            //2、在判断密码是否正确
            int userId = mUserDao.queryPassWord(connection, id, passWord);
            if (userId == 0) {
                result = RESULT_WRONG_PASSWORD;
                return result;
            }

            //3、设置相应的token
            long currentTime  = System.currentTimeMillis();
            String token = userId+"_"+currentTime;

            mUserDao.updateToken(connection, userId, token);
            result=0;
            result.setToken(token);

            return result;
        } catch (SQLException e) {

            e.printStackTrace();

            result.setCode(100);
            return result;
        }
    }

	public TalUser get(String id) {
		return super.get(id);
	}
	
	public List<TalUser> findList(TalUser talUser) {
		return super.findList(talUser);
	}
	
	public Page<TalUser> findPage(Page<TalUser> page, TalUser talUser) {
		return super.findPage(page, talUser);
	}
	
	@Transactional(readOnly = false)
	public void save(TalUser talUser) {
		super.save(talUser);
	}
	
	@Transactional(readOnly = false)
	public void delete(TalUser talUser) {
		super.delete(talUser);
	}
	
}