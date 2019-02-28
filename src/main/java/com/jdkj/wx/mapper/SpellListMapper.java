package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Advert;
import com.jdkj.wx.entity.SpellList;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.entity.UserSpellList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.SpellListQuery;

public interface SpellListMapper extends BaseMapper<SpellList>{
	 /**
	  * 直接传入一个参数
     * 
     * @param id
     * @return 得到一个对象
     */
	
	  /*查询拼团活动规定时间内未完成的用户*/
    	List<UserSpellList> getUserBySpellFail();
	  //更新字段----------只提醒一次
      @Update("update j_user_list set cue=0 where id=#{id} and list_id=#{listId} and user_id=#{userId}")
	  void updateCue(UserSpellList list);
	  
    /*查询该用户所有活动信息*/
    List<SpellList> getByUserIdAll(SpellListQuery query);
    @Select("SELECT count(*) FROM j_list l left join j_user_list u on l.id =u.list_id WHERE u.user_id=#{userId} "
    		+ "order by state asc limit #{begin},#{end}")
	long getCountByUserId(SpellListQuery query);
    
   
	 List<SpellList> getAllQuery(BaseQuery<SpellList> query);
	 @Select("SELECT count(*) FROM j_list")
	 long getCount(BaseQuery<SpellList> query);
   
    
    
    /*查询该商品活动信息*/
    @Select("SELECT * FROM j_list WHERE goods_id=#{goodsId}")
    SpellList getByGoodsId(Integer goodsId);
    /*查询对应商家的商品活动信息*/
    @Select("SELECT *  FROM j_list WHERE seller_id=#{sellerId}"
    		+ "order by state asc limit #{begin},#{end}")
    List<SpellList> getBySeller(SpellListQuery query);
    @Select("SELECT count(*)  FROM j_list WHERE lseller_id=#{sellerId}")
    long getBySellerCount(SpellListQuery query);
    
    /*状态==1:进行中的活动
     * 状态==2：将要进行的活动
     * 状态==3：结束的活动
     * */
    /*修改状态 当为活动为将要进行状态并且当前时间大于活动开始时间*/
    @Update("update j_list set state =1 where now()>=startTime and now()<endTime")
    void updateStateIng();
    /*修改状态 修改为将要进行状态*/
    @Update("update j_list set state =2 where startTime>now()")
    void updateStatePre();
    
    /*修改状态 改变过期的拼团state为3*/
    @Update("update j_list set state =3 where now()>=endTime")
    void updateStateOver();
    
    /*修改状态 */
    @Update("update j_list set state =#{state} where id=#{id}")
    void updateState(SpellList list);
    
  //查询是否满员
    @Select("select (SELECT count(*) FROM j_user_list where id =#{id})>=num from j_list where id=#{listId}")
    int chekNeedMan(UserSpellList userSpellList);
    //用户参加活动
    @Insert("INSERT INTO j_user_list(id,user_id,list_id,cue) "
    		+ "VALUES(#{id}, #{userId}, #{listId},1)")
    void addUser(UserSpellList userSpellList);
    //新用户发起活动，在最大的id上加1(代码中查出再添加)
    @Select("SELECT max(id) FROM j_user_list")
    int getId();
    //查询用户是否已经加入过该商品的拼团活动，无则添加，有则不进行添加操作，前端反馈不能再操作（只能分享操作）
    @Select("SELECT count(*) FROM j_user_list where list_id=#{listId} and user_id =#{userId}")
    long getIdCount(UserSpellList userSpellList);
    //通过goodsId间接查询是否参加了该活动
    @Select("SELECT count(*) FROM j_user_list where list_id=(select id from j_list where goods_id=#{goodsId}) and user_id =#{userId}")
    long getGoodsIdCount(UserSpellList userSpellList);
    
    //查询用户发起的拼团活动有多少人参与
    @Select("SELECT count(*) from j_user_list where id= (select id from j_user_list WHERE user_id=#{userId} and list_id=#{listId})")
    long getUserCount(UserSpellList userId);
    /*查询该用户该活动信息*/
    SpellList getByUserId(UserSpellList list);
    
    
    
  //添加活动
    @Insert("INSERT INTO j_list(id,startTime,endTime,price,num,state,goods_id,seller_id) VALUES(NULL"
    		+ ", #{startTime}, #{endTime}, #{price}, #{num}, #{state}, #{goods.id},#{seller.id})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void add(SpellList spellList);
    /*删除该拼团活动*/
    @Delete("DELETE FROM j_list WHERE id=#{id}")
    void remove(Serializable id);
    @Update("update j_list set startTime=#{startTime},endTime=#{endTime},price=#{price},"
    		+ "num=#{num},state=#{state},goods_id=#{goods.id},seller_id=#{seller.id} where id = #{id}")
    void update(SpellList spellList);
    
    /*查询所有活动*/
	 @Select("SELECT * FROM j_list order by state asc limit #{begin},#{end}")
	 List<Advert> getAll(SpellListQuery query);
	 @Select("SELECT count(*) FROM j_list")
	 int getCountAll();
	
	 /*查询该活动信息*/
	SpellList getById(Serializable id);
	
	Integer getTotal(SpellList spellList);
	List<SpellList> getAllBySpell(SpellList spellList);
	
	
	@Select("SELECT *,count(*) count FROM j_user_list  where list_id =#{id} GROUP BY id order by id LIMIT #{offset},#{limit}")
	List<UserSpellList> getSpellItem(UserSpellList id);
	@Select("SELECT count(*) from (SELECT * FROM j_user_list where list_id =#{id} group by id) z")
	Integer getTotalItem(UserSpellList id);
	
	
	@Select("SELECT name from j_user where id in(SELECT user_id from j_user_list ul  where id=#{id})")
	List<User> getUserGroup(Integer id);
	
	
}
