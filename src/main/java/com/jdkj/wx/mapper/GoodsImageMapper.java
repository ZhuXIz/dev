package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Evaluate;
import com.jdkj.wx.entity.GoodsImage;
import com.jdkj.wx.query.BaseQuery;

public interface GoodsImageMapper extends BaseMapper<GoodsImage> {

		@Select("SELECT * FROM j_goods_image WHERE id=#{id}")
	    GoodsImage getById(Integer id);
		
		
	 	@Select("SELECT * FROM j_goods_image WHERE goods_id=#{id}")
	 	List<GoodsImage> getByGoodsId(Serializable id);
	 	
	    @Delete("DELETE FROM j_goods_image WHERE id=#{id}")
	    void remove(Serializable id);
	    @Select("SELECT * FROM j_goods_image")
	    List<GoodsImage> getAll();
	    
	    

	    @Insert("INSERT INTO j_goods_image(id,image,goods_id) VALUES(NULL,#{image},#{goods.id})")
	    @Options(useGeneratedKeys = true, keyProperty = "id")
	    void add(GoodsImage goodsImage); 

	    @Update("update j_goods_image set image =#{image},goods_id=#{goods.id} where id = #{id}")
	    void update(GoodsImage goodsImage);


		void addAll(List<GoodsImage> list);

		 @Delete("DELETE FROM j_goods_image WHERE goods_id=#{goodsId}")
		void removeByGoodsId(int goodsId);

		 
		 @Select("SELECT * FROM j_goods_image limit #{begin},#{end}")
		 List<GoodsImage> getAllQuery(BaseQuery<GoodsImage> query);
		 @Select("SELECT count(*) FROM j_goods_image")
		 long getCount(BaseQuery<GoodsImage> query);

}
