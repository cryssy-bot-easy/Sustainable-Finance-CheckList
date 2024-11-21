/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package gov.landbank.SFC.dao;

import gov.landbank.SFC.models.Barangay;
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
public class BarangayDao {

    Connection conn;

    public BarangayDao(Connection con) {
        conn = con;
    }
    
    public List<Barangay> getList() throws SQLException, ClassNotFoundException, NamingException {
        List<Barangay> listBarangay = new ArrayList<>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;           
         
        try {
            
            String sql = "select * from psgc_barangay ORDER BY barangay_name";
            statement = conn.createStatement();
            result = statement.executeQuery(sql);
             
            while (result.next()) {                
                Barangay barangay = new Barangay();
                barangay.setBrgy(result.getString("barangay_name"));  
                listBarangay.add(barangay);
            }          
             
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw ex;
        }    
         
        return listBarangay;
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

     
    public ArrayList<Barangay> getBrgyDetailsPer(String region_id, String province_id, String city_id) {
        ArrayList<Barangay> barangay = new ArrayList<Barangay>();
        String sql = "";    
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;           
       
        try {            
            if(province_id != null && region_id != null && city_id != null && province_id != "" && region_id != "" && city_id != "")  {
            sql = "SELECT * FROM PSGC_barangay where region_id=? and province_id=? and city_mun_id=? ORDER BY barangay_name";
            }else {
            sql = "SELECT * FROM PSGC_barangay ORDER BY barangay_name";                
            };
                                    
            
            ps = conn.prepareStatement(sql);
            ps.setString(1, region_id);
            ps.setString(2, province_id);
            ps.setString(3, city_id);
            rs = ps.executeQuery();                                    

            while (rs.next()) {
                Barangay temp = new Barangay();          
                temp.setRegionID(rs.getString("REGION_ID"));
                temp.setProvinceID(rs.getString("PROVINCE_ID"));
                temp.setCityID(rs.getString("CITY_MUN_ID"));
                temp.setBrgyID(rs.getString("BARANGAY_ID"));
                temp.setBrgy(rs.getString("BARANGAY_NAME"));                
                barangay.add(temp);

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
        return barangay;

    }
          

    public String getBarangayCode(String barangay_desc, String region_id, String province_id, String city_id) {

        String sql = "SELECT * FROM PSGC_barangay where barangay_NAME=? and region_id=? and province_id=? and city_mun_id=?";        
        String barangaycode = "";
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;   
        
        try {
                        
            ps = conn.prepareStatement(sql);
            ps.setString(1, barangay_desc);            
            ps.setString(2, region_id);  
            ps.setString(3, province_id);  
            ps.setString(4, city_id);  
            System.out.println(barangay_desc);
                        
            rs = ps.executeQuery();
            if(rs.next()){
               barangaycode = rs.getString("barangay_id");
            }else {
               barangaycode = "";
            };

        } catch (Exception e) {
            barangaycode = "";
            e.printStackTrace();
        } finally {

            try {
                statement.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return barangaycode;

    }    
    
    
    
}
