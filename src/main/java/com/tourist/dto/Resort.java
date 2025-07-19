package com.tourist.dto;

public class Resort {
    private int resort_id;
    private int destination_id;
    private String name;
    private String description;
    private String type;
    private double rating;
    private double resort_price; // price of the resort

    public int getResort_id() {
        return resort_id;
    }

    public void setResort_id(int resort_id) {
        this.resort_id = resort_id;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }
    
    public double getResort_price() {
		return resort_price;
	}

	public void setResort_price(double resort_price) {
		this.resort_price = resort_price;
	}
    
    
}
