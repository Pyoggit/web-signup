package kr.co.pyo.order.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.pyo.bookShop.model.ProductVO;
import kr.co.pyo.util.ConnectionPool;

public class OrderDetailsDAO {
	public void insertOrder(String userId, ArrayList<ProductVO> cartList) {
        String sql = "INSERT INTO OrderDetails (orderID, userID, bookID, orderDate, quantity, totalAmount) " +
                     "VALUES (OrderDetails_SEQ.NEXTVAL, ?, ?, SYSDATE, ?, ?)";

        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            for (ProductVO product : cartList) {
                pstmt.setString(1, userId);
                pstmt.setString(2, product.getBookID());
                pstmt.setInt(3, product.getQuantity());
                pstmt.setInt(4, product.getUnitPrice() * product.getQuantity());
                pstmt.addBatch();
            }
            pstmt.executeBatch(); // 배열로 배치 처리
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<OrderVO> getOrderDetails(String userId) {
        String sql = "SELECT od.orderID, od.orderDate, p.bookName, od.quantity, od.totalAmount " +
                     "FROM OrderDetails od JOIN Product p ON od.bookID = p.bookID " +
                     "WHERE od.userID = ? ORDER BY od.orderDate DESC";

        ArrayList<OrderVO> orderList = new ArrayList<>();
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    OrderVO order = new OrderVO();
                    order.setOrderID(rs.getInt("orderID"));
                    order.setOrderDate(rs.getTimestamp("orderDate"));
                    order.setBookName(rs.getString("bookName"));
                    order.setQuantity(rs.getInt("quantity"));
                    order.setTotalAmount(rs.getInt("totalAmount"));
                    orderList.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }
}
