package com.cdboo.userplan.model;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.userplan.entity.CdbooPlan;
import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.google.common.collect.Lists;

import java.util.List;

/**
 * Created by mmzz on 2016/12/22.
 */
public class PlanModel {

    private String userId;
    private String userName;

    private List<CdbooPlan> planList = Lists.newArrayList();

    List<CdbooUserTimestep> cdbooUserTimestepList = Lists.newArrayList();
    List<CdbooChannel> cdbooChannelList = Lists.newArrayList();

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public List<CdbooPlan> getPlanList() {
        return planList;
    }

    public void setPlanList(List<CdbooPlan> planList) {
        this.planList = planList;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public List<CdbooUserTimestep> getCdbooUserTimestepList() {
        return cdbooUserTimestepList;
    }

    public void setCdbooUserTimestepList(List<CdbooUserTimestep> cdbooUserTimestepList) {
        this.cdbooUserTimestepList = cdbooUserTimestepList;
    }

    public List<CdbooChannel> getCdbooChannelList() {
        return cdbooChannelList;
    }

    public void setCdbooChannelList(List<CdbooChannel> cdbooChannelList) {
        this.cdbooChannelList = cdbooChannelList;
    }
}
