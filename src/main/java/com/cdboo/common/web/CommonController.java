package com.cdboo.common.web;

import java.lang.reflect.Field;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;

import org.dozer.util.ReflectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cdboo.common.func.FuncUtil;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;

@Controller
@RequestMapping(value = "${adminPath}/common")
public class CommonController extends BaseController{
	
	@RequestMapping(value = "disPic")
	public String disPic(PicBean picBean, HttpServletRequest request, Model model) {
		String tableName = picBean.getTableName();
		String id = picBean.getId();
		String pathFieldName = picBean.getPathFieldName();
		try {
			Object obj = FuncUtil.get(tableName, id);
			Field field = ReflectionUtils.getFieldFromBean(obj.getClass(), pathFieldName);
			String fieldValue = Objects.toString(field.get(obj));
			String[] pathArray = StringUtils.split(fieldValue, "|");
			request.setAttribute("pathArray", pathArray);
		} catch (Exception e) {
			request.setAttribute("pathArray", null);
		}
		return "crht/common/picCarousel";
	}
}
