package com.tourist.dao;

import java.util.List;

import com.tourist.dto.Restaurant;

public interface RestaurantInterface {

	boolean insertData(Restaurant restaurant);

	boolean deleteData(Restaurant restaurant);

	boolean updateData(Restaurant restaurant);

	Restaurant getRestaurant(int id);
	
	public List<Restaurant> getRestaurantsByDestinationId(int destinationId);
	
	public List<Restaurant> getAllRestaurants();

}
