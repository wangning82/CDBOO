package com.cdboo.common.func;

public class VolumeEntity {

	private String lable;
	private String value;

	public VolumeEntity() {
		super();
	}

	public VolumeEntity(String lable, String value) {
		super();
		this.lable = lable;
		this.value = value;
	}

	public String getLable() {
		return lable;
	}

	public void setLable(String lable) {
		this.lable = lable;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}
