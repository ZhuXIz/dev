package com.jdkj.wx.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Permiss;
import com.jdkj.wx.entity.Seller;
import com.jdkj.wx.query.BaseQuery;
import com.jdkj.wx.query.SellerQuery;

public interface SellerMapper extends BaseMapper<Seller> {

	@Select("SELECT * FROM j_seller WHERE id=#{id}")
    Seller getById(String id);


    @Delete("DELETE FROM j_seller WHERE id=#{id}")
    boolean remove(String id);
    @Select("SELECT * FROM j_seller")
    List<Seller> getAll();

    @Select("SELECT name FROM j_seller WHERE id=#{id}")
    Seller getOrderById(@Param("id")String id);

    @Insert("INSERT INTO j_seller(id,name,onTime,phoneNum,phoneName,address,addressStr,introduceText,introduceImage,isValid) "
    		+ "VALUES(#{id},#{name},#{onTime},#{phoneNum},#{phoneName},#{address},#{addressStr},#{introduceText},#{introduceImage},#{isValid})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void add(Seller seller);
    

    @Update("update j_seller set isValid=1 where id = #{id}")
    void updatePass(String id);
    
    @Update("update j_seller set name =#{name},onTime=#{onTime},phoneName=#{phoneName},phoneNum=#{phoneNum},address=#{address},addressStr=#{addressStr},introduceText=#{introduceText},introduceImage=#{introduceImage} where id = #{id}")
    void update(Seller seller);

    @Select("SELECT count(*) FROM j_seller WHERE id=#{id}")
	int getBySellerId(String id);
    
	 List<Seller> getAllQuery(BaseQuery<Seller> query);
	 @Select("SELECT count(*) FROM j_seller  where name LIKE CONCAT('%',#{keyWords},'%') or " + 
	 		"phoneName LIKE CONCAT('%',#{keyWords},'%')")
	 long getCount(BaseQuery<Seller> query);


	Integer getTotal(Seller seller);


	List<Seller> getAllBySeller(Seller seller);

}
