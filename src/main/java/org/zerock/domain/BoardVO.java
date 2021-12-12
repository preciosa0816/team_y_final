package org.zerock.domain;

public class BoardVO {
	// Book 테이블
	private String bno; // 도서번호
	private String sign; // 분류기호
	private String title; // 도서명
	private String author; // 작성자
	private String publisher;// 출판사
	private String redate; // 발행일
	private String ISBN; // ISBN
	private String sup_check; // 부록여부
	private String reserve; // 예약여부
	private String views; // 조회수

	public String getBno() {
		return bno;
	}
	public void setBno(String bno) {
		this.bno = bno;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getRedate() {
		return redate;
	}
	public void setRedate(String redate) {
		this.redate = redate;
	}
	public String getISBN() {
		return ISBN;
	}
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
	public String getSup_check() {
		return sup_check;
	}
	public void setSup_check(String sup_check) {
		this.sup_check = sup_check;
	}
	public String getReserve() {
		return reserve;
	}
	public void setReserve(String reserve) {
		this.reserve = reserve;
	}
	public String getViews() {
		return views;
	}
	public void setViews(String views) {
		this.views = views;
	}
	
	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", sign = " + sign + ", title = " + title + ", author = " + author + ", publisher = " + publisher
				+ ", redate = " + redate + ", ISBN = " + ISBN + ", sup_check = " + sup_check + ", reserve = " + reserve + ", views = " + views + "]";
	}

}
