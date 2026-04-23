CREATE DATABASE BookStoreDB;
USE BookStoreDB;

CREATE TABLE Category (
	category_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

CREATE TABlE Book (
	book_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    status INT DEFAULT 1,
    publish_date DATE,
    price DECIMAL(10,2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE BookOrder (
	order_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    book_id INT, 
    FOREIGN KEY (book_id) REFERENCES Book(book_id) ON DELETE CASCADE,
    order_date DATE DEFAULT (CURRENT_DATE),
    delivery_date DATE
);

ALTER TABLE Book
ADD author_name VARCHAR(100) NOT NULL;

ALTER TABLE BookOrder 
MODIFY customer_name VARCHAR(200);

ALTER TABLE BookOrder
ADD CHECK(delivery_date > order_date);

INSERT INTO Category VALUES
	(1, 'IT & Tech', 'Sách lập trình'),
    (2, 'Business', 'Sách kinh doanh'),
    (3, 'Novel', 'Tiểu thuyết');
    
INSERT INTO Book VALUES
	(1, 'Clean Code', 1, '2020-05-10', 500000, 1, 'Robert C. Martin'),
    (2, 'Đắc Nhân Tâm', 0, '2018-08-20', 150000, 2, 'Dale Carnrnegie'),
    (3, 'JavaScript Nâng Cao', 1, '2023-01-15', 350000, 1, 'KyKyle Simpson'),
    (4, 'Nhà Giả Kim', 0, '2015-11-25', 120000, 3, 'Paulo Coelho');
	
INSERT INTO BookOrder VALUES
	(101, 'Nguyen Hai Nam', 1, '2025-01-10', '2025-01-15'),
    (102, 'Tran Bao Ngoc', 3, '2025-02-05', '2025-02-10'),
    (103, 'Le Hoang Yen', 4, '2025-03-12', NULL);
    
UPDATE BOOK 
SET price = price + 50000
WHERE category_id = 1;

UPDATE BookOrder
SET delivery_date = '2025-12-31'
WHERE delivery_date IS NULL;

DELETE FROM BookOrder
WHERE order_date < '2025-02-01';

SELECT * FROM Category;
SELECT * FROM Book;
SELECT * FROM BookOrder;

SELECT title, author_name,
CASE
	WHEN status = 1 THEN 'Còn hàng'
    ELSE 'Hết hàng'
END AS status_name
FROM Book;

SELECT 
	UPPER(title) AS title_upper,
    (YEAR(NOW()) - YEAR(publish_date)) AS book_age
FROM Book;

SELECT b.title, b.price, c.category_name
FROM Book AS b
JOIN Category AS c ON b.category_id = c.category_id;

SELECT * FROM Book
ORDER BY price DESC
LIMIT 2;

SELECT c.category_name
FROM Book AS b
JOIN Category AS c ON b.category_id = c.category_id
GROUP BY c.category_id
HAVING COUNT(c.category_id) >=2;
