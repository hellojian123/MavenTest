package com.dao;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.apache.commons.dbcp.BasicDataSource;
import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Condition;
import org.nutz.dao.Sqls;
import org.nutz.dao.entity.Entity;
import org.nutz.dao.entity.Record;
import org.nutz.dao.impl.NutDao;
import org.nutz.dao.pager.Pager;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;
import org.nutz.ioc.Ioc;
/**
 * 基本数据库操作类
 * @author Administrator
 *
 */
public class BaseDao {
	
	protected DataSource ds = null;
	protected static NutDao dao = Init.dao;

	/**
	 * 使用默认数据源
	 * @param ioc
	 */
	public  BaseDao(Ioc ioc) {}
	/**
	 * 
	 * @param ioc
	 * @param dataSourceName 使用指定数据源
	 */
	public  BaseDao(Ioc ioc,String dataSourceName) {
		ds = ioc.get(BasicDataSource.class, dataSourceName);
		dao = new NutDao(ds);
	}
	public BaseDao(){};
	/**
	 * 根据Id删除数据
	 * @param <T>
	 * @param id 持久化Id
	 * @return true 成功删除一条数据,false删除失败
	 */
	public <T> boolean delById(int id,Class<T> c){
		
		return dao.delete(c, id)==1;
	}
	
	/**
	 * 根据ID查询一个对象
	 * @param <T>
	 * @param id 持久化Id
	 * @param c 要查询的表
	 * @return 查询到的对象
	 */
	public <T> T find(int id,Class<T> c){
		
		return dao.fetch(c, id);
	}
	
	/**
	 * 根据ID查询一个对象
	 * @param <T>
	 * @param id 持久化Id
	 * @param c 要查询的表
	 * @return 查询到的对象
	 */
	public <T> T find(int id,Class<T> c,String feild){
		T t = dao.fetch(c, id);
		dao.fetchLinks(t, feild);
		return t;
	}
	/**
	 * 查询数据库中的全部数据
	 * @param <T>
	 * @param c 查询的表
	 * @param orderby desc 排序的条件
	 * @return List
	 */
	public <T> List<T> search(Class<T> c,String orderby){
		
		return dao.query(c, Cnd.orderBy().desc(orderby), null);

	}
	/**
	 * 根据条件查询数据库中满足条件的数据
	 * @param <T>
	 * @param c
	 * @param condition
	 * @return
	 */
	public <T> List<T> search(Class<T> c,Condition condition){
		List<T> list = dao.query(c, condition, null);
		return list;
	}
	
	/**
	 * 分页查询表中所有数据
	 * @param <T>
	 * @param c 查询的表
	 * @param currentPage 当前页数
	 * @param pageSize 每页显示数量
	 * @param orderby desc排序的条件
	 * @return List 
	 */
	public <T> List<T> searchByPage(Class<T> c,int currentPage,int pageSize,String orderby){
		Pager pager = dao.createPager(currentPage, pageSize);
		return dao.query(c, Cnd.orderBy().desc(orderby), pager);
	}
	
	/**
	 * 分页带条件查询所有数据
	 * @param <T>
	 * @param c           查询的表
	 * @param condition   查询条件,用Cnd的静态方法构造
	 * @param currentPage 当前页码
	 * @param pageSize    每页显示的数据量
	 * @return List
	 */
	public <T> List<T> searchByPage(Class<T> c,Condition condition,int currentPage,int pageSize){
		Pager pager = dao.createPager(currentPage, pageSize);
		return dao.query(c, condition, pager);
	}
	
	/**
	 * 分页带条件查询所有数据
	 * @param <T>
	 * @param c            	查询的表
	 * @param condition    	查询条件,用Cnd的静态方法构造
	 * @param tem          	需要封装的实体
	 * @param currentPage  	当前页码
	 * @param pageSize     	每页显示的数据量
	 * @Param selectColumn	主键
	 * @param returnColumn	需要封装的字段
	 * @param relationId	外键
	 * @return List
	 */
	public <T> List<T> searchByPage(Class<T> c,Condition condition,Class cls,int currentPage,int pageSize,String selectColumn,String returnColumn,String relationId){
		
		Pager pager = dao.createPager(currentPage, pageSize);
		List<T> list = dao.query(c, condition, pager);
		
		if(list == null || list.size() == 0) return list;
		Field field = null;
		StringBuilder sb = new StringBuilder();
		Map<Object, List<T>> map = new HashMap<Object, List<T>>();
		Object obj = null;
		for (T t : list) {
			try {
				field = t.getClass().getDeclaredField(selectColumn);
				field.setAccessible(true);
				obj = field.get(t);
				sb.append(obj).append(",");
			} catch (Exception e) {
				e.printStackTrace();
			}
			map.put(obj, new ArrayList<T>());
		}
		sb.append("0");
		try {
			
			List<T> relationList = this.searchByConditionIdss(cls, relationId, sb.toString(), null);
			for (T t : relationList) {
				
				try {
					field = t.getClass().getDeclaredField(relationId);
					field.setAccessible(true);
					obj = field.get(t);
					map.get(obj).add(t);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} catch (Exception e1) {
			
			e1.printStackTrace();
		}
		
		Field temField = null;
		Object key = null;
		for (T t : list) {
			try{
				
				field = t.getClass().getDeclaredField(returnColumn);
				temField = t.getClass().getDeclaredField(selectColumn);
				field.setAccessible(true);
				temField.setAccessible(true);
				
				key = temField.get(t);
				field.set(t, map.get(key));
				
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	/**
	 * 修改一条数据
	 * @param <T>
	 * @param t     修改数据库中的数据
	 * @return true 修改成功,false 修改失败
	 */
	public <T> boolean update(T t){
		


		return dao.updateIgnoreNull(t) == 1;
	}
	/**
	 * 根据条件修改指定数据
	 * @param <T>
	 * @param c 数据库表
	 * @param chain 修改的内容
	 * @param condition 选择条件
	 * @return true 成功,false失败
	 */
	public <T> boolean update(Class<T> c,Chain chain,Condition condition){
		

		
		return dao.update(c, chain, condition)>0;
	}
	
	/**
	 * 增加一条数据
	 * @param <T>
	 * @param t
	 * @return 返回增加到数据库的这条数据
	 */
	public <T> T save(T t){
		return dao.insert(t);
	}
	
	public void save(String table,Chain chain){
		dao.insert(table, chain);
	}
	
	/**
	 * 查询数据库中的数据条数
	 * @param <T>
	 * @param c 查询的数据库表
	 * @return int
	 */
	public <T> int searchCount(Class<T> c){
		return dao.count(c);
	}
	/**
	 * 根据条件查询数据库中的数据条数
	 * @param <T> 
	 * @param c         查询的数据库表
	 * @param condition 条件,用Cnd的静态方法构造
	 * @return int
	 */
	public <T> int searchCount(Class<T> c,Condition condition){
		

		
		return dao.count(c,condition);
	}
	/**
	 * 计算最大分页数
	 * @param count 记录总数
	 * @param pageSize 每页显示多少数据
	 * @return int
	 */
	public int maxPageSize(int count,int pageSize){
		if(pageSize>0){
			if((count%pageSize)!=0){
				return (count/pageSize)+1;
			}else{
				return (count/pageSize);
			}
		}
		return 0;
	}
	/**
	 * 根据多个id 查询数据
	 * @param <T>
	 * @param ids 要查询的id,多个用","（逗号）分隔
	 * @param c   要查询的表信息
	 * @return List
	 */
	public <T> List<T> searchByIds(Class<T> c,String ids,String orderby){
		

		
		Entity<T>  entity = dao.getEntity(c);
		
		String id = entity.getIdField().getColumnName();
		
		String sql = " "+id +" in ("+ids+") order by "+orderby+" desc";
			
		return dao.query(c, Cnd.wrap(sql), null);
	
	}
	/**
	 * 根据多个id 查询数据
	 * @param <T>
	 * @param ids 要查询的id,多个用","（逗号）分隔
	 * @param c   要查询的表信息
	 * @return List
	 */
	public <T> List<T> searchByConditionIdss(Class<T> c,String column,String ids,String orderby){
		
		String sql = " "+column +" in ("+ids+") order by "+orderby+" desc";
			
		return dao.query(c, Cnd.wrap(sql), null);
	
	}
	public <T> List<T> searchByConditionIdss(Class<T> c,String column,String ids,String orderby,int curPage,int pagesize){
		String sql = " "+column +" in ("+ids+") order by "+orderby+" desc limit "+(curPage-1)*pagesize+", "+pagesize+"" ;
			
		return dao.query(c, Cnd.wrap(sql), null);
	
	}
	public <T> int searchCountByConditionIdss(Class<T> c,String column,String ids,String orderby,int curPage,int pagesize){
		String sql = " "+column +" in ("+ids+") order by "+orderby+" desc " ;
			
		return dao.query(c, Cnd.wrap(sql), null).size();
	
	}
	/**
	 * 根据多个id 查询数据条数
	 * @param <T>
	 * @param ids 要查询的id,多个用","（逗号）分隔
	 * @param c   要查询的表信息
	 * @return List
	 */
	public <T> int searchByIdsCount(Class<T> c,String ids,String orderby){
		

		
		Entity<T>  entity = dao.getEntity(c);
		
		String id = entity.getIdField().getColumnName();
		
		String sql = " "+id +" in ("+ids+") order by "+orderby+" desc";
			
		return dao.count(c, Cnd.wrap(sql));
	
	}
	/**
	 * 根据多个id 查询数据并且分页
	 * @param <T>
	 * @param ids 要查询的id,多个用","（逗号）分隔
	 * @param c   要查询的表信息
	 * @return List
	 */
	public <T> List<T> searchByIdsFenye(Class<T> c,String ids,String orderby,int currentPage,int pageSize){
		
		//Pager pager = dao.createPager(currentPage, pageSize);
		
		Entity<T>  entity = dao.getEntity(c);
		
		String id = entity.getIdField().getColumnName();
		
		String sql = " "+id +" in ("+ids+") order by "+orderby+" desc limit "+(currentPage-1)*pageSize+", "+pageSize+"" ;
			
		return dao.query(c, Cnd.wrap(sql), null);
	
	}
	/**
	 * 根据多个id 查询数据并且分页
	 * @param <T>
	 * @param ids 要查询的id,多个用","（逗号）分隔
	 * @param c   要查询的表信息
	 * @return List
	 */
	public <T> int searchByIdsCount(Class<T> c,String ids,String orderby,int currentPage,int pageSize){
		
		//Pager pager = dao.createPager(currentPage, pageSize);
		
		Entity<T>  entity = dao.getEntity(c);
		
		String id = entity.getIdField().getColumnName();
		
		String sql = " "+id +" in ("+ids+") order by "+orderby+" desc ";
		return dao.query(c, Cnd.wrap(sql), null).size();
	
	}
	/**
	 * 根据多个id 查询数据
	 * @param <T>
	 * @param ids 整形的id数组
	 * @param c   要查询的表信息
	 * @return List
	 */
	public <T> List<T> searchByIds(Class<T> c,int[] ids,String orderby){
		

		
		Entity<T>  entity = dao.getEntity(c);
		
		String id = entity.getIdField().getColumnName();
			
		return dao.query(c,Cnd.where(id, "in", ids).desc(orderby), null);
	
	}
	/**
	 * 根据多个id删除数据
	 * @param <T>
	 * @param c     要操作的表信息
	 * @param ids   要删除的id,多个用","（逗号）分隔
	 * @return true 成功,false 失败
	 */
	public <T> void deleteByIds(Class<T> c,String ids){
		
		Entity<T>  entity = dao.getEntity(c);
		
		String table = entity.getTableName();
		
		String id = entity.getIdField().getColumnName();
		
		Sql sql = Sqls.create("delete from "+table+" where "+id+" in("+ids+")");
		
		dao.execute(sql);
	}
	/**
	 * 根据条件返回一个条件
	 * @param <T>
	 * @param condition 查询条件用Cnd构造
	 * @return T
	 */
	public <T> T findByCondition(Class<T> c,Condition condition){
		

		
		return dao.fetch(c, condition);
	}

	/**
	 * 根据指定的字段模糊分页查询数据 
	 * @param <T>
	 * @param c           查询的表
	 * @param fieldName   字段名称
	 * @param value       模糊条件
	 * @param currentPage 当前页码
	 * @param pageSize    每页数据量
	 * @return List
	 */
	public <T> List<T> searchByPageLike(Class<T> c,String fieldName,String value,int currentPage,int pageSize){
		
		
		Entity<T> entity = dao.getEntity(c);
		
		String column = entity.getField(fieldName).getColumnName();
		
		Pager pager = dao.createPager(currentPage, pageSize);
		
		return dao.query(c, Cnd.where(column, "LIKE", "%"+value+"%"), pager);
		
	}
	
	/**
	 * 根据指定的字段模糊分页查询数据 记录总数
	 * @param <T>
	 * @param c           查询的表
	 * @param fieldName   字段名称
	 * @param value       模糊条件
	 * @param currentPage 当前页码
	 * @param pageSize    每页数据量
	 * @return List
	 */
	public <T> int searchByPageLike(Class<T> c,String fieldName,String value){

		
		Entity<T> entity = dao.getEntity(c);
		
		String column = entity.getField(fieldName).getColumnName();
		
		
		return dao.count(c, Cnd.where(column, "LIKE", "%"+value+"%"));
		
	}
	/**
	 * 根据某个条件分页查询数据
	 * @param <T>
	 * @param c           查询的表
	 * @param fieldName   匹配字段名
	 * @param value       匹配的值
	 * @param currentPage 当前页码
	 * @param pageSize    每页数据量
	 * @return List
	 */
	public <T> List<T> searchByPage(Class<T> c,String fieldName,String value,int currentPage,int pageSize){


		Entity<T> entity = dao.getEntity(c);
		
		String column = entity.getField(fieldName).getColumnName();
		
		Pager pager = dao.createPager(currentPage, pageSize);
		
		return dao.query(c, Cnd.where(column, "=", value), pager);
	}
	
	/**
	 * 根据指定条件返回一个对象
	 * @param <T>
	 * @param fileName  匹配名称
	 * @param value     匹配值
	 * @return T
	 */
	public <T> T findByCondition(Class<T> c,String fileName,String value){
		
		
		return dao.fetch(c, Cnd.where(fileName, "=", value));
	}
	/**
	 * 添加一条数据到数据库中，
	 * 该数据包括关联的多个其他数据
	 * @param <T>
	 * @param t         插入数据库的对象
	 * @param fieldName 关联数据的字段名，一般为List对象
	 * @return T
	 */
	public <T> T saveWidth(T t,String fieldName){
		
		
		return dao.insertWith(t, fieldName);
		
	}
	/**
	 * 获取关联对象
	 * @param <T>
	 * @param t          查询的对象
	 * @param fieldName  关联的对象
	 * @return T
	 */
	public <T> T findLink(T t,String fieldName){
		
		return dao.fetchLinks(t, fieldName);
	}
	/**
	 * 更新自身和关联的对象
	 * @param <T>
	 * @param t         修改的对象
	 * @param fieldName 关联对象
	 * @return T
	 */
	public <T> T updateWidth(T t,String fieldName){
		
		return dao.updateWith(t, fieldName);
	}
	/**
	 * 仅修改关联的对象的数据
	 * @param <T>
	 * @param t         查询条件
	 * @param fieldName 修改的对象
	 * @return T
	 */
	public <T> T updateLink(T t,String fieldName){
		
		return dao.updateLinks(t, fieldName);
	}
	
	/**
	 * 删除自身和关联对象 
	 * @param <T>
	 * @param t         删除的对象
	 * @param fieldName 关联的对象
	 */
	public <T> void deleteWidth(T t,String fieldName){
		
		dao.deleteWith(t, fieldName);
	}
	/**
	 * 删除关联的对象，不删除自身
	 * @param <T>
	 * @param t          删除的条件
	 * @param fieldName  删除的关联对象
	 */
	public <T> void  deleteLink(T t,String fieldName){
		
		dao.deleteLinks(t, fieldName);
	}
	/**
	 * 保存对象的多对多 关系
	 * @param <T>
	 * @param t
	 * @param fieldName
	 */
	public <T> T saveRelation(T t,String fieldName){
	
	
		return dao.insertRelation(t, fieldName);
	}
	/**
	 * 保存对象的关联关系,不保存对象本身
	 * @param <T>
	 * @param t
	 * @param fieldName
	 * @return
	 */
	public <T> T saveLink(T t,String fieldName){

		
		return dao.insertLinks(t, fieldName);
	}
	/**
	 * 更新对象的多对多关系
	 * @param <T>
	 * @param c    更新的对象的类
	 * @param fieldName  更新的字段名称
	 * @param chain    更新的内容
	 * @param condition  更新的条件
	 * @return true 成功,false 失败
	 */
	public <T> boolean updateRelation(Class<T> c,String fieldName,Chain chain,Condition condition){
		
		return dao.updateRelation(c, fieldName, chain, condition)>0;
	}
	/**
	 * 对于 '@One' 和 '@Many'，对应的记录将会删除
	 * 而 '@ManyMay' 对应的字段，只会清除关联表中的记录
	 * @param <T>
	 * @param t
	 * @param fieldName
	 * @return
	 */
	public <T> T clearRelation(T t,String fieldName){
		
		return dao.clearLinks(t, fieldName);
	}

	
	public void delete(String table,Condition condition){
		
		
		dao.clear(table, condition);
		
	}
	
	public List<Record> query(String joinT,Condition condition){
		
		return dao.query(joinT, condition, null);
	}

	/**
	 * 根据用户ID查询出服务时数
	 * @return
	 */
	public double findTime(int uid){
		
		Sql sql =Sqls.create("select  sum(services_number) as w  from t_personservices where uid="+uid+" and  queren=1");
		sql.setCallback(new SqlCallback() {
			
			public Object invoke(Connection arg0, ResultSet rs, Sql sql)
					throws SQLException {
				Object o=new Object();
				if(rs.next()){
					o= rs.getObject("w");
				}
				rs.close();
				return o;
			}
		});
		dao.execute(sql);
		Object o=sql.getResult();
		if(o != null){
			return Double.parseDouble(o.toString());
		}
		return 0;
	}
	/**
	 * 通过特定的sql查询出用户按服务时间大小倒叙排序的总条数
	 * @param str
	 * @return
	 */
	public int findSqlCount(String str,String table){
		Sql sql = Sqls.create("select count(*)  from "+table+" where id in ("+str+")");
		sql.setCallback(new SqlCallback() {
			
			public Object invoke(Connection arg0, ResultSet rs, Sql sql)
					throws SQLException {
				while(rs.next()){
					
					return rs.getInt(1);
				}
				return null;
			}
		});
		dao.execute(sql);
		return sql.getInt();
	}
	
	public NutDao getDao() {
		return dao;
	}
	
}

