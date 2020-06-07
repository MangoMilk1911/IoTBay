<%--
  Created by IntelliJ IDEA.
  User: Kevin
  Date: 7/06/2020
  Time: 9:22 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <title>Invoice</title>
</head>
<jsp:include page="templates/header.jsp"/>


<h1 class="mb-2">Invoice Statements</h1>

<h2 class="mb-5"> Search an Invoice</h2>

<div class="container-fluid">
    <form action="/IoTBay/InvoiceServlet" method="get">
        <table>
            <tr>
                <td><input class="form-control-sm mb-2 mr-2 border border-secondary" name="productId" placeholder="Product Id">
                </td>
            </tr>
            <tr>
                <td><input class="form-control-sm mb-2 mr-2 border border-secondary" name="date" placeholder="Date">
                </td>
            </tr>
            <tr>
                <td><button type="submit" class="btn btn-info btn-sm my-2">Search</button></td>
            </tr>
        </table>
    </form>

    <h2> ${user.firstName} ${user.lastName} </h2>
    <div style="max-height: 400px;" class="table-responsive overflow-auto table-light">
        <table class="table text-dark">

            <tr class="d-flex table-info">
                <th class="col">ProductID #</th>
                <th class="col">Email</th>
                <th class="col">Contact Number</th>
                <th class="col">Address</th>
                <th class="col">Payment Info</th>
            </tr>

        </table>
    </div>
</div>