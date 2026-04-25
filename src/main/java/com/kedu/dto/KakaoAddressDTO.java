package com.kedu.dto;

import java.util.List;

public class KakaoAddressDTO {
	private List<KakaoDTO> documents;

	public KakaoAddressDTO() {}
	
	public KakaoAddressDTO(List<KakaoDTO> documents) {
		this.documents = documents;
	}

	public List<KakaoDTO> getDocuments() {
		return documents;
	}

	public void setDocuments(List<KakaoDTO> documents) {
		this.documents = documents;
	}
}