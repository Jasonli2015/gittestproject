package com.jason.jdbc.service;

import java.util.ArrayList;

import com.jason.jdbc.dto.CustomerDTO;

public interface CustomerService {
	
	public ArrayList<CustomerDTO> queryCustomer();
	
	public boolean insertCustomer();
	
	public boolean updateCustomer();
	
	public boolean deleteCustomer();

}
