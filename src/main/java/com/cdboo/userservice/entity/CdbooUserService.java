/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userservice.entity;

import com.thinkgem.jeesite.modules.sys.entity.User;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户服务信息Entity
 * @author yubin
 * @version 2016-12-21
 */
public class CdbooUserService extends DataEntity<CdbooUserService> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户id
	private Date contractStartTime;		// 合同开始时间
	private Date contractEndTime;		// 合同结束时间
	private String serviceNote;		// 服务说明
	private String status;		// 状态位显示
	
	public CdbooUserService() {
		super();
	}

	public CdbooUserService(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getContractStartTime() {
		return contractStartTime;
	}

	public void setContractStartTime(Date contractStartTime) {
		this.contractStartTime = contractStartTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getContractEndTime() {
		return contractEndTime;
	}

	public void setContractEndTime(Date contractEndTime) {
		this.contractEndTime = contractEndTime;
	}
	
	public String getServiceNote() {
		return serviceNote;
	}

	public void setServiceNote(String serviceNote) {
		this.serviceNote = serviceNote;
	}
	
	@Length(min=0, max=1, message="状态位显示长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}