package com.cabinetms.common;

/**
 * Created by houyi on 2016/10/19.
 */
public class Constants {

	/**
	 * socket队列名前缀
	 */
	public static final String SOCKET_QUEUE_PREFIX = "/queue/";

	/**
	 * socket命令-ping
	 */
	public static final String SOCKET_COMMAND_PING = "ping";

	/**
	 * socket命令-截屏
	 */
	public static final String SOCKET_COMMAND_SCREENSHOT = "screenshot";

	/**
	 * socket命令-关机
	 */
	public static final String SOCKET_COMMAND_SHUTDOWN = "shutdown";

	/**
	 * socket命令-发布消息
	 */
	public static final String SOCKET_COMMAND_NOCITE_PUBLISH = "np";

	/**
	 * socket命令-撤销消息
	 */
	public static final String SOCKET_COMMAND_NOCITE_UNDOPUBLISH = "nup";

	/**
	 * socket命令-节目策略发布消息
	 */
	public static final String SOCKET_COMMAND_TACIC_PUBLISH = "tp";

	/**
	 * socket命令-节目策略撤销消息
	 */
	public static final String SOCKET_COMMAND_TACIC_UNDOPUBLISH = "tup";
	
    /**
     * 消息状态-未发布
     */
    public static final String NOTICE_STATUS_UNPUBLISHED = "1";

    /**
     * 消息状态-发布中
     */
    public static final String NOTICE_STATUS_PUBLISHING = "2";

	/**
	 * 终端状态-空闲中
	 */
	public static final String TERMINAL_STATUS_FREE = "1";

	/**
	 * 终端状态-播放中
	 */
	public static final String TERMINAL_STATUS_PLAYING = "2";

	/**
	 * 终端状态-策略中
	 */
	public static final String TERMINAL_STATUS_TACTIC = "3";

	/**
	 * 终端状态-关闭中
	 */
	public static final String TERMINAL_STATUS_CLOSED = "4";

	// 节目策略-待提交
	public static final String STATUS_WAIT_SUBMIT = "1";
	
	// 节目策略-待发布
	public static final String STATUS_WAIT_RELEASE = "2";
	
	// 节目策略-已发布
	public static final String STATUS_RELEASED = "3";
	
	// 节目状态-待提交
	public static final String PROGRAM_STATUS_WAIT_SUBMIT = "1";
		
	// 节目状态-已提交
	public static final String PROGRAM_STATUS_SUBMITED = "2";
		
	// 节目状态-策略中
	public static final String PROGRAM_STATUS_USED = "3";

}
