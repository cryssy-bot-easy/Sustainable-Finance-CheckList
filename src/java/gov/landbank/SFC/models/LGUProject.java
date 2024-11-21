/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.models;

/**
 *
 * @author F862
 */
public class LGUProject {
    private int lguProjectID;
    private String lguProjectDesc;    
    private String sftgEO;        

    public int getLguProjectID() {
        return lguProjectID;
    }

    public void setLguProjectID(int lguProjectID) {
        this.lguProjectID = lguProjectID;
    }

    public String getLguProjectDesc() {
        return lguProjectDesc;
    }

    public void setLguProjectDesc(String lguProjectDesc) {
        this.lguProjectDesc = lguProjectDesc;
    }

    public String getSftgEO() {
        return sftgEO;
    }

    public void setSftgEO(String sftgEO) {
        this.sftgEO = sftgEO;
    }
    
    
    
}
