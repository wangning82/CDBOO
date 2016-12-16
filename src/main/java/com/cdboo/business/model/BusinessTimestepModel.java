package com.cdboo.business.model;

import com.cdboo.business.entity.BusinessTimestep;
import com.google.common.collect.Lists;

import java.util.List;

/**
 * Created by mmzz on 2016/12/16.
 */
public class BusinessTimestepModel {

    private String businessId;

    private List<BusinessTimestep> businessTimestepList = Lists.newArrayList();

    public List<BusinessTimestep> getBusinessTimestepList() {
        return businessTimestepList;
    }

    public void setBusinessTimestepList(List<BusinessTimestep> businessTimestepList) {
        this.businessTimestepList = businessTimestepList;
    }

    public String getBusinessId() {
        return businessId;
    }

    public void setBusinessId(String businessId) {
        this.businessId = businessId;
    }
}
