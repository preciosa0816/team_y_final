package org.zerock.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("no driver exist ");
		}
	}
	
	@Test
	public void testConnection() {
		try(Connection con= DriverManager.getConnection
				("jdbc:oracle:thin:@211.183.8.34:1521:orcl", "admin", "admin")){
			log.info(con);
		}catch(Exception e) {
			fail(e.getMessage());
		}
				
	}
}
