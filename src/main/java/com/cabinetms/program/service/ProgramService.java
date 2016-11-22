/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.program.service;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

import freemarker.cache.StringTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import com.cabinetms.program.entity.Program;
import com.cabinetms.common.Constants;
import com.cabinetms.program.dao.ProgramDao;

/**
 * 节目管理Service
 * @author 朱广成
 * @version 2016-10-19
 */
@Service
@Transactional(readOnly = true)
public class ProgramService extends CrudService<ProgramDao, Program> {

	public Program get(String id) {
		return super.get(id);
	}
	
	public List<Program> findList(Program program) {
		return super.findList(program);
	}
	
	public Page<Program> findPage(Page<Program> page, Program program) {
		return super.findPage(page, program);
	}
	
	@Transactional(readOnly = false)
	public void save(Program program) {
		super.save(program);
	}
	
	@Transactional(readOnly = false)
	public void delete(Program program) {
		super.delete(program);
	}

	@Transactional(readOnly = false)
	public void submit(Program program) {
		program.setStatus(Constants.PROGRAM_STATUS_SUBMITED);
		super.save(program);
	}

	/**
	 * 为节目策略写的查询节目方法，如果是编辑则传id进来，
	 * 首先先查所有已提交的节目，判断编辑的节目id是否在已提交的节目集合中，
	 * 如果存在则直接返回给页面显示，如果不在，则单独查询出来放到集合中返回
	 * 
	 * @param id
	 * @return
	 */
	public List<Program> findProgramForEdit(String id){
		Program program = new Program();
		program.setStatus(Constants.PROGRAM_STATUS_SUBMITED);
		List<Program> programList = findList(program);
		if(CollectionUtils.isEmpty(programList)){
			programList = new ArrayList<>();
		}
		if(StringUtils.isNotBlank(id)){
			boolean flag = false;
			for (Program program2 : programList) {
				if(StringUtils.equals(program2.getId(), id)){
					flag = true;
					break;
				}
			}
			
			if(!flag){
				Program editProgram = get(id);
				if(editProgram!=null){
					programList.add(editProgram);
				}
			}
		}
		
		return programList;
	}
	
	/**
	 * 为节目策略写的查询节目方法，新增时调用此方法，
	 * 查所有已提交的节目返回即可
	 * 
	 *
	 * @return
	 */
	public List<Program> findProgramForAdd(){
		return findProgramForEdit(null);
	}
	
	public void getProgramHTMLStream(Program program, HttpServletRequest request, Writer writer)
			throws IOException, TemplateException {
		
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF/views/cabinetms/program/template");
		String templateFilePath = path + File.separator + program.getModelName() + ".ftl";
		String templateContent = FileUtils.readFileToString(new File(templateFilePath));

		String programFileRoot = request.getSession().getServletContext().getRealPath("/");

		Map<String, Object> map = new HashMap<String, Object>();
		String programFileContent = "";
		if (org.apache.commons.lang3.StringUtils.equals("txt", program.getModelName())) {
			String programFile = program.getProgramFile().substring(program.getProgramFile().indexOf("userfiles"));
			programFileContent = FileUtils
					.readFileToString(new File(programFileRoot + "/" + URLDecoder.decode(programFile, "utf-8")));

		}
		if (org.apache.commons.lang3.StringUtils.equals("video", program.getModelName())) {
			programFileContent = URLDecoder.decode(program.getProgramFile().substring(1), "utf-8");

		} else if (org.apache.commons.lang3.StringUtils.equals("image", program.getModelName())) {
			String imageStr = URLDecoder.decode(program.getProgramFile().substring(1), "utf-8");
			String[] nameArr = imageStr.split("\\|");
			map.put("imageList", nameArr);

		} else if (org.apache.commons.lang3.StringUtils.equals("mix", program.getModelName())) {
			String nameStr = URLDecoder.decode(program.getProgramFile().substring(1), "utf-8");
			String[] nameArr = nameStr.split("\\|");

			List<String> imageList = new ArrayList<String>();
			for (String url : nameArr) {
				if (org.apache.commons.lang3.StringUtils.contains(url, "txt")) {
					String programFile = url.substring(url.indexOf("userfiles"));
					programFileContent = FileUtils.readFileToString(
							new File(programFileRoot + "/" + URLDecoder.decode(programFile, "utf-8")));
					map.put("txtContent", programFileContent);
				}
				if (org.apache.commons.lang3.StringUtils.contains(url, "mp4")) {
					programFileContent = URLDecoder.decode(url, "utf-8");
					map.put("videoContent", programFileContent);
				}
				if (org.apache.commons.lang3.StringUtils.contains(url, "jpg")) {
					imageList.add(url);
				}
			}
			map.put("imageList", imageList);
		}

		map.put("ctxStatic", request.getContextPath());
		map.put("title", program.getTitle());
		map.put("image_idle", DictUtils.getDictValue("图片轮播时间", "image_idle", "1500"));
		map.put("content", programFileContent);

		Configuration configuration = new Configuration();
		StringTemplateLoader stringLoader = new StringTemplateLoader();
		stringLoader.putTemplate("myTemplate", templateContent);

		configuration.setTemplateLoader(stringLoader);

		Template temp = configuration.getTemplate("myTemplate", "utf-8");
		temp.process(map, writer);
	}
	
	public String getProgramHTML(Program program, HttpServletRequest request) throws IOException, TemplateException {
		StringWriter writer = new StringWriter();
		getProgramHTMLStream(program, request, writer);
		String html = writer.toString();
		return html;
	}
}