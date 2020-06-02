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


<% { %>
    <%--Payment information--%>
<div>
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
</div>
<% } %>

<jsp:include page="templates/footer.jsp"/>