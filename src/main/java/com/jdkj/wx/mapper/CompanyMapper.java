package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.jdkj.wx.entity.Company;
import com.jdkj.wx.page.PageList;
import com.jdkj.wx.query.BaseQuery;

public interface CompanyMapper {

    /**
     * 直接传入一个参数
     * 
     * @param id
     * @return 得到一个对象
     */
    @Select("SELECT * FROM company WHERE id=#{id}")
    Company getById(Serializable id);
    @Select("SELECT * FROM company")
    PageList<Company> getAll(BaseQuery<Company> query);
    /**
     * 传入多个参数，在接收参数的声明上需要添加@Param标签
     * 
     * @param id
     * @param name
     * @return 得到一个对象
     */
    @Select("SELECT * FROM company WHERE id=#{id} AND name=#{name}")
    Company getByIdAndName(@Param("id") Integer id, @Param("name") String name);

    /**
     * 传入一个对象
     * 
     * @param c
     * @return
     */
    @Select("SELECT * FROM company WHERE id=#{id} AND name=#{name}")
    Company getByIdAndName2(Company c);

    /**
     * 查询单个字段测试
     * 
     * @return 返回一个字段对应的类型
     */
    @Select("SELECT name FROM company WHERE id=#{id}")
    String getCompanyName(Integer id);

    /**
     * 查询总记录数
     * 
     * @return
     */
    @Select("SELECT COUNT(*) FROM company")
    long countCompany();
    
    //分页查询
    
    @Select("select * from company limit ${begin},${end}")
    List<Company> getByPage(BaseQuery query);
    /**
     * 查询单个字段测试
     * 
     * @return 返回一个List<String>
     */
    @Select("SELECT name FROM company")
    List<String> listAllCompanyName();

    void add(String name);

    /**
     * 使用注解定义新增并获取自增的主键时必须定义useGeneratedKeys，全局定义的不生效！
     * 
     * @param company
     * @return 返回受影响的行数，如果要取得自增的Id需要从传过来的company对象中取
     */
    @Insert("INSERT INTO company VALUES(NULL, #{name})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    Integer addCompany(Company company);

    /**
     * 删除<br>
     * 注：删除操作就必须用@Delete而不能换成其它注解（如@Select），否则只能执行删除，而不能获取受影响的行数，在XML中配置也是一样！
     * 
     * @param id
     * @return 返回受影响的行数
     */
    @Delete("DELETE FROM company WHERE id=#{id}")
    Integer delete(Integer id);

}
