<%--
  Created by IntelliJ IDEA.
  User: Kevin
  Date: 5/06/2020
  Time: 2:56 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="uts.isd.model.Customer" %>

<%
    Customer user = (Customer) session.getAttribute("user");
%>

<head>
    <title>Checkout</title>
</head>
<jsp:include page="templates/header.jsp"/>

<div class="max-w-md">
    <h1 class="font-weight-bold">Shopping Cart</h1>
    <table class="table">
        <thead class="thead-light">
        <tr>
            <th scope="col">Product Description</th>
            <th scope="col">SQU#</th>
            <th scope="col">QTY</th>
            <th scope="col">Price</th>
        </tr>
        </thead>

        <!--ShoppingCart List-->
        <tbody>
        <tr>
        </tr>
        </tbody>
    </table>

    <!--Subtotal of shopping Cart-->
    <table class="table">
    </table>

    <div>
        <h4 class="mt-5">Details</h4>
        <p>${user.firstName} ${user.lastName}</p>
        <p>Email: ${user.email}</p>
        <p>Phone number: ${user.contactNumber}</p>
        <p>Address: ${user.address}</p>
        <p>
            <a href="edit_payment_info.jsp"><button type="button" class="btn btn-info">Edit Payment Info</button></a>
        </p>
    </div>

    <div>
        <h4 class="mt-5">Subtotal</h4>
        <p>Sub Total Inc GST: </p>
        <p>Shipping Charge: </p>
        <p>Total: </p>
        <p>
            <a href="index.jsp"><button type="button" class="btn btn-info">Checkout</button></a>
        </p>
    </div>
</div>


<jsp:include page="templates/footer.jsp"/>
