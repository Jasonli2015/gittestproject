package com.jason.jdbc.service.impl;

import java.util.ArrayList;

import com.jason.jdbc.dao.CustomerDAO;
import com.jason.jdbc.dao.impl.CustomerDAOImpl;
import com.jason.jdbc.dto.CustomerDTO;
import com.jason.jdbc.service.CustomerService;

public class CustomerServiceImpl implements CustomerService {
	
	static CustomerDAO daoImpl = new CustomerDAOImpl();

	@Override
	public ArrayList<CustomerDTO> queryCustomer() {	
				
		ArrayList<CustomerDTO> list = daoImpl.queryCustomer();
		
		return list;
	}

	@Override
	public boolean insertCustomer() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateCustomer() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteCustomer() {
		// TODO Auto-generated method stub
		return false;
	}

}
