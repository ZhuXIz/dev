package com.jdkj.wx.mapper;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.jdkj.wx.entity.Contact;
import com.jdkj.wx.entity.Employee;
import com.jdkj.wx.query.BaseQuery;

public interface ContactMapper extends BaseMapper<Contact>{
	/*只能修该表相关内容,不能添加*/
    @Select("SELECT * FROM j_contact")
    Contact get();
    @Select("SELECT * FROM j_contact where id=#{id}")
    Contact getById(Serializable id);
    @Delete("delete from j_contact where id=#{id}")
    void remove(Serializable id);
    @Select("SELECT onTime,phoneNum,phoneName FROM j_contact")
    Contact getContact();
    @Update("update j_contact set service=#{service},introduce=#{introduce},companyName=#{companyName},companyAddress=#{companyAddress},"
    		+ "companyUrl=#{companyUrl},phoneNum=#{phoneNum},phoneName=#{phoneName},onTime=#{onTime}")
    void update(Contact contact);
    
     @Select("SELECT * FROM j_contact limit #{begin},#{end}")
	 List<Contact> getAllQuery(BaseQuery<Contact> query);
	 @Select("SELECT count(*) FROM j_contact")
	 long getCount(BaseQuery<Contact> query);
	 
	 @Select("SELECT service,phoneNum FROM j_contact")
	Contact getService();
	 
	 @Select("SELECT count(*) FROM j_contact")
	int getTotal(Contact contact);
	 @Select("SELECT * FROM j_contact limit #{offset},#{limit}")
	List<Contact> getAllByContact(Contact contact);
}
