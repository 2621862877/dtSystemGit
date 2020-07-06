package com.jiangjun.service;

import com.github.pagehelper.PageInfo;
import com.jiangjun.entity.Task;
import java.util.List;

/**
 * (Task)表服务接口
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:10
 */
public interface TaskService {

    /**
     * 通过ID查询单条数据
     *
     * @param taskId 主键
     * @return 实例对象
     */
    Task queryById(Integer taskId);

    /**
     * 新增数据
     *
     * @param task 实例对象
     * @return 实例对象
     */
    Task insert(Task task);

    /**
     * 修改数据
     *
     * @param task 实例对象
     * @return 实例对象
     */
    Task update(Task task);

    /**
     * 通过主键删除数据
     *
     * @param taskId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer taskId);

    /**
     * 根据主管编号查询发布过的所有任务
     * @param managerId
     * @return
     */
    PageInfo<Task> queryAllByManagerId(Integer managerId,Integer page,Integer size);

    /**
     * 根据主管id查询出所有未实施的任务
     * @param parentId
     * @return
     */
    PageInfo<Task> queryTaskundoneByParentId(Integer parentId,Integer page,Integer size);

    /**
     * 根据主管id查询出所有实施中的任务
     * @param parentId
     * @return
     */
    PageInfo<Task> queryIntendanceByParentId(Integer parentId,Integer page,Integer size);

    /**
     * 根据员工ID查询出分配给员工的所有任务
     * @param personId
     * @return
     */
    PageInfo<Task> queryTaskByPersonId(Integer personId,Integer page,Integer size);
}