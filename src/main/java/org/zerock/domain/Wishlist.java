package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Wishlist {
	private Long wno;
	private String book_type;
	private String title;
	private String author;
	private String publisher;
	private Date pubyear;	
	private Long ISBN;
	private String comments;
	private String progress;
	private Date regdate;
	private Date updateDate;
	private String user_id;
}
