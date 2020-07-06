package com.jiangjun.other.exception;

import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author JiangJun
 * @date 2020/6/11  10:24
 * @description 全局异常处理
 */
@ControllerAdvice
public class GlobalExceptionResolver {
    /**
     * 处理所有异常
     */
    @ExceptionHandler(Exception.class)
    public void handleException(Exception e, HttpServletResponse response) throws IOException {
        System.out.println(e.getMessage());
        response.setContentType("text/html;charset=utf-8");
        if (e instanceof BindException){
            response.getWriter().print("<script>alert('非法请求参数已被系统拦截,如需查看详细堆栈信息请联系管理员!');location.href='../login.jsp'</script>");
            return;
        }
        response.getWriter().print("<script>alert('非法请求已被系统拦截,如需查看详细堆栈信息请联系管理员!');location.href='../login.jsp'</script>");
    }

}
