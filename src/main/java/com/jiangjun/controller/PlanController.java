package com.jiangjun.controller;

import com.github.pagehelper.PageInfo;
import com.jiangjun.entity.Employee;
import com.jiangjun.entity.Plan;
import com.jiangjun.entity.Task;
import com.jiangjun.service.PlanService;
import com.jiangjun.service.TaskService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

/**
 * (Plan)表控制层
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:10
 */
@Controller
@RequestMapping("plan")
public class PlanController {
    /**
     * 服务对象
     */
    @Resource
    private PlanService planService;
    @Resource
    private TaskService taskService;

    /**
     * 通过主键查询单条数据
     *
     * @param planId 主键
     * @return 单条数据
     */
    @PostMapping("/queryPlanById")
    public ModelAndView selectOne(Integer planId) {
        Plan plan = this.planService.queryById(planId);
        ModelAndView mav = new ModelAndView();
        mav.addObject("plan",plan);
        mav.setViewName("/manager/program");
        return mav;
    }

    @GetMapping("/queryPlanById")
    public String queryPlanById(Integer planId,Model model){
        Plan plan = this.planService.queryById(planId);
        model.addAttribute("plan",plan);
        return "/person/feedback";
    }

    @PostMapping("/deleteById")
    public String deleteById(Integer planId){
        boolean result = planService.deleteById(planId);
        // 删除计划后重新跳转到查询我的任务
        return "redirect:/task/queryTaskByPersonId";
    }

    @PostMapping("/newPlan")
    public String newPlan(Plan plan){
        Plan insert = planService.insert(plan);
        // 新建计划后 跳往查询计划页面 高级查询表单的所属任务下拉框需要查出该员工的所有任务
        return "redirect:queryPlansByPersonId";
    }

    /**
     * 查出用户对应的所有计划和任务信息 渲染查询计划页面
     * 先查询除用户的所有任务  再查出任务下所有计划装入集合
     *
     * 2020/6/13因为要求分页 故将查询和分页作为一个方法
     * @param form 高级查询表单提交标识
     */
    @RequestMapping("/queryPlansByPersonId")
    public ModelAndView queryPlansByPersonId(boolean form,
                                             HttpSession session,
                                             Plan plan,
                                             HttpServletResponse response,
                                             @RequestParam(name = "page",defaultValue = "1") Integer page,
                                             @RequestParam(name = "size",defaultValue = "3") Integer size) throws IOException {

        ModelAndView mav = new ModelAndView();
        Employee employee = (Employee) session.getAttribute("user");
        // 用户所有任务 用于渲染下拉框
        PageInfo<Task> pageInfo = taskService.queryTaskByPersonId(employee.getEmployeeId(),0,0);
        List<Task> tasks = pageInfo.getList();
        mav.addObject("tasks",tasks);
        // 获得所有的任务ID作为查询用户所有计划的条件
        List<Integer> ids = tasks.stream().map(item -> {
            return item.getTaskId();
        }).collect(Collectors.toList());

        if (!form){
            // 点击的是超链接 或者是全部查询
            Object object = session.getAttribute("plan");
            // 如果session中的对象不为空 代表之前已有查询条件故需要作为查询参数
            plan = object != null ? (Plan) object : plan;
        }

        // 分页+高级查询 查询计划
        PageInfo<Plan> pageInfo1 = planService.queryPlanByCondition(plan,page,size,ids);

        if (pageInfo1 == null){
            // 没有符合条件的数据
            session.removeAttribute("plan");
            response.setContentType("text/html;charset=utf-8");
            response.getWriter().print("<script>alert('没有符合条件的数据');location.href='queryPlansByPersonId'</script>");
            return null;
        }
        // 是form表单提交的plan对象则将查询条件存入session
        if (form){
            session.setAttribute("plan",plan);
        }
        mav.addObject("pageInfo",pageInfo1);
        mav.setViewName("/person/checkpro");
        return mav;
    }

    /**
     * 反馈计划提交修改计划信息
     */
    @PostMapping("/updatePlan")
    public String updatePlan(Plan plan){
        Plan update = planService.update(plan);
        // 修改完成后跳往查询所有计划
        return "redirect:queryPlansByPersonId";
    }

    /**
     * 查询计划页面高级查询
     */
   /* @PostMapping("/queryPlanByCondition")
    public String queryPlanByCondition(Plan plan, HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Plan> plans = planService.queryPlanByCondition(plan);
        if (plans == null){
            // 没有符合条件的数据
            request.getSession().removeAttribute("plan");
            response.setContentType("text/html;charset=utf-8");
            response.getWriter().print("<script>alert('没有符合条件的数据');location.href='queryPlansByPersonId'</script>");
            return null;
        }
        // 有数据则将查询条件存入session
        request.getSession().setAttribute("plan",plan);
        request.setAttribute("plans",plans);
        return "/person/checkpro";
    }*/

   @GetMapping("queryAllPlan")
   public String  queryAllPlan(HttpSession session){
       session.removeAttribute("plan");
       return "redirect:queryPlansByPersonId";
   }

}