package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Goods;
import com.jdkj.wx.entity.GoodsType;
import com.jdkj.wx.query.BaseQuery;

public interface GoodsTypeMapper extends BaseMapper<GoodsType> {

	 	@Select("SELECT * FROM j_goods_type WHERE id=#{id}")
	    GoodsType getById(Integer id);


	    @Delete("DELETE FROM j_goods_type WHERE id=#{id}")
	    void remove(Serializable id);
	    @Select("SELECT * FROM j_goods_type")
		List<GoodsType> getAll();

	    @Insert("INSERT INTO j_goods_type(id,genreName) VALUES(NULL,#{genreName})")
	    @Options(useGeneratedKeys = true, keyProperty = "id")
	    void add(GoodsType goodsType); 

	    @Update("update j_goods_type set genreName=#{genreName} where id = #{id}")
	    void update(GoodsType goodsType);
	    
	    
	    @Select("SELECT * FROM j_goods_type limit #{begin},#{end}")
		 List<GoodsType> getAllQuery(BaseQuery<GoodsType> query);
		 @Select("SELECT count(*) FROM j_goods_type")
		 long getCount(BaseQuery<GoodsType> query);


		 
		@Select("SELECT count(*) FROM j_goods_type")
		int getTotal(GoodsType goodsType);
		
		@Select("SELECT * FROM j_goods_type limit #{offset},#{limit}")
		List<GoodsType> getAllByType(GoodsType goodsType);
}
