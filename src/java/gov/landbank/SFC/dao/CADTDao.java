/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.dao;

import gov.landbank.SFC.models.CADT;
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
public class CADTDao {
    Connection conn;

    public CADTDao(Connection con) {
        conn = con;
    }    
    
        public List<CADT> getListPerRegion(String rID) throws SQLException, ClassNotFoundException {
        List<CADT> listCADT = new ArrayList<>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;
        CallableStatement cs = null;
        
        try {            
            cs = conn.prepareCall("{CALL getCADT(?)}");
            cs.setString(1, rID);
                                                         
            statement = conn.createStatement();
            result = cs.executeQuery();
                    
            while (result.next()) {
                CADT cadt = new CADT();
                cadt.setCadtNo(result.getString("CADT_NO"));
                //cadt.setLocation(result.getString("LOCATION"));
                //cadt.setTribe(result.getString("TRIBE"));
                listCADT.add(cadt);
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

        return listCADT;
    }            
    
    public List<CADT> getListByID(String CADT_NO) throws SQLException, ClassNotFoundException {
        List<CADT> listCADT = new ArrayList<>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;
        CallableStatement cs = null;
        
        try {            
            cs = conn.prepareCall("{CALL getCADTPerCADTNo(?)}");
            cs.setString(1, CADT_NO);
            statement = conn.createStatement();
            result = cs.executeQuery();
                    
            while (result.next()) {
                CADT cadt = new CADT();
                cadt.setCadtNo(result.getString("CADT_NO"));
                cadt.setLocation(result.getString("LOCATION"));
                cadt.setTribe(result.getString("TRIBE"));
                listCADT.add(cadt);
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

        return listCADT;
    }      
    
    public String getCADTLocation(String cadt_no) {
        
        String cadtLocation = "";
        //Connection conn = null;
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        CallableStatement cs = null;
        //String action = false;

        try {
            //conn = ConnectionPool.getConnection();

            cs = conn.prepareCall("{CALL getCADTPerCADTNo(?)}");
            cs.setString(1, cadt_no);            

            //System.out.println(ps);
            rs = cs.executeQuery();
            if (rs.next()) {
                cadtLocation = rs.getString("location");
            } else {
                cadtLocation = "";
            };

//            statement = conn.createStatement();
//            action = statement.executeUpdate(sql);
        } catch (Exception e) {
            cadtLocation = "";
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

        return cadtLocation;

    }        
    
    
            
    public String getCADTTribe(String cadt_no) {
        
        String cadtTribe = "";
        //Connection conn = null;
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        CallableStatement cs = null;
        //String action = false;

        try {
            //conn = ConnectionPool.getConnection();

            cs = conn.prepareCall("{CALL getCADTPerCADTNoTribe(?)}");
            cs.setString(1, cadt_no);            

            //System.out.println(ps);
            rs = cs.executeQuery();
            if (rs.next()) {
                cadtTribe = rs.getString("tribe");
            } else {
                cadtTribe = "";
            };

//            statement = conn.createStatement();
//            action = statement.executeUpdate(sql);
        } catch (Exception e) {
            cadtTribe = "";
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

        return cadtTribe;

    }                    
    
}
