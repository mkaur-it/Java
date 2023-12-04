package com.kidsEcommerceProject.model;

public class Cart extends Products {
    private int productID;
    private String productName;
    private double price;
    private double salePrice;
    private int quantity;
    private String mainImage;

    public int getProductId() {
        return productID;
    }

    public void setProductId(int productId) {
        this.productID = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getMainImage() {
        return mainImage;
    }

    public void setMainImage(String mainImage) {
        this.mainImage = mainImage;
    }
}

