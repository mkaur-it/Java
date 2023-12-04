package com.kidsEcommerceProject.model;

import java.util.ArrayList;
import java.util.List;

public class CartItemsList {
	 private static List<Cart> itemsList;// Using List<Cart> directly

	 static {
	        // Initialize the static itemsList when the class is loaded
	        itemsList = new ArrayList<>();
	    }

	 public static List<Cart> getItemsList() {
	        return itemsList;
	    }

	 public static void setItemsList(List<Cart> itemsList) {
	        CartItemsList.itemsList = itemsList != null ? itemsList : new ArrayList<>();
	    }

	 public static void addItem(int productID, String productName, double price, double salePrice, int quantity, String mainImage) {
	        Cart newItem = new Cart();
	        newItem.setProductID(productID);
	        newItem.setProductName(productName);
	        newItem.setPrice(price);
	        newItem.setSalePrice(salePrice);
	        newItem.setQuantity(quantity);
	        newItem.setMainImage(mainImage);

	        itemsList.add(newItem);
	        System.out.println("-------------Added-----------------");
	    }
	 
	 public static void removeItem(Cart item) {
	        itemsList.remove(item);
	    }

	    public static List<OrderDetail> copyItemsToOrderDetail(long orderId) {
    	System.out.println("-----I am Called---------------" + orderId);

        List<OrderDetail> orderDetails = new ArrayList<>();
        System.out.println("-----Next line--------------size-" + itemsList.size());

        for (Cart cartItem : itemsList) {
        	System.out.println("-----IN LOOP--------------");
            OrderDetail orderDetail = new OrderDetail();
            System.out.println("-----IN LOOP--------------");
            orderDetail.setOrderID(orderId);
            // Set other details from CartItem to OrderDetail
            orderDetail.setProductID(cartItem.getProductID());
            orderDetail.setQuantity(cartItem.getQuantity());
            orderDetail.setUnitPrice(cartItem.getPrice());

            // Print the details of the added item to the console
            System.out.println("Added OrderDetail:");
            System.out.println("Order ID: " + orderDetail.getOrderID());
            System.out.println("Product ID: " + orderDetail.getProductID());
            System.out.println("Quantity: " + orderDetail.getQuantity());
            System.out.println("Unit Price: " + orderDetail.getUnitPrice());
            System.out.println("---------------------------------");

            orderDetails.add(orderDetail); // Add the OrderDetail object to the list
        }
        return orderDetails;
    }
	    
	 // Method to clear the itemsList
	    public static void clearItemsList() {
	        itemsList.clear();
	        System.out.println("---------List Cleared----------------");
	    }

}
