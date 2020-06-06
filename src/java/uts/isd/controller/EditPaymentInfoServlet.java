package uts.isd.controller;

import uts.isd.model.Account;
import uts.isd.model.Address;
import uts.isd.model.Customer;
import uts.isd.model.PaymentInformation;
import uts.isd.model.dao.CustomerDAO;
import uts.isd.model.dao.DAOException;

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
            request.getRequestDispatcher("/edit_payment_info.jsp").include(request, response);
        }
    }

    //doPost for updating Data
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Address address = new Address();
        address.setAddressLine1(request.getParameter("addressLine1"));
        address.setAddressLine2(request.getParameter("addressLine1"));
        address.setSuburb(request.getParameter("suburb"));
        address.setPostcode(request.getParameter("postcode"));
        address.setState(request.getParameter("state"));


        PaymentInformation paymentInfo = new PaymentInformation();
        paymentInfo.setCardNumber(request.getParameter("cardNumber"));
        paymentInfo.setCvvNumber(request.getParameter("cvvNumber"));
        paymentInfo.setExpiryMonth(request.getParameter("expiryMonth"));
        paymentInfo.setExpiryYear(request.getParameter("expiryYear"));

        //Update and store the new data into the DAO

    }
}
