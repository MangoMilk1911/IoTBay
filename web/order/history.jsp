<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%--Request Scope EL Vars--%>
<%--@elvariable id="product" type="uts.isd.model.Product"--%>

<%--Session Scope EL Vars--%>
<%--@elvariable id="user" type="uts.isd.model.Customer"--%>

<head>
    <title>Product Details</title>
</head>
<jsp:include page="../templates/header.jsp"/>

<c:if test="${param.successAdd}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <p class="mb-0"><strong>Yipee! </strong>Added to cart!</p>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
</c:if>

<c:if test="${param.failAdd}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <p class="mb-0"><strong>Can't add to cart! </strong>We don't have enough left!</p>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
</c:if>

<h1 class="mb-2">Order History</h1>

<table id="historyTable" class="table table-striped">
    <thead>
    <tr>
        <th scope="col">Order ID</th>
        <th scope="col">Ordered On</th>
        <th scope="col">Status</th>
        <th scope="col">Total</th>
        <th scope="col">Details</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${user.orders}" var="order" varStatus="count">
        <tr>
            <th scope="row">#${order.ID}</th>
            <td>${order.orderedOn}</td>
            <td>${order.status}</td>
            <td>$${order.total}</td>
            <td><a href="OrderDetailsServlet?ID=${order.ID}">View</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>


<jsp:include page="../templates/footer.jsp"/>