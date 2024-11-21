/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package gov.landbank.SFC.dao;

import gov.landbank.SFC.models.Province;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;

/**
 *
 * @author F862
 */
public class ProvinceDao {
    Connection conn;

    public ProvinceDao(Connection con) {
        conn = con;
    }
    
    public List<Province> getProvinceListPerRegion(String region_name) throws SQLException, ClassNotFoundException, NamingException {
        List<Province> listProvince = new ArrayList<>();
        String sql = ""; 
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;   
        
        try {
            
            if(region_name != null){
            sql = "SELECT * FROM PSGC_PROVINCE where region=? ORDER BY province_name";
            }else {
            sql = "SELECT * FROM PSGC_PROVINCE ORDER BY province_name";                
            };
                                
            ps = conn.prepareStatement(sql);
            ps.setString(1, region_name);
            rs = ps.executeQuery();                                    
            //Statement statement = conn.createStatement();
            //ResultSet result = statement.executeQuery(sql);                        
            
            while (rs.next()) {                
                Province province = new Province();
                province.setProvinceName(rs.getString("province_name"));  
                listProvince.add(province);
            }          
             
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw ex;
        }    
         
        return listProvince;
    }

    
    public List<Province> getList() throws SQLException, ClassNotFoundException {
        List<Province> listProvince = new ArrayList<>();         
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;           
        try {
            
            String sql = "SELECT * FROM PSGC_PROVINCE ORDER BY province_name";
            statement = conn.createStatement();
            result = statement.executeQuery(sql);
             
            while (result.next()) {                
                Province province = new Province();
                province.setProvinceName(result.getString("PROVINCE_NAME"));  
                listProvince.add(province);
            }          
             
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw ex;
        }    
         
        return listProvince;
    }
    
    public ArrayList<Province> getProvinceDetailsAll() {
        ArrayList<Province> province = new ArrayList<Province>();
        String sql = "SELECT * FROM PSGC_PROVINCE ORDER BY province_name";        
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;        

        try {
            
            statement = conn.createStatement();
            result = statement.executeQuery(sql);

            while (result.next()) {
                Province temp = new Province();          
                temp.setRegionID(result.getString("REGION_ID"));
                temp.setProvinceID(result.getString("PROVINCE_ID"));
                temp.setProvinceName(result.getString("PROVINCE_NAME"));
                province.add(temp);

            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {

            try {
                statement.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return province;

    }
    
    public ArrayList<Province> getProvinceDetailsPerRegion(String region_id) {
        ArrayList<Province> province = new ArrayList<Province>();
        String sql = "";    
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;                
       
        try {            
            if(region_id != null && region_id != ""){
            sql = "SELECT * FROM PSGC_PROVINCE where region_id=? ORDER BY province_name";
            }else {
            sql = "SELECT * FROM PSGC_PROVINCE ORDER BY province_name";                
            };
                                    
            
            ps = conn.prepareStatement(sql);
            ps.setString(1, region_id);
            result = ps.executeQuery();                                    


            while (result.next()) {
                Province temp = new Province();          
                temp.setRegionID(result.getString("REGION_ID"));
                temp.setProvinceID(result.getString("PROVINCE_ID"));
                temp.setProvinceName(result.getString("PROVINCE_NAME"));
                province.add(temp);

            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {

            try {                
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return province;

    }

     public void killConnection() {
        String query = "Select concat('KILL ',id,';') from information_schema.processlist where host like CONCAT((select LEFT(host, LENGTH(host) - 6) from information_schema.processlist WHERE ID=connection_id()), '%')";
        String killQuery = "";
        PreparedStatement psKill = null;
        try {
            
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                killQuery = rs.getString(1);
                System.out.println(killQuery);
                psKill = conn.prepareStatement(killQuery);
                psKill.execute();
            }
//            conn.close();
        } catch (Exception e) {
//            System.out.println("killConnection error: " + e);
        }
    }   

    public String getProvinceCode(String province_desc) {

        String sql = "SELECT * FROM PSGC_PROVINCE where PROVINCE_NAME=?";        
        String provincecode = "";
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;   
        
        try {
                        
            ps = conn.prepareStatement(sql);
            ps.setString(1, province_desc);            
            System.out.println(province_desc);
                                    
            rs = ps.executeQuery();
            if(rs.next()){
               provincecode = rs.getString("province_id");
            }else {
               provincecode = "";
            };

        } catch (Exception e) {
            provincecode = "";
            e.printStackTrace();
        } finally {

            try {
                statement.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return provincecode;

    }    
    
}
