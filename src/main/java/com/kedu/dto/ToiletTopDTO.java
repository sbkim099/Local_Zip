package com.kedu.dto;

public class ToiletTopDTO {
	private ToiletMiddleDTO response;

	public ToiletTopDTO() {}
	
	public ToiletTopDTO(ToiletMiddleDTO response) {
		this.response = response;
	}

	public ToiletMiddleDTO getTop() {
		return response;
	}

	public void setTop(ToiletMiddleDTO response) {
		this.response = response;
	}
}