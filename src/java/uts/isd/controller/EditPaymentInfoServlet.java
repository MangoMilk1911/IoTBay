package uts.isd.controller;

import uts.isd.model.Address;
import uts.isd.model.PaymentInformation;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class EditPaymentInfoServlet extends HttpServlet {
    //doGet for initialData
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

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
    }
}
