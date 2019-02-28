package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.entity.SpellList;
import com.jdkj.wx.entity.User;
import com.jdkj.wx.entity.UserSpellList;
import com.jdkj.wx.mapper.SpellListMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.SpellListQuery;
import com.jdkj.wx.service.ISpellListService;

@Service
public class SpellListServiceImpl extends BaseServiceImpl<SpellList> implements ISpellListService {

	@Autowired
	protected SpellListMapper spellListMapper;
	
	
	/*删除*/
	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			spellListMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}
	
	@Override
	public SpellList getById(Serializable id) {
		return spellListMapper.getById(id);
	 }
	/*修改*/
	@Override
	@Transactional
	public void update(SpellList spell) {
		try {
			spellListMapper.update(spell);
		}catch (Exception e) {
		}
	}
	/*添加*/
	@Override
	@Transactional
	public void add(SpellList spell) {
		try {
			spellListMapper.add(spell);
			spellListMapper.updateStateIng();
		}catch (Exception e) {
		}
	}
	
	/*查询所有拼团活动*/
	@Override
	public PageList<SpellList> getAll(SpellListQuery query) {
		long count = spellListMapper.getCountAll();
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<SpellList> pageList = new PageList<SpellList>(total,spellListMapper.getAllQuery(query));
        return pageList;
	}
	
	
	
/************************************************/
	/*查询该用户所有拼团活动*/
	@Override
	public PageList<SpellList> getByUserIdAll(SpellListQuery query) {
		long count = spellListMapper.getCountByUserId(query);
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<SpellList> pageList = new PageList<SpellList>(total,spellListMapper.getByUserIdAll(query));
        return pageList;
	}

	
	/*查询该商品拼团活动*/
	@Override
	public SpellList getByGoodsId(Integer goodsId) {
		return spellListMapper.getByGoodsId(goodsId);
	}
	
	/*查询该商家所有拼团活动*/
	@Override
	public PageList<SpellList> getBySeller(SpellListQuery query) {
		long count = spellListMapper.getBySellerCount(query);
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<SpellList> pageList = new PageList<SpellList>(total,spellListMapper.getByUserIdAll(query));
        return pageList;
	}

	   /*状态==1:进行中的活动
		     * 状态==2：将要进行的活动
		     * 状态==3：结束的活动
     * */
    /*修改状态 当为state1修改为state2*/
	@Override
	@Transactional
	public boolean updateStateIng() {

		try {
			spellListMapper.updateStateIng();
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	//用户参加活动
	@Override
	@Transactional
	public boolean addSpell(UserSpellList userSpellList) {

		try {
			//查询用户是否已经加入过该商品的拼团活动，无则添加，有则不进行添加操作，前端反馈不能再操作（只能分享操作）
			if(spellListMapper.getIdCount(userSpellList)<=0) {
				//新用户发起活动，在最大的id上加1(代码中查出再添加)
				userSpellList.setId(spellListMapper.getId()+1);
				spellListMapper.addUser(userSpellList);
				return true;
			}
		} catch (Exception e) {
			return false;
		}
		return false;
	}

	//加入朋友拼团
	@Override
	public boolean addSpell2(UserSpellList userSpell) {
		try {
			
			//查询用户是否已经加入过该商品的拼团活动，无则添加，有则不进行添加操作，前端反馈不能再操作（只能分享操作）
			if(spellListMapper.getIdCount(userSpell)<=0) {
				spellListMapper.addUser(userSpell);
				return true;
			}
		} catch (Exception e) {
			return false;
		}
		return false;
	}
	

	@Override
	public SpellList getByUserId(UserSpellList userSpellList) {
		SpellList spellList=null;
		try {
			int state = spellListMapper.chekNeedMan(userSpellList);
			System.out.println(state);
			boolean bool;
			if(state>=1)
				bool=false;
			else 
				bool=true;
			spellList= spellListMapper.getByUserId(userSpellList);
			//查询用户发起的拼团活动有多少人参与
			spellList.setCount(spellListMapper.getUserCount(userSpellList));
			// TODO Auto-generated method stub
			spellList.setIsJoin(bool);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return spellList;
	}

	@Override
	public boolean check(UserSpellList userSpellList) {
		try {
			//查询用户是否已经加入过该商品的拼团活动，无则添加，有则不进行添加操作，前端反馈不能再操作（只能分享操作）
			if(spellListMapper.getIdCount(userSpellList)<=0)
				return false;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	@Override
	@Transactional	
	public boolean updateState() {
		try {
			spellListMapper.updateStateIng();
			spellListMapper.updateStateOver();
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public boolean updateState(SpellList list) {
		try {
			spellListMapper.updateState(list);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	@Transactional
	public boolean cue(String userId) {
		try {
			List<UserSpellList> userSpell= spellListMapper.getUserBySpellFail();
			if(userSpell.size()>0&&userSpell!=null) {
				for (UserSpellList userSpellList : userSpell) {
					if(userId.equals(userSpellList.getUserId())) {
						spellListMapper.updateCue(userSpellList);
						return true;
					}
				}
			}
		}catch (Exception e) {
			return false;
		}
		return false;
	}

	@Override
	public PageList<SpellList> getAllBySpell(SpellList spellList) {
		PageList<SpellList> pageList = new PageList<SpellList>();
		// 统计总记录数
		Integer count = spellListMapper.getTotal(spellList);
		pageList.setCount(count);
		pageList.setRows(spellListMapper.getAllBySpell(spellList));
        return pageList;
	}

	@Override
	public PageList<UserSpellList> getSpellItem(UserSpellList id) {
		PageList<UserSpellList> pageList = new PageList<UserSpellList>();
		// 统计总记录数
		Integer count = spellListMapper.getTotalItem(id);
		pageList.setCount(count);
		pageList.setRows(spellListMapper.getSpellItem(id));
        return pageList;
	}

	@Override
	public List<User> getUserGroup(Integer id) {
		return spellListMapper.getUserGroup(id);
	}
}
