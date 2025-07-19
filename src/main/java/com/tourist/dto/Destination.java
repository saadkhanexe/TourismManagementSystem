package com.tourist.dto;

public class Destination {
	private int destination_id;
	private String destination_name;
	private String destination_description;
	private String destination_paragraph;
	private double destination_price;
	private String destination_image;
	private String destination_rating;

	public int getDestination_id() {
		return destination_id;
	}

	public void setDestination_id(int destination_id) {
		this.destination_id = destination_id;
	}

	public String getDestination_name() {
		return destination_name;
	}

	public void setDestination_name(String destination_name) {
		this.destination_name = destination_name;
	}

	public String getDestination_description() {
		return destination_description;
	}

	public void setDestination_description(String destination_description) {
		this.destination_description = destination_description;
	}

	public String getDestination_paragraph() {
		return destination_paragraph;
	}

	public void setDestination_paragraph(String destination_paragraph) {
		this.destination_paragraph = destination_paragraph;
	}

	public double getDestination_price() {
		return destination_price;
	}

	public void setDestination_price(double d) {
		this.destination_price = d;
	}

	public String getDestination_image() {
		return destination_image;
	}

	public void setDestination_image(String destination_image) {
		this.destination_image = destination_image;
	}

	public String getDestination_rating() {
		return destination_rating;
	}

	public void setDestination_rating(String destination_rating) {
		this.destination_rating = destination_rating;
	}

}
