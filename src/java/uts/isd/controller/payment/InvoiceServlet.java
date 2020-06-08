package uts.isd.controller.payment;

import uts.isd.model.Customer;
import uts.isd.model.dao.CustomerDAO;
import uts.isd.model.dao.DAOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

public class InvoiceServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("user");


        try {
            //Use the OrderDAO to get orderID# passing in the ID of the customer
            //would use customer ID to look up any column with that ID returning the column
            //OrderDAO.getOrders(customerID); return type List
            //save what orderDAO returned into a variable
            //Store the variable onto the request
        }
        catch (DAOException err) {
            request.setAttribute("editErr", err.getMessage());
        }
        catch (SQLException err) {
            request.setAttribute("editErr", "Error accessing database.");
            err.printStackTrace();
        }
        finally {
            request.getRequestDispatcher("/invoice.jsp").include(request, response);
        }
    }
}