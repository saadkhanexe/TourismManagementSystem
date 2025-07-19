package com.tourist.dto;

import java.sql.Date;

public class Booking {

    private int bookingId;
    private int tourist_id;
    private int destination_id;
    private int resort_id;
    private int restaurant_id;
    private int itinerary_id; // optional link to Itinerary
    private Date booking_date;
    private String status;
    private double price; // total calculated price
    private String remarks;
//    private Date travel_date;
//    private int numPassengers;

    // Constructors
    public Booking() {}

    public Booking(int bookingId, int tourist_id, int destination_id, int resort_id, int restaurant_id, int itinerary_id, Date booking_date, String status, double price, String remarks) {
        this.bookingId = bookingId;
        this.tourist_id = tourist_id;
        this.destination_id = destination_id;
        this.resort_id = resort_id;
        this.restaurant_id = restaurant_id;
        this.itinerary_id = itinerary_id;
        this.booking_date = booking_date;
        this.status = status;
        this.price = price;
        this.remarks = remarks;
//        this.travel_date = travel_date;
//        this.numPassengers = numPassengers;
    }

    public Booking(int tourist_id, int destination_id, int resort_id, int restaurant_id, int itinerary_id, Date booking_date, String status, double price, String remarks) {
        this.tourist_id = tourist_id;
        this.destination_id = destination_id;
        this.resort_id = resort_id;
        this.restaurant_id = restaurant_id;
        this.itinerary_id = itinerary_id;
        this.booking_date = booking_date;
        this.status = status;
        this.price = price;
        this.remarks = remarks;
//        this.travel_date = travel_date;
//        this.numPassengers = numPassengers;
    }

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getTourist_id() {
        return tourist_id;
    }

    public void setTourist_id(int tourist_id) {
        this.tourist_id = tourist_id;
    }

    public int getDestination_id() {
        return destination_id;
    }

    public void setDestination_id(int destination_id) {
        this.destination_id = destination_id;
    }

    public int getResort_id() {
        return resort_id;
    }

    public void setResort_id(int resort_id) {
        this.resort_id = resort_id;
    }

    public int getRestaurant_id() {
        return restaurant_id;
    }

    public void setRestaurant_id(int restaurant_id) {
        this.restaurant_id = restaurant_id;
    }

    public int getItinerary_id() {
        return itinerary_id;
    }

    public void setItinerary_id(int itinerary_id) {
        this.itinerary_id = itinerary_id;
    }

    public Date getBooking_date() {
        return booking_date;
    }

    public void setBooking_date(Date booking_date) {
        this.booking_date = booking_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

//	public Date getTravel_date() {
//		return travel_date;
//	}
//	
//	public void setTravel_date(Date travel_date) {
//		this.travel_date = travel_date;
//	}
//	
//	public int getNumPassengers() {
//		return numPassengers;
//	}
//	
//	public void setNumPassengers(int numPassengers) {
//		this.numPassengers = numPassengers;
//	}
}
