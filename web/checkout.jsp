<%--
  Created by IntelliJ IDEA.
  User: Kevin
  Date: 5/06/2020
  Time: 2:56 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<head>
    <title>Checkout</title>
</head>
<jsp:include page="templates/header.jsp"/>

<!--Delete-->
<c:if test="${not empty successDelete}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <p class="mb-0">Payment Information deleted successfully!</p>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
</c:if>

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
        <c:if test="${user.customer}">
            <h4 class="mt-5">Details</h4>
            <p>${user.firstName} ${user.lastName}</p>
            <p>Email: ${user.email}</p>
            <p>Phone number: ${user.contactNumber}</p>
            <p>Address: ${user.address.addressLine1}</p>
            <p>Credit Card: ${user.paymentInfo.cardNumber}</p>
            <c:choose>
                <c:when test="${empty user.paymentInfo.cardNumber || empty user.address.addressLine1}">
                    <a href="edit_payment_info.jsp" class="btn btn-primary">Add Payment Info +</a>
                </c:when>
                <c:otherwise>
                    <a href="edit_payment_info.jsp" class="btn btn-primary">Edit Payment Info</a>
                    <form class="form-inline mt-2" action="DeletePaymentServlet" method="post">
                        <button type="submit" class="btn btn-outline-danger">Remove Payment Info</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>

    <div>
        <h4 class="mt-5">Subtotal</h4>
        <p>Sub Total Inc GST: </p>
        <p>Shipping Charge: </p>
        <p>Total: </p>
        <c:choose>
            <c:when test="${empty user.paymentInfo.cardNumber || empty user.address.addressLine1}">
                <button type="button" class="btn btn-primary" disabled>Checkout</button>
                <p class="text-danger my-2">
                    <small>You need to add valid payment information before you can purchase</small>
                </p>
            </c:when>
            <c:otherwise>
                <button type="button" class="btn btn-primary">Checkout</button>
            </c:otherwise>
        </c:choose>
    </div>
</div>


<jsp:include page="templates/footer.jsp"/>
