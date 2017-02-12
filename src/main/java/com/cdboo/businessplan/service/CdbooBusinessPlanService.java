package com.cdboo.businessplan.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.cdboo.businessplan.dao.CdbooBusinessPlanDao;
import com.cdboo.businessplan.entity.CdbooBusinessPlan;
import com.thinkgem.jeesite.common.service.CrudService;

@Service
@Transactional(readOnly = true)
public class CdbooBusinessPlanService extends CrudService<CdbooBusinessPlanDao, CdbooBusinessPlan>{

}
