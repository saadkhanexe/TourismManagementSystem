package com.tourist.dto;

public class Itinerary {
    private int itinerary_id;
    private String itinerary_day1;
    private String itinerary_day1_description;
    private String itinerary_day2;
    private String itinerary_day2_description;
    private String itinerary_day3;
    private String itinerary_day3_description;
    private String itinerary_day4;
    private String itinerary_day4_description;
    private String itinerary_day5;
    private String itinerary_day5_description;
    private int destination_id;
    private double itinerary_price;

    // Getters and Setters
    public int getItinerary_id() {
        return itinerary_id;
    }

    public void setItinerary_id(int itinerary_id) {
        this.itinerary_id = itinerary_id;
    }

    public String getItinerary_day1() {
		return itinerary_day1;
	}

	public void setItinerary_day1(String itinerary_day1) {
		this.itinerary_day1 = itinerary_day1;
	}

	public String getItinerary_day1_description() {
		return itinerary_day1_description;
	}

	public void setItinerary_day1_description(String itinerary_day1_description) {
		this.itinerary_day1_description = itinerary_day1_description;
	}

	public String getItinerary_day2() {
		return itinerary_day2;
	}

	public void setItinerary_day2(String itinerary_day2) {
		this.itinerary_day2 = itinerary_day2;
	}

	public String getItinerary_day2_description() {
		return itinerary_day2_description;
	}

	public void setItinerary_day2_description(String itinerary_day2_description) {
		this.itinerary_day2_description = itinerary_day2_description;
	}

	public String getItinerary_day3() {
		return itinerary_day3;
	}

	public void setItinerary_day3(String itinerary_day3) {
		this.itinerary_day3 = itinerary_day3;
	}

	public String getItinerary_day3_description() {
		return itinerary_day3_description;
	}

	public void setItinerary_day3_description(String itinerary_day3_description) {
		this.itinerary_day3_description = itinerary_day3_description;
	}

	public String getItinerary_day4() {
		return itinerary_day4;
	}

	public void setItinerary_day4(String itinerary_day4) {
		this.itinerary_day4 = itinerary_day4;
	}

	public String getItinerary_day4_description() {
		return itinerary_day4_description;
	}

	public void setItinerary_day4_description(String itinerary_day4_description) {
		this.itinerary_day4_description = itinerary_day4_description;
	}

	public String getItinerary_day5() {
		return itinerary_day5;
	}

	public void setItinerary_day5(String itinerary_day5) {
		this.itinerary_day5 = itinerary_day5;
	}

	public String getItinerary_day5_description() {
		return itinerary_day5_description;
	}

	public void setItinerary_day5_description(String itinerary_day5_description) {
		this.itinerary_day5_description = itinerary_day5_description;
	}

	public int getDestination_id() {
        return destination_id;
    }

    public void setDestination_id(int destination_id) {
        this.destination_id = destination_id;
    }
    
    public Double getItinerary_price() {
		return itinerary_price;
	}
    
    public void setItinerary_price(Double d) {
		this.itinerary_price = d;
    }
}
