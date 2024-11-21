/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.dao;

import gov.landbank.SFC.models.Department;
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
public class DepartmentDao {

    Connection conn;

    public DepartmentDao(Connection con) {
        conn = con;
    }

    public List<Department> getList() throws SQLException, ClassNotFoundException {
        List<Department> listDepartment = new ArrayList<>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet result = null;
        try {
            String sql = "SELECT * FROM departments ORDER BY DEP_DESC";
            statement = conn.createStatement();
            result = statement.executeQuery(sql);

            while (result.next()) {
                Department department = new Department();
                department.setDepDesc(result.getString("dep_desc"));
                listDepartment.add(department);
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

        return listDepartment;
    }

    public String getDepID(String dep_desc) {

        String sql = "SELECT * FROM departments where dep_desc = ?";
        String depid = "";
        //Connection conn = null;
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        //String action = false;

        try {
            //conn = ConnectionPool.getConnection();

            ps = conn.prepareStatement(sql);
            ps.setString(1, dep_desc);
            System.out.println(dep_desc);

            //System.out.println(ps);
            rs = ps.executeQuery();
            if (rs.next()) {
                depid = rs.getString("dep_id");
            } else {
                depid = "";
            };

//            statement = conn.createStatement();
//            action = statement.executeUpdate(sql);
        } catch (Exception e) {
            depid = "";
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

        return depid;

    }

    public ArrayList<Department> getDepartment(int id) {
        ArrayList<Department> department = new ArrayList<Department>();
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            String sql = "select * from departments where dep_id= " + id;
            statement = conn.createStatement();
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                Department temp = new Department();
                temp.setDepID(rs.getInt("dep_id"));
                temp.setDepDesc(rs.getString("dep_desc"));
                department.add(temp);

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
        return department;
    }

    public ArrayList<Department> getAll() {
        ArrayList<Department> department = new ArrayList<Department>();

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            String sql = "select * from departments";
            statement = conn.createStatement();
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                Department temp = new Department();
                temp.setDepID(rs.getInt("dep_id"));
                temp.setDepDesc(rs.getString("dep_desc"));
                department.add(temp);

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
        return department;

    }

    public String create(String depdesc) throws SQLException, NamingException {

        String res = "fail";
        int success = 0;
        String sql = "insert into departments "
                + "(dep_desc) "
                + "values "
                + "(?)";
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, depdesc);
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

    public String create2(String depdesc) throws SQLException, NamingException {

        String res = "fail";
        int success = 0;
        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        CallableStatement cs = null;

        try {

            cs = conn.prepareCall("{CALL create_dept(?,?)}");
            cs.setString(1, depdesc);
                
            //cs.registerOutParameter(2, Type.INT);
            rs = cs.executeQuery();
            int generatedKey = 0;

            if (rs.next()) {
                generatedKey = rs.getInt("depid");
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

    public Department get(int id) {
        Department department = null;
        for (Department f : this.getAll()) {
            if (f.getDepID() == id) {
                department = f;
                break;
            }
        }
        return department;
    }

    public String update(int depid,
            String depdesc) {

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String res = "fail";

        int success = 0;
        try {

            //Department f = (this.get(depid));
            String sql = "Update departments set "
                    + "dep_desc = ? "
                    + "where dep_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, depdesc);
            ps.setInt(2, depid);

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

    public String deletedep(int depid) {
        String sql = "delete from departments where dep_id= " + depid;

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

    public String delete(int depid) {
        String sql = "delete from departments where dep_id= ?";

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String res = "fail";
        int action = 0;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, depid);
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

    public String getDepDesc(String sdepid) {

        String sql = "select dep_desc from departments where dep_id = ?";
        String depdesc = "";

        Statement statement = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            ps = conn.prepareStatement(sql);
            ps.setString(1, sdepid);

            rs = ps.executeQuery();
            if (rs.next()) {
                depdesc = rs.getString("dep_desc");
            } else {
                depdesc = "";
            };

        } catch (Exception e) {
            depdesc = "";
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

        return depdesc;

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
