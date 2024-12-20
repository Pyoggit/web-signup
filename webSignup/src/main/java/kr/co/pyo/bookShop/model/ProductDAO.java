package kr.co.pyo.bookShop.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.pyo.signup.util.ConnectionPool;

public class ProductDAO {

    public ArrayList<ProductVO> getAllProducts() {
        ArrayList<ProductVO> products = new ArrayList<>();
        String sql = "SELECT * FROM Product";

        try (
            Connection con = ConnectionPool.getInstance().dbCon();
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()
        ) {
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
        }

        return products;
    }

    public ProductVO getProductById(String id) {
        String sql = "SELECT * FROM Product WHERE bookID = ?";
        try (
            Connection con = ConnectionPool.getInstance().dbCon();
            PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
            pstmt.setString(1, id);
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
                    return product;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // ID가 존재하지 않을 경우 null 반환
    }

    public void addProduct(ProductVO product) {
        String sql = "INSERT INTO Product (bookID, bookName, unitPrice, description, author, publisher, category, unitsInStock, productCondition, filename) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection con = ConnectionPool.getInstance().dbCon();
            PreparedStatement pstmt = con.prepareStatement(sql)
        ) {
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

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
