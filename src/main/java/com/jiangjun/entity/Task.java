package com.jiangjun.entity;

import com.jiangjun.utils.DateUtil;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.io.Serializable;
import java.util.List;

/**
 * (Task)实体类
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:10
 */
public class Task implements Serializable {
    private static final long serialVersionUID = -22787345799534470L;
    
    private Integer taskId;
    
    private String taskName;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date beginDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date realBeginDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date realEndDate;
    
    private String status;
    
    private Integer implementorId;
    
    private Integer assignerId;
    
    private String taskDesc;

    // 任务实施人
    private Employee employee;


    // 计划集合 一个任务对应多个计划
    private List<Plan> plans;

    public String getBeginDateStr(){
        return DateUtil.dateToStr(this.beginDate);
    }
    public String getEndDateStr(){
        return DateUtil.dateToStr(this.endDate);
    }
    public String getRealBeginDateStr(){
        return DateUtil.dateToStr(this.realBeginDate);
    }
    public String getRealEndDateStr(){
        return DateUtil.dateToStr(this.realEndDate);
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public List<Plan> getPlans() {
        return plans;
    }

    public void setPlans(List<Plan> plans) {
        this.plans = plans;
    }

    @Override
    public String toString() {
        return "Task{" +
                "taskId=" + taskId +
                ", taskName='" + taskName + '\'' +
                ", beginDate=" + beginDate +
                ", endDate=" + endDate +
                ", realBeginDate=" + realBeginDate +
                ", realEndDate=" + realEndDate +
                ", status='" + status + '\'' +
                ", implementorId=" + implementorId +
                ", assignerId=" + assignerId +
                ", taskDesc='" + taskDesc + '\'' +
                '}';
    }

    public Integer getTaskId() {
        return taskId;
    }

    public void setTaskId(Integer taskId) {
        this.taskId = taskId;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public Date getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(Date beginDate) {
        this.beginDate = beginDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Date getRealBeginDate() {
        return realBeginDate;
    }

    public void setRealBeginDate(Date realBeginDate) {
        this.realBeginDate = realBeginDate;
    }

    public Date getRealEndDate() {
        return realEndDate;
    }

    public void setRealEndDate(Date realEndDate) {
        this.realEndDate = realEndDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getImplementorId() {
        return implementorId;
    }

    public void setImplementorId(Integer implementorId) {
        this.implementorId = implementorId;
    }

    public Integer getAssignerId() {
        return assignerId;
    }

    public void setAssignerId(Integer assignerId) {
        this.assignerId = assignerId;
    }

    public String getTaskDesc() {
        return taskDesc;
    }

    public void setTaskDesc(String taskDesc) {
        this.taskDesc = taskDesc;
    }

}