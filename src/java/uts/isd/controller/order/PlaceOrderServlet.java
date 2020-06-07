package uts.isd.controller.order;

import uts.isd.model.Customer;
import uts.isd.model.Order;
import uts.isd.model.OrderLineItem;
import uts.isd.model.Product;
import uts.isd.model.dao.DAOException;
import uts.isd.model.dao.OrderDAO;
import uts.isd.model.dao.ProductDAO;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.LinkedList;

public class PlaceOrderServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws java.io.IOException {
        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("user");
        LinkedList<OrderLineItem> cart = (LinkedList<OrderLineItem>) session.getAttribute("cart");

        Order order = new Order();
        order.setCustomer(user);
        order.setOrderedProducts(cart);
        order.setShippingAddress(user.getAddress().getAddressLine1());
        order.setTrackingID("123HEHEHERACKINGID");

        try {
            int newOrderID = OrderDAO.save(order);

            LinkedList<Order> customerOrders = user.getOrders();
            customerOrders.add(order);

            user.setOrders(customerOrders);

            session.setAttribute("user", user);
            session.setAttribute("cart", new LinkedList<>());

            response.sendRedirect("OrderDetailsServlet?ID=" + newOrderID + "&successAdd=true");
        } catch (DAOException err) {
            request.setAttribute("orderErr", err.getMessage());
            response.sendRedirect("cart.jsp");
        } catch (SQLException err) {
            request.setAttribute("orderErr", err.getMessage());
            err.printStackTrace();
            response.sendRedirect("cart.jsp");
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