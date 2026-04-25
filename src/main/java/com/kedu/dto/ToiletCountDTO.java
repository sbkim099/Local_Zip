package com.kedu.dto;

public class ToiletCountDTO {
	private int totalCount;
	private ToiletItemsDTO items;
	
	public ToiletCountDTO() {}
	
	public ToiletCountDTO(int totalCount, ToiletItemsDTO items) {
		this.totalCount = totalCount;
		this.items = items;
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public ToiletItemsDTO getItems() {
		return items;
	}
	public void setItems(ToiletItemsDTO items) {
		this.items = items;
	}
}