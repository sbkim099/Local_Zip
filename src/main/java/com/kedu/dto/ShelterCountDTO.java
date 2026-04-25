package com.kedu.dto;

import java.util.List;

public class ShelterCountDTO {
	private int list_total_count;
	private List<ShelterDTO> row;
	
	public ShelterCountDTO() {}
	
	public ShelterCountDTO(int list_total_count, List<ShelterDTO> row) {
		this.list_total_count = list_total_count;
		this.row = row;
	}
	
	public int getList_total_count() {
		return list_total_count;
	}
	public void setList_total_count(int list_total_count) {
		this.list_total_count = list_total_count;
	}
	public List<ShelterDTO> getRow() {
		return row;
	}
	public void setRow(List<ShelterDTO> row) {
		this.row = row;
	}
}