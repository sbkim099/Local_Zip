package com.kedu.dto;

public class ToiletDTO {
	private String LCTN_ROAD_NM_ADDR;
	private String LCTN_LOTNO_ADDR;
	private String RSTRM_NM;
	private String WGS84_LAT;
	private String WGS84_LOT;
	
	public ToiletDTO() {}
	
	public ToiletDTO(String lCTN_ROAD_NM_ADDR, String lCTN_LOTNO_ADDR, String rSTRM_NM, String wGS84_LAT,
			String wGS84_LOT) {
		LCTN_ROAD_NM_ADDR = lCTN_ROAD_NM_ADDR;
		LCTN_LOTNO_ADDR = lCTN_LOTNO_ADDR;
		RSTRM_NM = rSTRM_NM;
		WGS84_LAT = wGS84_LAT;
		WGS84_LOT = wGS84_LOT;
	}
	
	public String getLCTN_ROAD_NM_ADDR() {
		return LCTN_ROAD_NM_ADDR;
	}
	public void setLCTN_ROAD_NM_ADDR(String lCTN_ROAD_NM_ADDR) {
		LCTN_ROAD_NM_ADDR = lCTN_ROAD_NM_ADDR;
	}
	public String getLCTN_LOTNO_ADDR() {
		return LCTN_LOTNO_ADDR;
	}
	public void setLCTN_LOTNO_ADDR(String lCTN_LOTNO_ADDR) {
		LCTN_LOTNO_ADDR = lCTN_LOTNO_ADDR;
	}
	public String getRSTRM_NM() {
		return RSTRM_NM;
	}
	public void setRSTRM_NM(String rSTRM_NM) {
		RSTRM_NM = rSTRM_NM;
	}
	public String getWGS84_LAT() {
		return WGS84_LAT;
	}
	public void setWGS84_LAT(String wGS84_LAT) {
		WGS84_LAT = wGS84_LAT;
	}
	public String getWGS84_LOT() {
		return WGS84_LOT;
	}
	public void setWGS84_LOT(String wGS84_LOT) {
		WGS84_LOT = wGS84_LOT;
	}
}