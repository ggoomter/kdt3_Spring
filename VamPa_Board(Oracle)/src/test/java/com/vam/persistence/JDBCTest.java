package com.vam.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class JDBCTest {

    static { 
        try { 
            Class.forName("oracle.jdbc.driver.OracleDriver"); 
            //Class.forName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy"); 
        } catch(Exception e) { 
            e.printStackTrace(); 
        } 
    } 
    
    @Test
    public void testConnection() { 
        try(Connection con = DriverManager.getConnection( 
        		"jdbc:oracle:thin:@localhost:1521:orcl",
                "ora_user", 
                "evan")){ 
            System.out.println(con); 
        } catch (Exception e) { 
            fail(e.getMessage()); 
        } 
    
    }
    
    @Test
    public void testLog4j2Connection() { 
        try(Connection con = DriverManager.getConnection( 
        		"jdbc:log4jdbc:oracle:thin:@localhost:1521:orcl",
                "ora_user", 
                "evan")){ 
            System.out.println(con); 
        } catch (Exception e) { 
            fail(e.getMessage()); 
        } 
    
    }   
}
