package com.dao;

import javax.sql.DataSource;

import org.nutz.dao.entity.annotation.Table;
import org.nutz.dao.impl.NutDao;
import org.nutz.mvc.Mvcs;
import org.nutz.resource.Scans;

public class Init {
	public static DataSource ds = null;
	public static NutDao dao = null;
	static{
		 ds	 = Mvcs.ctx.getDefaultIoc().get(DataSource.class,"datasource");
		 dao = new NutDao(ds);

        //自动建表
        for(Class<?> clazz: Scans.me().scanPackage("com.bean")){
            if(null!=clazz.getAnnotation(Table.class)){
                dao.create(clazz, false);//建表
            }
        }
	}
}
