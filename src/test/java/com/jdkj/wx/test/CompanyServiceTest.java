package com.jdkj.wx.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jdkj.wx.mapper.CompanyMapper;
import com.jdkj.wx.mapper.GoodsMapper;
import com.jdkj.wx.service.IEvaluateService;
import com.jdkj.wx.service.IGoodsService;
import com.jdkj.wx.service.IGoodsTypeService;
import com.jdkj.wx.service.IOrderService;
import com.jdkj.wx.service.ISpellListService;
import com.jdkj.wx.service.impl.CompanyServiceImpl;

@RunWith(SpringJUnit4ClassRunner.class)
// 使用junit4进行测试
@ContextConfiguration(locations = { "classpath:spring-common.xml" })
// 加载配置文件
public class CompanyServiceTest {

    @Autowired
    private CompanyServiceImpl companyService;
    @Autowired
    private IGoodsTypeService goodsTypeService;
    @Autowired
    private CompanyMapper companyMapper;
    @Autowired
    private GoodsMapper goodsMapper;
    @Autowired
    private IGoodsService goodsService;
    @Autowired
    private IEvaluateService evaluateService;
    @Autowired
    private IOrderService orderService;
    @Autowired
    private ISpellListService spellService;
    


    @Test
    public void testDelete() throws InterruptedException, IllegalAccessException {
    	//System.out.println(spellService.getSpellItem(1));
    	//超时未支付订单修改
    			orderService.updateIsValidTimeOut();
    	
    	//orderService.updateOrder("dsasdasa");
    	//https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxd5f05ec829f479d3&redirect_uri=http%3A%2F%2F127.0.0.1%3A8080%2Fwx&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect
    	//https://api.weixin.qq.com/sns/oauth2/access_token?appid=wxd5f05ec829f479d3&secret=1bcb78c1e7058c4e25fdb93a94d4e603&code=081Bnwyf1EBkEr0bHxuf1v0Tyf1BnwyG&grant_type=authorization_code
    	//https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=wxd5f05ec829f479d3&grant_type=refresh_token&refresh_token=REFRESH_TOKEN
    	// https://api.weixin.qq.com/sns/userinfo?access_token=16_94YHozeafiWdU127ieiZqPvfUxQ-NBz4W3LpWcAc0VdOv9-uQu-clEOaGzZYPRNGrMMNRg5fimmj89UKFSFUng&openid=ozSob0rk__knHZgvIfMf8c-Y35nY&lang=zh_CN
    	//String encode = URLEncoder.encode("http://127.0.0.1:8080/wx");
    	//System.out.println(encode);
    	//orderService.cancelOrder(1);
    	//BaseQuery query= new BaseQuery<>();
    	
    	//System.out.println(goodsService.getMoreByType(query, 1));
    	//System.out.println("**********\n"+orderService.getSellerOrder("dsasdasa",query));
//    	List<Order> list = orderService.getOrder("dsasdasa",query);
//    	for (Order order : list) {
//			System.out.println(order.getSeller());
//		}
//    	System.out.println("**********\n");
    	//System.out.println(goodsTypeService.getAll());
    	//goodsMapper.updateState();
//    	BaseQuery query = new BaseQuery<>();
//    	query.setPage(1);
//    	List<Company> list = companyService.getAll(query);
//   
//
//    	query.setPage(1);
//    	companyService.getAll(query);
//    	query.setPage(1);
//    	companyService.getAll(query);
//    	
//    	System.out.println("********"+list.size()+list);
    	
    }
    
    
    
//    @Test
//    public void testGetById() {
//        System.out.println(companyService.getById(1));
//    }
//
//
//    @Test
//    public void testGetByIdAndName() {
//        Company company = companyService.getByIdAndName(1, "千锋");
//        if (company != null) {
//            System.out.println(company.getId() + ", " + company.getName());
//        }
//    }
//
//    @Test
//    public void testGetByIdAndName2() {
//        Company c = new Company();
//        c.setId(1);
//        c.setName("千锋");
//        Company company = companyService.getByIdAndName2(c);
//        if (company != null) {
//            System.out.println(company.getId() + ", " + company.getName());
//        }
//    }
//
//    @Test
//    public void testGetCompanyName() {
//        String companyName = companyService.getCompanyName(1);
//        System.out.println(companyName);
//    }
//
//    @Test
//    public void testCountCompany() {
//        long total = companyService.countCompany();
//        System.out.println(total);
//    }
//
//    @Test
//    public void testListAllCompanyName() {
//        List<String> companyNameList = companyService.listAllCompanyName();
//        System.out.println(companyNameList);
//    }
//
//    @Test
//    public void testAdd() {
//        companyService.add();
//    }
//
//    @Test
//    public void testAddCompany() {
//        Company company = new Company();
//        company.setName("Xxx公司");
//        Integer row = companyService.addCompany(company);
//        System.out.println("受影响的行数：" + row);
//        System.out.println("自增的Id：" + company.getId());
//    }



}
