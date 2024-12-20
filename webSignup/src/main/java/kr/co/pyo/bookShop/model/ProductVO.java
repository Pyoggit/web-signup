package kr.co.pyo.bookShop.model;

import java.io.Serializable;

public class ProductVO implements Serializable {
		private static final long serialVersionUID = -4274700572038677000L;

		private String bookID;	//도서아이디
		private String bookName;	//상품명
		private Integer unitPrice;	//상품 가격
		private String author;	//저자
		private String description;	//설명
		private String publisher;	//출판사
		private String category;	//분류
		private long unitsInStock;	//재고 수
		private long totalpages;	//페이지 수
		private String releaseDate;	//출판일
		private String condition;	//신규 or 중고 or E-Book
		private String filename;

		public ProductVO() {
			super();
		}

		public ProductVO(String bookID, String bookName, Integer unitPrice) {
			this.bookID = bookID;
			this.bookName = bookName;
			this.unitPrice = unitPrice;
		}

		public String getBookID() {
			return bookID;
		}

		public void setBookID(String bookID) {
			this.bookID = bookID;
		}

		public String getBookName() {
			return bookName;
		}

		public void setBookName(String bookName) {
			this.bookName = bookName;
		}

		public Integer getUnitPrice() {
			return unitPrice;
		}

		public void setUnitPrice(Integer unitPrice) {
			this.unitPrice = unitPrice;
		}

		public String getAuthor() {
			return author;
		}

		public void setAuthor(String author) {
			this.author = author;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}

		public String getPublisher() {
			return publisher;
		}

		public void setPublisher(String publisher) {
			this.publisher = publisher;
		}

		public String getCategory() {
			return category;
		}

		public void setCategory(String category) {
			this.category = category;
		}

		public long getUnitsInStock() {
			return unitsInStock;
		}

		public void setUnitsInStock(long unitsInStock) {
			this.unitsInStock = unitsInStock;
		}

		public long getTotalpages() {
			return totalpages;
		}

		public void setTotalpages(long totalpages) {
			this.totalpages = totalpages;
		}

		public String getReleaseDate() {
			return releaseDate;
		}

		public void setReleaseDate(String releaseDate) {
			this.releaseDate = releaseDate;
		}

		public String getCondition() {
			return condition;
		}

		public void setCondition(String condition) {
			this.condition = condition;
		}
		
		public String getFilename() {
			return filename;
		}

		public void setFilename(String filename) {
			this.filename = filename;
		}
	}
