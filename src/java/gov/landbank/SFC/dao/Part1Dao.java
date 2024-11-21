/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.dao;

import gov.landbank.SFC.models.Part1;
import java.sql.CallableStatement;
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
public class Part1Dao {

    Connection conn;

    public Part1Dao(Connection con) {
        conn = con;
    }

    public List<Part1> getList() throws SQLException, ClassNotFoundException {
        List<Part1> listPart1 = new ArrayList<>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;
        try {
            String sql = "SELECT * FROM TRAN_ES_PT1";
            statement = conn.createStatement();
            result = statement.executeQuery(sql);

            while (result.next()) {
                Part1 part1 = new Part1();
                part1.setLendInv(result.getString("LEND_INV"));
                part1.setLendInvID(result.getString("LEND_INV_ID"));
                part1.setSecurityName(result.getString("SECURITY_NAME"));
                part1.setIssuer(result.getString("ISSUER_N"));
                part1.setUseOfProceeds(result.getString("USE_OF_PROCEEDS"));
                part1.setAccountName(result.getString("ACCOUNT_NAME"));
                part1.setAccountType(result.getString("ACCOUNT_TYPE"));
                part1.setFirstname(result.getString("FIRSTNAME"));
                part1.setMiddlename(result.getString("MIDDLENAME"));
                part1.setLastname(result.getString("LASTNAME"));
                part1.setSuffix(result.getString("SUFFIX"));                
                part1.setFinancedProject(result.getString("FINANCED_PROJECT"));
                part1.setReqID(result.getInt("REQ_ID"));
                listPart1.add(part1);
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
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    /* ignored */
                }
            }
        }

        return listPart1;
    }

    public ArrayList<Part1> getPart1(int id) {
        ArrayList<Part1> part1 = new ArrayList<Part1>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;

        try {

            String sql = "select * from TRAN_ES_PT1 where req_id= " + id;
            statement = conn.createStatement();
            result = statement.executeQuery(sql);

            while (result.next()) {
                Part1 temp = new Part1();
                temp.setLendInv(result.getString("LEND_INV"));
                temp.setLendInvID(result.getString("LEND_INV_ID"));
                temp.setSecurityName(result.getString("SECURITY_NAME"));
                temp.setIssuer(result.getString("ISSUER_N"));
                temp.setUseOfProceeds(result.getString("USE_OF_PROCEEDS"));
                temp.setAccountName(result.getString("ACCOUNT_NAME"));
                temp.setAccountType(result.getString("ACCOUNT_TYPE"));
                temp.setFirstname(result.getString("FIRSTNAME"));
                temp.setMiddlename(result.getString("MIDDLENAME"));
                temp.setLastname(result.getString("LASTNAME"));
                temp.setSuffix(result.getString("SUFFIX"));                
                temp.setFinancedProject(result.getString("FINANCED_PROJECT"));
                temp.setReqID(result.getInt("REQ_ID"));
                part1.add(temp);

            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
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
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    /* ignored */
                }
            }

        }
        return part1;
    }

    public ArrayList<Part1> getAll() {
        ArrayList<Part1> part1 = new ArrayList<Part1>();

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;

        try {

            String sql = "select * from TRAN_ES_PT1";
            statement = conn.createStatement();
            result = statement.executeQuery(sql);

            while (result.next()) {
                Part1 temp = new Part1();
                temp.setLendInv(result.getString("LEND_INV"));
                temp.setLendInvID(result.getString("LEND_INV_ID"));
                temp.setSecurityName(result.getString("SECURITY_NAME"));
                temp.setIssuer(result.getString("ISSUER_N"));
                temp.setUseOfProceeds(result.getString("USE_OF_PROCEEDS"));
                temp.setAccountName(result.getString("ACCOUNT_NAME"));
                temp.setAccountType(result.getString("ACCOUNT_TYPE"));
                temp.setFirstname(result.getString("FIRSTNAME"));
                temp.setMiddlename(result.getString("MIDDLENAME"));
                temp.setLastname(result.getString("LASTNAME"));
                temp.setSuffix(result.getString("SUFFIX"));                
                temp.setFinancedProject(result.getString("FINANCED_PROJECT"));
                temp.setReqID(result.getInt("REQ_ID"));
                part1.add(temp);

            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
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
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    /* ignored */
                }
            }
        }
        return part1;

    }

    public String create(String lendinv, String lendinvID, String securityName, String issuer, String useOfProceeds,
             String accountName, String accountType, String firstname, String middlename, String lastname,
             String suffix, String financedProject) throws SQLException, NamingException {

        String res = "fail";
        int success = 0;
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        CallableStatement cs = null;
        
        try {

            cs = conn.prepareCall("{CALL create_part1(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cs.setString(1, lendinv);
            cs.setString(2, lendinvID);
            cs.setString(3, securityName);
            cs.setString(4, issuer);
            cs.setString(5, useOfProceeds);
            cs.setString(6, accountName);
            cs.setString(7, accountType);
            cs.setString(8, firstname);
            cs.setString(9, middlename);
            cs.setString(10, lastname);
            cs.setString(11, suffix);            
            cs.setString(12, financedProject);

            //cs.registerOutParameter(13, Type.INT);
            rs = cs.executeQuery();
            int generatedKey = 0;

            if (rs.next()) {
                generatedKey = cs.getInt("REQ_ID");
                res = "added" + generatedKey;
            }
                                   
        } catch (SQLException ex) {
            Logger.getLogger(Part1Dao.class.getName()).log(Level.SEVERE, null, ex);
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

        }
        return res;
    }

    public String createAddress(int reqID, String baRoom, String baLot, String baBuildingName
             , String baStreet, String baSubdivision, String baRegion, String baProvince, String baCity
             , String baDistrict, String baBrgy, String baPostalCode, String paRoom, String paLot
             , String paBuildingName, String paStreet, String paSubdivision, String paRegion, String paProvince
             , String paCity, String paDistrict, String paBrgy, String paPostalCode) throws SQLException, NamingException {

        String res = "fail";
        int success = 0;
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        CallableStatement cs = null;
        
        try {
            cs = conn.prepareCall("{CALL create_part1_address(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cs.setString(1, baRoom);
            cs.setString(2, baLot);
            cs.setString(3, baBuildingName);
            cs.setString(4, baStreet);
            cs.setString(5, baSubdivision);
            cs.setString(6, baRegion);
            cs.setString(7, baProvince);
            cs.setString(8, baCity);
            cs.setString(9, baDistrict);
            cs.setString(10, baBrgy);
            cs.setString(11, baPostalCode);
            cs.setString(12, paRoom);
            cs.setString(13, paLot);
            cs.setString(14, paBuildingName);
            cs.setString(15, paStreet);
            cs.setString(16, paSubdivision);
            cs.setString(17, paRegion);
            cs.setString(18, paProvince);
            cs.setString(19, paCity);
            cs.setString(20, paDistrict);
            cs.setString(21, paBrgy);
            cs.setString(22, paPostalCode);
            cs.setInt(23, reqID);
            //cs.registerOutParameter(24, Type.INT);
            rs = cs.executeQuery();
            int generatedKey = 0;

            if (rs.next()) {
                generatedKey = rs.getInt("ADDRESS_ID");
                res = "added" + generatedKey;
            }
                                   
        } catch (SQLException ex) {
            Logger.getLogger(Part1Dao.class.getName()).log(Level.SEVERE, null, ex);
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

        }
        return res;
    }    
    
    
    public Part1 get(int id) {
        Part1 part1 = null;
        for (Part1 f : this.getAll()) {
            if (f.getReqID() == id) {
                part1 = f;
                break;
            }
        }
        return part1;
    }

    
    
    
    public String update(int reqid,
            String lendinv, String lendinvID, String securityName, String issuer, String useOfProceeds,
             String accountName, String accountType, String firstname, String middlename, String lastname,
             String suffix, String businessAddress, String financedProject, String projectAddress, String baRoom,
             String baLot, String baBuildingName, String baStreet, String baSubdivision, String baRegion,
             String baProvince, String baCity, String baDistrict, String baBrgy, String baPostalCode,
             String paRoom, String paLot, String paBuildingName, String paStreet, String paSubdivision,
             String paRegion, String paProvince, String paCity, String paDistrict, String paBrgy, String paPostalCode) {

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String res = "fail";

        int success = 0;
        try {
            
            String sql = "Update TRAN_ES_PT1 set "
                    + "LEND_INV = ?, "
                    + "LEND_INV_ID = ?, "
                    + "SECURITY_NAME = ?, "
                    + "ISSUER_N = ?, "
                    + "USE_OF_PROCEEDS = ?, "
                    + "ACCOUNT_NAME = ?, "
                    + "ACCOUNT_TYPE = ?, "
                    + "FIRSTNAME = ?, "
                    + "MIDDLENAME = ?, "
                    + "LASTNAME = ?, "
                    + "SUFFIX = ?, "
                    + "BUSINESS_ADDRESS = ?, "
                    + "FINANCED_PROJECT = ?, "
                    + "PROJECT_ADDRESS = ?, "
                    + "BA_ROOM = ?, "
                    + "BA_LOT = ?, "
                    + "BA_BUILDINGNAME = ?, "
                    + "BA_STREET = ?, "
                    + "BA_SUBDIVISION = ?, "
                    + "BA_REGION = ?, "
                    + "BA_PROVINCE = ?, "
                    + "BA_CITY = ?, "
                    + "BA_DISTIRCT = ?, "
                    + "BA_BRGY = ?, "
                    + "BA_POSTALCODE = ?, "
                    + "PA_ROOM = ?, "
                    + "PA_LOT = ?, "
                    + "PA_BUILDINGNAME = ?, "
                    + "PA_STREET = ?, "
                    + "PA_SUBDIVISION = ?, "
                    + "PA_REGION = ?, "
                    + "PA_PROVINCE = ?, "
                    + "PA_CITY = ?, "
                    + "PA_DISTIRCT = ?, "
                    + "PA_BRGY = ?, "
                    + "PA_POSTALCODE = ? "
                    + "where req_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, lendinv);
            ps.setString(2, lendinvID);
            ps.setString(3, securityName);
            ps.setString(4, issuer);
            ps.setString(5, useOfProceeds);
            ps.setString(6, accountName);
            ps.setString(7, accountType);
            ps.setString(8, firstname);
            ps.setString(9, middlename);
            ps.setString(10, lastname);
            ps.setString(11, suffix);
            ps.setString(12, businessAddress);
            ps.setString(13, financedProject);
            ps.setString(14, projectAddress);
            ps.setString(15, baRoom);
            ps.setString(16, baLot);
            ps.setString(17, baBuildingName);
            ps.setString(18, baStreet);
            ps.setString(19, baSubdivision);
            ps.setString(20, baRegion);
            ps.setString(21, baProvince);
            ps.setString(22, baCity);
            ps.setString(23, baDistrict);
            ps.setString(24, baBrgy);
            ps.setString(25, baPostalCode);
            ps.setString(26, paRoom);
            ps.setString(27, paLot);
            ps.setString(28, paBuildingName);
            ps.setString(29, paStreet);
            ps.setString(30, paSubdivision);
            ps.setString(31, paRegion);
            ps.setString(32, paProvince);
            ps.setString(33, paCity);
            ps.setString(34, paDistrict);
            ps.setString(35, paBrgy);
            ps.setString(35, paPostalCode);
            ps.setInt(36, reqid);

            success = ps.executeUpdate();

        } catch (Exception e) {
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
                    ps.close();
                } catch (Exception e) {
                    /* ignored */
                }
            }

        }
        if (success > 0) {
            res = "updated";
        } else {
            res = "fail";
        }
        return res;
    }

    public String deletepart1(int reqid) {
        String sql = "delete from TRAN_ES_PT1 where req_id= " + reqid;

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String res = "fail";
        int action = 0;
        try {

            statement = conn.createStatement();
            action = statement.executeUpdate(sql);
        } catch (Exception e) {
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
                    ps.close();
                } catch (Exception e) {
                    /* ignored */
                }
            }
        }
        if (action > 0) {
            res = "deleted";
        } else {
            res = "fail";
        }
        return res;
    }

    public String delete(int reqid) {
        String sql = "delete from TRAN_ES_PT1 where req_id= ?";

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String res = "fail";
        int action = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, reqid);
            System.out.println(sql);
            action = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            try {
                statement.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (action > 0) {
            res = "deleted";
        } else {
            res = "fail";
        }
        return res;
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

        } catch (Exception e) {

        }
    }

}
