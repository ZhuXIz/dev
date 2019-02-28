package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Advert;
import com.jdkj.wx.entity.Employee;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.EmployeeQuery;

public interface EmployeeMapper extends BaseMapper<Employee>{
	 /**
	  * 直接传入一个参数
     * 
     * @param id
     * @return 得到一个对象
     */
	   
	  //添加账号
	    @Insert("INSERT INTO j_employee(id,name,pwd,permiss_id) VALUES(NULL"
	    		+ ", #{name}, #{pwd}, #{permiss.id})")
	    @Options(useGeneratedKeys = true, keyProperty = "id")
	    void add(Employee employee);
	    /*删除该账号*/
	    @Delete("DELETE FROM j_employee WHERE id=#{id}")
	    void remove(Serializable id);
	    @Update("update j_employee set name= #{name}, pwd = #{pwd},permiss_id = #{permiss.id} where id = #{id}")
	    void update(Employee employee);
	    
	    /*查询所有账号*/
		 List<Employee> getAllQuery(BaseQuery<Employee> query);
		 @Select("SELECT count(*) FROM j_employee where name LIKE CONCAT('%',#{keyWords},'%')")
		 long getCountAll(BaseQuery<Employee> query);
		
		 /*查询该账号信息*/
		Employee getById(Serializable id);
		@Select("SELECT * FROM j_employee WHERE name=#{name} and pwd = #{pwd}")
		Employee check(Employee emp);
    
 
}
