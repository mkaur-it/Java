package com.kidsEcommerceProject.model;

import java.util.Date;

public class ProductReview {
    private int reviewID;
    private int productID;
    private int userID;
    private Date reviewDate;
    private int rating;
    private String reviewComment;

    // Constructors
    public ProductReview() {
    }

    public ProductReview(int reviewID, int productID, int userID, Date reviewDate, int rating, String reviewComment) {
        this.reviewID = reviewID;
        this.productID = productID;
        this.userID = userID;
        this.reviewDate = reviewDate;
        this.rating = rating;
        this.reviewComment = reviewComment;
    }

    // Getters and Setters
    public int getReviewID() {
        return reviewID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getReviewComment() {
        return reviewComment;
    }

    public void setReviewComment(String reviewComment) {
        this.reviewComment = reviewComment;
    }

    // toString() method
    @Override
    public String toString() {
        return "ProductReview{" +
                "reviewID=" + reviewID +
                ", productID=" + productID +
                ", userID=" + userID +
                ", reviewDate=" + reviewDate +
                ", rating=" + rating +
                ", reviewComment='" + reviewComment + '\'' +
                '}';
    }
}
