package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Goods;
import com.jdkj.wx.entity.GoodsItem;
import com.jdkj.wx.entity.GoodsType;
import com.jdkj.wx.entity.MyCollection;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.GoodsQuery;

public interface GoodsMapper {

//		@Select("SELECT * FROM j_goods WHERE id=#{id}")
//	    Goods getById(Serializable id);
	
	

    	Goods getById(@Param("id")Serializable id);
    	
    	@Select("SELECT id,titleName,price from j_goods where id =#{id}")
    	Goods getOrderById(@Param("id")Integer id);
	
	    @Delete("DELETE FROM j_goods WHERE id=#{id}")
	    void remove(Serializable id) ;
	    @Select("SELECT g.id,g.seller_id,g.payType," + 
	    		"g.titleName,g.publish,g.preTime,g.sufTime,g.oldPrice,g.price," + 
	    		"g.soldNum,g.resNum,g.browNum,g.preTime,g.sufTime," + 
	    		"g.isRecommend,g.isValid,t.genreName,i.image,s.*" + 
	    		"from j_goods g JOIN j_goodsImage i on " + 
	    		"g.id=i.goods_id left JOIN j_goodsType t on g.type_id=t.id" + 
	    		"Left JOIN j_seller s on g.seller_id=s.id")
	    List<Goods> getAll();

	    /**改变商品状态*/
	    @Update("update  j_goods set isValid=#{isValid} where id=#{id}")
	    void updateState(Goods goods);
	    
	    /**查询更多商品，分页，下拉加载*/
	    @Select("SELECT id,titleName,titleImage,price,preTime,sufTime,isValid FROM j_goods ORDER BY isValid desc,isRecommend desc,publish desc limit ${begin},${end}")
	    List<Goods> getMore(BaseQuery<Goods> query);
	    
	    /**查询更多商品，分类展示*/
	    //@Select("SELECT id,titleName,titleImage,price,preTime,sufTime,isValid FROM j_goods where type_id=#{intParam} ORDER BY isValid desc,isRecommend desc,publish desc limit ${begin},${end}")
	    List<Goods> getMoreByType(GoodsQuery query);
	    
		/**未过期的、有推荐权限的商品优先排序--其次按发布时间先后排序*/
	    @Select("select id,titleName,titleImage,price,oldPrice,isValid,soldNum from j_goods ORDER BY isValid desc,isRecommend desc,publish desc limit 6")
	    List<Goods> getFirst();
	    
	    
	    @Insert("INSERT INTO j_goods"
	    		+ "(id,isValid,seller_id,titleImage,payType,type_id,titleName,publish,oldPrice,price,soldNum,resNum,browNum,preTime,sufTime,isRecommend,itemSrc)"
	    		+ " VALUES(NULL, 1,#{seller.id},#{titleImage}, #{payType}, #{goodsType.id}, #{titleName},now(), #{oldPrice}, #{price},"
	    		+ "0, #{resNum}, 0,#{preTime}, #{sufTime}, #{isRecommend},#{itemSrc})")
	    @Options(useGeneratedKeys = true, keyProperty = "id")
	    void add(Goods goods);
	    
	    @Update("update j_goods set seller_id=#{seller.id},isValid =#{isValid},titleImage=#{titleImage},payType = #{payType},type_id = #{goodsType.id}"
	    		+ ",titleName =#{titleName},publish=now(),oldPrice =#{oldPrice},price = #{price}"
	    		+ ",soldNum=#{soldNum},resNum =#{resNum},browNum =#{browNum},preTime =#{preTime},sufTime =#{sufTime},isRecommend =#{isRecommend} where id = #{id}")
	    void update(Goods goods);
	    
	    
	    
	    @Update("update j_goods set seller_id=#{seller.id},isValid =#{isValid},titleImage=#{titleImage},payType = #{payType},type_id = #{goodsType.id}"
	    		+ ",titleName =#{titleName},publish=now(),oldPrice =#{oldPrice},price = #{price}"
	    		+ ",resNum =#{resNum},browNum =#{browNum},preTime =#{preTime},sufTime =#{sufTime},isRecommend =#{isRecommend} where id = #{id}")
	    void updateGoods(Goods goods);
	    
	    @Select("SELECT * from j_goodsType")
		List<GoodsType> getGoodsType();
	    
		long getCountByType(GoodsQuery query);

		@Update("update j_goods set browNum=browNum+1 where id=#{goodsId}")
		void updateBrowNum(int goodsId);

		/*查询该商家总的促销活动数目*/
		@Select("SELECT count(*) from j_goods where seller_id = #{sellerId}")
		long getSellerCount(@Param("sellerId")String sellerId);

		/*查询该商家总的促销活动*/
		
		List<Goods> getSellerGoods(GoodsQuery query);
		/*删除促销活动*/
		@Delete("delete from j_goods where id=#{goodsId}")
		void removeSellerGoods(int goodsId);
		@Delete("delete from j_goods where seller_id = #{sellerId}")
		void removeBySellerId(Serializable id);

		@Update("update j_goods set payType=#{payType} where id=#{id}")
		void updatePayType(Goods goods);

		@Update("update j_goods set isValid=0 where id=#{id} and soldNum>=resNum and resNum!='' and resNum !=0")
		void updateValidByNum(@Param("id")Integer id);
		@Update("update j_goods set soldNum=soldNum+1 where id=#{id} and (soldNum<resNum or resNum =0)")
		void addSoldNum(@Param("id")Integer id);
		@Update("update j_goods set soldNum=soldNum-1 where id=#{id} and soldNum>0 and (soldNum<=resNum or resNum =0)")
		void removeSoldNum(@Param("id")Integer id);

		@Select("SELECT resNum-soldNum from j_goods where id = #{id} and resNum!='' and resNum !=0")
		int getNum(Integer id);
		@Select("SELECT count(*) from j_goods where seller_id = #{id} and now()-publish<9000")
		int getBySellerId(String id);
		
		
		 List<Goods> getAllQuery(BaseQuery<Goods> query);
		 @Select("SELECT count(*) FROM j_goods")
		 long getCount(BaseQuery<Goods> query);

		@Update("update j_goods set isValid=0 where now()>=sufTime and(isValid=1 or isValid=2)")
		void updateGoodsState();
		
		@Select("SELECT * from j_goods where seller_id = #{sellerId} order by isValid desc,publish desc")
		List<Goods> getGoodsBySellerId(Integer sellerId);

		
		
		
		Integer getTotal(Goods goods);
		List<Goods> getAllGoodsBySeller(Goods goods);

		
		Integer getAllGoodsTotal(Goods goods);
		List<Goods> getAllGoods(Goods goods);

		@Select("SELECT preTime,sufTime from j_goods where id=#{goodsId}")
		Goods getGoodsTime(Integer goodsId);
}
