package com.jiangjun.entity;

import com.jiangjun.utils.DateUtil;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.io.Serializable;

/**
 * (Plan)实体类
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:10
 */
public class Plan implements Serializable {
    private static final long serialVersionUID = -27197118203062726L;
    
    private Integer planId;
    
    private String planName;
    
    private String status;
    
    private String isFeedback;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date beginDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;

    // 用于区间查询
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date beginDateEnd;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDateEnd;
    
    private Integer taskId;
    
    private String feedbackInfo;
    
    private String planDesc;

    // 计划所属的任务
    private Task task;


    public void setBeginDateEnd(Date beginDateEnd) {
        this.beginDateEnd = beginDateEnd;
    }

    public void setEndDateEnd(Date endDateEnd) {
        this.endDateEnd = endDateEnd;
    }

    public Task getTask() {
        return task;
    }

    public void setTask(Task task) {
        this.task = task;
    }

    public String getBeginDateStr(){
        return DateUtil.dateToStr(this.beginDate);
    }
    public String getEndDateStr(){
        return DateUtil.dateToStr(this.endDate);
    }
    public String getBeginDateEndStr(){
        return DateUtil.dateToStr(this.beginDateEnd);
    }
    public String getEndDateEndStr(){
        return DateUtil.dateToStr(this.endDateEnd);
    }

    public Date getBeginDateEnd() {
        return beginDateEnd;
    }

    public Date getEndDateEnd() {
        return endDateEnd;
    }

    @Override
    public String toString() {
        return "Plan{" +
                "planId=" + planId +
                ", planName='" + planName + '\'' +
                ", status='" + status + '\'' +
                ", isFeedback='" + isFeedback + '\'' +
                ", beginDate=" + beginDate +
                ", endDate=" + endDate +
                ", taskId=" + taskId +
                ", feedbackInfo='" + feedbackInfo + '\'' +
                ", planDesc='" + planDesc + '\'' +
                '}';
    }

    public Integer getPlanId() {
        return planId;
    }

    public void setPlanId(Integer planId) {
        this.planId = planId;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getIsFeedback() {
        return isFeedback;
    }

    public void setIsFeedback(String isFeedback) {
        this.isFeedback = isFeedback;
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

    public Integer getTaskId() {
        return taskId;
    }

    public void setTaskId(Integer taskId) {
        this.taskId = taskId;
    }

    public String getFeedbackInfo() {
        return feedbackInfo;
    }

    public void setFeedbackInfo(String feedbackInfo) {
        this.feedbackInfo = feedbackInfo;
    }

    public String getPlanDesc() {
        return planDesc;
    }

    public void setPlanDesc(String planDesc) {
        this.planDesc = planDesc;
    }

}