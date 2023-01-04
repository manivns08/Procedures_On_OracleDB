procedure Data_Link
is
begin

INSERT INTO CustomerProductCategory (CustomerName, ProductName, CategoryName)
SELECT Customers.Customer_Name AS CustomerName, Product.Product_Name AS ProductN
ame, Product_Categories.Category_Name AS CategoryName

FROM Customers
JOIN Product ON Customers.Cus_id = Product.CUSTOMER_ID
JOIN Product_Categories ON Product.prod_id = Product_Categories.P_PROD_ID;
end;
