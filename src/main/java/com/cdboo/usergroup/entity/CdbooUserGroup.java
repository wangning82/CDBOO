package com.cdboo.usergroup.entity;

import com.cdboo.channel.entity.CdbooChannel;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * Created by mmzz on 2017/1/3.
 */
public class CdbooUserGroup extends DataEntity<CdbooUserGroup> {
    private static final long serialVersionUID = 1L;

    private User user;
    private CdbooChannel cdbooChannel;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }


    public CdbooChannel getCdbooChannel() {
        return cdbooChannel;
    }

    public void setCdbooChannel(CdbooChannel cdbooChannel) {
        this.cdbooChannel = cdbooChannel;
    }
}
