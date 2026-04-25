package com.kedu.dto;

public class ToiletMiddleDTO {
	private ToiletCountDTO body;

	public ToiletMiddleDTO() {}
	
	public ToiletMiddleDTO(ToiletCountDTO body) {
		this.body = body;
	}

	public ToiletCountDTO getMiddle() {
		return body;
	}

	public void setMiddle(ToiletCountDTO body) {
		this.body = body;
	}
}