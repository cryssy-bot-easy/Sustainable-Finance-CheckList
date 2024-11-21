/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.dao;

import gov.landbank.SFC.models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;

/**
 *
 * @author F862
 */
public class UserDao {

    Connection conn;

    public UserDao(Connection con) {
        conn = con;
    }

    public String getUserName(String username) {
        System.out.println("username_dao" + username);
        String sql = "SELECT * FROM user_accounts where upper(username) = upper(?)";
        System.out.println(sql);
        String uname = "";

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            //System.out.println(sql);
            //System.out.println(ps);
            rs = ps.executeQuery();
            if (rs.next()) {
                uname = rs.getString("username");
                System.out.println("GETSTING " + uname);
            } else {
                uname = "";
                System.out.println(uname);
            };

        } catch (Exception e) {
            uname = "";
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

        return uname;

    }

    public ArrayList<User> getUser(String username) {
        ArrayList<User> user = new ArrayList<User>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            String sql = "select * from user_accounts where upper(username)= ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, username.toUpperCase());
            rs = ps.executeQuery();

            while (rs.next()) {
                User temp = new User();
                temp.setUserID(rs.getInt("user_id"));
                temp.setUsername(rs.getString("username"));
                temp.setFullname(rs.getString("fullname"));
                temp.setDeptID(rs.getInt("dept_id"));
                temp.setRoleID(rs.getInt("role_id"));
                temp.setIsAdmin(rs.getString("is_admin"));
                temp.setAccountStatus(rs.getString("account_status"));
                temp.setCreatedBy(rs.getString("created_by"));
                temp.setDateCreated(rs.getString("date_created"));

                user.add(temp);

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
        return user;
    }

    public ArrayList<User> getUserData() {
        ArrayList<User> user = new ArrayList<User>();

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            String sql = "SELECT USERNAME, "
                    + "FULLNAME, "
                    + "EMAIL, "
                    + "DEPT_ID, "
                    + "DEP_DESC, "
                    + "user_accounts.ROLE_ID, "
                    + "ROLE_DESC, "
                    + "ACCOUNT_STATUS, "
                    + "IS_ADMIN, "
                    + "CREATED_BY, "
                    + "DATE_CREATED, "
                    + "USER_ID "
                    + "FROM user_accounts left join departments on user_accounts.dept_id=departments.dep_id LEFT JOIN USER_ROLES ON user_accounts.role_id=user_roles.role_id order by username asc";
            statement = conn.createStatement();
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                User temp = new User();
                temp.setUserID(rs.getInt("user_id"));
                temp.setUsername(rs.getString("username"));
                temp.setFullname(rs.getString("fullname"));
                temp.setEmail(rs.getString("email"));
                temp.setDeptID(rs.getInt("dept_id"));
                temp.setDepDesc(rs.getString("dep_desc"));                        
                temp.setRoleID(rs.getInt("role_id"));
                temp.setRoleDesc(rs.getString("role_desc"));                        
                temp.setAccountStatus(rs.getString("account_status"));
                temp.setIsAdmin(rs.getString("is_admin"));
                temp.setCreatedBy(rs.getString("created_by"));
                temp.setDateCreated(rs.getString("date_created"));
                user.add(temp);

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
        return user;

    }

    public String checkUserExist(String username) {
        String sql = "select * from user_accounts where upper(username)= ?";

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String res = "fail";
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, username.toUpperCase());
            rs = ps.executeQuery();
            if (rs.first()) {
                res = "success";
            }

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

        return res;
    }

    public String create(String username,
            String fullname,
            String email,
            String userrole,
            String department,
            String status,
            String createdby,
            String datecreated,
            String useraccess) throws SQLException, NamingException {

        String res = "fail";
        int success = 0;
        String sql = "insert into user_accounts "
                + "(username, "
                + "fullname, "
                + "email, "
                + "dept_id, "
                + "role_id, "
                + "account_status, "
                + "is_admin, "
                + "created_by,"
                + "date_created) "
                + "values "
                + "(?,?,?,?,?,?,?,?,?)";
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, username);
            ps.setString(2, fullname);
            ps.setString(3, email);
            ps.setString(4, department);
            ps.setString(5, userrole);
            ps.setString(6, status);
            ps.setString(7, useraccess);
            ps.setString(8, createdby.toUpperCase());
            ps.setString(9, datecreated);

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
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
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

    public String update(int userid,
            String username,
            String fullname,
            String email,
            String userrole,
            String department,
            String status,
            String useraccess) {

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String res = "fail";

        int success = 0;
        try {

            String sql = "Update user_accounts set "
                    + "username = ? "
                    + ", fullname = ? "
                    + ", email = ? "
                    + ", dept_id = ? "
                    + ", role_id = ? "
                    + ", account_status = ? "
                    + ", is_admin = ? "
                    + "where user_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, fullname);
            ps.setString(3, email);
            ps.setString(4, department);
            ps.setString(5, userrole);
            ps.setString(6, status);
            ps.setString(7, useraccess);
            ps.setInt(8, userid);
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

    public String deactivateUser(String username) {

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String res = "Deactivation Failed";
        int success = 0;

        try {

            String sql = "Update user_accounts set account_status = 'I' where upper(username) = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, username.toUpperCase());
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
            if (success > 0) {
                res = "User Deactivated";
            } else {
                res = "Deactivation Failed";
            }
            return res;
        }
    }        
    
}
