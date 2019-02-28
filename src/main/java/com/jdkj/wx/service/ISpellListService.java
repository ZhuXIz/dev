package com.jdkj.wx.service;

import java.io.Serializable;
import java.util.List;

import com.jdkj.wx.entity.SpellList;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.entity.UserSpellList;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.SpellListQuery;

public interface ISpellListService extends IBaseService<SpellList>{

	
	/*查询该活动信息*/
   SpellList getById(Serializable id);

   /*查询该用户所有活动信息*/
   PageList<SpellList> getByUserIdAll(SpellListQuery query);
   
  
   //用户参加活动
  
   boolean addSpell(UserSpellList userSpellList);
   
   /*查询该商品活动信息*/
   SpellList getByGoodsId(Integer goodsId);
   /*查询对应商家的商品活动信息*/
   PageList<SpellList> getBySeller(SpellListQuery query);
   
   
   /*状态==1:进行中的活动
    * 状态==2：将要进行的活动
    * 状态==3：结束的活动
    * */
   /*修改状态 当为活动为将要进行状态并且当前时间大于活动开始时间*/
   boolean updateStateIng();
   
  

   
   
   
   /*查询该用户该活动信息*/
   SpellList getByUserId(UserSpellList userSpellList);

   boolean check(UserSpellList userSpellList);
   /*修改状态 改变过期的拼团state为3*/
   boolean updateState();

   boolean addSpell2(UserSpellList userSpell);

boolean updateState(SpellList list);



	boolean cue(String userId);

	PageList<SpellList> getAllBySpell(SpellList spellList);

	PageList<UserSpellList> getSpellItem(UserSpellList spell);

	List<User> getUserGroup(Integer id);


}
