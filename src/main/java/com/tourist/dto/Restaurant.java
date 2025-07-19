package com.tourist.dto;

public class Restaurant {
    private int restaurant_id;
    private int destination_id;
    private String name;
    private String description; // ✅ Newly added
    private String cuisine_type;
    private double rating;
    private double restaurant_price; // price of the restaurant

    public int getRestaurant_id() {
        return restaurant_id;
    }

    public void setRestaurant_id(int restaurant_id) {
        this.restaurant_id = restaurant_id;
    }

    public int getDestination_id() {
        return destination_id;
    }

    public void setDestination_id(int destination_id) {
        this.destination_id = destination_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCuisine_type() {
        return cuisine_type;
    }

    public void setCuisine_type(String cuisine_type) {
        this.cuisine_type = cuisine_type;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }
    
    	public double getRestaurant_price() {
		return restaurant_price;
	}
    	public void setRestaurant_price(double restaurant_price) {
		this.restaurant_price = restaurant_price;
	}
    @Override
	public String toString() {
		return "Restaurant{" +
				"restaurant_id=" + restaurant_id +
				", destination_id=" + destination_id +
				", name='" + name + '\'' +
				", description='" + description + '\'' +
				", cuisine_type='" + cuisine_type + '\'' +
				", rating=" + rating +
				", restaurant_price=" + restaurant_price +
				'}';
	}
}
