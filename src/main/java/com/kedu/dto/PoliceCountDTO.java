package com.kedu.dto;

import java.util.List;

public class PoliceCountDTO {
	private int totalCount;
	private List<PoliceDTO> data;
	
	public PoliceCountDTO() {}
	
	public PoliceCountDTO(int totalCount, List<PoliceDTO> data) {
		this.totalCount = totalCount;
		this.data = data;
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public List<PoliceDTO> getData() {
		return data;
	}
	public void setData(List<PoliceDTO> data) {
		this.data = data;
	}
}