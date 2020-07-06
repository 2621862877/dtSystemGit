package com.jiangjun.entity;

import java.io.Serializable;

/**
 * (Role)实体类
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:10
 */
public class Role implements Serializable {
    private static final long serialVersionUID = 291130746071491170L;
    
    private Integer roleId;
    
    private String roleName;
    
    private String roleDesc;

    @Override
    public String toString() {
        return "Role{" +
                "roleId=" + roleId +
                ", roleName='" + roleName + '\'' +
                ", roleDesc='" + roleDesc + '\'' +
                '}';
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleDesc() {
        return roleDesc;
    }

    public void setRoleDesc(String roleDesc) {
        this.roleDesc = roleDesc;
    }

}