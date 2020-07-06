package com.jiangjun.controller;

import com.github.pagehelper.PageInfo;
import com.jiangjun.entity.Employee;
import com.jiangjun.service.EmployeeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * (Employee)表控制层
 *
 * @author JiangJun
 * @since 2020-06-09 19:51:09
 */
@Controller
@RequestMapping("employee")
public class EmployeeController {
    /**
     * 服务对象
     */
    @Resource
    private EmployeeService employeeService;

    /**
     * 点击了用户管理 查询所有用户并跳往指定的管理页面
     */
    @GetMapping("/userManager/{viewName}")
    public ModelAndView userManager(@PathVariable("viewName") String viewName,
                                    @RequestParam(name = "page",defaultValue = "1") Integer page,
                                    @RequestParam(name = "size",defaultValue = "3") Integer size){
        ModelAndView mav = new ModelAndView();
        PageInfo<Employee> pageInfo = employeeService.queryAll(page, size);
        mav.addObject("pageInfo",pageInfo);
        mav.setViewName("/admin/"+viewName);
        return mav;
    }

    /**
     * 添加员工
     * @param employee
     * @return
     */
    @PostMapping("/addEmp")
    public String addEmployee(Employee employee){
        Employee emp = employeeService.insert(employee);
        if (emp.getEmployeeId() != null){
            // success
        }
        // 查询所有员工信息跳回用户管理页面
        return "redirect:userManager/useradmin";
    }

    /**
     * 根据编号删除员工
     * 删除该员工对应的所有任务和计划需要一并删除
     */
    @PostMapping("/deleteById")
    public String deleteById(Integer id){
        boolean result = employeeService.deleteById(id);
        if (result){
            // success
        }
        // 删除后跳回员工管理页面
        return "redirect:userManager/empadmin";
    }


    /**
     * 通过主键查询员工一并查出所有主管信息进行分配人员设置
     * @param id 主键
     */
    @PostMapping("/queryById")
    public ModelAndView selectOne(Integer id) {
        Employee employee = this.employeeService.queryById(id);
        ModelAndView mav = new ModelAndView();
        mav.addObject("emp",employee);
        // 查询出所有主管信息 便于放入上级主管下拉框
        List<Employee> managers = employeeService.queryAllManager();
        mav.addObject("managers",managers);
        mav.setViewName("/admin/persondesc");
        return mav;
    }

    /**
     * 给员工分配主管
     */
    @PostMapping("/empManager")
    public String empManager(Employee employee){
        employeeService.update(employee);
        // 修改后回到人员页面
        return "redirect:userManager/empdistribute";
    }

    /**
     * 根据主管ID查出该主管下所有员工 并跳往路径变量指定的页面
     */
    @GetMapping("/queryEmpByParentId/{viewName}")
    public String queryEmpByParentId(Model model, HttpSession session,
                                     @PathVariable("viewName") String viewName,
                                     @RequestParam(name = "page",defaultValue = "1") Integer page,
                                     @RequestParam(name = "size",defaultValue = "3") Integer size){
        Employee employee = (Employee) session.getAttribute("user");
        if ("task".equals(viewName)){
            // 跳往指定任务页也需要查出所有员工渲染实施人员下拉框
            // 不需要分页 查询所有
            page = 0;
        }
        PageInfo<Employee> pageInfo = employeeService.queryAllEmpByManagerId(employee.getEmployeeId(),page,size);
        model.addAttribute("pageInfo",pageInfo);
        return "/manager/"+viewName;
    }

    /**
     * 根据员工id查询详细信息
     * @param empId
     * @return
     */
    @PostMapping("/queryInfoById")
    public String queryInfoById(Integer empId,Model model){
        Employee employee = employeeService.queryById(empId);
        model.addAttribute("emp",employee);
        return "/manager/personinfo";
    }



}