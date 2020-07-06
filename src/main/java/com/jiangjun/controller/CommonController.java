package com.jiangjun.controller;

import com.jiangjun.entity.Employee;
import com.jiangjun.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @author JiangJun
 * @date 2020/6/9  21:32
 * @description
 */
@Controller
public class CommonController {

    @Autowired
    private EmployeeService employeeService;

    @PostMapping("/login")
    public String login(Employee employee, HttpServletRequest request, HttpSession session, Model model) throws Exception{
        // 跳往指定目录下的欢迎页面名
        String viewName = "";
        employee = employeeService.login(employee);
        if (employee != null){
            session.setAttribute("ctp",request.getContextPath()+"/");
            session.setAttribute("user",employee);
            // 登录成功 根据角色跳转到对应的welcome页面
            int roleId = employee.getRoleId();
            switch(roleId){
                case 2:
                    viewName = "admin/";
                    break;
                case 3:
                    viewName = "manager/";
                    break;
                case 4:
                    viewName = "person/";
                    break;
                default:
                    System.out.println("没有此角色信息！");
            }
            // 将用户能够访问的路径存入session
            session.setAttribute("allowPath",viewName);

            /*
                if (RoleConstant.ROLE_ADMIN.getId() == employee.getRoleId()){
                    viewName += RoleConstant.ROLE_ADMIN.getViewName();
                } else if (RoleConstant.ROLE_MANAGER.getId() == employee.getRoleId()){
                    viewName += RoleConstant.ROLE_MANAGER.getViewName();
                }else {
                    viewName += RoleConstant.ROLE_PERSON.getViewName();
                }
            */
            return "redirect:"+viewName+"welcome.jsp";
        }
        model.addAttribute("msg","用户名或密码错误！");
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "login";
    }
}
