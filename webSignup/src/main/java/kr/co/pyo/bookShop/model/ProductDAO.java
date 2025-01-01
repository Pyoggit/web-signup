package kr.co.pyo.bookShop.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.pyo.util.ConnectionPool;

public class ProductDAO {

    // 전체 상품 가져오기
    public ArrayList<ProductVO> getAllProducts() {
        ArrayList<ProductVO> products = new ArrayList<>();
        String sql = "SELECT * FROM Product";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                ProductVO product = mapProduct(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // 특정 상품 가져오기
    public ProductVO getProductById(String id) {
        String sql = "SELECT * FROM Product WHERE bookID = ?";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapProduct(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 상품 추가
    public void addProduct(ProductVO product) {
        String sql = "INSERT INTO Product (bookID, bookName, unitPrice, description, author, publisher, category, unitsInStock, productCondition, filename, quantity) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
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
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 전체 상품 개수 가져오기
    public int getTotalProductCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Product";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // 특정 페이지 상품 가져오기
    public ArrayList<ProductVO> getProductsByPage(int startIndex, int pageSize) {
        ArrayList<ProductVO> products = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT a.*, ROWNUM rnum FROM Product a WHERE ROWNUM <= ?) WHERE rnum > ?";
        try (Connection conn = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, startIndex + pageSize); // 종료 인덱스
            pstmt.setInt(2, startIndex); // 시작 인덱스
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ProductVO product = new ProductVO();
                    product.setBookID(rs.getString("bookID"));
                    product.setBookName(rs.getString("bookName"));
                    product.setAuthor(rs.getString("author"));
                    product.setPublisher(rs.getString("publisher"));
                    product.setCategory(rs.getString("category"));
                    product.setFilename(rs.getString("filename"));
                    product.setUnitPrice(rs.getInt("unitPrice"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public ArrayList<ProductVO> searchProductsByName(String keyword) {
        ArrayList<ProductVO> products = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE bookName LIKE ?";
        try (Connection con = ConnectionPool.getInstance().dbCon();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, "%" + keyword + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ProductVO product = new ProductVO();
                    product.setBookID(rs.getString("bookID"));
                    product.setBookName(rs.getString("bookName"));
                    product.setAuthor(rs.getString("author"));
                    product.setPublisher(rs.getString("publisher"));
                    product.setCategory(rs.getString("category"));
                    product.setFilename(rs.getString("filename"));
                    product.setUnitPrice(rs.getInt("unitPrice"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }



    // ResultSet을 ProductVO로 매핑
    private ProductVO mapProduct(ResultSet rs) throws SQLException {
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
