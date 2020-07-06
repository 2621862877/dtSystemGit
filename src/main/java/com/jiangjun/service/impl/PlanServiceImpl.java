package com.jiangjun.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangjun.entity.Plan;
import com.jiangjun.dao.PlanDao;
import com.jiangjun.entity.Task;
import com.jiangjun.service.PlanService;
import com.jiangjun.service.TaskService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

/**
 * (Plan)表服务实现类
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:10
 */
@Service("planService")
public class PlanServiceImpl implements PlanService {
    @Resource
    private PlanDao planDao;
    @Resource
    private TaskService taskService;

    /**
     * 通过ID查询单条数据
     *
     * @param planId 主键
     * @return 实例对象
     */
    @Override
    public Plan queryById(Integer planId) {
        Plan plan = this.planDao.queryById(planId);
        // 根据任务id查询任务信息
        plan.setTask(taskService.queryById(plan.getTaskId()));
        return plan;
    }


    /**
     * 新增数据
     *
     * @param plan 实例对象
     * @return 实例对象
     */
    @Override
    public Plan insert(Plan plan) {
        this.planDao.insert(plan);
        return plan;
    }

    /**
     * 修改数据
     *
     * @param plan 实例对象
     * @return 实例对象
     */
    @Override
    public Plan update(Plan plan) {
        this.planDao.update(plan);
        return this.queryById(plan.getPlanId());
    }

    /**
     * 通过主键删除数据
     *
     * @param planId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer planId) {
        return this.planDao.deleteById(planId) > 0;
    }

    @Override
    public List<Plan> queryPlansByTaskId(Integer taskId) {
        Plan plan = new Plan();
        plan.setTaskId(taskId);
        return planDao.queryAll(plan);
    }

    @Override
    public PageInfo<Plan> queryPlanByCondition(Plan plan, Integer page, Integer size, List<Integer> ids) {
        PageHelper.startPage(page,size);
        List<Plan> plans = planDao.queryPlanByCondition(plan,ids);
        if (plans == null || plans.size() == 0){
            return null;
        }
        PageInfo<Plan> pageInfo = new PageInfo<>(plans);
        List<Plan> collect = plans.stream().map(item -> {
            // 查询每个计划对应的任务
            Task task = taskService.queryById(item.getTaskId());
            item.setTask(task);
            return item;
        }).collect(Collectors.toList());
        pageInfo.setList(collect);
        return pageInfo;
    }
}