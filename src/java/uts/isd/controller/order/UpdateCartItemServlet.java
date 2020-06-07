package uts.isd.controller.order;

import uts.isd.model.OrderLineItem;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.LinkedList;

public class UpdateCartItemServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws java.io.IOException {
        HttpSession session = request.getSession();
        int ID = Integer.parseInt(request.getParameter("ID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        LinkedList<OrderLineItem> cart = (LinkedList<OrderLineItem>) session.getAttribute("cart");
        for (OrderLineItem lineItem : cart) {
            if (lineItem.getProduct().getID() == ID)
                lineItem.setQuantity(quantity);
        }

        session.setAttribute("cart", cart);

        response.sendRedirect("../cart.jsp");
    }
}