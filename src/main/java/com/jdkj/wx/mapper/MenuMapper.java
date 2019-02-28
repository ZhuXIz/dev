package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Advert;
import com.jdkj.wx.entity.GoodsType;
import com.jdkj.wx.entity.Menu;
import com.jdkj.wx.entity.Menu_Permiss;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.MenuQuery;

public interface MenuMapper extends BaseMapper<Menu>{
	   
	  //添加菜单
	    @Insert("INSERT INTO j_menu(id,url,name,icon,p_id) VALUES(NULL"
	    		+ ", #{url}, #{name}, #{icon},#{pid})")
	    @Options(useGeneratedKeys = true, keyProperty = "id")
	    void add(Menu menu);
	    /*删除该账号*/
	    @Delete("DELETE FROM j_menu WHERE id=#{id}")
	    void remove(Serializable id);
	    @Update("update j_menu set url= #{url}, name = #{name},icon = #{icon} where id = #{id}")
	    void update(Menu menu);
	    
	    /*查询所有账号*/
		 @Select("SELECT * FROM j_menu limit #{begin},#{end}")
		 List<Advert> getAll(MenuQuery query);
		 @Select("SELECT count(*) FROM j_menu")
		 int getCountAll();
		
		 /*查询该账号信息*/
		@Select("SELECT * FROM j_menu WHERE id=#{id}")
		Menu getById(Serializable id);
		
		//带权限查所有菜单
		List<Menu> show();
		@Select("select * from j_menu where id in "
				+ "(select menu_id from j_permiss_menu where permiss_id=#{permissId}) and p_id=#{pId}")
		List<Menu> getMenuItem(@Param("pId")Serializable pId,@Param("permissId")Serializable permissId);
		
		
		List<Menu> getMenuByRole(Integer id);
		
		
		@Select("select * from j_menu where id in "
				+ "(select menu_id from j_permiss_menu where permiss_id="
				+ "(select permiss_id from j_employee where id=#{id}))")
		List<Menu> getMenu(@Param("id")Serializable id);
 
		
		 @Select("SELECT * FROM j_menu limit #{begin},#{end}")
		 List<Menu> getAllQuery(BaseQuery<Menu> query);
		 @Select("SELECT count(*) FROM j_menu")
		 long getCount(BaseQuery<Menu> query);
		 
		@Select("SELECT count(*) FROM j_menu where p_id = '' or p_id=0 or ISNULL(p_id)")
		Integer getTotal(Menu menu);
		@Select("SELECT * FROM j_menu where p_id = '' or p_id=0 or ISNULL(p_id) limit #{offset},#{limit}")
		List<Menu> getAllParentByMenu(Menu menu);
		
		@Select("SELECT count(*)  FROM j_menu where p_id= #{pid} and (p_id != '' or p_id !=0 or !ISNULL(p_id))")
		Integer getItemTotal(Menu menu);
		@Select("SELECT * FROM j_menu where p_id= #{pid} and (p_id != '' or p_id !=0 or !ISNULL(p_id)) limit #{offset},#{limit}")
		List<Menu> getAllItem(Menu menu);
		
		 @Update("update j_menu set url= '' where id = #{id}")
		void updateParentUrl(Integer id);
		 
		//不带权限查所有菜单
		 List<Menu> getAllMenu();
		@Select("select * from j_menu where p_id=#{pId}")
		List<Menu> getAllMenuItem(@Param("pId")Serializable pId);
		
		@Select("select count(*) from j_menu where p_id=#{id}")
		int checkItem(Integer id);
		
}
