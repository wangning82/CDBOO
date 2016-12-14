package com.thinkgem.jeesite.common.utils;

import java.io.RandomAccessFile;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class Mp3ResolveUtils {
	
	public static Map<String,Object> resolveMp3(String mp3Path) throws Exception{
		
		byte[] buf = new byte[128];//初始化标签信息的byte数组

	    RandomAccessFile raf = new RandomAccessFile(mp3Path, "r");//随机读写方式打开MP3文件

	    raf.seek(raf.length() - 128);//移动到文件MP3末尾

	    raf.read(buf);//读取标签信息

	    raf.close();//关闭文件

	    if(buf.length != 128){//数据长度是否合法
	        throw new Exception("MP3标签信息数据长度不合法!");
	    }

	    if(!"TAG".equalsIgnoreCase(new String(buf,0,3))){//标签头是否存在
	        throw new Exception("MP3标签信息数据格式不正确!");
	    }
	    
	    Map<String, Object> mp3InfoMap = new HashMap<>();
	    
	    String songName = new String(buf,3,30,"gbk").trim();//歌曲名称
	    mp3InfoMap.put("songName", songName);
	    
	    String artist = new String(buf,33,30,"gbk").trim();//歌手名字
	    mp3InfoMap.put("artist", artist);
	    
	    String album = new String(buf,63,30,"gbk").trim();//专辑名称
	    mp3InfoMap.put("album", album);
	    
	    String year = new String(buf,93,4,"gbk").trim();//出品年份
	    mp3InfoMap.put("year", year);
	    
	    String comment = new String(buf,97,28,"gbk").trim();//备注信息
	    mp3InfoMap.put("comment", comment);
	    
		return mp3InfoMap;
	}
	
	public static void main(String[] args) {
		try {
			Map<String, Object> resolveMp3 = Mp3ResolveUtils.resolveMp3("D:\\workspace-cdboo\\CDBOO\\src\\main\\java\\com\\thinkgem\\jeesite\\common\\utils\\余波荡漾.mp3");
			Set<String> keySet = resolveMp3.keySet();
			for (String key : keySet) {
				System.out.println(resolveMp3.get(key));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
