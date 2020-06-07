package uts.isd.controller.order;

import uts.isd.model.OrderLineItem;
import uts.isd.model.Product;
import uts.isd.model.dao.DAOException;
import uts.isd.model.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.LinkedList;

public class AddToCartServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
        HttpSession session = request.getSession();
        LinkedList<OrderLineItem> cart = (LinkedList<OrderLineItem>) session.getAttribute("cart");

        int ID = Integer.parseInt(request.getParameter("ID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        try {
            Product product = ProductDAO.get(ID);

            OrderLineItem existingLineItem = productInCart(cart, product);
            if (existingLineItem != null) {
                int currentQuantity = existingLineItem.getQuantity();
                existingLineItem.setQuantity(currentQuantity + quantity);

                session.setAttribute("cart", cart);

                return;
            }

            OrderLineItem lineItem = new OrderLineItem();

            lineItem.setProduct(product);
            lineItem.setQuantity(quantity);

            cart.add(lineItem);

            session.setAttribute("cart", cart);
        }
        catch (DAOException err) {
            request.setAttribute("cartAddErr", err.getMessage());
        }
        catch (SQLException err) {
            request.setAttribute("cartAddErr", err.getMessage());
            err.printStackTrace();
        }
        finally {
            response.sendRedirect("../products/ProductDetailsServlet?ID=" + ID + "&successAdd=true");
        }
    }

    private OrderLineItem productInCart(LinkedList<OrderLineItem> cart, Product product) {
        for (OrderLineItem lineItem : cart) {
            if (lineItem.getProduct().getID() == product.getID()) {
                return lineItem;
            }
        }

        return null;
    }
}