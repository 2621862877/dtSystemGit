package com.jiangjun.other.constant;

/**
 * @author JiangJun
 * @date 2020/6/9  22:24
 * @description 角色信息枚举类
 */
public enum RoleConstant {
    /**
     *
     */
    ROLE_ADMIN(2,"系统管理员","admin/"),
    ROLE_MANAGER(3,"主管","manager/"),
    ROLE_PERSON(4,"员工","person/");
    private int id;
    private String name;
    private String viewName;
    RoleConstant(int id,String name,String viewName){
        this.viewName = viewName;
        this.id = id;
        this.name = name;
    }

    public String getViewName() {
        return viewName;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }
}
