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
        } catch (DAOException err) {
            request.setAttribute("loginErr", err.getMessage());
        } catch (SQLException err) {
            request.setAttribute("loginErr", "Error accessing database.");
            err.printStackTrace();
        } finally {
            request.getRequestDispatcher("/edit_payment_info.jsp").include(request, response);
        }
    }

    //doPost for updating Data
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Validator validator = new Validator(request);

        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("user");

        String addressLine1 = request.getParameter("addressLine1");
        String addressLine2 = request.getParameter("addressLine2");
        String suburb = request.getParameter("suburb");
        String postcode = request.getParameter("postcode");
        String state = request.getParameter("state");
        String cardNumber = request.getParameter("cardNumber");
        String expiryMonth = request.getParameter("expiryMonth");
        String expiryYear = request.getParameter("expiryYear");
        String cvvNumber = request.getParameter("cvvNumber");

        user.getAddress().setAddressLine1(addressLine1);
        user.getAddress().setAddressLine2(addressLine2);
        user.getAddress().setSuburb(suburb);
        user.getAddress().setPostcode(postcode);
        user.getAddress().setState(state);
        user.getPaymentInfo().setCardNumber(cardNumber);
        user.getPaymentInfo().setCvvNumber(cvvNumber);
        user.getPaymentInfo().setExpiryMonth(expiryMonth);
        user.getPaymentInfo().setExpiryYear(expiryYear);


        try {
            CustomerDAO.update((user));
            request.setAttribute("successEdit", true);
            Account account = (Account) session.getAttribute("user");
            Customer customerDetails = CustomerDAO.get(account.getEmail(), account.getPassword());
            request.setAttribute("customerDetails", customerDetails);
        } catch (DAOException err) {
            request.setAttribute("loginErr", err.getMessage());
        } catch (SQLException err) {
            request.setAttribute("loginErr", "Error accessing database.");
            err.printStackTrace();
        } finally {
            request.getRequestDispatcher("/edit_payment_info.jsp").include(request, response);
        }
    }
}
