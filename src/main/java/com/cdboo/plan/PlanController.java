package com.cdboo.plan;

import com.cdboo.plan.entity.PlanDefinition;
import com.cdboo.plan.service.PlanService;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 计划Controller
 * @author 朱广成
 * @version 2016-12-01
 */
@Controller
@RequestMapping(value = "${adminPath}/plan/plan")
public class PlanController extends BaseController {

    @Autowired
    private PlanService planService;


    @RequiresPermissions("plan:plan:view")
    @RequestMapping(value = {"list"})
    public String list(PlanDefinition plan, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<PlanDefinition> page = planService.findPage(new Page<>(request, response), plan);

        model.addAttribute("page", page);
        return "cdboo/plan/planList";
    }




}
