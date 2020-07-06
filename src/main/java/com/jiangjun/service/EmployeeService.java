package com.jiangjun.service;

import com.github.pagehelper.PageInfo;
import com.jiangjun.entity.Employee;
import java.util.List;

/**
 * (Employee)表服务接口
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:09
 */
public interface EmployeeService {

    /**
     * 通过ID查询单条数据
     *
     * @param employeeId 主键
     * @return 实例对象
     */
    Employee queryById(Integer employeeId);


    /**
     * 新增数据
     *
     * @param employee 实例对象
     * @return 实例对象
     */
    Employee insert(Employee employee);

    /**
     * 修改数据
     *
     * @param employee 实例对象
     * @return 实例对象
     */
    Employee update(Employee employee);

    /**
     * 通过主键删除数据
     *
     * @param employeeId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer employeeId);

    Employee login(Employee employee);

    PageInfo<Employee> queryAll(Integer page, Integer size);

    /**
     * 查询所有主管
     */
    List<Employee> queryAllManager();

    /**
     * 根据主管id查出其下所有员工
     * @param employeeId
     * @return
     */
    PageInfo<Employee> queryAllEmpByManagerId(Integer employeeId,Integer page, Integer size);
}