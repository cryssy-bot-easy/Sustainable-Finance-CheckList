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
public class Province {

    
private int pID;
private String regionID;    
private String provinceID;    
private String provinceName;    
private String interLevel;

    public int getpID() {
        return pID;
    }

    public void setpID(int pID) {
        this.pID = pID;
    }

    public String getRegionID() {
        return regionID;
    }

    public void setRegionID(String regionID) {
        this.regionID = regionID;
    }

    public String getProvinceID() {
        return provinceID;
    }

    public void setProvinceID(String provinceID) {
        this.provinceID = provinceID;
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }

    public String getInterLevel() {
        return interLevel;
    }

    public void setInterLevel(String interLevel) {
        this.interLevel = interLevel;
    }
   

    
    
    
}
