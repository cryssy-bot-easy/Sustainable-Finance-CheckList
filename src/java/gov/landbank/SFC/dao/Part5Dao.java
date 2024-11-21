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
public class Part5Dao {
    Connection conn;

    public Part5Dao(Connection con) {
        conn = con;              
    }            
    
    public String create(
        String reqID,
        String mNoRegEmployees,
        String fNoRegEmployees,
        String mNoContractEmployees,
        String fNoContractEmployees,
        String mNoSubconEmployees,
        String fNoSubconEmployees,
        String pracChildLabor,
        String payingBelowMinWage,
        String landUsedIP,
        String landUsedIPDetail,
        String cadtCalt,
        String cadtCaltRegion,
        String cadtCaltNo,
        String ipAffected,
        String ipAffectedDTL,
        String arbBene,
        String arbBeneDTL,
        String arbBorrower,
        String arbBorrowerDTL,
        String operateWoAuthLandTitle,
        String arbAffected,
        String arbAffectedDTL,
        String promoteGenderEquality,
        String promoteGenderEqualityDTL,
        String noWomenOwnership,
        String noWomenDecisionBoard,
        String noWomenDecisionSeniorMGMT,
        String womenBene,
        String womenBeneDTL,
        String womenLongTermImpact,
        String womenLongTermImpactDTL,
        String womenMinImpact,
        String womenMinImpactDTL,
        String improvePrac,
        String improvePracDTL) throws SQLException, NamingException {

        String res = "fail";
        int success = 0;
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        CallableStatement cs = null;

        try {
                                                                                    
            cs = conn.prepareCall("{CALL create_part5(?,?,?,?,?,?,?,?,?,?,"
                    + "?,?,?,?,?,?,?,?,?,?,"
                    + "?,?,?,?,?,?,?,?,?,?,"
                    + "?,?,?,?,?,?,?)}");
            cs.setString(1, reqID);
            cs.setString(2, mNoRegEmployees);
            cs.setString(3, fNoRegEmployees);
            cs.setString(4, mNoContractEmployees);
            cs.setString(5, fNoContractEmployees);
            cs.setString(6, mNoSubconEmployees);
            cs.setString(7, fNoSubconEmployees);
            cs.setString(8, pracChildLabor);
            cs.setString(9, payingBelowMinWage);
            cs.setString(10, landUsedIP);
            cs.setString(11, landUsedIPDetail);
            cs.setString(12, cadtCalt);
            cs.setString(13, cadtCaltRegion);
            cs.setString(14, cadtCaltNo);
            cs.setString(15, ipAffected);
            cs.setString(16, ipAffectedDTL);
            cs.setString(17, arbBene);
            cs.setString(18, arbBeneDTL);
            cs.setString(19, arbBorrower);
            cs.setString(20, arbBorrowerDTL);
            cs.setString(21, operateWoAuthLandTitle);
            cs.setString(22, arbAffected);
            cs.setString(23, arbAffectedDTL);
            cs.setString(24, promoteGenderEquality);
            cs.setString(25, promoteGenderEqualityDTL);
            cs.setString(26, noWomenOwnership);
            cs.setString(27, noWomenDecisionBoard);
            cs.setString(28, noWomenDecisionSeniorMGMT);
            cs.setString(29, womenBene);
            cs.setString(30, womenBeneDTL);
            cs.setString(31, womenLongTermImpact);
            cs.setString(32, womenLongTermImpactDTL);
            cs.setString(33, womenMinImpact);
            cs.setString(34, womenMinImpactDTL);
            cs.setString(35, improvePrac);
            cs.setString(36, improvePracDTL);
                                    
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
