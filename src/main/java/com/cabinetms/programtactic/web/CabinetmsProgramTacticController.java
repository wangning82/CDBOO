/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.programtactic.web;

import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cabinetms.common.Constants;
import com.cabinetms.program.entity.Program;
import com.cabinetms.program.service.ProgramService;
import com.cabinetms.programtactic.entity.CabinetmsProgramTactic;
import com.cabinetms.programtactic.service.CabinetmsProgramTacticService;
import com.cabinetms.terminal.entity.CabinetmsTerminal;
import com.cabinetms.terminal.service.CabinetmsTerminalService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * 节目策略Controller
 * @author 于滨
 * @version 2016-10-19
 */
@Controller
@RequestMapping(value = "${adminPath}/programtactic/cabinetmsProgramTactic")
public class CabinetmsProgramTacticController extends BaseController {

	@Autowired
	private CabinetmsProgramTacticService cabinetmsProgramTacticService;
	
	@Autowired
	private CabinetmsTerminalService cabinetmsTerminalService;
	
	@Autowired
	private ProgramService	programService;
	
	@Autowired
	private SimpMessagingTemplate template;
	
	@ModelAttribute
	public CabinetmsProgramTactic get(@RequestParam(required=false) String id) {
		CabinetmsProgramTactic entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cabinetmsProgramTacticService.get(id);
		}
		if (entity == null){
			entity = new CabinetmsProgramTactic();
		}
		return entity;
	}
	
	@RequiresPermissions("programtactic:cabinetmsProgramTactic:view")
	@RequestMapping(value = {"list", ""})
	public String list(CabinetmsProgramTactic cabinetmsProgramTactic, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CabinetmsProgramTactic> page = cabinetmsProgramTacticService.findPage(new Page<CabinetmsProgramTactic>(request, response), cabinetmsProgramTactic); 
		model.addAttribute("page", page);
		return "cabinetms/programtactic/cabinetmsProgramTacticList";
	}

	@RequiresPermissions("programtactic:cabinetmsProgramTactic:view")
	@RequestMapping(value = "form")
	public String form(CabinetmsProgramTactic cabinetmsProgramTactic, Model model) throws InstantiationException, IllegalAccessException {
		Program program = new Program();
		program.setStatus(Constants.PROGRAM_STATUS_SUBMITED);
		List<Program> programList = programService.findList(program);
		model.addAttribute("programList", programList);
		model.addAttribute("cabinetmsProgramTactic", cabinetmsProgramTactic);
		return "cabinetms/programtactic/cabinetmsProgramTacticForm";
	}

	@RequiresPermissions("programtactic:cabinetmsProgramTactic:edit")
	@RequestMapping(value = "save")
	public String save(CabinetmsProgramTactic cabinetmsProgramTactic, Model model, RedirectAttributes redirectAttributes) throws InstantiationException, IllegalAccessException {
		if (!beanValidator(model, cabinetmsProgramTactic)){
			return form(cabinetmsProgramTactic, model);
		}
		cabinetmsProgramTacticService.save(cabinetmsProgramTactic);
		addMessage(redirectAttributes, "保存节目策略成功");
		return "redirect:"+Global.getAdminPath()+"/programtactic/cabinetmsProgramTactic/?repage";
	}
	
	@RequiresPermissions("programtactic:cabinetmsProgramTactic:edit")
	@RequestMapping(value = "delete")
	public String delete(CabinetmsProgramTactic cabinetmsProgramTactic, RedirectAttributes redirectAttributes) {
		cabinetmsProgramTacticService.delete(cabinetmsProgramTactic);
		addMessage(redirectAttributes, "删除节目策略成功");
		return "redirect:"+Global.getAdminPath()+"/programtactic/cabinetmsProgramTactic/?repage";
	}

	/**
	 * 更新状态公用方法，待提交-待发布，待发布-已发布
	 * @param cabinetmsProgramTactic
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("programtactic:cabinetmsProgramTactic:edit")
	@RequestMapping(value = "updateStatus")
	public String updateStatus(CabinetmsProgramTactic cabinetmsProgramTactic, Model model,
			RedirectAttributes redirectAttributes) {
		
		String id = cabinetmsProgramTactic.getId();
		String status = cabinetmsProgramTactic.getStatus();
		
		CabinetmsProgramTactic cabinetmsProgramTactic2 = cabinetmsProgramTacticService.get(id);
		String orgStatus = cabinetmsProgramTactic2.getStatus();
		cabinetmsProgramTactic2.setStatus(status);
		try {
			cabinetmsProgramTacticService.save(cabinetmsProgramTactic2);
			
			//原始状态是待提交，更新后的状态是待提交，就提示提交成功
			if (StringUtils.equals(orgStatus, Constants.STATUS_WAIT_SUBMIT)&&StringUtils.equals(status, Constants.STATUS_WAIT_RELEASE)) {
				addMessage(redirectAttributes, "策略信息提交成功");
			}
			
		} catch (Exception e) {
			e.printStackTrace();

			//原始状态是待提交，更新后的状态是待提交，就提示提交失败
			if (StringUtils.equals(orgStatus, Constants.STATUS_WAIT_SUBMIT)&&StringUtils.equals(status, Constants.STATUS_WAIT_RELEASE)) {
				addMessage(redirectAttributes, "策略信息提交失败");
			}
		}
		return "redirect:" + Global.getAdminPath() + "/programtactic/cabinetmsProgramTactic/list?repage";
	}
	
	/**
	 * 查询终端
	 * @param cabinetmsProgramTactic
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("programtactic:cabinetmsProgramTactic:view")
	@RequestMapping(value = {"termList"})
	public String termList(CabinetmsProgramTactic cabinetmsProgramTactic, HttpServletRequest request, HttpServletResponse response, Model model){
		CabinetmsTerminal cabinetmsTerminal = new CabinetmsTerminal();
		cabinetmsTerminal.setStatus(Constants.TERMINAL_STATUS_FREE);
		Page<CabinetmsTerminal> page = cabinetmsTerminalService.findPage(new Page<CabinetmsTerminal>(request, response), cabinetmsTerminal);
		model.addAttribute("page", page);
		return "cabinetms/programtactic/cabinetmsProgramTacticSelectTerm";
	}
	
	/**
	 * 根据策略id查询终端（仅查看）
	 * @param cabinetmsProgramTactic
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("programtactic:cabinetmsProgramTactic:view")
	@RequestMapping(value = {"termListOnly"})
	public String termListOnly(CabinetmsProgramTactic cabinetmsProgramTactic, HttpServletRequest request, HttpServletResponse response, Model model){
		CabinetmsTerminal cabinetmsTerminal = new CabinetmsTerminal();
		cabinetmsTerminal.setProgramTactic(cabinetmsProgramTactic);
		Page<CabinetmsTerminal> page = cabinetmsTerminalService.findPage(new Page<CabinetmsTerminal>(request, response), cabinetmsTerminal);
		model.addAttribute("page", page);
		return "cabinetms/programtactic/cabinetmsProgramTacticSelectTerm";
	}
	
	/**
	 * 发布方法
	 * @param cabinetmsProgramTactic
	 * @param request
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("programtactic:cabinetmsProgramTactic:edit")
	@RequestMapping(value = {"release"})
	public String release(CabinetmsProgramTactic cabinetmsProgramTactic, HttpServletRequest request, Model model,
			RedirectAttributes redirectAttributes){
		try {
			cabinetmsProgramTacticService.release(cabinetmsProgramTactic,request,template);
			addMessage(redirectAttributes, "发布节目策略成功");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "发布节目策略失败");
		}
		return "redirect:" + Global.getAdminPath() + "/programtactic/cabinetmsProgramTactic/list?repage";
	}
	
	/**
	 * 撤销方法
	 * @param cabinetmsProgramTactic
	 * @param request
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("programtactic:cabinetmsProgramTactic:edit")
	@RequestMapping(value = {"cancel"})
	public String cancel(CabinetmsProgramTactic cabinetmsProgramTactic, HttpServletRequest request, Model model,
			RedirectAttributes redirectAttributes){
		try {
			cabinetmsProgramTacticService.cancel(cabinetmsProgramTactic,request,template);
			addMessage(redirectAttributes, "撤销节目策略成功");
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "撤销节目策略失败");
		}
		return "redirect:" + Global.getAdminPath() + "/programtactic/cabinetmsProgramTactic/list?repage";
	}
	
	/**
	 * 获得节目列表
	 * @param cabinetmsProgramTactic
	 * @param request
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("programtactic:cabinetmsProgramTactic:view")
	@RequestMapping(value = {"getProgramList"})
	@ResponseBody
	public List<LinkedHashMap<String, Object>> getProgramList(CabinetmsProgramTactic cabinetmsProgramTactic, HttpServletRequest request, Model model,
			RedirectAttributes redirectAttributes){
		return cabinetmsProgramTacticService.getProgramList(cabinetmsProgramTactic);
	}
	
}