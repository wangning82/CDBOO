package com.cdboo.plan.service;

import com.cdboo.plan.dao.PlanDao;
import com.cdboo.plan.entity.PlanDefinition;
import com.thinkgem.jeesite.common.service.CrudService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by mmzz on 2016/12/21.
 */
@Service
@Transactional(readOnly = true)
public class PlanService extends CrudService<PlanDao, PlanDefinition> {

    @Autowired
    private PlanDao planDao;


}
