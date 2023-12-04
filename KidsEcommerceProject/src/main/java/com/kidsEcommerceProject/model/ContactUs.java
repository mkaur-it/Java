package com.kidsEcommerceProject.model;

import java.util.Date;

public class ContactUs {
    private int inquiryID;
    private int userID;
    private Date inquiryDate;
    private String subject;
    private String message;

    // Constructors
    public ContactUs() {
    }

    public ContactUs(int inquiryID, int userID, Date inquiryDate, String subject, String message) {
        this.inquiryID = inquiryID;
        this.userID = userID;
        this.inquiryDate = inquiryDate;
        this.subject = subject;
        this.message = message;
    }

    // Getters and Setters
    public int getInquiryID() {
        return inquiryID;
    }

    public void setInquiryID(int inquiryID) {
        this.inquiryID = inquiryID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public Date getInquiryDate() {
        return inquiryDate;
    }

    public void setInquiryDate(Date inquiryDate) {
        this.inquiryDate = inquiryDate;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    // toString() method
    @Override
    public String toString() {
        return "ContactUs{" +
                "inquiryID=" + inquiryID +
                ", userID=" + userID +
                ", inquiryDate=" + inquiryDate +
                ", subject='" + subject + '\'' +
                ", message='" + message + '\'' +
                '}';
    }
}
