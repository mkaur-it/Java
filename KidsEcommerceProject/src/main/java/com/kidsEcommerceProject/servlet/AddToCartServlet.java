package com.kidsEcommerceProject.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

import com.kidsEcommerceProject.DAO.ProductDao;
import com.kidsEcommerceProject.connection.DbCon;
import com.kidsEcommerceProject.model.Cart;
import com.kidsEcommerceProject.model.Products;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");

            if (idParam != null) {
                int id = Integer.parseInt(idParam);

                ProductDao productDao = new ProductDao(DbCon.getConnection());

                Products product = productDao.getSingleProduct(id);

                if (product != null) {
                    HttpSession session = request.getSession();
                    ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("cart-list");

                    if (cartList == null) {
                        cartList = new ArrayList<>();
                    }

                    boolean exist = false;

                    for (Cart c : cartList) {
                        if (c.getProductId() == id) {
                            exist = true;
                            break;
                        }
                    }

                    if (!exist) {
                        Cart cm = new Cart();
                        cm.setProductId(product.getProductID());
                        cm.setQuantity(1); // Assuming default quantity is 1
                        cm.setPrice(product.getPrice());
                        cm.setProductName(product.getProductName());
                        cm.setMainImage(product.getMainImage());

                        cartList.add(cm);
                        session.setAttribute("cart-list", cartList);

                        double totalCartPrice = 0.0;
                        if (!cartList.isEmpty()) {
                            totalCartPrice = productDao.getTotalCartPrice(cartList);
                        }

                        request.setAttribute("totalCartPrice", totalCartPrice);

                        // Redirect to Cart page if the product exists in the cart
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    } else {
                        // Redirect to Cart page if the product ID already exists in the cart
                        response.sendRedirect("cart.jsp");
                    }
                } else {
                    // Handle product not found scenario
                    System.out.println("Product not found.");
                    response.sendRedirect("error.jsp");
                }
            } else {
                // Handle missing or invalid parameters
                System.out.println("Invalid parameters received.");
                response.sendRedirect("error.jsp");
            }
        } catch (NumberFormatException e) {
            // Handle parsing errors (e.g., invalid number format)
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (Exception e) {
            // Handle other unexpected exceptions
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

}
