/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.taluser.service;

import java.util.List;

import com.cdboo.taluser.dao.TalUserDao;
import com.cdboo.taluser.dao.TalUserDaoImplement;
import com.cdboo.taluser.entity.TalUser;
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