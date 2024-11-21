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
public class Part3 {
    private int recordID;
    private int reqID;
    private int lguProjectID;
    private String alignmentSDG;    

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

    public int getLguProjectID() {
        return lguProjectID;
    }

    public void setLguProjectID(int lguProjectID) {
        this.lguProjectID = lguProjectID;
    }

    public String getAlignmentSDG() {
        return alignmentSDG;
    }

    public void setAlignmentSDG(String alignmentSDG) {
        this.alignmentSDG = alignmentSDG;
    }
       
}
