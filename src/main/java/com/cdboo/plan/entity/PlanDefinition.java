package com.cdboo.plan.entity;

import com.cdboo.business.entity.Business;
import com.cdboo.business.entity.BusinessTimestep;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.persistence.TreeEntity;

/**
 * Created by mmzz on 2016/12/21.
 */
public class PlanDefinition extends DataEntity<PlanDefinition> {


    private String planNo;//计划编号
    private String planName;//计划名称

    private String status;//计划状态


    public String getPlanNo() {
        return planNo;
    }

    public void setPlanNo(String planNo) {
        this.planNo = planNo;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
