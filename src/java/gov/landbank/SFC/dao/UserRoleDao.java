/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.dao;

import gov.landbank.SFC.models.UserRole;
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
public class UserRoleDao {
    Connection conn;

    public UserRoleDao(Connection con) {
        conn = con;
    }    

    public List<UserRole> getList() throws SQLException, ClassNotFoundException {
        List<UserRole> listUserRole = new ArrayList<>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;           
        try {            
            String sql = "SELECT * FROM user_roles ORDER BY ROLE_DESC";
            statement = conn.createStatement();
            result = statement.executeQuery(sql);
             
            while (result.next()) {                
                UserRole userrole = new UserRole();
                userrole.setRoleDesc(result.getString("role_desc"));  
                listUserRole.add(userrole);
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
         
        return listUserRole;
    }    
    
    public String getRoleID(String role_desc) {

        String sql = "SELECT * FROM user_roles where role_desc = ?";        
        String roleid = "";
        //Connection conn = null;
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;             
        //String action = false;
        
        try {
            //conn = ConnectionPool.getConnection();
            
            ps = conn.prepareStatement(sql);
            ps.setString(1, role_desc);            
            System.out.println(role_desc);
            
            //System.out.println(ps);
            
            rs = ps.executeQuery();
            if(rs.next()){
               roleid = rs.getString("role_id");
            }else {
               roleid = "";
            };

//            statement = conn.createStatement();
//            action = statement.executeUpdate(sql);
        } catch (Exception e) {
            roleid = "";
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

        return roleid;

    }    
    
    public ArrayList<UserRole> getUserRole(int id) {
        ArrayList<UserRole> userrole = new ArrayList<UserRole>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            String sql = "select * from user_roles where role_id= " + id;
            statement = conn.createStatement();
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                UserRole temp = new UserRole();
                temp.setRoleID(rs.getInt("role_id"));
                temp.setRoleDesc(rs.getString("role_desc"));
                userrole.add(temp);

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
        return userrole;
    }

    public ArrayList<UserRole> getAll() {
        ArrayList<UserRole> userrole = new ArrayList<UserRole>();

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            String sql = "select * from user_roles";
            statement = conn.createStatement();
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                UserRole temp = new UserRole();
                temp.setRoleID(rs.getInt("role_id"));
                temp.setRoleDesc(rs.getString("role_desc"));
                userrole.add(temp);

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
        return userrole;

    }

        
    public String create(String roledesc) throws SQLException, NamingException {

        String res = "fail";
        int success = 0;
        String sql = "insert into user_roles "
                + "(role_desc) "
                + "values "
                + "(?)";
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, roledesc);            
            success = ps.executeUpdate();
            
            rs = ps.getGeneratedKeys();
            int generatedKey = 0;
            if (rs.next()) {
                generatedKey = rs.getInt(1);
            }

            if (success > 0) {
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

    public UserRole get(int id) {
        UserRole userrole = null;
        for (UserRole f : this.getAll()) {
            if (f.getRoleID() == id) {
                userrole = f;
                break;
            }
        }
        return userrole;
    }

    public String update(int roleid,
            String roledesc) {

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String res = "fail";

        int success = 0;
        try {
            
            String sql = "Update user_roles set "
                    + "role_desc = ? "                    
                    + "where role_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, roledesc);            
            ps.setInt(2, roleid);
            
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

    public String deleteuserrole(int roleid) {
        String sql = "delete from user_roles where role_id= " + roleid;

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

    public String delete(int roleid) {
        String sql = "delete from user_roles where role_id= ?";

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String res = "fail";
        int action = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, roleid);
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

   public String getRoleDesc(String roleid) {

        String sql = "select role_desc from user_roles where role_id = ?";
        String roledesc = "";

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            ps = conn.prepareStatement(sql);
            ps.setString(1, roleid);

            rs = ps.executeQuery();
            if (rs.next()) {
                roledesc = rs.getString("role_desc");
            } else {
                roledesc = "";
            };

        } catch (Exception e) {
            roledesc = "";
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

        return roledesc;

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
