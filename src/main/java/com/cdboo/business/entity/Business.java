/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.business.entity;

import org.hibernate.validator.constraints.Length;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.thinkgem.jeesite.common.persistence.TreeEntity;

/**
 * 行业Entity
 * @author 朱广成
 * @version 2016-12-01
 */
public class Business extends TreeEntity<Business> {
	
	private static final long serialVersionUID = 1L;
	private String hierarchy;		// 所在层级
	private String status;		// 状态位显示

	public Business() {
		super();
	}

	public Business(String id){
		super(id);
	}

	@JsonBackReference
	public Business getParent() {
		return parent;
	}

	public void setParent(Business parent) {
		this.parent = parent;
	}
	
	@Length(min=0, max=2000, message="所有父级编号长度必须介于 0 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@Length(min=0, max=2000, message="名称长度必须介于 0 和 2000 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=10, message="所在层级长度必须介于 0 和 10 之间")
	public String getHierarchy() {
		return hierarchy;
	}

	public void setHierarchy(String hierarchy) {
		this.hierarchy = hierarchy;
	}

	@Length(min=0, max=1, message="状态位显示长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}

}