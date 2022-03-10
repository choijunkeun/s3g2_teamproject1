package com.ilinbun.mulcam.dto;

public class PlaceRating {
	int id;
	Double tasteRate;
	Double priceRate;
	Double serviceRate;
	Double interiorRate;
	public PlaceRating() {}
	public PlaceRating(int id, Double tasteRate, Double priceRate, Double serviceRate, Double interiorRate) {
		super();
		this.id = id;
		this.tasteRate = tasteRate;
		this.priceRate = priceRate;
		this.serviceRate = serviceRate;
		this.interiorRate = interiorRate;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Double getTasteRate() {
		return tasteRate;
	}
	public void setTasteRate(Double tasteRate) {
		this.tasteRate = tasteRate;
	}
	public Double getPriceRate() {
		return priceRate;
	}
	public void setPriceRate(Double priceRate) {
		this.priceRate = priceRate;
	}
	public Double getServiceRate() {
		return serviceRate;
	}
	public void setServiceRate(Double serviceRate) {
		this.serviceRate = serviceRate;
	}
	public Double getInteriorRate() {
		return interiorRate;
	}
	public void setInteriorRate(Double interiorRate) {
		this.interiorRate = interiorRate;
	}
}
