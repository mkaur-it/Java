package com.kidsEcommerceProject.model;

public class Brands {
    private int brandId;
    private String brandName;
    // Add other brand-related attributes as needed

    public Brands() {
        // Default constructor
    }

    public Brands(int brandId, String brandName) {
        this.brandId = brandId;
        this.brandName = brandName;
        // Initialize other attributes as needed
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    // Implement other getters and setters for additional attributes

    @Override
    public String toString() {
        return "Brand [brandId=" + brandId + ", brandName=" + brandName + "]";
        // Add other attributes to the string representation as needed
    }
}