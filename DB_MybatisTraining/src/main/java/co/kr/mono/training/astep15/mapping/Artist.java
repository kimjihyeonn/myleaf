package co.kr.mono.training.astep15.mapping;

import java.util.List;

public class Artist {
	
	private String mstId;
	private String mstName;
	private String debutDate;
	public String getMstId() {
		return mstId;
	}
	public void setMstId(String mstId) {
		this.mstId = mstId;
	}
	public String getMstName() {
		return mstName;
	}
	public void setMstName(String mstName) {
		this.mstName = mstName;
	}
	public String getDebutDate() {
		return debutDate;
	}
	public void setDebutDate(String debutDate) {
		this.debutDate = debutDate;
	}
	@Override
	public String toString() {
		return "Artist [mstId=" + mstId + ", mstName=" + mstName + ", debutDate=" + debutDate + "]";
	}
	public Artist(String mstId, String mstName, String debutDate) {
		super();
		this.mstId = mstId;
		this.mstName = mstName;
		this.debutDate = debutDate;
	}
	
	public Artist() {
		// TODO Auto-generated constructor stub
	}

}
