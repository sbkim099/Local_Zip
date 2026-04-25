package com.kedu.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class PoliceDTO {
	@JsonProperty("치안센터명")
	private String policeName;

	@JsonProperty("주소")
	private String address;
	
	@JsonProperty("관서명")
	private String officeName;

	public PoliceDTO() {}
	
	public PoliceDTO(String policeName, String address, String officeName) {
		this.policeName = policeName;
		this.address = address;
		this.officeName = officeName;
	}

	public String getPoliceName() {
		return policeName;
	}

	public void setPoliceName(String policeName) {
		this.policeName = policeName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
}