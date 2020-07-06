package com.jiangjun.other.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * @author JiangJun
 * @date 2020/6/11  11:40
 * @description 访问控制过滤器
 */
@WebFilter("/*")
public class AccessControlFilter implements Filter {

    private static List<String> ignores;

    @Override
    public void init(FilterConfig config) throws ServletException {
        // 需要直接放行的路径
        String ignorePath = config.getServletContext().getInitParameter("ignorePath");
        String[] split = ignorePath.split(",");
        ignores = Arrays.asList(split);
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        // 获得请求路径
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();
        String path = request.getServletPath();
        // 获得登录中的用户
        Object user = session.getAttribute("user");
        // 获取用户能访问的资源路径
        String allowPath = (String) session.getAttribute("allowPath");
        boolean flag = false;
        for (String p : ignores) {
            if (path.contains(p)){
                flag = true;
                break;
            }
        }
        if (flag || user != null){
            // 不是忽略页面并且登录后 判断是否访问的是否是对应的权限页面  只判断jsp结尾的请求
            if (!flag && user != null && path.endsWith(".jsp") &&  !path.contains(allowPath)){
                HttpServletResponse response = (HttpServletResponse) resp;
                response.setContentType("text/html;charset=utf-8");
                response.getWriter().print("<script>alert('访问页面权限不足！');location.href='"+request.getContextPath()+"/"+allowPath+"welcome.jsp';</script>");
                return;
            }
            chain.doFilter(req, resp);
        }else {
            // 未登录或者不是访问的忽略权限控制的路径 跳回登录页面
            request.getRequestDispatcher("/index.jsp").forward(request, resp);
        }
    }

    @Override
    public void destroy() {

    }


}
