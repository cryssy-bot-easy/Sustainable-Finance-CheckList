/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package gov.landbank.SFC.dao;

//import gov.landbank.RSBSAEF.dao.ConnectionPool;
import gov.landbank.SFC.models.Region;
import java.sql.Connection;
import java.sql.DriverManager;
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
public class RegionDao {
    Connection conn;

    public RegionDao(Connection con) {
        conn = con;
    }
    
    public List<Region> getList() throws SQLException, ClassNotFoundException {
        List<Region> listRegion = new ArrayList<>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;   
        
        try {           
            String sql = "SELECT * FROM PSGC_REGION ORDER BY REGION_ID";
            statement = conn.createStatement();
            result = statement.executeQuery(sql);
             
            while (result.next()) {                
                Region region = new Region();
                region.setRegion(result.getString("region_name"));  
                listRegion.add(region);
            }          
             
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw ex;
        }    
         
        return listRegion;
    }
    
    public ArrayList<Region> getAll() {
        ArrayList<Region> region = new ArrayList<Region>();
        String sql = "SELECT * FROM PSGC_REGION ORDER BY REGION_ID";        
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {            
            statement = conn.createStatement();
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                Region temp = new Region();
                temp.setRegion(rs.getString("region_name"));
                region.add(temp);

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
        return region;

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
    
    public String getRegionCode(String region_desc) {

        String sql = "SELECT * FROM PSGC_REGION where REGION_NAME=?";        
        String regioncode = "";        
        Statement statement = null;
                
        try {            
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, region_desc);            
            System.out.println(region_desc);
            
            //System.out.println(ps);
            
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
               regioncode = rs.getString("region_id");
            }else {
               regioncode = "";
            };

        } catch (Exception e) {
            regioncode = "";
            e.printStackTrace();
        } finally {

            try {
                statement.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return regioncode;

    }

     
     
    
}
