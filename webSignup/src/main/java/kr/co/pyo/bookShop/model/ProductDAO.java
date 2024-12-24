package kr.co.pyo.bookShop.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.pyo.util.ConnectionPool;

public class ProductDAO {

	public ArrayList<ProductVO> getAllProducts() {
	    ArrayList<ProductVO> products = new ArrayList<>();
	    String sql = "SELECT * FROM Product";
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        con = ConnectionPool.getInstance().dbCon();
	        pstmt = con.prepareStatement(sql);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            ProductVO product = new ProductVO();
	            product.setBookID(rs.getString("bookID"));
	            product.setBookName(rs.getString("bookName"));
	            product.setUnitPrice(rs.getInt("unitPrice"));
	            product.setDescription(rs.getString("description"));
	            product.setAuthor(rs.getString("author"));
	            product.setPublisher(rs.getString("publisher"));
	            product.setCategory(rs.getString("category"));
	            product.setUnitsInStock(rs.getLong("unitsInStock"));
	            product.setCondition(rs.getString("productCondition"));
	            product.setFilename(rs.getString("filename"));
	            products.add(product);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        closeResources(rs, pstmt, con);
	    }

	    return products;
	}

    public ProductVO getProductById(String id) {
        String sql = "SELECT * FROM Product WHERE bookID = ?";
        System.out.println("Querying product with ID: " + id); // 디버깅 메시지
        try (
            Connection con = ConnectionPool.getInstance().dbCon();
            PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            pstmt.setString(1, id);
            System.out.println("Executing query: " + sql + " with ID: " + id); // 디버깅 메시지
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ProductVO product = new ProductVO();
                    product.setBookID(rs.getString("bookID"));
                    product.setBookName(rs.getString("bookName"));
                    product.setUnitPrice(rs.getInt("unitPrice"));
                    product.setDescription(rs.getString("description"));
                    product.setAuthor(rs.getString("author"));
                    product.setPublisher(rs.getString("publisher"));
                    product.setCategory(rs.getString("category"));
                    product.setUnitsInStock(rs.getLong("unitsInStock"));
                    product.setCondition(rs.getString("productCondition"));
                    product.setFilename(rs.getString("filename"));
                    System.out.println("Product found: " + product.getBookName());
                    return product;
                } else {
                    System.out.println("No product found with ID: " + id);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addProduct(ProductVO product) {
        String sql = "INSERT INTO Product (bookID, bookName, unitPrice, description, author, publisher, category, unitsInStock, productCondition, filename, quantity) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = ConnectionPool.getInstance().dbCon();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, product.getBookID());
            pstmt.setString(2, product.getBookName());
            pstmt.setInt(3, product.getUnitPrice());
            pstmt.setString(4, product.getDescription());
            pstmt.setString(5, product.getAuthor());
            pstmt.setString(6, product.getPublisher());
            pstmt.setString(7, product.getCategory());
            pstmt.setLong(8, product.getUnitsInStock());
            pstmt.setString(9, product.getCondition());
            pstmt.setString(10, product.getFilename());
            pstmt.setInt(11, product.getQuantity());

            System.out.println("Executing query: " + sql); // 디버깅 메시지
            pstmt.executeUpdate();
            System.out.println("Product added successfully: " + product.getBookName());
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(null, pstmt, con);
        }
    }

    private void closeResources(ResultSet rs, PreparedStatement pstmt, Connection con) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) ConnectionPool.getInstance().releaseConnection(con);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
