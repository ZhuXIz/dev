package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.GoodsImage;
import com.jdkj.wx.entity.GoodsItem;
import com.jdkj.wx.query.BaseQuery;

public interface GoodsItemMapper extends BaseMapper<GoodsItem> {

	

	 @Select("SELECT * FROM j_goods_item WHERE id=#{id}")
	    GoodsItem getById(Integer id);
	 
	 
	 	@Select("SELECT * FROM j_goods_item WHERE goods_id=#{goodsId}")
	    GoodsItem getByGoodsId(Serializable goodsId);

	    @Delete("DELETE FROM j_goods_item WHERE id=#{id}")
	    void remove(Serializable id);
	    @Select("SELECT * FROM j_goods_item")
	    List<GoodsItem> getAll();
	    
	    

	    @Insert("INSERT INTO j_goods_item(id,goods_id,htmlSrc) VALUES(NULL,#{goods.id},#{htmlSrc})")
	    @Options(useGeneratedKeys = true, keyProperty = "id")
	    void add(GoodsItem goodsItem); 

	    @Update("update j_goods_item set image=#{image},goods_id=#{goods.id},text=#{text},htmlSrc=#{htmlSrc} where id = #{id}")
	    void update(GoodsItem goodsItem);

	    @Delete("DELETE FROM j_goods_item WHERE goods_id=#{goodsId}")
		void removeByGoodsId(int goodsId);
	    
	    @Select("SELECT * FROM j_goods_item limit #{begin},#{end}")
		 List<GoodsItem> getAllQuery(BaseQuery<GoodsItem> query);
		 @Select("SELECT count(*) FROM j_goods_item")
		 long getCount(BaseQuery<GoodsItem> query);
}
