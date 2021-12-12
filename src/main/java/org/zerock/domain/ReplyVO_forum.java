package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO_forum {
	
	private Long rno;
	private Long fno;//해당댓글이 어느글의 댓글인지를 명시
	
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
	
}
