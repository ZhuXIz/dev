package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Menu;
import com.jdkj.wx.entity.MyCollection;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.MyCollQuery;

public interface MyCollectionMapper extends BaseMapper<MyCollection> {
	@Select("SELECT * FROM j_collection WHERE id=#{id}")
    MyCollection getById(Integer id);


    @Select("SELECT * FROM j_collection")
    List<MyCollection> getAll();
    
    

    @Update("update j_collection set collAddress=#{collAddress},goods_id=#{goods.id},user_id=#{user.id} where id = #{id}")
    void update(MyCollection myCollection);

    
	List<MyCollection> getMyColl(MyCollQuery query);

    

    @Select("SELECT count(*) from j_collection where user_id =#{userId}")
	long getCount(String userId);

    @Insert("INSERT INTO j_collection(id,collAddress,goods_id,user_id,isColl) "
    		+ "VALUES(NULL,#{collAddress},#{goods.id},#{user.id},true)")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void add(MyCollection myCollection); 
    
    @Select("SELECT isColl from j_collection where user_id =#{user.id} and goods_id =#{goods.id}")
    boolean getByGoodsId(MyCollection coll);
    
    @Update("update j_collection set isColl=false WHERE goods_id=#{goodsId} and user_id=#{user.id}")
	void updateIsCollFalse(MyCollection coll);
    
    @Update("update j_collection set isColl=true WHERE user_id=#{user.id} and goods_id=#{goods.id}")
	void updateIsCollTrue(MyCollection coll);
    
    @Select("SELECT count(*) from j_collection where user_id =#{user.id} and goods_id =#{goods.id}")
	int checkHas(MyCollection coll);

    @Delete("delete from j_collection WHERE user_id=#{user.id} and goods_id=#{goods.id}")
	void remove(MyCollection coll);

    @Update("update j_collection set isColl=isColl^1 WHERE id=#{id}")
	void updateIsCollFalseById(MyCollection coll);


}
