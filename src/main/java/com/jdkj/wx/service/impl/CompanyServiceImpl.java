package com.jdkj.wx.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jdkj.wx.entity.Company;
import com.jdkj.wx.mapper.CompanyMapper;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;

@Service
public class CompanyServiceImpl {

    private static Logger logger = Logger.getLogger(CompanyServiceImpl.class);

    @Autowired
    private CompanyMapper companyMapper;

    public Company getById(Integer id) {
        logger.info("进入public Company getById(int id)方法...");
        return companyMapper.getById(id);
    }
    
  
    public List<Company> getAll(BaseQuery<Company> query) {

        return companyMapper.getByPage(query);
    }

    public String getCompanyName(Integer id) {
        return companyMapper.getCompanyName(id);
    }

    public Company getByIdAndName(Integer id, String name) {
        return companyMapper.getByIdAndName(id, name);
    }

    public Company getByIdAndName2(Company c) {
        return companyMapper.getByIdAndName2(c);
    }

    public long countCompany() {
        return companyMapper.countCompany();
    }

    public List<String> listAllCompanyName() {
        return companyMapper.listAllCompanyName();
    }

    public void add() {
        companyMapper.add("company3");
        System.out.println(1 / 0);
        companyMapper.add("company4");
    }

    public Integer addCompany(Company company) {
        return companyMapper.addCompany(company);
    }

    public Integer delete(Integer id) {
        return companyMapper.delete(id);
    }

}
