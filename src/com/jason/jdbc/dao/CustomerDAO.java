package com.jason.jdbc.dao;

import java.util.ArrayList;

import com.jason.jdbc.dto.CustomerDTO;

public interface CustomerDAO {
	
public ArrayList<CustomerDTO> queryCustomer();
	
	public boolean insertCustomer();
	
	public boolean updateCustomer();
	
	public boolean deleteCustomer();

}
