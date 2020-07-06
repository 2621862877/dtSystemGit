package com.jiangjun.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangjun.entity.Employee;
import com.jiangjun.entity.Plan;
import com.jiangjun.entity.Task;
import com.jiangjun.dao.TaskDao;
import com.jiangjun.service.EmployeeService;
import com.jiangjun.service.PlanService;
import com.jiangjun.service.TaskService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

/**
 * (Task)表服务实现类
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:10
 */
@Service("taskService")
public class TaskServiceImpl implements TaskService {
    @Resource
    private TaskDao taskDao;
    @Resource
    private PlanService planService;
    @Resource
    private EmployeeService employeeService;

    /**
     * 通过ID查询单条数据
     *
     * @param taskId 主键
     * @return 实例对象
     */
    @Override
    public Task queryById(Integer taskId) {
        Task task = this.taskDao.queryById(taskId);
        // 查询实施人
        task.setEmployee(employeeService.queryById(task.getImplementorId()));
        // 根据任务查询对应的所有计划
        List<Plan> plans = planService.queryPlansByTaskId(taskId);
        task.setPlans(plans);
        return task;
    }

    /**
     * 新增数据
     *
     * @param task 实例对象
     * @return 实例对象
     */
    @Override
    public Task insert(Task task) {
        this.taskDao.insert(task);
        return task;
    }

    /**
     * 修改数据
     *
     * @param task 实例对象
     * @return 实例对象
     */
    @Override
    public Task update(Task task) {
        if ("已完成".equals(task.getStatus())){
            // 状态修改为已完成的话，前提是该任务下所有计划都是已完成and已反馈状态
            // 1.查出任务下所有计划
            Task task1 = this.queryById(task.getTaskId());
            List<Plan> plans = task1.getPlans();
            plans = plans.stream().filter(item -> {
                // 过滤出除已完成/已反馈外的所有计划  集合大小>1则还有计划未完成 不能将任务状态设置为已完成
                return (!"已完成".equals(item.getStatus()) || !"已反馈".equals(item.getIsFeedback()));
            }).collect(Collectors.toList());
            if (plans.size() > 0){
                return null;
            }
        }
        this.taskDao.update(task);
        return this.queryById(task.getTaskId());
    }

    /**
     * 通过主键删除数据
     *
     * @param taskId 主键
     * @return 是否成功
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteById(Integer taskId) {
        // 先删除任务下所有计划
        List<Plan> plans = planService.queryPlansByTaskId(taskId);
        for (Plan plan : plans) {
            planService.deleteById(plan.getPlanId());
        }
        return this.taskDao.deleteById(taskId) > 0;
    }

    @Override
    public PageInfo<Task> queryAllByManagerId(Integer managerId,Integer page,Integer size) {
        // 查询条件根据分配人id查询分配的所有任务
        Task task = new Task();
        task.setAssignerId(managerId);
        PageHelper.startPage(page,size);
        List<Task> tasks = taskDao.queryAll(task);

        PageInfo<Task> pageInfo = new PageInfo<>(tasks);

        tasks = tasks.stream().map(item->{
            // 根据任务id查出所有计划
            List<Plan> plans = planService.queryPlansByTaskId(item.getTaskId());
            item.setPlans(plans);
            return item;
        }).map(item->{
            // 根据实施人编号查出任务的实施人
            Employee employee = employeeService.queryById(item.getImplementorId());
            item.setEmployee(employee);
            return item;
        }).collect(Collectors.toList());

        // 重新保存新的数据
        pageInfo.setList(tasks);
        return pageInfo;
    }

    @Override
    public PageInfo<Task> queryTaskundoneByParentId(Integer parentId,Integer page,Integer size) {
        // 调用dao查询对应主管发布的所有未实施的任务
        Task task = new Task();
        task.setAssignerId(parentId);
        task.setStatus("未实施");
        PageHelper.startPage(page,size);
        List<Task> tasks = taskDao.queryAll(task);
        PageInfo<Task> pageInfo = new PageInfo<>(tasks);
        List<Task> collect = this.findImimplementorEmployee(pageInfo.getList());
        pageInfo.setList(collect);
        return pageInfo;
    }

    @Override
    public PageInfo<Task> queryIntendanceByParentId(Integer parentId,Integer page,Integer size) {

        PageHelper.startPage(page,size);
        Task task = new Task();
        task.setAssignerId(parentId);
        task.setStatus("实施中");
        List<Task> tasks = taskDao.queryAll(task);
        PageInfo<Task> pageInfo = new PageInfo<>(tasks);
        List<Task> collect = this.findImimplementorEmployee(pageInfo.getList());
        pageInfo.setList(collect);
        return pageInfo;
    }

    @Override
    public PageInfo<Task> queryTaskByPersonId(Integer personId,Integer page,Integer size) {
        Task task = new Task();
        // 设置任务实施人ID作为查询条件
        task.setImplementorId(personId);
        PageHelper.startPage(page,size);
        List<Task> tasks = taskDao.queryAll(task);
        PageInfo<Task> pageInfo = new PageInfo<>(tasks);
        List<Task> collect = tasks.stream().map(item -> {
            // 根据任务id查出所有计划
            List<Plan> plans = planService.queryPlansByTaskId(item.getTaskId());
            item.setPlans(plans);
            return item;
        }).map(item -> {
            // 根据分配人编号查出任务的分配人
            Employee employee = employeeService.queryById(item.getAssignerId());
            item.setEmployee(employee);
            return item;
        }).collect(Collectors.toList());
        pageInfo.setList(collect);
        return pageInfo;
    }


    private List<Task> findImimplementorEmployee(List<Task> tasks){
        return tasks.stream().map(item -> {
            Integer implementorId = item.getImplementorId();
            Employee employee = employeeService.queryById(implementorId);
            item.setEmployee(employee);
            return item;
        }).collect(Collectors.toList());
    }

}