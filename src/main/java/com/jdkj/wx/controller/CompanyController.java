package com.jdkj.wx.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jdkj.wx.entity.Company;
import com.jdkj.wx.service.impl.CompanyServiceImpl;

@Controller
@RequestMapping("/company")
public class CompanyController {

    @Autowired
    private CompanyServiceImpl companyService;

    @RequestMapping("/getById")
    public String getById(int id, Model m) {
        Company company = companyService.getById(id);
        m.addAttribute("company", company);
        return "success";
    }

    @RequestMapping("/transaction")
    public String transaction() {
        companyService.add();
        return "success";
    }

    @RequestMapping("/toCompanyAddUI")
    public String toCompanyAddUI() {
        return "company-add";
    }

    @RequestMapping("/addCompany")
    public String addCompany(Company company) {
        companyService.addCompany(company);
        return "success";
    }
}
