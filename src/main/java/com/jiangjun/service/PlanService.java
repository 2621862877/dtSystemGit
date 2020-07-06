package com.jiangjun.service;

import com.github.pagehelper.PageInfo;
import com.jiangjun.entity.Plan;
import java.util.List;

/**
 * (Plan)表服务接口
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:10
 */
public interface PlanService {

    /**
     * 通过ID查询单条数据
     *
     * @param planId 主键
     * @return 实例对象
     */
    Plan queryById(Integer planId);


    /**
     * 新增数据
     *
     * @param plan 实例对象
     * @return 实例对象
     */
    Plan insert(Plan plan);

    /**
     * 修改数据
     *
     * @param plan 实例对象
     * @return 实例对象
     */
    Plan update(Plan plan);

    /**
     * 通过主键删除数据
     *
     * @param planId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer planId);

    /**
     * 根据任务编号查询所有计划
     * @return
     */
    List<Plan> queryPlansByTaskId(Integer taskId);

    /**
     * 高级查询
     * @param plan
     * @return
     */
    PageInfo<Plan> queryPlanByCondition(Plan plan,Integer page,Integer size,List<Integer> ids);
}