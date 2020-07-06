package com.jiangjun.controller;

import com.github.pagehelper.PageInfo;
import com.jiangjun.entity.Employee;
import com.jiangjun.entity.Task;
import com.jiangjun.service.EmployeeService;
import com.jiangjun.service.TaskService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * (Task)表控制层
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:10
 */
@Controller
@RequestMapping("task")
public class TaskController {
    /**
     * 服务对象
     */
    @Resource
    private TaskService taskService;
    @Resource
    private EmployeeService employeeService;

    /**
     * 通过主键查询单条任务跳往主管页面
     *
     * @param taskId 主键
     * @return 单条数据
     */
    @RequestMapping("/queryTaskById/{viewName}")
    public ModelAndView selectOne(Integer taskId,@PathVariable("viewName") String viewName) throws Exception {
        ModelAndView mav = new ModelAndView();
        Task task = this.taskService.queryById(taskId);
        mav.addObject("task",task);

        // 调整任务时需要查询出主管下所有员工 用于渲染实施人下拉框
        List<Employee> emps = employeeService.queryAllEmpByManagerId(task.getAssignerId(),0,0).getList();
        mav.addObject("emps",emps);
        mav.setViewName("/manager/"+viewName);
        return mav;
    }

    @PostMapping("/queryTaskById")
    public ModelAndView queryTaskById(Integer taskId) throws Exception{
        ModelAndView mav = new ModelAndView();
        Task task = this.taskService.queryById(taskId);
        mav.addObject("task",task);

        mav.setViewName("/person/taskview");
        return mav;
    }

    /**
     * 添加任务
     */
    @PostMapping("/addTask")
    public String addTask(Task task) throws Exception{
        taskService.insert(task);
        // 查询全部任务
        return "redirect:queryAll";
    }

    /**
     * 根据主管编号查询发布过的所有任务
     */
    @GetMapping("/queryAll")
    public ModelAndView queryAll(HttpSession session,
                                 @RequestParam(name = "page",defaultValue = "1") Integer page,
                                 @RequestParam(name = "size",defaultValue = "3") Integer size) throws Exception{
        Employee employee = (Employee) session.getAttribute("user");
        Integer managerId = employee.getEmployeeId();

        PageInfo<Task> pageInfo = taskService.queryAllByManagerId(managerId,page,size);
        ModelAndView mav = new ModelAndView();
        mav.addObject("pageInfo",pageInfo);
        mav.setViewName("/manager/taskview");
        return mav;
    }

    /**
     * 根据主管id查询出所有未实施的任务
     */
    @GetMapping("/queryTaskundoneByParentId")
    public ModelAndView queryTaskundoneByParentId(HttpSession session,
                                                  @RequestParam(name = "page",defaultValue = "1") Integer page,
                                                  @RequestParam(name = "size",defaultValue = "3") Integer size) throws Exception{
        ModelAndView mav = new ModelAndView();
        Employee employee = (Employee) session.getAttribute("user");
        Integer parentId = employee.getEmployeeId();

        PageInfo<Task> pageInfo = taskService.queryTaskundoneByParentId(parentId, page, size);
        mav.addObject("pageInfo",pageInfo);
        mav.setViewName("/manager/taskundone");
        return mav;
    }

    /**
     * 根据主管id查询出所有实施中的任务
     */
    @GetMapping("/queryIntendanceByParentId")
    public ModelAndView queryIntendanceByParentId(HttpSession session,
                                                  @RequestParam(name = "page",defaultValue = "1") Integer page,
                                                  @RequestParam(name = "size",defaultValue = "3") Integer size) throws Exception{
        ModelAndView mav = new ModelAndView();
        Employee employee = (Employee) session.getAttribute("user");
        Integer parentId = employee.getEmployeeId();

        PageInfo<Task> pageInfo = taskService.queryIntendanceByParentId(parentId, page, size);
        mav.addObject("pageInfo",pageInfo);
        mav.setViewName("/manager/intendance");
        return mav;
    }

    @PostMapping("/deleteById")
    public String deleteById(Integer taskId) throws Exception{
        boolean result = taskService.deleteById(taskId);
        // 继续查询所有未实施的任务
        return "redirect:queryTaskundoneByParentId";
    }

    @PostMapping("/updateTask")
    public String updateTask(Task task) throws Exception{
        taskService.update(task);
        return "redirect:queryTaskundoneByParentId";
    }

    /**
     * 修改任务的状态,如果状态修改为已完成的话，前提是该任务下所有计划都是已完成and已反馈状态
     * @param task
     * @return
     */
    @PostMapping("/updateTaskStatus")
    public String updateTaskStatus(Task task, HttpServletResponse response) throws Exception {
        Task result = taskService.update(task);
        if (result == null){
            // 还有未完成的计划  无法将任务状态设置为已完成!
            response.setContentType("text/html;charset=urf-8");
            response.getWriter().print("<script>alert('还有未完成的计划,无法将任务状态设置为已完成!');" +
                    "location.href='queryIntendanceByParentId'</script>");
            return null;
        }
        // success 跳往查询所有实施中的任务
        return "redirect:queryIntendanceByParentId";
    }

    /**
     * 根据员工ID查询出分配给员工的所有任务
     */
    @GetMapping("/queryTaskByPersonId")
    public ModelAndView queryTaskByPersonId(HttpSession session,
                                            @RequestParam(name = "page",defaultValue = "1") Integer page,
                                            @RequestParam(name = "size",defaultValue = "3") Integer size)throws Exception{
        ModelAndView mav = new ModelAndView();
        Employee employee = (Employee) session.getAttribute("user");
        Integer personId = employee.getEmployeeId();
        PageInfo<Task> pageInfo = taskService.queryTaskByPersonId(personId, page, size);
        mav.addObject("pageInfo",pageInfo);
        mav.setViewName("/person/task");
        return mav;
    }

}