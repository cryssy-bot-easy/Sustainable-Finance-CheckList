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
public class CADT {
  private int cadtId;  
  private int rId;
  private String cadtNo;
  private String dateApproved;
  private String location;
  private String cadcNo;
  private String tribe;
  private String areaHectares;
  private String ipRightHolders;

    public int getCadtId() {
        return cadtId;
    }

    public void setCadtId(int cadtId) {
        this.cadtId = cadtId;
    }

    public int getrId() {
        return rId;
    }

    public void setrId(int rId) {
        this.rId = rId;
    }

    public String getCadtNo() {
        return cadtNo;
    }

    public void setCadtNo(String cadtNo) {
        this.cadtNo = cadtNo;
    }

    public String getDateApproved() {
        return dateApproved;
    }

    public void setDateApproved(String dateApproved) {
        this.dateApproved = dateApproved;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getCadcNo() {
        return cadcNo;
    }

    public void setCadcNo(String cadcNo) {
        this.cadcNo = cadcNo;
    }

    public String getTribe() {
        return tribe;
    }

    public void setTribe(String tribe) {
        this.tribe = tribe;
    }

    public String getAreaHectares() {
        return areaHectares;
    }

    public void setAreaHectares(String areaHectares) {
        this.areaHectares = areaHectares;
    }

    public String getIpRightHolders() {
        return ipRightHolders;
    }

    public void setIpRightHolders(String ipRightHolders) {
        this.ipRightHolders = ipRightHolders;
    }
  
  
  
}
