package com.jdkj.wx.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Config;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.query.BaseQuery;

public interface UserMapper extends BaseMapper<User> {

	@Select("SELECT * FROM j_user WHERE id=#{id}")
    User getById(String id);


    @Delete("DELETE FROM j_user WHERE id=#{id}")
    void remove(String id);
    @Select("SELECT * FROM j_user")
    List<User> getAll();
    
    
    @Select("SELECT * FROM j_user limit #{begin},#{end}")
  	 List<User> getAllQuery(BaseQuery<User> query);
  	 @Select("SELECT count(*) FROM j_user")
  	 long getCount(BaseQuery<User> query);


    @Insert("INSERT INTO j_user(id,name,imageUrl,times,score,money,address,phoneNum,phoneName) "
    		+ "VALUES(#{id},#{name},#{imageUrl},0,#{score},#{money},#{address},#{phoneNum},#{phoneName})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void add(User user); 

    @Update("update j_user set money=money+#{name} where id = #{id}")
    void updateMoney(User user);
    
    @Update("update j_user set name=#{name},imageUrl=#{imageUrl} where id = #{id}")
    void update(User user);
    
    
    @Update("update j_user set name=#{name},phoneNum=#{phoneNum},imageUrl=#{imageUrl},phoneName=#{phoneName},score=#{score},address=#{address}"
    		+ " ,money=#{money} where id = #{id}")
    void updateUser(User user);
    

    @Update("update j_user set score=#{score},times=#{times} where id = #{id}")
    void updateScore(User user);
    
    
    @Select("select count(*) from j_user where id =#{id}")
	int selectUser(String id);

    @Update("update j_user set phoneNum=#{phoneNum},phoneName=#{phoneName} where id = #{id}")
	void updatePhone(User user);
    
    @Select("select phoneNum from j_user where id =#{id}")
   	String selectPhone(String id);

    @Select("SELECT id,score,times,checkTime FROM j_user WHERE id=#{id}")
	User getTimes(String id);
    
    @Select("SELECT score,times FROM j_user WHERE id=#{id}")
	User getScore(String id);
    @Update("update j_user set times=#{times},checkTime=now(),score=score+#{score} where id = #{id}")
	void updateTimes(User user);

    @Select("SELECT now()-saveTime>18000 FROM j_wx WHERE id=1")
	int checkWx();
    
    
    @Update("update j_wx set access_token=#{acess_token},jsapi_ticket=#{jsapiTicket},saveTime=now() WHERE id=1")
	void updateWxConfig(Map<String, String> map);

    @Select("SELECT jsapi_ticket FROM j_wx WHERE id=1")
	String getWxconfig();

    @Select("SELECT count(*) FROM j_user")
	long getCountAll(BaseQuery<User> query);
}
