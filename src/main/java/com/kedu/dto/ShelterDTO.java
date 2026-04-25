package com.kedu.dto;

public class ShelterDTO {
	private String ACTC_FCLT_NM;
	private String DADDR;
	private String SGG_NM;
	private String LAT;
	private String LOT;
	
	public ShelterDTO() {}
	
	public ShelterDTO(String aCTC_FCLT_NM, String dADDR, String sGG_NM, String lAT, String lOT) {
		ACTC_FCLT_NM = aCTC_FCLT_NM;
		DADDR = dADDR;
		SGG_NM = sGG_NM;
		LAT = lAT;
		LOT = lOT;
	}
	
	public String getACTC_FCLT_NM() {
		return ACTC_FCLT_NM;
	}
	public void setACTC_FCLT_NM(String aCTC_FCLT_NM) {
		ACTC_FCLT_NM = aCTC_FCLT_NM;
	}
	public String getDADDR() {
		return DADDR;
	}
	public void setDADDR(String dADDR) {
		DADDR = dADDR;
	}
	public String getSGG_NM() {
		return SGG_NM;
	}
	public void setSGG_NM(String sGG_NM) {
		SGG_NM = sGG_NM;
	}
	public String getLAT() {
		return LAT;
	}
	public void setLAT(String lAT) {
		LAT = lAT;
	}
	public String getLOT() {
		return LOT;
	}
	public void setLOT(String lOT) {
		LOT = lOT;
	}
}