package com.semi.yolo.common.encrypt;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

//@WebFilter(filterName = "encryptFilter",servletNames = { "memberLogin", "createAccount"})

public class EncryptFilter implements Filter {
       

    public EncryptFilter() {
    }

    public void init(FilterConfig fConfig) throws ServletException {
    	
    }
    
	public void destroy() {

	}


	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//		EncryptPassword encryptPassword = new EncryptPassword((HttpServletRequest) request);
//		
//		chain.doFilter(encryptPassword, response);
//		
//		HttpServletRequest httpRequest = (HttpServletRequest) request;
	    
	}
}
