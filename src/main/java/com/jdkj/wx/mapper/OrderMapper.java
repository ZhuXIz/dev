package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.MyCollection;
import com.jdkj.wx.entity.Order;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.OrderQuery;
/*订单状态
 * 0==全部完成
 * 1==进行中
 * 2==完成未评论
 * 3==被取消的（涉及金额自动退款）
 * 4==拼团任务（未完成/提示申请退款）
 * 5==下单未支付
 * --*/
public interface OrderMapper extends BaseMapper<Order> {

	
    Order getById(Integer id);


    @Delete("DELETE FROM j_order WHERE id=#{id}")
    void remove(Serializable id);
    @Select("SELECT * FROM j_order")
    List<Order> getAll();


    @Insert("INSERT INTO j_order(id,seller_id,goods_id,user_id,oTime,isValid,name,phoneNum,price,payPrice,type) "
    		+ "VALUES(NULL,#{sellerId},#{goodsId},#{userId},now(),1,#{name},#{phoneNum},#{price},#{payPrice},#{type})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void add(Order order); 

    @Update("update j_order set seller_id =#{seller.id},oTime=#{oTime},"
    		+ "isValid=#{isValid},goods_id=#{goods.id},user_id=#{user.id},"
    		+ "name = #{name},phoneNum = #{phoneNum},price = #{price}"
    		+ ",payPrice = #{payPrice},type = #{type} where id = #{id}")
    void update(Order order);

	List<Order> getOrder(BaseQuery query);

	/*订单到活动结束，自动完成订单，并查询*/
	 @Select("select o.id from j_order o " + 
	 		"LEFT JOIN j_goods g on o.goods_id=g.id where o.user_id =#{userId} and o.isValid =1 and now()>g.sufTime")
	 List<Integer> getOrderId(String userId);
	 
	
 
	 /*取消订单，修改状态为3*/
    @Update("update j_order set isValid=3 where id = #{orderId}")
	void cancelOrder(int orderId);

	List<Order> getSellerOrder(BaseQuery query);

	 @Select("select count(*) from j_order where user_id = #{userId}")
	 long getCountByUserId(String string);
	 @Select("select count(*) from j_order where seller_id = #{sellerId}")
	 long getCountBySellerId(String sellerId);

	 /*过期订单，修改状态为完成状态2（完成，未评论状态）*/
	void updateOrder(@Param("list")List<Integer> list);
    
	@Update("update j_order set isValid=2 where id = #{orderId}")
	void updateOrderOk(Integer orderId);
	@Update("update j_order set isValid=0 where id = #{orderId}")
	void updateOrderAllOk(Integer orderId);
	
	//根据userId和goodsId修改状态--针对isValid=5-------已经下单未支付修改订单状态为5
	@Update("update j_order set isValid=#{isValid} where user_id=#{userId} and goods_id = ${goodsId}")
	void updateOrderSpell(@Param("order")Order order);
	//根据userId和goodsId修改状态--针对isValid=4--------当拼团过期未完成改订单状态为4----全局修改
	@Update("update j_order set isValid=4 where (user_id,goods_id)=(" + 
			"SELECT nt.user_id,l.goods_id from (select *,count(*) cou from j_user_list group BY(id))nt " + 
			"LEFT JOIN j_list l on nt.list_id=l.id where l.num>nt.cou and l.state=3)and isValid=1")
	void updateOrderIsValid();
	
	@Update("update j_order set isValid=7 where id in (select o.id  from (select * from j_order) o " + 
			"left join j_goods g on g.id =o.goods_id where o.isValid=5 and now()>g.sufTime)")
	void updateOrderIsValid7();
	
    @Update("update j_order set isValid=#{isValid} where user_id=#{user.id} and id = ${orderId}")
	void updateUserOrder(@Param("order")Order order);
    
    @Update("update j_order set isValid=#{isValid} where seller_id=#{seller.id} and id = ${orderId}")
	void updateSellerOrder(@Param("order")Order order);

    @Update("update j_order set isValid=#{payType} where id = #{id}")
	void updatePayType(Order order);

    @Select("select count(*) from j_order where user_id = #{user.id} and goods_id = #{goods.id}")
	int getOne(Order order);
    
    
    @Select("SELECT * FROM j_order limit #{begin},#{end}")
	 List<Order> getAllQuery(BaseQuery<Order> query);
	 @Select("SELECT count(*) FROM j_order")
	 long getCount(BaseQuery<Order> query);

	 @Select("SELECT u.name,u.imageUrl FROM j_order o left join j_user u on u.id=o.user_id where o.goods_id=#{goodsId}")
	List<User> getUserByThisGoods(Serializable goodsId);

	 //根据id修改
	@Update("update j_order set isValid=#{isValid} where id=#{id} ")
	void updateIsValid(Order order);
	
	@Select("select o.id from j_order o left join j_goods g on o.goods_id=g.id where g.sufTime<=now() and o.isValid=5 and o.user_id=#{userId}")
	List<Integer> selectTimeOutByUser(String userId);
	@Select("select o.id from j_order o left join j_goods g on o.goods_id=g.id where g.sufTime<=now() and o.isValid=5")
	List<Integer> selectTimeOut();
	
	Integer getTotal(Order order);


	List<Order> getAllByOrder(Order order);


	
}
