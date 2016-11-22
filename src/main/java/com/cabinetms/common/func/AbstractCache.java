package com.cabinetms.common.func;

import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.util.ReflectionUtils;

import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.service.CrudService;

public abstract class AbstractCache<T> {
	
	@SuppressWarnings("rawtypes")
	protected abstract CrudService getService();
	
	/**
     * 通过反射, 获得定义Class时声明的父类的泛型参数的类型. 如无法找到, 返回Object.class.
     * 
     *@param clazz
     *            clazz The class to introspect
     * @param index
     *            the Index of the generic ddeclaration,start from 0.
     * @return the index generic declaration, or Object.class if cannot be
     *         determined
     */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static Class<Object> getSuperClassGenricType(final Class clazz, final int index) {

		// 返回表示此 Class 所表示的实体（类、接口、基本类型或 void）的直接超类的 Type。
		Type genType = clazz.getGenericSuperclass();

		if (!(genType instanceof ParameterizedType)) {
			return Object.class;
		}
		// 返回表示此类型实际类型参数的 Type 对象的数组。
		Type[] params = ((ParameterizedType) genType).getActualTypeArguments();

		if (index >= params.length || index < 0) {
			return Object.class;
		}
		if (!(params[index] instanceof Class)) {
			return Object.class;
		}

		return (Class) params[index];
	}
	
	/**
	 * 按照主键查询
	 * @param id 主键
	 * @return 数据集合
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public BaseEntity<T> get(String id){
		CrudService crudService = getService();
		return (BaseEntity<T>) crudService.get(id);
	}
	
	/**
	 * 查询全部，默认调用dao层getAll方法
	 * 
	 * @param params
	 *            参数
	 * @return 数据集合
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<BaseEntity<T>> getAll() throws InstantiationException, IllegalAccessException {
		CrudService crudService = getService();
		Class<Object> clazz = getSuperClassGenricType(this.getClass(), 0);
		Object newInstance = clazz.newInstance();
		List<?> list = crudService.findList((DataEntity) newInstance);
		return (List<BaseEntity<T>>) list;
	}
	
	/**
	 * 按照methodName查询，第二个参数是方法传递参数
	 * @param methodName 方法名
	 * @param params 参数数组
	 * @return 数据集合
	 */
	@SuppressWarnings({"rawtypes" })
	public Object get(String methodName, String params) {
		CrudService crudService = getService();
		Object[] values = null;
		if (params != null && !"".equals(params)) {
			values = StringUtils.split(params, ",");
		}
		Method method = org.dozer.util.ReflectionUtils.getMethod(crudService, methodName);
		Object result = null;
		if (values != null && values.length>0) {
			result = ReflectionUtils.invokeMethod(method, crudService, values);
		} else {
			result = ReflectionUtils.invokeMethod(method, crudService);
		}
		return result;
	}
}
