package com.jiangjun.other.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author JiangJun
 * @date 2020/6/9  22:59
 * @description 权限验证拦截器
 */
public class JurisdictionInterceptor implements HandlerInterceptor {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri = request.getRequestURI();
        Object user = request.getSession().getAttribute("user");
        if (uri.contains("login") || user != null){return true;}
        request.setAttribute("msg","您还没有登录,请先登录账号!");
        request.getRequestDispatcher("/login.jsp").forward(request,response);
        return false;
    }
}
