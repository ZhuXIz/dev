package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Menu;
import com.jdkj.wx.entity.Permiss;
import com.jdkj.wx.query.BaseQuery;

public interface PermissMapper extends BaseMapper<Permiss>{
	  //添加菜单
    @Insert("INSERT INTO j_permiss(id,name) VALUES(NULL"
    		+ ", #{name})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void add(Permiss permiss);
    /*删除该账号*/
    @Delete("DELETE FROM j_permiss WHERE id=#{id}")
    void remove(Serializable id);
    @Update("update j_permiss set name= #{name} where id = #{id}")
    void update(Permiss permiss);
    
    @Select("SELECT * FROM j_permiss")
	 List<Permiss> getAll();
    
	 /*查询该权限*/
	Permiss getById(Serializable id);
	/*给改权限添加菜单*/
	@Insert("INSERT INTO j_permiss_menu(permiss_id,menu_id) VALUES(id"
    		+ ", #{menuId})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void addMenu(Permiss permiss);
	
	/*删除该权限某菜单*/
	@Delete("DELETE FROM j_permiss_menu WHERE permiss_id=#{id} and menu_id=#{menuId}")
    void removeMenu(Permiss permiss);
 
	
	 @Select("SELECT * FROM j_permiss limit #{begin},#{end}")
	 List<Permiss> getAllQuery(BaseQuery<Permiss> query);
	 @Select("SELECT count(*) FROM j_permiss")
	 long getCount(BaseQuery<Permiss> query);
	 
	 @Select("select m.id,m.name from j_permiss_menu pm " + 
				" left join j_menu m on m.id=pm.menu_id where permiss_id=#{id}")
	 List<Menu> getMenu(Integer id);
	@Select("SELECT count(*) FROM j_permiss")
	Integer getTotal(Permiss permiss);
	@Select("SELECT * FROM j_permiss limit #{offset},#{limit}")
	List<Permiss> getAllByPer(Permiss permiss);
	
	//删除该权限所有菜单
	@Delete("DELETE FROM j_permiss_menu WHERE permiss_id=#{id}")
	void removeAllMenu(Integer id);
	
	void addAllMenu(List<Object> list);
}
