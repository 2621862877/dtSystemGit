package com.jiangjun.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author JiangJun
 * @date 2020/6/10  15:44
 * @description
 */
public class DateUtil {
    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    public static String dateToStr(Date date){
        if (date == null){return "";}
        return sdf.format(date);
    }
}
