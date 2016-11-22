/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.notice.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.util.Date;

/**
 * 消息信息Entity
 * @author houyi
 * @version 2016-10-11
 */
public class CabinetmsNotice extends DataEntity<CabinetmsNotice> {

	private static final long serialVersionUID = 1L;
	private String noticeNo;		// 消息编号
	private String noticeName;		// 消息名称
	private String noticeContent;	// 消息内容
	private String status;		// 消息状态

	private Date beginDate;
	private Date endDate;
	private String[] terminalIds;
	private String terminalId;

	public CabinetmsNotice() {
		super();
	}

	public CabinetmsNotice(String id){
		super(id);
	}

	@Length(min=0, max=64, message="消息编号长度必须介于 0 和 64 之间")
	public String getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(String noticeNo) {
		this.noticeNo = noticeNo;
	}

	@Length(min=0, max=64, message="消息名称长度必须介于 0 和 64 之间")
	public String getNoticeName() {
		return noticeName;
	}

	public void setNoticeName(String noticeName) {
		this.noticeName = noticeName;
	}

	@Length(min=0, max=200, message="消息内容长度必须介于 0 和 200 之间")
	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	@Length(min=0, max=1, message="消息状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String[] getTerminalIds() {
		return terminalIds;
	}

	public void setTerminalIds(String terminalIds) {
		if(StringUtils.isNotEmpty(terminalIds)){
			this.terminalIds = terminalIds.split(",");
		}
	}

	public String getTerminalId() {
		return terminalId;
	}

	public void setTerminalId(String terminalId) {
		this.terminalId = terminalId;
	}
}