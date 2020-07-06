package com.jiangjun.dao;

import com.jiangjun.entity.Plan;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * (Plan)表数据库访问层
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:10
 */
public interface PlanDao {

    /**
     * 通过ID查询单条数据
     *
     * @param planId 主键
     * @return 实例对象
     */
    Plan queryById(Integer planId);

    /**
     * 通过实体作为筛选条件查询
     *
     * @param plan 实例对象
     * @return 对象列表
     */
    List<Plan> queryAll(Plan plan);

    /**
     * 新增数据
     *
     * @param plan 实例对象
     * @return 影响行数
     */
    int insert(Plan plan);

    /**
     * 修改数据
     *
     * @param plan 实例对象
     * @return 影响行数
     */
    int update(Plan plan);

    /**
     * 通过主键删除数据
     *
     * @param planId 主键
     * @return 影响行数
     */
    int deleteById(Integer planId);

    /**
     * 高级查询 按照提供的任务ID集合查询计划
     * @param plan
     * @param ids
     * @return
     */
    List<Plan> queryPlanByCondition(@Param("plan") Plan plan,@Param("ids")List<Integer> ids);
}