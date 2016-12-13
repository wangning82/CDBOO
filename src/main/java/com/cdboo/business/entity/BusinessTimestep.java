package com.cdboo.business.entity;

import com.cdboo.timestep.entity.Timestep;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * Created by mmzz on 2016/12/13.
 */
public class BusinessTimestep extends DataEntity<BusinessTimestep> {


    private String name;
    private String sort;

    private Business business;
    private Timestep timestep;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public Business getBusiness() {
        return business;
    }

    public void setBusiness(Business business) {
        this.business = business;
    }

    public Timestep getTimestep() {
        return timestep;
    }

    public void setTimestep(Timestep timestep) {
        this.timestep = timestep;
    }
}
