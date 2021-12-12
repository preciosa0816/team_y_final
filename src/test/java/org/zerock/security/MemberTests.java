package org.zerock.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
						"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberTests {

	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Setter(onMethod_ = @Autowired)
	private DataSource ds;
	
//	@Test
//	public void testInsertMember() {
//		String sql = "insert into login(user_no,user_id, user_pw, user_name,tel1, tel2,tel3, email1,email2, rrn1,rrn2 ) values (seq_login.nextval,?,?,?,?,?,?,?,?,?,?)";
//		
//		for(int i=0; i<100; i++) {
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			
//			try {
//				con=ds.getConnection();
//				pstmt=con.prepareStatement(sql);
//				
//				pstmt.setString(2, pwencoder.encode("pw"+i));
//				pstmt.setString(4, "010");
//				pstmt.setString(5, "0"+i);
//				pstmt.setString(6, "01"+i);
//				pstmt.setString(7, "a"+i);
//				pstmt.setString(8, "@a.com");
//				pstmt.setString(9, "1111"+i);
//				pstmt.setString(10, "2222"+i);
//				
//				
//				if(i<80) {
//					pstmt.setString(1, "user"+i);
//					pstmt.setString(3, "일반사용자"+i);
//				}else if (i<90) {
//					pstmt.setString(1, "manager"+i);
//					pstmt.setString(3, "운영자"+i);
//				}else {//admin90, pw90
//					pstmt.setString(1, "admin"+i);
//					pstmt.setString(3, "관리자"+i);
//				}
//				pstmt.executeUpdate();
//				
//			} catch (SQLException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}finally {
//				if(pstmt!=null) {
//					try {pstmt.close();} catch (SQLException e) {
//						e.printStackTrace();
//					}
//				}
//				if(con!=null) {
//					try {con.close();} catch (SQLException e) {
//						e.printStackTrace();
//					}
//				}
//			}//end for
//		}
//		
//	}

//	@Test
//	public void testInsertAuth() {
//		String sql="insert into tbl_login_auth(user_id,auth) values (?,?)";
//		for(int i=0; i<100; i++) {
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			
//			try {
//				con=ds.getConnection();
//				pstmt=con.prepareStatement(sql);
//				
//
//				if(i<80) {
//					pstmt.setString(1, "user"+i);
//					pstmt.setString(2, "ROLE_USER");
//				}else if (i<90) {
//					pstmt.setString(1, "manager"+i);
//					pstmt.setString(2, "ROLE_MEMBER");
//				}else {
//					pstmt.setString(1, "admin"+i);
//					pstmt.setString(2, "ROLE_ADMIN");
//				}
//				pstmt.executeUpdate();
//				
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}finally {
//				if(pstmt!=null) {
//					try {pstmt.close();} catch (SQLException e) {
//						e.printStackTrace();
//					}
//				}
//				if(con!=null) {
//					try {con.close();} catch (SQLException e) {
//						e.printStackTrace();
//					}
//				}
//			}//end for
//		}
//		
//	}
	
	@Test
	public void testInsertMember() {
		String sql = "insert into login(user_no,user_id, user_pw, user_name,tel1, tel2,tel3, email1,email2, rrn1,rrn2 ) values (999998,?,?,?,?,?,?,?,?,?,?)";
		
		
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con=ds.getConnection();
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(2, pwencoder.encode("user97"));
				pstmt.setString(4, "010");
				pstmt.setString(5, "123");
				pstmt.setString(6, "1234");
				pstmt.setString(7, "b");
				pstmt.setString(8, "@b.com");
				pstmt.setString(9, "010103");
				pstmt.setString(10, "2020208");
				
				pstmt.setString(1, "user97");
				pstmt.setString(3, "이용자");
				
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				if(pstmt!=null) {
					try {pstmt.close();} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(con!=null) {
					try {con.close();} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}//end for
		}
		
	
	
	@Test
	public void testInsertAuth() {
		String sql="insert into authories(user_id,authority) values (?,?)";
		
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con=ds.getConnection();
				pstmt=con.prepareStatement(sql);
				
					pstmt.setString(1, "user97");
					pstmt.setString(2, "ROLE_USER");
				
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				if(pstmt!=null) {
					try {pstmt.close();} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(con!=null) {
					try {con.close();} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}//end for
		}
		
	}

