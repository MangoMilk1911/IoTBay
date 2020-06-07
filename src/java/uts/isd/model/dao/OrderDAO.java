package uts.isd.model.dao;

import uts.isd.model.Customer;
import uts.isd.model.Order;
import uts.isd.model.OrderLineItem;
import uts.isd.model.Product;

import java.sql.*;
import java.util.LinkedList;

public class OrderDAO {
    public static Order get(int orderID) throws SQLException, DAOException {
        String getStaffDataQuery = "SELECT * FROM ORDERS O WHERE O.ID = " + orderID;
        PreparedStatement st = DAOUtils.prepareStatement(getStaffDataQuery, false);
        ResultSet orderRs = st.executeQuery();

        if (!orderRs.next())
            throw new DAOException("No Order with that ID exists.");

        return createOrderObject(orderRs);
    }

    public static LinkedList<Order> getAll() throws SQLException {
        LinkedList<Order> orders = new LinkedList<>();

        String getOrdersQuery = "SELECT * FROM ORDERS";
        PreparedStatement st = DAOUtils.prepareStatement(getOrdersQuery, false);
        ResultSet ordersRs = st.executeQuery();

        while (ordersRs.next()) {
            orders.add(createOrderObject(ordersRs));
        }

        return orders;
    }

    public static int save(Order order) throws SQLException, DAOException {
        LinkedList<OrderLineItem> orderedProducts = order.getOrderedProducts();

        double total = 0;
        for (OrderLineItem lineItem : orderedProducts) {
            total += lineItem.getSumPrice();
        }

        String staffInsertQuery =
                "INSERT INTO ORDERS (CUSTOMER_ID, ORDERED_ON, SHIPPING_ADDRESS, TOTAL, STATUS, TRACKING_ID) " +
                "VALUES (?, CURRENT_TIMESTAMP, ?, ?, ?, ?) ";

        PreparedStatement orderInsertSt = DAOUtils.prepareStatement(staffInsertQuery, false,
                order.getCustomer().getID(),
                order.getShippingAddress(),
                total,
                "pending",
                order.getTrackingID()
        );

        int rowsChanged = orderInsertSt.executeUpdate();
        if (rowsChanged == 0)
            throw new DAOException("Failed to create order. Please try again.");

        return DAOUtils.getGeneratedID(orderInsertSt);
    }

    /**
     * Update a single order from the database.
     *
     * @param order The instantiated order to update. Must have an ID.
     */
    public static void update(Order order) throws SQLException, DAOException {
        LinkedList<OrderLineItem> orderedProducts = order.getOrderedProducts();

        double newTotal = 0;
        for (OrderLineItem lineItem : orderedProducts) {
            newTotal += lineItem.getSumPrice();
        }

        String updateQuery =
                "UPDATE ORDERS SET STATUS = ?, SHIPPING_ADDRESS = ?, TOTAL = ?, TRACKING_ID = ? " +
                "WHERE ID = " + order.getID();

        PreparedStatement updateSt = DAOUtils.prepareStatement(updateQuery, false,
                order.getStatus(),
                order.getShippingAddress(),
                newTotal,
                order.getTrackingID()
        );

        int rowsChanged = updateSt.executeUpdate();
        if (rowsChanged == 0)
            throw new DAOException("Failed to update order details. Please try again.");
    }

    // Helpers
    private static Order createOrderObject(ResultSet orderRs) throws SQLException, DAOException {
        Order order = new Order();

        Customer customer = CustomerDAO.get(orderRs.getInt("CUSTOMER_ID"));

        order.setID(orderRs.getInt("ID"));
        order.setCustomer(customer);
        order.setOrderedOn(orderRs.getDate("ORDERED_ON"));
        order.setTotal(orderRs.getInt("TOTAL"));
        order.setTrackingID(orderRs.getString("TRACKING_ID"));
        order.setStatus(orderRs.getString("STATUS"));
        order.setShippingAddress(orderRs.getString("SHIPPING_ADDRESS"));

        LinkedList<OrderLineItem> orderedProducts = new LinkedList<>();

        String getProductsQuery = "SELECT * FROM ORDER_LINE OL WHERE OL.ORDER_ID = " + order.getID();
        PreparedStatement getProductsSt = DAOUtils.prepareStatement(getProductsQuery, false);
        ResultSet productsRs  = getProductsSt.executeQuery();

        while (productsRs.next()) {
            Product product = ProductDAO.get(productsRs.getInt("PRODUCT_ID"));
            int quantity = productsRs.getInt("QUANTITY");

            OrderLineItem lineItem = new OrderLineItem();

            lineItem.setProduct(product);
            lineItem.setQuantity(quantity);

            orderedProducts.add(lineItem);
        }

        order.setOrderedProducts(orderedProducts);

        return order;
    }
}
