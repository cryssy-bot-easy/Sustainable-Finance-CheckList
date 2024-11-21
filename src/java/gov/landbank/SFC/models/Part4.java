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
public class Part4 {
    private int recordID;
    private int reqID;
    private String environmentalImpact;
    private String ecc;   
    private String cnc;   

    public int getRecordID() {
        return recordID;
    }

    public void setRecordID(int recordID) {
        this.recordID = recordID;
    }

    public int getReqID() {
        return reqID;
    }

    public void setReqID(int reqID) {
        this.reqID = reqID;
    }

    public String getEnvironmentalImpact() {
        return environmentalImpact;
    }

    public void setEnvironmentalImpact(String environmentalImpact) {
        this.environmentalImpact = environmentalImpact;
    }

    public String getEcc() {
        return ecc;
    }

    public void setEcc(String ecc) {
        this.ecc = ecc;
    }

    public String getCnc() {
        return cnc;
    }

    public void setCnc(String cnc) {
        this.cnc = cnc;
    }
            
    
}
