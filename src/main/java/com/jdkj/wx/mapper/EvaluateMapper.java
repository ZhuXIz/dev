package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Employee;
import com.jdkj.wx.entity.Evaluate;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.EvaluateQuery;

public interface EvaluateMapper extends BaseMapper<Evaluate> {
	
    @Select("SELECT * FROM j_evaluate WHERE id=#{id}")
    Evaluate getById(Integer id);


    @Delete("DELETE FROM j_evaluate WHERE id=#{id}")
    void remove(Serializable id);
    @Select("SELECT * FROM j_evaluate")
    List<Evaluate> getAll();

    @Insert("INSERT INTO j_evaluate(id,user_id,message,eTime,goods_id) VALUES(NULL,#{userId},#{message},now(),#{goodsId})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void add(Evaluate evaluate); 

    @Update("update j_evaluate set user_id =#{user.id},message =#{message},eTime =#{eTime} where id = #{id}")
    void update(Evaluate evaluate);

    @Select("SELECT * FROM j_evaluate WHERE goods_id=#{goodsId}")
	List<Evaluate> getByGoodsId(int goodsId);
    
    
	List<Evaluate> getEvaluate(EvaluateQuery query);

    @Select("SELECT count(*) FROM j_evaluate WHERE goods_id=#{goodsId}")
	int getEvaluateCount(int goodsId);

   
    @Select("SELECT count(*) FROM j_evaluate WHERE goods_id=#{goodsId} and user_id=#{userId}")
	int check(Evaluate eva);
    
    @Select("SELECT * FROM j_evaluate limit #{begin},#{end}")
	 List<Evaluate> getAllQuery(BaseQuery<Evaluate> query);
	 @Select("SELECT count(*) FROM j_evaluate")
	 long getCount(BaseQuery<Evaluate> query);

}
