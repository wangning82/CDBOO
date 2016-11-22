/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.terminal.entity;

import com.cabinetms.notice.entity.CabinetmsNotice;
import com.cabinetms.programtactic.entity.CabinetmsProgramTactic;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import org.hibernate.validator.constraints.Length;

/**
 * 终端管理Entity
 * @author houyi
 * @version 2016-10-11
 */
public class CabinetmsTerminal extends DataEntity<CabinetmsTerminal> {
	
	private static final long serialVersionUID = 1L;
	private String terminalNo;		// 终端编号
	private String terminalName;		// 终端名称
	private String terminalIp;		// 终端IP
	private Office office;		// 机构ID
	private CabinetmsProgramTactic programTactic;		// 节目策略ID
	private CabinetmsNotice notice;		// 消息ID
	private String screenshot;
	private String status;		// 终端状态

	public CabinetmsTerminal() {
		super();
	}

	public CabinetmsTerminal(String id){
		super(id);
	}

	@Length(min=0, max=20, message="终端编号长度必须介于 0 和 20 之间")
	public String getTerminalNo() {
		return terminalNo;
	}

	public void setTerminalNo(String terminalNo) {
		this.terminalNo = terminalNo;
	}
	
	@Length(min=0, max=20, message="终端名称长度必须介于 0 和 20 之间")
	public String getTerminalName() {
		return terminalName;
	}

	public void setTerminalName(String terminalName) {
		this.terminalName = terminalName;
	}
	
	@Length(min=0, max=64, message="终端IP长度必须介于 0 和 64 之间")
	public String getTerminalIp() {
		return terminalIp;
	}

	public void setTerminalIp(String terminalIp) {
		this.terminalIp = terminalIp;
	}
	
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	public CabinetmsProgramTactic getProgramTactic() {
		return programTactic;
	}

	public void setProgramTactic(CabinetmsProgramTactic programTactic) {
		this.programTactic = programTactic;
	}
	
	public CabinetmsNotice getNotice() {
		return notice;
	}

	public void setNotice(CabinetmsNotice notice) {
		this.notice = notice;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getScreenshot() {
		return screenshot;
	}

	public void setScreenshot(String screenshot) {
		this.screenshot = screenshot;
	}

}