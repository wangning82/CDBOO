/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.terminal.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.cabinetms.terminal.entity.CabinetmsTerminal;

import java.util.List;

/**
 * 终端管理DAO接口
 *
 * @author houyi
 * @version 2016-10-11
 */
@MyBatisDao
public interface CabinetmsTerminalDao extends CrudDao<CabinetmsTerminal> {

    /**
     * 更新终端状态
     * @param entity
     * @return
     */
    int updateByIP(CabinetmsTerminal entity);

    /**
     * 查找所有连接终端
     * @param entity
     * @return
     */
    List<CabinetmsTerminal> findAllConnectedList(CabinetmsTerminal entity);

}