package org.zerock.domain;

public class ReserveVO {
	private String reserveno;
	private String cover;
	private String title;
	private String author;
	private String publisher;

	public String getReserveno() {
		return reserveno;
	}

	public void setReserveno(String reserveno) {
		this.reserveno = reserveno;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
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

	@Override
	public String toString() {
		return "ReserveVO [reserveno=" + reserveno + ", cover = " + cover + ", title = " + title + ", author = " + author + ", publisher = " + publisher +"]";
	}

}
