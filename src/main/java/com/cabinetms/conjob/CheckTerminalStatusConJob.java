package com.cabinetms.conjob;

import com.cabinetms.common.Constants;
import com.cabinetms.terminal.entity.CabinetmsTerminal;
import com.cabinetms.terminal.service.CabinetmsTerminalService;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 检查终端状态
 * Created by houyi on 2016/10/16.
 */
public class CheckTerminalStatusConJob extends QuartzJobBean {

    @Autowired
    private CabinetmsTerminalService terminalService;

    private String minute;

    public String getMinute() {
        return minute;
    }

    public void setMinute(String minute) {
        this.minute = minute;
    }

    @Override
    protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        List<CabinetmsTerminal> list = terminalService.findList(new CabinetmsTerminal());
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        for(CabinetmsTerminal terminal : list){
            Calendar nowTime = Calendar.getInstance();
            nowTime.setTime(new Date());
            Calendar lastTime = Calendar.getInstance();
            lastTime.setTime(terminal.getUpdateDate());
            System.out.println("终端IP=" + terminal.getTerminalIp() + ";上次更新时间" + sdf.format(lastTime.getTime()) + ";现在时间：" + sdf.format(nowTime.getTime()));
            if(nowTime.compareTo(lastTime) > 0){
                terminal.setStatus(Constants.TERMINAL_STATUS_CLOSED);
                terminal.setUpdateDate(new Date());
                terminalService.updateByIP(terminal);
            }

        }
    }
}
