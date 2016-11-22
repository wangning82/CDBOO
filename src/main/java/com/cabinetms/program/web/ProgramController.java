/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.program.web;

import java.io.File;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FileUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import freemarker.template.TemplateException;

/**
 * 节目管理Controller
 * @author 朱广成
 * @version 2016-10-19
 */
@Controller
@RequestMapping(value = "${adminPath}/program/program")
public class ProgramController extends BaseController {

	@Autowired
	private ProgramService programService;
	
	@ModelAttribute
	public Program get(@RequestParam(required=false) String id) {
		Program entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = programService.get(id);
		}
		if (entity == null){
			entity = new Program();
		}
		return entity;
	}
	
	@RequiresPermissions("program:program:view")
	@RequestMapping(value = {"list", ""})
	public String list(Program program, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Program> page = programService.findPage(new Page<Program>(request, response), program); 
		model.addAttribute("page", page);
		return "cabinetms/program/programList";
	}

	@RequiresPermissions("program:program:view")
	@RequestMapping(value = "form")
	public String form(Program program, Model model) {
		model.addAttribute("program", program);
		return "cabinetms/program/programForm";
	}

	@RequiresPermissions("program:program:edit")
	@RequestMapping(value = "save")
	public String save(Program program, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, program)){
			return form(program, model);
		}
		program.setStatus(Constants.PROGRAM_STATUS_WAIT_SUBMIT);
		programService.save(program);
		addMessage(redirectAttributes, "保存节目管理成功");
		return "redirect:"+Global.getAdminPath()+"/program/program/?repage";
	}
	
	@RequiresPermissions("program:program:edit")
	@RequestMapping(value = "delete")
	public String delete(Program program, RedirectAttributes redirectAttributes) {
		programService.delete(program);
		addMessage(redirectAttributes, "删除节目管理成功");
		return "redirect:"+Global.getAdminPath()+"/program/program/?repage";
	}

	@RequiresPermissions("program:program:edit")
	@RequestMapping(value = "submit")
	public String submit(Program program, RedirectAttributes redirectAttributes) {
		programService.submit(program);
		addMessage(redirectAttributes, "提交节目管理成功");
		return "redirect:"+Global.getAdminPath()+"/program/program/?repage";
	}

	@RequiresPermissions("program:program:view")
	@RequestMapping(value = "template")
	@ResponseBody
	public Program template(Program program, Model model, HttpServletRequest request) throws IOException {

		String path = request.getSession().getServletContext().getRealPath("/WEB-INF/views/cabinetms/program/template/");
		String templateFilePath = path + program.getModelName() + ".ftl";
		String templateContent = FileUtils.readFileToString(new File(templateFilePath));

		program.setTemplateContent(templateContent);
		return program;
	}

	@RequestMapping(value = "preview")
	@ResponseBody
	public void preview(Program program, Model model, HttpServletRequest request, HttpServletResponse response) throws IOException, TemplateException {
		programService.getProgramHTMLStream(program, request, response.getWriter());
//		System.out.println(writer.toString().replaceAll("[\\n\\r]", ""));
		response.flushBuffer();
	}

}