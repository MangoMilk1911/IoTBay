<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="uts.isd.model.Customer" %>

<%
    Customer user = (Customer) session.getAttribute("user");
%>

<header class="navbar navbar-expand-md navbar-light bg-light mb-5">
    <div class="container">
        <a class="navbar-brand h1 mb-0 font-weight-bold" href="${pageContext.request.contextPath}/index.jsp">IoT Bay</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <div class="navbar-nav mr-auto">
                <a class="nav-item nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <a class="nav-item nav-link" href="${pageContext.request.contextPath}/main.jsp">Main</a>
                <% if (user != null) { %>
                <a class="nav-item nav-link" href="${pageContext.request.contextPath}/edit.jsp">Edit Profile</a>
                <% } else { %>
                <a class="nav-item nav-link" href="${pageContext.request.contextPath}/register.jsp">Register</a>
                <% } %>
            </div>

            <% if (user != null) { %>
            <a class="btn btn-outline-dark my-2 my-sm-0" href="${pageContext.request.contextPath}/logout.jsp"
               role="button">Logout</a>
            <% } else { %>
            <a class="btn btn-outline-dark my-2 my-sm-0" href="${pageContext.request.contextPath}/login.jsp"
               role="button">Login</a>
            <% } %>
        </div>
    </div>
</header>