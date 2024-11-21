/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package gov.landbank.SFC.dao;

import gov.landbank.SFC.models.City;
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
public class CityDao {
    Connection conn;

    public CityDao(Connection con) {
        conn = con;
    }
    
    public List<City> getList() throws SQLException, ClassNotFoundException {
        List<City> listCity = new ArrayList<>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;   
        
        try {            
            String sql = "select * from psgc_city_mun ORDER BY city_mun_name";
            statement = conn.createStatement();
            result = statement.executeQuery(sql);
             
            while (result.next()) {                
                City city = new City();
                city.setCity(result.getString("city_mun_name"));  
                listCity.add(city);
            }          
             
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw ex;
        }    
         
        return listCity;
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

     
    public ArrayList<City> getCityDetailsPer(String region_id, String province_id) {
        ArrayList<City> city = new ArrayList<City>();
        String sql = "";                
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;   
        
        try {            
            if(province_id != null && region_id != null && province_id != "" && region_id != "")  {
            sql = "SELECT * FROM PSGC_city_mun where region_id=? and province_id=? ORDER BY city_mun_name";
            }else {
            sql = "SELECT * FROM PSGC_city_mun ORDER BY city_mun_name";                
            };
                                    
            
            ps = conn.prepareStatement(sql);
            ps.setString(1, region_id);
            ps.setString(2, province_id);
            rs = ps.executeQuery();                                    


            while (rs.next()) {
                City temp = new City();          
                temp.setRegionID(rs.getString("REGION_ID"));
                temp.setProvinceID(rs.getString("PROVINCE_ID"));
                temp.setCityID(rs.getString("CITY_MUN_ID"));
                temp.setCity(rs.getString("CITY_MUN_NAME"));
                city.add(temp);

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
        return city;

    }
          

    public String getCityCode(String citymun_desc, String region_id, String province_id) {

        String sql = "SELECT * FROM PSGC_city_mun where city_mun_NAME=? and region_id=? and province_id=?";        
        String citycode = "";
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;   
        
        try {            
            
            ps = conn.prepareStatement(sql);
            ps.setString(1, citymun_desc);            
            ps.setString(2, region_id);  
            ps.setString(3, province_id);  
            System.out.println(citymun_desc);
            
            //System.out.println(ps);
            
            rs = ps.executeQuery();
            if(rs.next()){
               citycode = rs.getString("city_mun_id");
            }else {
               citycode = "";
            };

        } catch (Exception e) {
            citycode = "";
            e.printStackTrace();
        } finally {

            try {
                statement.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return citycode;

    }    
    
    @SuppressWarnings("empty-statement")
    public String getCityCodePerProv(String citymun_desc, String province_id) {

        String sql = "SELECT * FROM PSGC_city_mun where city_mun_NAME=? and province_id=?";        
        String citycode = "";
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;   
        
        try {
            
            
            ps = conn.prepareStatement(sql);
            ps.setString(1, citymun_desc);                        
            ps.setString(2, province_id);  
            System.out.println(citymun_desc);
            
            //System.out.println(ps);
            
            rs = ps.executeQuery();
            if(rs.next()){
               citycode = rs.getString("city_mun_id");
            }else {
               citycode = "";
            };

        } catch (Exception e) {
            citycode = "";
            e.printStackTrace();
        } finally {

            try {
                statement.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return citycode;

    }    

    public ArrayList<City> getCityDetailsPerProv(String province_id) {
        ArrayList<City> city = new ArrayList<City>();
        String sql = "";        
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;           
       
        try {            
            if(province_id != null && province_id != "")  {
            sql = "SELECT * FROM PSGC_city_mun where province_id=? ORDER BY city_mun_name";
            }else {
            sql = "SELECT * FROM PSGC_city_mun ORDER BY city_mun_name";                
            };
                                                
            ps = conn.prepareStatement(sql);            
            ps.setString(1, province_id);
            rs = ps.executeQuery();                                    

            while (rs.next()) {
                City temp = new City();          
                temp.setRegionID(rs.getString("REGION_ID"));
                temp.setProvinceID(rs.getString("PROVINCE_ID"));
                temp.setCityID(rs.getString("CITY_MUN_ID"));
                temp.setCity(rs.getString("CITY_MUN_NAME"));
                city.add(temp);

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
        return city;

    }

    
    
}
