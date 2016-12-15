/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.music.service;

import java.io.File;
import java.io.FileFilter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.cdboo.common.Constants;
import com.cdboo.music.dao.CdbooMusicDao;
import com.cdboo.music.entity.CdbooMusic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.FileUtils;
import com.thinkgem.jeesite.common.utils.Mp3ResolveUtils;
import com.thinkgem.jeesite.common.utils.ZipUtils;
import com.thinkgem.jeesite.common.web.Servlets;
import com.thinkgem.jeesite.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 曲库管理Service
 * @author yubin
 * @version 2016-12-13
 */
@Service
@Transactional(readOnly = true)
public class CdbooMusicService extends CrudService<CdbooMusicDao, CdbooMusic> {

	public CdbooMusic get(String id) {
		return super.get(id);
	}
	
	public List<CdbooMusic> findList(CdbooMusic cdbooMusic) {
		return super.findList(cdbooMusic);
	}
	
	public Page<CdbooMusic> findPage(Page<CdbooMusic> page, CdbooMusic cdbooMusic) {
		return super.findPage(page, cdbooMusic);
	}
	
	@Transactional(readOnly = false)
	public void save(CdbooMusic cdbooMusic) {
		super.save(cdbooMusic);
	}
	
	@Transactional(readOnly = false)
	public void delete(CdbooMusic cdbooMusic) {
		super.delete(cdbooMusic);
	}
	
//	songName:余波荡漾
//	artist:田馥甄
//	year:2016
//	album:日常
	@Transactional(readOnly=false)
	public void importMusicFile(MultipartFile file) throws Exception {
		File tempPath = null;
		File tempFile = null;
		try {
			/****************** 创建临时目录，把上传的zip文件拷贝过去 Start *******************/
			String tempFilePath = Global.getUserfilesBaseDir()+"/temp";
			tempPath = new File(tempFilePath);
			if (!tempPath.exists() || !tempPath.isDirectory()) {
				tempPath.mkdir(); // 如果不存在，则创建该文件夹
			}
			tempFile = File.createTempFile("musicZip", ".zip", tempPath);
			file.transferTo(tempFile);
			/****************** 创建临时目录，把上传的zip文件拷贝过去 End *******************/

			/****************** 获得当前时间的年月 Start *******************/
			Calendar now = Calendar.getInstance();
			String year = now.get(Calendar.YEAR) + "";
			String month = (now.get(Calendar.MONTH)+1) + "";
			/****************** 获得当前时间的年月 End *******************/

			/****************** 解压文件 Start *******************/
			ZipUtils.unZipFiles(tempFile, tempFilePath+"/");
			/****************** 解压文件 End *******************/

			/******************
			 * 从临时文件目录下过滤出扩展名是mp3的文件集合 Start
			 *******************/
			File[] mp3Files = tempPath.listFiles(new FileFilter() {
				@Override
				public boolean accept(File pathname) {
					if (pathname.getName().endsWith(".mp3")) {
						return true;
					}
					return false;
				}
			});
			/****************** 从临时文件目录下过滤出扩展名是mp3的文件集合 End *******************/

			if (mp3Files != null && mp3Files.length > 0) {// 如果mp3文件存在
				
				Principal principal = (Principal) UserUtils.getPrincipal();
				
				String path = FileUtils.path(Servlets.getRequest().getContextPath() + Global.USERFILES_BASE_URL + principal + "/");
				
				String dir = FileUtils.path(Global.USERFILES_BASE_URL + Global.USERFILES_BASE_URL + principal + "/");
				
//				String path = FileUtils.path(Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + principal);
				
				// 获取项目内部mp3文件待上传路径
				String realDir = path + "media" + "/" + "music" + "/" + year + "/" + month;
				String realPath = dir + "media" + "/" + "music" + "/" + year + "/" + month;
				for (int i = 0; i < mp3Files.length; i++) {
					File mp3File = mp3Files[i];
					String destMp3Path = null;
					String destMp3Dir = null;
					try {
						String orgMp3Path = mp3File.getAbsolutePath();// 临时目录下mp3绝对路径
						String mp3Name = mp3File.getName();// 临时目录下mp3名称
						destMp3Path = realPath + "/" + mp3Name;// 真是目录下mp3绝对路径
						destMp3Dir = realDir + "/" + mp3Name;
						// 拷贝文件到真实路径
						boolean copyFileFlag = FileUtils.copyFile(orgMp3Path, destMp3Path);

						if (copyFileFlag) {// 拷贝成功走下面

							/******************
							 * 创建音乐文件记录，保存到数据库中 Start
							 *******************/
							Map<String, Object> result = Mp3ResolveUtils.resolveMp3(orgMp3Path);
							CdbooMusic cdbooMusic = new CdbooMusic();
							cdbooMusic.setMusicName(Objects.toString(result.get("songName")));//歌曲名称
							cdbooMusic.setActor(Objects.toString(result.get("artist")));//歌手
							cdbooMusic.setSpecial(Objects.toString(result.get("album")));//专辑
							cdbooMusic.setCreateBy(UserUtils.getUser());
							cdbooMusic.setCreateDate(new Date());
							cdbooMusic.setDelFlag(CdbooMusic.DEL_FLAG_NORMAL);
							cdbooMusic.setMusicOwner(Constants.MUSICOWNER_PUBLIC);
							cdbooMusic.setPath(destMp3Dir);
							cdbooMusic.setVolume(Constants.MUSIC_VOLUME_DEFAULT);
							save(cdbooMusic);
							/******************
							 * 创建音乐文件记录，保存到数据库中 End
							 *******************/
						}
					} catch (Exception e) {
						e.printStackTrace();
						
						//如果数据库保存失败，需要把之前拷贝的文件也跟着删除，实现数据文件存在一致性
						if(StringUtils.isNotBlank(destMp3Path)){
							File destMp3File = new File(destMp3Path);
							if (destMp3File.exists()) {
								destMp3File.delete();
							}
						}
					} finally {
						// 不论成功失败，即时删除临时文件
						if (mp3File.exists()) {
							mp3File.delete();
						}
					}
				}
			}
		} catch (Exception e) {
			throw e;
		}finally {
			// 不论成功失败，即时删除临时文件
			if (tempFile.exists()) {
				tempFile.delete();
			}
		}
	}
}