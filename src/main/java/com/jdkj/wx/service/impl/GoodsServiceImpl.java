package com.jdkj.wx.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jdkj.wx.common.ResponseResult;
import com.jdkj.wx.entity.Goods;
import com.jdkj.wx.entity.GoodsImage;
import com.jdkj.wx.entity.GoodsType;
import com.jdkj.wx.entity.Seller;
import com.jdkj.wx.mapper.GoodsImageMapper;
import com.jdkj.wx.mapper.GoodsItemMapper;
import com.jdkj.wx.mapper.GoodsMapper;
import com.jdkj.wx.mapper.SellerMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.GoodsQuery;
import com.jdkj.wx.service.IGoodsService;
@Service
public class GoodsServiceImpl extends BaseServiceImpl<Goods> implements IGoodsService {
	

	@Autowired
	protected GoodsMapper goodsMapper;
	@Autowired
	protected SellerMapper sellerMapper;
	@Autowired
	protected GoodsItemMapper goodItemMapper;
	@Autowired
	protected GoodsImageMapper goodsImageMapper;
	@Override
	@Transactional
	public void add(Goods goods) {
		try {
			goodsMapper.add(goods);
		}catch (Exception e) {
			// TODO: handle exception
		}
		
	}

	@Override
	@Transactional
	public void update(Goods goods) {
		goodsMapper.update(goods);
	}
	
	//不带已售数量
	@Override
	@Transactional
	public void updateGoods(Goods goods) {
		goodsMapper.updateGoods(goods);
	}
	@Override
	@Transactional
	public boolean remove(Serializable id) {
		try {
			goodsMapper.remove(id);
		}catch (Exception e) {
			return false;
		}
		return true;
	}
	@Override
	public Goods getById(Serializable id) {
		Goods goods = goodsMapper.getById(id);
		return goods;
	}

	@Override
	public List<Goods> getAll() {
		return goodsMapper.getAll();
	}

	/*查询更多商品,分页查询*/
	@Override
	public List<Goods> getMore(BaseQuery<Goods> query) {
        return goodsMapper.getMore(query);
	}
	
	/*查询更多商品,分页并分类查询*/
	@Override
	public PageList<Goods> getMoreByType(GoodsQuery query) {
		long count = goodsMapper.getCountByType(query);
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<Goods> pageList = new PageList<Goods>(total,goodsMapper.getMoreByType(query));
        return pageList;
	}
	@Override
	public PageList<Goods> getAll(BaseQuery<Goods> query) {
		long count = goodsMapper.getCount(query);
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<Goods> pageList = new PageList<Goods>(total,goodsMapper.getAllQuery(query),query.getPage());
        return pageList;
	}
	
	/*首页展示*/

	public List<Goods> getFirst() {
		
        return goodsMapper.getFirst();
	}
	
	/**更新商品状态*/
	@Transactional
	public boolean updateState(Goods goods) {
		try {
			goodsMapper.updateState(goods);
		}catch (Exception e) {
			return false;
		}
		return true;
		
	}
	/*获取分类*/
	@Override
	public List<GoodsType> getGoodsType() {
		return goodsMapper.getGoodsType();
	}

	@Override
	@Transactional
	public void updateBrowNum(int goodsId) {
		// TODO Auto-generated method stub
		try {
			goodsMapper.updateBrowNum(goodsId);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	/*查询商家的促销活动*/
	@Override
	public PageList<Goods> getSellerGoods(GoodsQuery query) {
		long count = goodsMapper.getSellerCount(query.getSellerId());
		int row = query.getRows();
		long total = count%row!=0?count/row+1:count/row;
		PageList<Goods> pageList = new PageList<Goods>(total,goodsMapper.getSellerGoods(query));
        return pageList;
	}

	@Override
	@Transactional
	public boolean removeSellerGoods(int goodsId) {
		try{
			goodsMapper.removeSellerGoods(goodsId);
			goodsImageMapper.removeByGoodsId(goodsId);
		}catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	@Transactional
	public void updatePayType(Goods goods) {
		goodsMapper.updatePayType(goods);
	}

	@Override
	@Transactional
	public void updateValidByNum(int goodsId) {
		try {
			goodsMapper.updateValidByNum(goodsId);
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
	}

	@Override
	@Transactional
	public void addSoldNum(Integer goodsId) {
		try {
			
			goodsMapper.addSoldNum(goodsId);
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}

	@Override
	@Transactional
	public void removeSoldNum(Integer goodsId) {
		try {
			goodsMapper.removeSoldNum(goodsId);
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}

	@Override
	public boolean getNum(Integer goodsId) {
		try {
			if(goodsMapper.getNum(goodsId)<=0) 
				return true;
			return false;
			
		}catch (Exception e) {
		}
		return false;
	}

	@Override
	public boolean getBySellerId(String id) {
		try {
			if(goodsMapper.getBySellerId(id)<=0)
				return true;
			return false;
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	@Override
	@Transactional
	public void updateGoodsState() {
		try {
			goodsMapper.updateGoodsState();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}

	@Override
	public List<Goods> getSellerGoods(Integer sellerId) {
		return goodsMapper.getGoodsBySellerId(sellerId);
	}

	@Override
	public PageList<Goods> getAllGoodsBySeller(Goods goods) {
		PageList<Goods> pageList = new PageList<Goods>();
		// 统计总记录数
		Integer count = goodsMapper.getTotal(goods);
		pageList.setCount(count);
		pageList.setRows(goodsMapper.getAllGoodsBySeller(goods));
        return pageList;
	}

	@Override
	public PageList<Goods> getAllGoods(Goods goods) {
		PageList<Goods> pageList = new PageList<Goods>();
		// 统计总记录数
		Integer count = goodsMapper.getAllGoodsTotal(goods);
		pageList.setCount(count);
		pageList.setRows(goodsMapper.getAllGoods(goods));
        return pageList;
	}

	@Override
	public Goods getGoodsTime(Integer goodsId) {
		
		return goodsMapper.getGoodsTime(goodsId);
	}

	@Override
	@Transactional
	public ResponseResult addAll(Goods goods) {
		ResponseResult result =new ResponseResult();
		Goods good = goods;
    	try {
    		Seller seller = good.getSeller();
    		//商家信息
    		if(seller.getId()==null) {
        		//添加
    			String id=new Date().getTime()+"X"+new Random().nextInt(1000);//新id
    			seller.setId(id);
    			seller.setIsValid(true);
    			sellerMapper.add(seller);
    			//result.setMessage("添加成功");
        	}else {
        		//修改
        		sellerMapper.update(seller);
        		//result.setMessage("修改成功");
        	}
    		
    		good.setSeller(seller);
    		if(good.getId()==null) {
        		//添加
    			good.setSoldNum(0);
    			goodsMapper.add(good);
				List<GoodsImage> list = good.getImages();
				for (GoodsImage goodsImage : list) {
					goodsImage.setGoods(new Goods(good.getId()));
				}
				
				if(list.size()>0) {
					if(goodsImageMapper.getByGoodsId(list.get(0).getGoods().getId())!=null) {
						goodsImageMapper.removeByGoodsId(list.get(0).getGoods().getId());
					}
					goodsImageMapper.addAll(list);
				}
				
				
				//result.setMessage("添加成功");
        	}else {
        		//修改
        		goodsMapper.updateGoods(good);
        		result.setMessage("修改成功");
        		
        		List<GoodsImage> list = good.getImages();
				for (GoodsImage goodsImage : list) {
					goodsImage.setGoods(new Goods(good.getId()));
				}
				
				if(list.size()>0) {
					if(goodsImageMapper.getByGoodsId(list.get(0).getGoods().getId())!=null) {
						goodsImageMapper.removeByGoodsId(list.get(0).getGoods().getId());
					}
					goodsImageMapper.addAll(list);
				}
        	}
    		
    		
    		
    		result.setCode(0);
    		result.setMessage("操作成功");
    	}catch (Exception e) {
    		result.setCode(1);
    		result.setMessage("操作失败");
		}
		return result;
	}

	

}
