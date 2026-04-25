package com.kedu.dto;

import java.util.List;

public class ToiletItemsDTO {
	private List<ToiletDTO> item;

	public ToiletItemsDTO() {}
	
	public ToiletItemsDTO(List<ToiletDTO> item) {
		this.item = item;
	}

	public List<ToiletDTO> getItem() {
		return item;
	}

	public void setItem(List<ToiletDTO> item) {
		this.item = item;
	}
}