package com.cdboo.common.func;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import com.cdboo.common.cache.cacheEntity.AbstractCache;
import com.thinkgem.jeesite.common.utils.StringUtils;

public class FuncUtil {
	@SuppressWarnings("rawtypes")
	private static final Map<String, AbstractCache> map = new LinkedHashMap<>();
	
	static {
//		map.put(CACHE_NAME_COMPANY, new CompanyCacheEntity());
	}

	/**
	 * 根据主键获得信息
	 * 
	 * @param id
	 *            主键id
	 * @return 公司信息
	 * @author yubin
	 */
	@SuppressWarnings("rawtypes")
	public static Object get(String cacheKey, String id) {
		AbstractCache abstractCache = map.get(cacheKey);
		if (abstractCache == null) {
			return null;
		}

		Object obj =  abstractCache.get(id);
		return obj;
	}

	/**
	 * 获得所有信息
	 * 
	 * @return 公司集合
	 * @author yubin
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 */
	@SuppressWarnings({ "rawtypes" })
	public static List<?> getAll(String cacheKey) throws InstantiationException, IllegalAccessException {
		AbstractCache abstractCache = map.get(cacheKey);
		if (abstractCache == null) {
			return null;
		}

		List list = abstractCache.getAll();
		return list;
	}

	/**
	 * 查询方法
	 * 
	 * @param cacheKey
	 *            缓存key
	 * @param methodName
	 *            调用dao方法名,不带参数
	 * @return 数据集合
	 * @author yubin
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 */
	@SuppressWarnings("rawtypes")
	public static Object query(String cacheKey, String methodName)
			throws InstantiationException, IllegalAccessException {
		AbstractCache abstractCache = map.get(cacheKey);
		if (abstractCache == null) {
			return null;
		}

		Object obj = abstractCache.get(methodName, null);
		
		return obj;
	}

	/**
	 * 查询方法
	 * 
	 * @param cacheKey
	 *            缓存key
	 * @param methodName
	 *            调用dao方法名
	 * @param values
	 *            方法传递参数
	 * @return 数据集合
	 * @author yubin
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 */
	@SuppressWarnings({ "rawtypes" })
	public static Object query(String cacheKey, String methodName, String values)
			throws InstantiationException, IllegalAccessException {
		AbstractCache abstractCache = map.get(cacheKey);
		if (abstractCache == null||StringUtils.isBlank(values)) {
			return null;
		}

		Object obj = abstractCache.get(methodName, values);
		
		return obj;
	}
	
	/**
	 * 获得音量集合list，供下拉列表使用
	 * @return
	 */
	public static List<VolumeEntity> getVolumeList() {
		List<VolumeEntity> list = new ArrayList<>();
		for (int i = 0; i <= 100; i += 10) {
			VolumeEntity volumeEntity = new VolumeEntity(i + "%", i + "");
			list.add(volumeEntity);
		}
		return list;
	}
}
