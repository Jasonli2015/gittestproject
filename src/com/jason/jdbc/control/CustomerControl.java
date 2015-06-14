package com.jason.jdbc.control;

import java.util.ArrayList;

import com.jason.jdbc.dto.CustomerDTO;
import com.jason.jdbc.service.CustomerService;
import com.jason.jdbc.service.impl.CustomerServiceImpl;

public class CustomerControl {
	
	static CustomerService customerServiceImpl = new CustomerServiceImpl();
	
	public void quertCoustmer(){
		
		ArrayList<CustomerDTO> list = customerServiceImpl.queryCustomer();
		
	}
	
	public static void main(String[] args) {
		
		ArrayList<CustomerDTO> list = customerServiceImpl.queryCustomer();
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).getCustname());
		}
		
	}

}
