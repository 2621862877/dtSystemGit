package com.jiangjun.dao;

import com.jiangjun.entity.Task;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * (Task)表数据库访问层
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:10
 */
public interface TaskDao {

    /**
     * 通过ID查询单条数据
     *
     * @param taskId 主键
     * @return 实例对象
     */
    Task queryById(Integer taskId);

    /**
     * 通过实体作为筛选条件查询
     *
     * @param task 实例对象
     * @return 对象列表
     */
    List<Task> queryAll(Task task);

    /**
     * 新增数据
     *
     * @param task 实例对象
     * @return 影响行数
     */
    int insert(Task task);

    /**
     * 修改数据
     *
     * @param task 实例对象
     * @return 影响行数
     */
    int update(Task task);

    /**
     * 通过主键删除数据
     *
     * @param taskId 主键
     * @return 影响行数
     */
    int deleteById(Integer taskId);

}