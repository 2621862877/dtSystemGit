package com.jiangjun.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiangjun.entity.Plan;
import com.jiangjun.entity.Task;
import com.jiangjun.other.constant.RoleConstant;
import com.jiangjun.entity.Employee;
import com.jiangjun.dao.EmployeeDao;
import com.jiangjun.entity.Role;
import com.jiangjun.service.EmployeeService;
import com.jiangjun.service.PlanService;
import com.jiangjun.service.RoleService;
import com.jiangjun.service.TaskService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

/**
 * (Employee)表服务实现类
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:09
 */
@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService {
    @Resource
    private EmployeeDao employeeDao;
    @Resource
    private RoleService roleService;

    @Resource
    private TaskService taskService;
    @Resource
    private PlanService planService;

    /**
     * 通过ID查询单条数据
     *
     * @param employeeId 主键
     * @return 实例对象
     */
    @Override
    public Employee queryById(Integer employeeId) {
        Employee employee = this.employeeDao.queryById(employeeId);
        employee.setRole(roleService.queryById(employee.getRoleId()));
        return employee;
    }


    /**
     * 新增数据
     *
     * @param employee 实例对象
     * @return 实例对象
     */
    @Override
    public Employee insert(Employee employee) {
        this.employeeDao.insert(employee);
        return employee;
    }

    /**
     * 修改数据
     *
     * @param employee 实例对象
     * @return 实例对象
     */
    @Override
    public Employee update(Employee employee) {
        this.employeeDao.update(employee);
        return this.queryById(employee.getEmployeeId());
    }

    /**
     * 通过主键删除数据
     *
     * @param employeeId 主键
     * @return 是否成功
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public boolean deleteById(Integer employeeId) {
        // 查出该主管/员工对应的所有任务
        List<Task> tasks = taskService.queryTaskByPersonId(employeeId,0,0).getList();
        PageInfo<Task> pageInfo = taskService.queryAllByManagerId(employeeId, 0, 0);
        tasks.addAll(pageInfo.getList());

        for (Task task : tasks) {
            // 删除任务的同时会删除计划
            taskService.deleteById(task.getTaskId());
        }
        return this.employeeDao.deleteById(employeeId) > 0;
    }

    @Override
    public Employee login(Employee employee) {
        return this.employeeDao.login(employee);
    }

    @Override
    public PageInfo<Employee> queryAll(Integer page, Integer size) {
        // 执行查询操作前调用分页插件执行分页的方法
        PageHelper.startPage(page,size);
        List<Employee> employees = employeeDao.queryAll(null);
        // 创建分页对象把查询的结果放入
        PageInfo<Employee> pageInfo = new PageInfo<>(employees);
        // 遍历结果集查出每个员工对应的角色信息
        List<Employee> emps = employees.stream().map(item->{
            Integer roleId = item.getRoleId();
            Role role = roleService.queryById(roleId);
            item.setRole(role);
            return item;
        }).collect(Collectors.toList());
        // 重新放入分页对象中
        pageInfo.setList(emps);
        return pageInfo;
    }

    @Override
    public List<Employee> queryAllManager() {
        Employee employee = new Employee();
        employee.setRoleId(RoleConstant.ROLE_MANAGER.getId());
        return employeeDao.queryAll(employee);
    }

    @Override
    public PageInfo<Employee> queryAllEmpByManagerId(Integer employeeId,Integer page, Integer size) {
        Employee employee = new Employee();
        employee.setParentId(employeeId);
        // 执行查询操作前调用分页插件执行分页的方法 传入页号和页大小
        PageHelper.startPage(page,size);
        List<Employee> employees = employeeDao.queryAll(employee);
        return new PageInfo<>(employees);
    }
}