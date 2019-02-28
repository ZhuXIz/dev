package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Advert;
import com.jdkj.wx.entity.Coupon;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.CouponQuery;

public interface CouponMapper extends BaseMapper<Coupon>{
	 /**
	  * 直接传入一个参数
     * 
     * @param id
     * @return 得到一个对象
     */
	   
	  //添加活动
	    @Insert("INSERT INTO j_coupon(id,startTime,endTime,price,num,state,goods_id,seller_id) VALUES(NULL"
	    		+ ", #{startTime}, #{endTime}, #{price}, #{num}, #{state}, #{goodsId},#{sellerId})")
	    @Options(useGeneratedKeys = true, keyProperty = "id")
	    void add(Coupon spellList);
	    /*删除该拼团活动*/
	    @Delete("DELETE FROM j_coupon WHERE id=#{id}")
	    void remove(Serializable id);
	    @Update("update j_coupon set startTime=#{startTime},endTime=#{endTime},price=#{price},"
	    		+ "num=#{num},state=#{state},goods_id=#{goodsId},seller_id=#{sellerId} where id = #{id}")
	    void update(Coupon coupon);
	    
	    /*查询所有活动*/
		 @Select("SELECT * FROM j_coupon order by state desc limit #{begin},#{end}")
		 List<Coupon> getAll(CouponQuery query);
		 @Select("SELECT count(*) FROM j_coupon")
		 int getCountAll();
		
		 /*查询该活动信息*/
		@Select("SELECT * FROM j_coupon WHERE id=#{id}")
		Coupon getById(Serializable id);
    
		
		@Select("SELECT * FROM j_coupon limit #{begin},#{end}")
		 List<Coupon> getAllQuery(BaseQuery<Coupon> query);
		 @Select("SELECT count(*) FROM j_coupon")
		 long getCount(BaseQuery<Coupon> query);
 
}
