package com.kedu.dao;

import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

import com.kedu.dto.KakaoAddressDTO;
import com.kedu.dto.KakaoDTO;
import com.kedu.dto.PoliceCountDTO;
import com.kedu.dto.PoliceDTO;
import com.kedu.dto.SafetyFacilityDTO;
import com.kedu.dto.ShelterCountDTO;
import com.kedu.dto.ShelterDTO;
import com.kedu.dto.SheltersDTO;
import com.kedu.dto.ToiletCountDTO;
import com.kedu.dto.ToiletDTO;
import com.kedu.dto.ToiletTopDTO;

@Repository
public class SafetyFacilityDAO {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private RestTemplate restTemplate;
	
	@Value("${data.toilet.police.api.service-key}")
	private String apiKey;
	
	@Value("${data.shelter.api.service-key}")
	private String shelterKey;
	
	@Value("${data.kakao.api-key}")
	private String kakaoKey;
	

	// 대피소
	public int saveShelterData() {
		int count = 0;

		try {
			this.deleteByType("대피소");

			int start = 1;
			int end = 1000;

			while (true) {

				String url = "http://openapi.seoul.go.kr:8088/"
						+ shelterKey
						+ "/json/TlEtqkP/"
						+ start + "/" + end;

				SheltersDTO sdto = restTemplate.getForObject(url, SheltersDTO.class);

				ShelterCountDTO data = sdto.getTlEtqkP();
				List<ShelterDTO> rows = data.getRow();
				if(rows == null) {
					break;
				}

				for (ShelterDTO item : rows) {
					if (item.getDADDR() == null || !item.getDADDR().contains("서울")) continue;

					SafetyFacilityDTO sfdto = new SafetyFacilityDTO();
					sfdto.setFac_type("대피소");
					sfdto.setFac_name(item.getACTC_FCLT_NM());
					sfdto.setFac_address(item.getDADDR());
					sfdto.setFac_gu(item.getSGG_NM());
					sfdto.setFac_numaddress("");

					try {
						sfdto.setFac_lat(Double.parseDouble(item.getLAT()));
						sfdto.setFac_lng(Double.parseDouble(item.getLOT()));

						this.insert(sfdto);
						count++;
					} catch (Exception e) {
						e.printStackTrace();
						continue;
					}
				}

				if (end >= data.getList_total_count()) break;
				start += 1000;
				end += 1000;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// 공중화장실
	public int saveToiletData() {
		int count = 0;

		try {
			this.deleteByType("공중화장실");

			int pageNo = 1;
			int numOfRows = 1000;

			while(true) {
				String url = "https://apis.data.go.kr/1741000/public_restroom_info/info"
						+ "?serviceKey=" + apiKey
						+ "&pageNo=" + pageNo
						+ "&numOfRows=" + numOfRows
						+ "&type=json";

				ToiletTopDTO response = restTemplate.getForObject(url, ToiletTopDTO.class);
				ToiletCountDTO body = response.getTop().getMiddle();

				List<ToiletDTO> list = body.getItems().getItem();

				for (ToiletDTO tlist : list) {
					String roadAddr = 
							(tlist.getLCTN_ROAD_NM_ADDR() == null) ? "" : tlist.getLCTN_ROAD_NM_ADDR().trim();
					String numAddr = 
							(tlist.getLCTN_LOTNO_ADDR() == null) ? "" : tlist.getLCTN_LOTNO_ADDR().trim();
					String facName = 
							(tlist.getRSTRM_NM() == null) ? "" : tlist.getRSTRM_NM().trim();
					String latStr = 
							(tlist.getWGS84_LAT() == null) ? "" : tlist.getWGS84_LAT().trim();
					String lngStr = 
							(tlist.getWGS84_LOT() == null) ? "" : tlist.getWGS84_LOT().trim();

					String addr = !roadAddr.isEmpty() ? roadAddr : numAddr;

					if (!addr.contains("서울")) continue;
					if (latStr.isEmpty() || lngStr.isEmpty()) continue;

					SafetyFacilityDTO dto = new SafetyFacilityDTO();
					dto.setFac_type("공중화장실");
					dto.setFac_name(facName);
					dto.setFac_address(roadAddr);
					dto.setFac_numaddress(numAddr);
					dto.setFac_gu(extractGu(addr));

					try {
						dto.setFac_lat(Double.parseDouble(latStr));
						dto.setFac_lng(Double.parseDouble(lngStr));
					}catch(Exception e) {
						e.printStackTrace();
						continue;
					}
					this.insert(dto);
					count++;
				}

				if (pageNo * numOfRows >= body.getTotalCount()) {
					break;
				}

				pageNo++;
			}

		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// 치안시설 저장
	public int savePoliceData() {
		int count = 0;

		try {
			this.deleteByType("치안시설");

			int pageNo = 1;
			int numOfRows = 1000;

			while (true) {
				String url = "https://api.odcloud.kr/api/15076962/v1/uddi:8ba698ca-b192-4fb7-99f7-e60903af03d0"
						+ "?serviceKey=" + apiKey
						+ "&page=" + pageNo
						+ "&perPage=" + numOfRows;

				PoliceCountDTO list = restTemplate.getForObject(url, PoliceCountDTO.class);

				for (PoliceDTO item : list.getData()) {
					String facName = 
							item.getPoliceName() == null ? "" : item.getPoliceName().trim();
					String addr = 
							item.getAddress() == null ?  "" : item.getAddress().trim();
					String officeName = 
							item.getOfficeName() == null ? "" : item.getOfficeName().trim();

					if (!addr.contains("서울")) continue;

					SafetyFacilityDTO dto = new SafetyFacilityDTO();
					dto.setFac_type("치안시설");
					dto.setFac_name(!facName.isEmpty() ? facName : officeName);
					dto.setFac_address(addr);
					dto.setFac_numaddress("");
					dto.setFac_gu(extractGu(addr));
					dto.setFac_lat(0);
					dto.setFac_lng(0);

					this.insert(dto);
					count++;
				}

				if (pageNo * numOfRows >= list.getTotalCount()) {
					break;
				}

				pageNo++;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}

	// 치안시설 위도,경도 업데이트
	public int updatePoliceLatLng() {
		int count = 0;

		try {
			List<SafetyFacilityDTO> list = this.selectPoliceWithoutCoords();

			for (SafetyFacilityDTO dto : list) {
				String address = dto.getFac_address();
				if (address == null || address.isBlank()) continue;

				String encodedAddr = URLEncoder.encode(address, StandardCharsets.UTF_8);
				String url = "https://dapi.kakao.com/v2/local/search/address.json?query=" + encodedAddr;

				HttpHeaders headers = new HttpHeaders();
				headers.set("Authorization", "KakaoAK " + kakaoKey);
				HttpEntity<String> entity = new HttpEntity<>(headers);

				ResponseEntity<KakaoAddressDTO> response = 
						restTemplate.exchange(URI.create(url), HttpMethod.GET, entity, KakaoAddressDTO.class);
				
				KakaoAddressDTO body = response.getBody();

				if (body != null && body.getDocuments() != null && !body.getDocuments().isEmpty()) {
					KakaoDTO klist = body.getDocuments().get(0);

					double lat = Double.parseDouble(klist.getY());
					double lng = Double.parseDouble(klist.getX());
					
					int result = this.updateLatLngBySeq(lat, lng, dto.getFac_seq());

					if (result > 0) {
						count++;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public int insert(SafetyFacilityDTO dto) {
		String sql = "insert into safety_facility values(safety_facility_seq.nextval,?,?,?,?,?,?,?,sysdate)";

		return jdbc.update(sql, dto.getFac_type(), dto.getFac_name(), dto.getFac_address(), dto.getFac_numaddress()
				,dto.getFac_gu(), dto.getFac_lat(), dto.getFac_lng());
	}

	public int deleteByType(String facType) {
		String sql = "delete from safety_facility where fac_type = ?";

		return jdbc.update(sql, facType);
	}

	public List<SafetyFacilityDTO> selectPoliceWithoutCoords() {
		String sql = "select * from safety_facility "
				+ "where fac_type = ? and fac_lat = 0 and fac_lng = 0";
		return jdbc.query(sql,
				new BeanPropertyRowMapper<>(SafetyFacilityDTO.class),
				"치안시설");
	}

	public int updateLatLngBySeq(double fac_lat, double fac_lng, int fac_seq) {
		String sql = "update safety_facility set fac_lat = ?, fac_lng = ? where fac_seq = ?";
		return jdbc.update(sql, fac_lat, fac_lng, fac_seq);
	}

	public List<SafetyFacilityDTO> selectAll(){
		String sql = "select * from safety_facility";
		return jdbc.query(sql, new BeanPropertyRowMapper<SafetyFacilityDTO>(SafetyFacilityDTO.class));
	}

	private String extractGu(String addr) {
		if (addr == null || addr.isBlank()) return "";
		String[] arr = addr.split(" ");
		if (arr.length >= 2) {
			return arr[1];
		}
		return "";
	}
}