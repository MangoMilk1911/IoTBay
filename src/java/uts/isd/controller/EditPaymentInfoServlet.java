package uts.isd.controller;

import uts.isd.model.Account;
import uts.isd.model.Address;
import uts.isd.model.Customer;
import uts.isd.model.PaymentInformation;
import uts.isd.model.dao.CustomerDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

public class EditPaymentInfoServlet extends HttpServlet {
    //doGet for initialData
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Account account = (Account) session.getAttribute("user");
            Customer customerDetails = CustomerDAO.get(account.getEmail(), account.getPassword());
            request.setAttribute("customerDetails", customerDetails);
        }
        catch (DAOException err) {
            request.setAttribute("loginErr", err.getMessage());
        }
        catch (SQLException err) {
            request.setAttribute("loginErr", "Error accessing database.");
            err.printStackTrace();
        }
        finally {
            request.getRequestDispatcher("/logs.jsp").include(request, response);
        }
    }

    //doPost for updating Data
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Address address = new Address(
                request.getParameter("addressLine1"),
                request.getParameter("addressLine2"),
                request.getParameter("suburb"),
                request.getParameter("postcode"),
                request.getParameter("state")
        );

        PaymentInformation paymentInfo = new PaymentInformation(
                request.getParameter("cardNumber"),
                request.getParameter("cvvNumber"),
                request.getParameter("expiryMonth"),
                request.getParameter("expiryYear")
        );

        //Update and store the new data into the DAO

    }
}
