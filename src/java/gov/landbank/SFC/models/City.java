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
public class City {
    private int cID;
    private String regionID;    
    private String provinceID;    
    private String cityID;
    private String city;
    private String interLevel;
    

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public int getcID() {
        return cID;
    }

    public void setcID(int cID) {
        this.cID = cID;
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

    public String getInterLevel() {
        return interLevel;
    }

    public void setInterLevel(String interLevel) {
        this.interLevel = interLevel;
    }
    
}
