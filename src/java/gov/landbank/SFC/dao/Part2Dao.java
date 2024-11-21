/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.dao;


import gov.landbank.SFC.models.Part2;
import gov.landbank.SFC.models.GuidingPrinciple;
import gov.landbank.SFC.models.SustainableDevelopmentGoal;
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
public class Part2Dao {

    Connection conn;

    public Part2Dao(Connection con) {
        conn = con;
    }    
        
    public List<Part2> getLendingProgram(String avail) throws SQLException, ClassNotFoundException, NamingException {
        List<Part2> listPart2 = new ArrayList<>();
        String sql = ""; 
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;   
        
        try {
                        
            sql = "SELECT * FROM LENDING_PROGRAM where avail_lp = ? order by lp_id;";
                                            
            ps = conn.prepareStatement(sql);
            ps.setString(1, avail);
            rs = ps.executeQuery();                                    
                              
            while (rs.next()) {                
                Part2 part2 = new Part2();
                part2.setLpDesc(rs.getString("lp_desc"));  
                listPart2.add(part2);
            }          
             
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw ex;
        }    
         
        return listPart2;
    }    
    
    public String getProgramGroupCode(String program_desc) {

        String sql = "SELECT * FROM LENDING_PROGRAM where upper(LP_DESC)=upper(?);";        
        String programcode = "";
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;   
        
        try {
                        
            ps = conn.prepareStatement(sql);
            ps.setString(1, program_desc);            
            System.out.println(program_desc);
                                    
            rs = ps.executeQuery();
            if(rs.next()){
               programcode = rs.getString("GROUP_ID");
            }else {
               programcode = "";
            };

        } catch (Exception e) {
            programcode = "";
            e.printStackTrace();
        } finally {

            try {
                statement.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return programcode;

    }        


    public String getLendingProgramCode(String program_desc) {

        String sql = "SELECT * FROM LENDING_PROGRAM where upper(LP_DESC)=upper(?);";        
        String programcode = "";
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;   
        
        try {
                        
            ps = conn.prepareStatement(sql);
            ps.setString(1, program_desc);            
            System.out.println(program_desc);
                                    
            rs = ps.executeQuery();
            if(rs.next()){
               programcode = rs.getString("LP_ID");
            }else {
               programcode = "";
            };

        } catch (Exception e) {
            programcode = "";
            e.printStackTrace();
        } finally {

            try {
                statement.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return programcode;

    }        
    

    
    public ArrayList<GuidingPrinciple> getGP(int groupid) {
        ArrayList<GuidingPrinciple> gp = new ArrayList<GuidingPrinciple>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            String sql = "WITH RECURSIVE cte AS (" +
                            "SELECT 1 AS n " +
                            "UNION ALL " +
                            "SELECT n + 1 FROM cte WHERE n < (select char_length(GP) - char_length(replace(GP, ',', '')) + 1 as N from " +
                            "(SELECT LP_ID, GROUP_CONCAT(SUBSTRING(gp_desc, 4, 1)) AS GP FROM guiding_principle GROUP BY LP_ID) a  where lp_id = ?) " +
                            "), NUMBERS AS " +
                            "(SELECT n FROM cte) " +
                            ", GP_GROUPED as (" +
                            "SELECT LP_ID AS GROUP_ID, GROUP_CONCAT(SUBSTRING(gp_desc, 4, 1)) AS GP FROM guiding_principle GROUP BY LP_ID " +
                            ") " +
                            "select group_id, TRIM(substring_index(substring_index(GP, ',', n), ',', -1 )) as GP from GP_GROUPED " +
                            "join numbers on char_length(GP) - char_length(replace(GP, ',', '')) >= n - 1 " +
                            "WHERE GROUP_ID = ?;";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, groupid);
            ps.setInt(2, groupid);
            rs = ps.executeQuery();

            while (rs.next()) {
                GuidingPrinciple temp = new GuidingPrinciple();
                temp.setGroupID(rs.getInt("group_id"));
                temp.setGpDesc(rs.getInt("gp"));
                gp.add(temp);

            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
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
        return gp;
    }
    
    public ArrayList<SustainableDevelopmentGoal> getSDG(int groupid) {
        ArrayList<SustainableDevelopmentGoal> sdg = new ArrayList<SustainableDevelopmentGoal>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String sql = "WITH RECURSIVE cte AS (" +
                            "SELECT 1 AS n " +
                            "UNION ALL " +
                            "SELECT n + 1 FROM cte WHERE n < (select char_length(SUBSTRING(sdg_desc, 5)) - char_length(replace(SUBSTRING(sdg_desc, 5), ',', '')) + 1 as N from sdg where group_id = ?)" +
                            "), NUMBERS AS " +
                            "(SELECT n FROM cte) " +
                            "select GROUP_ID, TRIM(substring_index(substring_index(SUBSTRING(sdg_desc, 5), ',', n), ',', -1 )) as SDG from SDG " +
                            "join numbers on char_length(SUBSTRING(sdg_desc, 5)) - char_length(replace(SUBSTRING(sdg_desc, 5), ',', '')) >= n - 1 " +
                            "WHERE GROUP_ID = ?;";
            
            ps = conn.prepareStatement(sql);
            ps.setInt(1, groupid);
            ps.setInt(2, groupid);
            rs = ps.executeQuery();

            while (rs.next()) {
                SustainableDevelopmentGoal temp = new SustainableDevelopmentGoal();
                temp.setGroupID(rs.getInt("group_id"));
                temp.setSdgDesc(rs.getInt("sdg"));
                sdg.add(temp);

            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
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
        return sdg;
    }    
    
    public String create(String esrequestid, String sectorprioritysector, String typeofinvestmentsubsector, String typeinvothers, String availlendprog, String lendingprogramcode, 
                        String group1_1, String group1_2, String group1_3, String group2_1, String group2_2, String group2_3, String group2_4, String group2_5, String group2_6, 
                        String group3_1, String group3_2, String group3_3, String group4_1, String group4_2, String group4_3, String group4_4, String group4_5, String group4_6, 
                        String group5_1, String group6_1, String group6_2, String group6_3, String group7_1, String group7_2, String group7_3, String group7_4, String group7_5, 
                        String group7_6, String group8_1, String group8_2, String group8_3, String group8_4, String group8_5, String group9_1, String group9_2, String group9_3, 
                        String group9_4, String group10_1, String group10_2, String group11_1, String group11_1_others, String group11_2, String group11_3, String group12_1, String group12_2, 
                        String group12_3, String group13_1, String group13_2, String group13_3, String group14_1, String group14_2, String group14_3, String group14_4, String group14_5, 
                        String group15_1, String group16_1, String group16_2, String group16_3, String group16_4, String group17_1, String group17_2, String group17_3, String group17_4, 
                        String group18_1, String group18_2, String group18_3, String group18_4, String group18_5, String GP1, String GP2, String GP3, String GP4, String GP5, 
                        String GP6, String GP7, String SDG1, String SDG2, String SDG3, String SDG4, String SDG5, String SDG6, String SDG7, String SDG8, String SDG9, String SDG10, String SDG11, 
                        String SDG12, String SDG13, String SDG14, String SDG15, String SDG16, String SDG17, String SDG18) throws SQLException, NamingException {

        String res = "fail";
        int success = 0;
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        CallableStatement cs = null;
        
        try {

            cs = conn.prepareCall("{CALL create_part2(?,?,?,?,?,?,?,?,?,?,"
                    + "?,?,?,?,?,?,?,?,?,?,"
                    + "?,?,?,?,?,?,?,?,?,?,"
                    + "?,?,?,?,?,?,?,?,?,?,"
                    + "?,?,?,?,?,?,?,?,?,?,"
                    + "?,?,?,?,?,?,?,?,?,?,"
                    + "?,?,?,?,?,?,?,?,?,?,"
                    + "?,?,?,?,?,?,?,?,?,?,"
                    + "?,?,?,?,?,?,?,?,?,?,"
                    + "?,?,?,?,?,?,?,?,?,?)}");
            cs.setString(1, esrequestid);
            cs.setString(2, sectorprioritysector);
            cs.setString(3, typeofinvestmentsubsector);
            cs.setString(4, typeinvothers);
            cs.setString(5, availlendprog);
            cs.setString(6, lendingprogramcode);
            cs.setString(7, group1_1);
            cs.setString(8, group1_2);
            cs.setString(9, group1_3);
            cs.setString(10, group2_1);
            cs.setString(11, group2_2);
            cs.setString(12, group2_3);
            cs.setString(13, group2_4);
            cs.setString(14, group2_5);
            cs.setString(15, group2_6);
            cs.setString(16, group3_1);
            cs.setString(17, group3_2);
            cs.setString(18, group3_3);
            cs.setString(19, group4_1);
            cs.setString(20, group4_2);
            cs.setString(21, group4_3);
            cs.setString(22, group4_4);
            cs.setString(23, group4_5);
            cs.setString(24, group4_6);
            cs.setString(25, group5_1);
            cs.setString(26, group6_1);
            cs.setString(27, group6_2);
            cs.setString(28, group6_3);
            cs.setString(29, group7_1);
            cs.setString(30, group7_2);
            cs.setString(31, group7_3);
            cs.setString(32, group7_4);
            cs.setString(33, group7_5);
            cs.setString(34, group7_6);
            cs.setString(35, group8_1);
            cs.setString(36, group8_2);
            cs.setString(37, group8_3);
            cs.setString(38, group8_4);
            cs.setString(39, group8_5);
            cs.setString(40, group9_1);
            cs.setString(41, group9_2);
            cs.setString(42, group9_3);
            cs.setString(43, group9_4);
            cs.setString(44, group10_1);
            cs.setString(45, group10_2);
            cs.setString(46, group11_1);
            cs.setString(47, group11_1_others);
            cs.setString(48, group11_2);
            cs.setString(49, group11_3);
            cs.setString(50, group12_1);
            cs.setString(51, group12_2);
            cs.setString(52, group12_3);
            cs.setString(53, group13_1);
            cs.setString(54, group13_2);
            cs.setString(55, group13_3);
            cs.setString(56, group14_1);
            cs.setString(57, group14_2);
            cs.setString(58, group14_3);
            cs.setString(59, group14_4);
            cs.setString(60, group14_5);
            cs.setString(61, group15_1);
            cs.setString(62, group16_1);
            cs.setString(63, group16_2);
            cs.setString(64, group16_3);
            cs.setString(65, group16_4);
            cs.setString(66, group17_1);
            cs.setString(67, group17_2);
            cs.setString(68, group17_3);
            cs.setString(69, group17_4);
            cs.setString(70, group18_1);
            cs.setString(71, group18_2);
            cs.setString(72, group18_3);
            cs.setString(73, group18_4);
            cs.setString(74, group18_5);
            cs.setString(75, GP1);
            cs.setString(76, GP2);
            cs.setString(77, GP3);
            cs.setString(78, GP4);
            cs.setString(79, GP5);
            cs.setString(80, GP6);
            cs.setString(81, GP7);
            cs.setString(82, SDG1);
            cs.setString(83, SDG2);
            cs.setString(84, SDG3);
            cs.setString(85, SDG4);
            cs.setString(86, SDG5);
            cs.setString(87, SDG6);
            cs.setString(88, SDG7);
            cs.setString(89, SDG8);
            cs.setString(90, SDG9);
            cs.setString(91, SDG10);
            cs.setString(92, SDG11);
            cs.setString(93, SDG12);
            cs.setString(94, SDG13);
            cs.setString(95, SDG14);
            cs.setString(96, SDG15);
            cs.setString(97, SDG16);
            cs.setString(98, SDG17);
            cs.setString(99, SDG18);

            //cs.registerOutParameter(100, Type.INT);
            rs = cs.executeQuery();
            int generatedKey = 0;

            if (rs.next()) {
                generatedKey = cs.getInt("REC_ID");
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
    
}
