<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%--Request Scope EL Vars--%>
<%--@elvariable id="order" type="uts.isd.model.Order"--%>

<%--Session Scope EL Vars--%>
<%--@elvariable id="user" type="uts.isd.model.Account"--%>

<head>
    <title>Product Details</title>
</head>
<jsp:include page="../templates/header.jsp"/>

<c:choose>
    <c:when test="${not empty user || user.ID == order.customer.ID || user.staff}">
        <div class="d-flex align-items-center">
            <h1 class="mr-auto">
                Order #${order.ID}
                <small class="text-secondary" style="font-size: 0.5em"><fmt:formatDate value="${order.orderedOn}"
                                                                                       pattern="MM/dd/yyyy ' at ' HH:mm a"/></small>
            </h1>
            <p class="rounded text-white bg-info px-2 py-1 font-weight-bold">${order.status}</p>
        </div>

        <div class="rounded border p-3 mt-3 mb-5">
            <p>
                <strong>Customer:</strong>
                <span class="float-right">${order.customer.ID} (${order.customer.firstName } ${order.customer.lastName})</span>
            </p>
            <p>
                <strong>Shipped To:</strong>
                <span class="float-right">${order.shippingAddress}</span>
            </p>
            <p>
                <strong>Tracking ID:</strong>
                <span class="float-right">#${order.trackingID}</span>
            </p>
            <p class="mb-0">
                <strong>Payment Card Used:</strong>
                <span class="float-right">${order.customer.paymentInfo.cardNumber}</span>
            </p>
        </div>

        <h2 class="mb-0">Items</h2>
        <c:forEach items="${order.orderedProducts}" var="lineItem" varStatus="count">
            <div class="mb-3 py-3 border-bottom row" style="min-height: 180px">
                <aside class="col-2 rounded overflow-hidden">
                    <svg class="card-img-top" style="text-anchor: middle" width="100%" height="100%"
                         xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false">
                        <title>Placeholder</title>
                        <rect width="100%" height="100%" fill="#868e96"></rect>
                        <text x="50%" y="50%" fill="#dee2e6" dy=".3em">Image</text>
                    </svg>
                </aside>

                <div class="col d-flex flex-column align-items-start pr-0">
                    <div class="row mb-auto w-100 align-items-start">
                        <div class="col-8">
                            <h4 class="display-5 p-0">
                                <small>${lineItem.quantity}x</small>
                                <strong>${lineItem.product.name}</strong>
                            </h4>
                            <a href="../products/CatalogueServlet?category=${lineItem.product.category}">${lineItem.product.category}</a>
                        </div>

                        <h3 class="col text-right display-5 font-weight-bold pr-0">
                            $<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2"
                                               value="${lineItem.sumPrice}"/>
                            <br>
                            <small class="text-secondary" style="font-size: 0.8rem">
                                $<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${lineItem.product.price}"/> / item
                            </small>
                        </h3>
                    </div>

                    <c:if test="${!user.staff}">
                        <a class="btn btn-outline-success align-self-end mr-3"
                           href="../products/ProductDetailsServlet?ID=${lineItem.product.ID}">Purchase again</a>
                    </c:if>
                </div>
            </div>
        </c:forEach>

        <h1 class="text-right mt-5">
            <small class="text-secondary" style="font-size: 0.6em">Total:</small> $<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${order.total}"/>
        </h1>
    </c:when>

    <c:otherwise>
        <div class="alert alert-danger w mx-auto" role="alert">
            <h4 class="alert-heading">Warning!</h4>
            <p>You aren't authorised to access this content. You either haven't logged in or are trying to view an order
                you didn't make.</p>
            <hr>
            <p class="mb-0">If you are a staff member, you need to log into your staff account
                <a class="alert-link" href="${pageContext.request.contextPath}/login.jsp">here</a>.
            </p>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="../templates/footer.jsp"/>