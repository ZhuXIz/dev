package com.jdkj.wx.controller;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jdkj.wx.entity.Coupon;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.CouponQuery;
import com.jdkj.wx.service.ICouponService;

@Controller
@RequestMapping("/coupon")
public class CouponController extends BaseController {

    @Autowired
    private ICouponService couponService;

    @RequestMapping("/getAll")
    @ResponseBody
    public PageList<Coupon> getAllCoupon(CouponQuery query) {
    	return couponService.getAll(query);
    }
    
    @RequestMapping("/get")
    @ResponseBody
    public Coupon getOneCoupon(Serializable id) {
    	return couponService.getById(id);
    }
    
    @RequestMapping("/index")
    public String pageToIndex() {
    	return "wx/coupon/index";
    }
    
}
