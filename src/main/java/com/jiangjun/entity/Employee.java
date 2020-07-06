package com.jiangjun.entity;

import com.jiangjun.utils.DateUtil;
import org.springframework.format.annotation.DateTimeFormat;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.Serializable;

/**
 * (Employee)实体类
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:08
 */
public class Employee implements Serializable {
    private static final long serialVersionUID = 575884202719607034L;
    
    private Integer employeeId;
    
    private String employeeName;
    
    private String password;
    
    private String realName;
    
    private String sex;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthday;
    
    private String duty;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date enrolldate;
    
    private String education;
    
    private String major;
    
    private String experience;
    
    private Integer roleId;
    
    private Integer parentId;

    private Role role;


    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "employeeId=" + employeeId +
                ", employeeName='" + employeeName + '\'' +
                ", password='" + password + '\'' +
                ", realName='" + realName + '\'' +
                ", sex='" + sex + '\'' +
                ", birthday=" + birthday +
                ", duty='" + duty + '\'' +
                ", enrolldate=" + enrolldate +
                ", education='" + education + '\'' +
                ", major='" + major + '\'' +
                ", experience='" + experience + '\'' +
                ", roleId=" + roleId +
                ", parentId=" + parentId +
                '}';
    }

    public Integer getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(Integer employeeId) {
        this.employeeId = employeeId;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getBirthdayStr() {
        return DateUtil.dateToStr(birthday);
    }
    public String getEnrolldateStr() {
        return DateUtil.dateToStr(enrolldate);
    }

    public Date getBirthday() {
        return birthday;
    }

    public Date getEnrolldate() {
        return enrolldate;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getDuty() {
        return duty;
    }

    public void setDuty(String duty) {
        this.duty = duty;
    }


    public void setEnrolldate(Date enrolldate) {
        this.enrolldate = enrolldate;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

}