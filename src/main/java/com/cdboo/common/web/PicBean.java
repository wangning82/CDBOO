package com.cdboo.common.web;

public class PicBean {
	private String tableName;
	private String id;
	private String pathFieldName;
	private String path;
	public PicBean() {
	}

	public PicBean(String tableName, String id, String pathFieldName) {
		super();
		this.tableName = tableName;
		this.id = id;
		this.pathFieldName = pathFieldName;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPathFieldName() {
		return pathFieldName;
	}

	public void setPathFieldName(String pathFieldName) {
		this.pathFieldName = pathFieldName;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
}
