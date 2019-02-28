package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Advert;
import com.jdkj.wx.entity.Contact;
import com.jdkj.wx.entity.Employee;
import com.jdkj.wx.query.BaseQuery;

public interface AdvertMapper extends BaseMapper<Advert>{
	 /**
     * 直接传入一个参数
     * 
     * @param id
     * @return 得到一个对象
     */
    @Select("SELECT * FROM j_advert WHERE id=#{id}")
    Advert getById(Serializable id);


    @Delete("DELETE FROM j_advert WHERE id=#{id}")
    void remove(Serializable id);
    @Select("SELECT * FROM j_advert order by id desc")
    List<Advert> getAll();

    @Insert("INSERT INTO j_advert(id,img) VALUES(NULL, #{img})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void add(Advert advert);
    
    @Update("update j_advert set img =#{img} where id = #{id}")
    void update(Advert advert);

    @Select("SELECT * FROM j_advert limit #{begin},#{end}")
	 List<Advert> getAllQuery(BaseQuery<Advert> query);
	 @Select("SELECT count(*) FROM j_advert")
	 long getCount(BaseQuery<Advert> query);


	Integer getTotal(Advert advert);


	List<Advert> getAllByAdvert(Advert advert);

}
