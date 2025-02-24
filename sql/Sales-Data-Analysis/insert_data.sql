-- Insert into Customers
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, City, Country)
VALUES 
(1, 'Иван', 'Иванов', 'ivan.ivanov@example.com', 'Москва', 'Россия'),
(2, 'Мария', 'Петрова', 'maria.petrova@example.com', 'Санкт-Петербург', 'Россия'),
(3, 'Алексей', 'Сидоров', 'alexey.sidorov@example.com', 'Новосибирск', 'Россия');

-- Insert into Products
INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES 
(1, 'Ноутбук', 'Электроника', 1200.00),
(2, 'Смартфон', 'Электроника', 800.00),
(3, 'Наушники', 'Аксессуары', 150.00);

-- Insert into Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES 
(1, 1, '2023-10-01', 1200.00),
(2, 2, '2023-10-02', 800.00),
(3, 3, '2023-10-03', 300.00);

-- Insert into Sales
INSERT INTO Sales (SaleID, OrderID, ProductID, Quantity, SaleAmount)
VALUES 
(1, 1, 1, 1, 1200.00),
(2, 2, 2, 1, 800.00),
(3, 3, 3, 2, 300.00);
