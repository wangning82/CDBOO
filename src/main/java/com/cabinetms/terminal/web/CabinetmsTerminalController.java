/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.terminal.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cabinetms.client.MediaCommand;
import com.cabinetms.common.Constants;
import com.cabinetms.common.tool.Base64Util;
import org.apache.commons.io.IOUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.cabinetms.terminal.entity.CabinetmsTerminal;
import com.cabinetms.terminal.service.CabinetmsTerminalService;

import java.io.*;
import java.util.List;

/**
 * 终端管理Controller
 * @author houyi
 * @version 2016-10-11
 */
@Controller
@RequestMapping(value = "${adminPath}/terminal/cabinetmsTerminal")
public class CabinetmsTerminalController extends BaseController {

	@Autowired
	private CabinetmsTerminalService terminalService;

	@Autowired
	private SimpMessagingTemplate template;
	
	@ModelAttribute
	public CabinetmsTerminal get(@RequestParam(required=false) String id) {
		CabinetmsTerminal entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = terminalService.get(id);
		}
		if (entity == null){
			entity = new CabinetmsTerminal();
		}
		return entity;
	}

	@RequiresPermissions("terminal:cabinetmsTerminal:view")
	@RequestMapping(value = {"list", ""})
	public String list(CabinetmsTerminal cabinetmsTerminal, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CabinetmsTerminal> page = terminalService.findPage(new Page<CabinetmsTerminal>(request, response), cabinetmsTerminal);
		model.addAttribute("page", page);
		return "cabinetms/terminal/cabinetmsTerminalList";
	}

	@RequiresPermissions("terminal:cabinetmsTerminal:view")
	@RequestMapping(value = "form")
	public String form(CabinetmsTerminal cabinetmsTerminal, Model model) {
		model.addAttribute("cabinetmsTerminal", cabinetmsTerminal);
		return "cabinetms/terminal/cabinetmsTerminalForm";
	}

	@RequiresPermissions("terminal:cabinetmsTerminal:edit")
	@RequestMapping(value = "save")
	public String save(CabinetmsTerminal cabinetmsTerminal, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cabinetmsTerminal)){
			return form(cabinetmsTerminal, model);
		}
		if(cabinetmsTerminal.getStatus() == null){
			cabinetmsTerminal.setStatus(Constants.TERMINAL_STATUS_CLOSED);
		}
		terminalService.save(cabinetmsTerminal);
		addMessage(redirectAttributes, "保存终端管理成功");
		return "redirect:"+Global.getAdminPath()+"/terminal/cabinetmsTerminal/?repage";
	}
	
	@RequiresPermissions("terminal:cabinetmsTerminal:edit")
	@RequestMapping(value = "delete")
	public String delete(CabinetmsTerminal cabinetmsTerminal, RedirectAttributes redirectAttributes) {
		terminalService.delete(cabinetmsTerminal);
		addMessage(redirectAttributes, "删除终端管理成功");
		return "redirect:"+Global.getAdminPath()+"/terminal/cabinetmsTerminal/?repage";
	}

	@RequestMapping(value = "statistics")
	public String statistics(Model model) {
		CabinetmsTerminal param = new CabinetmsTerminal();

		param.setStatus(Constants.TERMINAL_STATUS_FREE);
		model.addAttribute("free", terminalService.findList(param).size());

		param.setStatus(Constants.TERMINAL_STATUS_PLAYING);
		model.addAttribute("playing", terminalService.findList(param).size());

		param.setStatus(Constants.TERMINAL_STATUS_CLOSED);
		model.addAttribute("closed", terminalService.findList(param).size());

		return "cabinetms/terminal/cabinetmsStatistics";
	}

	/**
	 * 发送截屏指令
	 * @param cabinetmsTerminal
	 */
	@RequiresPermissions("terminal:cabinetmsTerminal:view")
	@RequestMapping(value = "screenshot", method = RequestMethod.POST)
	@ResponseBody
	public String screenshot(CabinetmsTerminal cabinetmsTerminal){
		MediaCommand mediaCommand = new MediaCommand();
		mediaCommand.setCommand(Constants.SOCKET_COMMAND_SCREENSHOT);
		mediaCommand.setClientIp(cabinetmsTerminal.getTerminalIp());
		String dest = Constants.SOCKET_QUEUE_PREFIX + cabinetmsTerminal.getTerminalIp();
		mediaCommand.setDestination(dest);
		template.convertAndSend(dest, mediaCommand);
		return "发送截屏指令成功";
	}

	/**
	 * 发送关机指令
	 * @param cabinetmsTerminal
	 */
	@RequiresPermissions("terminal:cabinetmsTerminal:view")
	@RequestMapping(value = "shutdown", method = RequestMethod.POST)
	@ResponseBody
	public String shutdown(CabinetmsTerminal cabinetmsTerminal){
		MediaCommand mediaCommand = new MediaCommand();
		mediaCommand.setCommand(Constants.SOCKET_COMMAND_SHUTDOWN);
		mediaCommand.setClientIp(cabinetmsTerminal.getTerminalIp());
		String dest = Constants.SOCKET_QUEUE_PREFIX + cabinetmsTerminal.getTerminalIp();
		mediaCommand.setDestination(dest);
		template.convertAndSend(dest, mediaCommand);
		return "发送关机指令成功";
	}

	@RequiresPermissions("terminal:cabinetmsTerminal:view")
	@RequestMapping(value = "findTerminal", method = RequestMethod.POST)
	@ResponseBody
	public CabinetmsTerminal findTerminal(CabinetmsTerminal cabinetmsTerminal){
		return cabinetmsTerminal;
	}

}