/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.dao;

import gov.landbank.SFC.models.LGUProject;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author F862
 */
public class LGUProjectDao {
    
    Connection conn;

    public LGUProjectDao(Connection con) {
        conn = con;
    }    
    
    public List<LGUProject> getList() throws SQLException, ClassNotFoundException {
        List<LGUProject> listLGUProject = new ArrayList<>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;
        CallableStatement cs = null;
        
        try {            
            cs = conn.prepareCall("{CALL getLGUProjects()}");
            
            statement = conn.createStatement();
            result = cs.executeQuery();
                    
            while (result.next()) {
                LGUProject lguproject = new LGUProject();
                lguproject.setLguProjectDesc(result.getString("LGU_PROJECT_DESC"));
                listLGUProject.add(lguproject);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            throw ex;
        } finally {

            if (result != null) {
                try {
                    result.close();
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

        return listLGUProject;
    }    
    
    public String getLGUProjectID(String LGUProject_desc) {
        
        String LGUProjectid = "";
        //Connection conn = null;
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        CallableStatement cs = null;
        //String action = false;

        try {
            //conn = ConnectionPool.getConnection();

            cs = conn.prepareCall("{CALL getLGUProjectID(?)}");
            cs.setString(1, LGUProject_desc);
            System.out.println(LGUProject_desc);

            //System.out.println(ps);
            rs = cs.executeQuery();
            if (rs.next()) {
                LGUProjectid = rs.getString("LGU_PROJECT_ID");
            } else {
                LGUProjectid = "";
            };

//            statement = conn.createStatement();
//            action = statement.executeUpdate(sql);
        } catch (Exception e) {
            LGUProjectid = "";
            e.printStackTrace();
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
            if (ps != null) {
                try {
                    cs.close();
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
        }

        return LGUProjectid;

    }    
    
}
