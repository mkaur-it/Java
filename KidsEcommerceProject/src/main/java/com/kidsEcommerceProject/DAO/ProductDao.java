package com.kidsEcommerceProject.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.kidsEcommerceProject.model.Products;
import com.kidsEcommerceProject.model.Cart;

public class ProductDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet res;

    public ProductDao(Connection con) {
        this.con = con;
    }

    public List<Products> getAllProducts() {
        List<Products> products = new ArrayList<>();
        try {
            query = "SELECT * FROM Products WHERE CategoryID != 105 ORDER BY ProductID";
            pst = this.con.prepareStatement(query);
            res = pst.executeQuery();
            while (res.next()) {
                Products row = new Products();
                row.setProductID(res.getInt("ProductID"));
                row.setProductName(res.getString("ProductName"));
                row.setPrice(res.getDouble("Price"));
                row.setCategoryID(res.getInt("CategoryID"));
                row.setMainImage(res.getString("MainImage"));
                row.setImage2(res.getString("Image2"));
                row.setImage3(res.getString("Image3"));
                row.setImage4(res.getString("Image4"));
                row.setImage5(res.getString("Image5"));
                row.setSize(res.getString("Size"));
                row.setDescription(res.getString("Description"));
                row.setStockQuantity(res.getInt("StockQuantity"));
                row.setBrandID(res.getInt("BrandID"));
                row.setSalePrice(res.getDouble("SalePrice"));
                products.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return products;
    }
    public List<Products> getAllSaleProducts() {
        List<Products> saleProducts = new ArrayList<>();
        try {
            query = "SELECT * FROM Products WHERE SalePrice != 0 ORDER BY ProductID";
            pst = this.con.prepareStatement(query);
            res = pst.executeQuery();
            while (res.next()) {
                Products row = new Products();
                row.setProductID(res.getInt("ProductID"));
                row.setProductName(res.getString("ProductName"));
                row.setPrice(res.getDouble("Price"));
                row.setCategoryID(res.getInt("CategoryID"));
                row.setMainImage(res.getString("MainImage"));
                row.setImage2(res.getString("Image2"));
                row.setImage3(res.getString("Image3"));
                row.setImage4(res.getString("Image4"));
                row.setImage5(res.getString("Image5"));
                row.setSize(res.getString("Size"));
                row.setDescription(res.getString("Description"));
                row.setStockQuantity(res.getInt("StockQuantity"));
                row.setBrandID(res.getInt("BrandID"));
                row.setSalePrice(res.getDouble("SalePrice"));
                saleProducts.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return saleProducts;
    }

    public List<Products> getAllNewProducts() {
        List<Products> newProducts = new ArrayList<>();
        try {
        	query = "SELECT * FROM Products WHERE SalePrice IS NULL ORDER BY ProductID";
            pst = this.con.prepareStatement(query);
            res = pst.executeQuery();
            while (res.next()) {
                Products row = new Products();
                row.setProductID(res.getInt("ProductID"));
                row.setProductName(res.getString("ProductName"));
                row.setPrice(res.getDouble("Price"));
                row.setCategoryID(res.getInt("CategoryID"));
                row.setMainImage(res.getString("MainImage"));
                row.setImage2(res.getString("Image2"));
                row.setImage3(res.getString("Image3"));
                row.setImage4(res.getString("Image4"));
                row.setImage5(res.getString("Image5"));
                row.setSize(res.getString("Size"));
                row.setDescription(res.getString("Description"));
                row.setStockQuantity(res.getInt("StockQuantity"));
                row.setBrandID(res.getInt("BrandID"));
                row.setSalePrice(res.getDouble("SalePrice"));
                newProducts.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return newProducts;
    }

    public List<Products> getGiftSetProducts() {
        List<Products> giftSetProducts = new ArrayList<>();
        try {
            query = "SELECT * FROM Products WHERE CategoryID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, 105); // Set CategoryID to 105 for gift sets
            res = pst.executeQuery();
            while (res.next()) {
                Products row = new Products();
                row.setProductID(res.getInt("ProductID"));
                row.setProductName(res.getString("ProductName"));
                row.setPrice(res.getDouble("Price"));
                row.setCategoryID(res.getInt("CategoryID"));
                row.setMainImage(res.getString("MainImage"));
                row.setImage2(res.getString("Image2"));
                row.setImage3(res.getString("Image3"));
                row.setImage4(res.getString("Image4"));
                row.setImage5(res.getString("Image5"));
                row.setSize(res.getString("Size"));
                row.setDescription(res.getString("Description"));
                row.setStockQuantity(res.getInt("StockQuantity"));
                row.setBrandID(res.getInt("BrandID"));
                row.setSalePrice(res.getDouble("SalePrice"));
                giftSetProducts.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return giftSetProducts;
    }

    public Products getSingleProduct(int id) {
        Products row = null;
        try {
            query = "SELECT * FROM Products WHERE ProductID=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            res = pst.executeQuery();
            while (res.next()) {
                row = new Products();
                row.setProductID(res.getInt("ProductID"));
                row.setProductName(res.getString("ProductName"));
                row.setPrice(res.getDouble("Price"));
                row.setCategoryID(res.getInt("CategoryID"));
                row.setMainImage(res.getString("MainImage"));
                row.setImage2(res.getString("Image2"));
                row.setImage3(res.getString("Image3"));
                row.setImage4(res.getString("Image4"));
                row.setImage5(res.getString("Image5"));
                row.setSize(res.getString("Size"));
                row.setDescription(res.getString("Description"));
                row.setStockQuantity(res.getInt("StockQuantity"));
                row.setBrandID(res.getInt("BrandID"));
                row.setSalePrice(res.getDouble("SalePrice"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return row;
    }

    public double getTotalCartPrice(ArrayList<Cart> cartList) {
        double sum = 0;
        try {
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    Products product = getSingleProduct(item.getProductID());
                    if (product != null) {
                        double price;
                        Double salePrice = product.getSalePrice(); // Using Double wrapper
                        
                        if (salePrice != null && salePrice != 0.0) {
                            price = salePrice * item.getQuantity();
                        } else {
                            price = product.getPrice() * item.getQuantity();
                        }
                        sum += price;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sum;
    }


    public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
        List<Cart> products = new ArrayList<>();
        try {
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    Products product = getSingleProduct(item.getProductID());
                    if (product != null) {
                        Cart cartItem = new Cart();
                        cartItem.setProductID(product.getProductID());
                        cartItem.setProductName(product.getProductName());
                        
                        Double salePrice = product.getSalePrice(); // Using Double wrapper
                        
                        double price;
                        if (salePrice != null && salePrice != 0.0) {
                            price = salePrice * item.getQuantity();
                        } else {
                            price = product.getPrice() * item.getQuantity();
                        }
                        cartItem.setPrice(price);
                        
                        cartItem.setCategoryID(product.getCategoryID());
                        cartItem.setMainImage(product.getMainImage());
                        cartItem.setQuantity(item.getQuantity());
                        products.add(cartItem);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }



}
