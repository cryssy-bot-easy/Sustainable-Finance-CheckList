/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;

/**
 *
 * @author F862
 */
public class Part4Dao {
    
    Connection conn;

    public Part4Dao(Connection con) {
        conn = con;              
    }            
    
    public String create(String environmentalimpact, String ecc, String cnc, String esrequestid) throws SQLException, NamingException {

        String res = "fail";
        int success = 0;
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        CallableStatement cs = null;

        try {

            cs = conn.prepareCall("{CALL create_part4(?,?,?,?,?)}");
            cs.setString(1, environmentalimpact);
            cs.setString(2, ecc);
            cs.setString(3, cnc);
            cs.setString(4, esrequestid);
                
            rs = cs.executeQuery();
            int generatedKey = 0;

            if (rs.next()) {
                generatedKey = rs.getInt("P_RECORD_ID");
                res = "added" + generatedKey;
            }

        } catch (SQLException ex) {
            Logger.getLogger(DepartmentDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    /* ignored */
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (Exception e) {
                    /* ignored */
                }
            }
            if (cs != null) {
                try {
                    cs.close();
                } catch (Exception e) {
                    /* ignored */
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    /* ignored */
                }
            }
        }
        return res;
    }        
    
}
