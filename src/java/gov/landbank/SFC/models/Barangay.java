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
public class Barangay {
    private int bID;
    private String regionID;    
    private String provinceID;    
    private String cityID;
    private String brgyID;
    private String brgy;
    private String interLevel;    

    public int getbID() {
        return bID;
    }

    public void setbID(int bID) {
        this.bID = bID;
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

    public String getCityID() {
        return cityID;
    }

    public void setCityID(String cityID) {
        this.cityID = cityID;
    }

    public String getBrgyID() {
        return brgyID;
    }

    public void setBrgyID(String brgyID) {
        this.brgyID = brgyID;
    }

    public String getBrgy() {
        return brgy;
    }

    public void setBrgy(String brgy) {
        this.brgy = brgy;
    }

    public String getInterLevel() {
        return interLevel;
    }

    public void setInterLevel(String interLevel) {
        this.interLevel = interLevel;
    }
    
    
}
