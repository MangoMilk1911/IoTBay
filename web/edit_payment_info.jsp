<%--
    Document   : paymentmanagement
    Created on : 28/05/2020, 11:04:58 PM
    Author     : olive
--%>

<%@ page import="uts.isd.model.Customer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <title>Payment Management</title>
</head>
<jsp:include page="templates/header.jsp"/>

<div>
    <%--Shipping--%>
    <h4 class="mt-5">Shipping Address</h4>
    <div class="form-group">
        <label for="addressLine1">Address</label>
        <input type="text" class="form-control" name="addressLine1" id="addressLine1"
               placeholder="Sherman 42 Wallaby Way, Sydney" required>
    </div>
    <div class="form-group">
        <label for="addressLine2">Address 2 (Optional)</label>
        <input type="text" class="form-control" name="addressLine2" id="addressLine2">
    </div>
    <div class="form-group">
        <label for="suburb">Suburb</label>
        <input type="text" class="form-control" name="suburb" id="suburb" required>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col">
                <label for="state">State</label>
                <select class="form-control" name="state" id="state" required>
                    <option>NSW</option>
                    <option>QLD</option>
                    <option>ACT</option>
                    <option>VIC</option>
                    <option>TAS</option>
                    <option>SA</option>
                    <option>WA</option>
                    <option>NT</option>
                </select>
            </div>
            <div class="col-4">
                <label for="postcode">Postcode</label>
                <input type="number" class="form-control" name="postcode" id="postcode" required>
            </div>
        </div>
    </div>

    <%--Payment information--%>
    <h4 class="mt-5">Billing Information</h4>
    <div class="form-group">
        <label for="cardNumber">Card Number</label>
        <input type="number" class="form-control" name="cardNumber" id="cardNumber" required>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col">
                <label for="expiryMonth">Expiry Month</label>
                <input type="text" class="form-control" name="expiryMonth" id="expiryMonth" required>
            </div>
            <div class="col">
                <label for="expiryYear">Expiry Year</label>
                <input type="text" class="form-control" name="expiryYear" id="expiryYear" required>
            </div>
            <div class="col">
                <label for="cvvNumber">CVV</label>
                <input type="password" class="form-control" name="cvvNumber" id="cvvNumber" required>
            </div>
        </div>
    </div>

    <div>
        <a href="checkout.jsp"><button type="button" class="btn btn-info">Update</button></a>
    </div>
</div>


<jsp:include page="templates/footer.jsp"/>