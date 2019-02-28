package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Advert;
import com.jdkj.wx.entity.SMS;
import com.jdkj.wx.entity.Seller;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.SMSQuery;

public interface SMSMapper extends BaseMapper<SMS>{
	 /**
	  * 直接传入一个参数
     * 
     * @param id
     * @return 得到一个对象
     */
	   
	  //添加活动
	    @Insert("INSERT INTO j_sms(id,sendTime,seller_id,message) VALUES(NULL"
	    		+ ", now(),#{sellerId},#{message})")
	    @Options(useGeneratedKeys = true, keyProperty = "id")
	    void add(SMS sms);
	    /*删除该拼团活动*/
	    @Delete("DELETE FROM j_sms WHERE id=#{id}")
	    void remove(Serializable id);
	    @Update("update j_sms set startTime=#{startTime},endTime=#{endTime},price=#{price},"
	    		+ "num=#{num},state=#{state},goods_id=#{goodsId},seller_id=#{sellerId} where id = #{id}")
	    void update(SMS sms);
	    
	    /*查询所有活动*/
		 @Select("SELECT * FROM j_sms order by state desc limit #{begin},#{end}")
		 List<SMS> getAll(SMSQuery query);
		 @Select("SELECT count(*) FROM j_sms")
		 int getCountAll();
		
		 /*查询该活动信息*/
		@Select("SELECT * FROM j_sms WHERE id=#{id}")
		SMS getById(Serializable id);
    
		@Select("SELECT * FROM j_sms limit #{begin},#{end}")
		 List<SMS> getAllQuery(BaseQuery<SMS> query);
		 @Select("SELECT count(*) FROM j_sms")
		 long getCount(BaseQuery<SMS> query);
}
