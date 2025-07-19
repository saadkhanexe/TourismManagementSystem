package com.tourist.dao;

import java.util.List;

import com.tourist.dto.Tourist;

public interface TouristInterface {

	boolean insertData(Tourist t);

	boolean deleteData(Tourist t);

	boolean updateData(Tourist t);

	Tourist getTourist(int id);
	
	Tourist getTouristInfo(String email, String password);
	
	List<Tourist> getAllTourists();

	boolean deleteTouristById(int id);
	
	Tourist getTouristByEmail(String email);

}
