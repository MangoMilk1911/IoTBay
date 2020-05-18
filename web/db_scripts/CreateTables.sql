DROP TABLE STAFF;
DROP TABLE CUSTOMERS;
DROP TABLE ORDER_LINE;
DROP TABLE ORDERS;
DROP TABLE PRODUCTS;
DROP TABLE PRODUCT_CATEGORIES;
DROP TABLE PAYMENT_INFORMATION;
DROP TABLE ACCOUNTS;
DROP TABLE DASHBOARD_LINE_ITEMS;
DROP TABLE DASHBOARD_ITEMS;
DROP TABLE DASHBOARDS;

CREATE TABLE ACCOUNTS (
    "USER_ID" VARCHAR(50) NOT NULL,
    "USER_EMAIL" VARCHAR(50),
    "USER_F_NAME" VARCHAR(20),
    "USER_L_NAME" VARCHAR(20),
    "ACCOUNT_TYPE" VARCHAR(5),
	"PASSWORD" VARCHAR(50),
    PRIMARY KEY (USER_ID)
);

CREATE TABLE CUSTOMERS (
	"USER_ID" VARCHAR(50) NOT NULL,
	"CONTACT_NUMBER" VARCHAR(12),
	"ADDRESS_LINE_1" VARCHAR(50),
	"ADDRESS_LINE_2" VARCHAR(50),
	"SUBURB" VARCHAR(50),
	"STATE" VARCHAR(3),
	"POSTCODE" VARCHAR(4),
	"IS_ANONYMOUS" BOOLEAN,
	FOREIGN KEY ("USER_ID") REFERENCES ACCOUNTS ("USER_ID"),
	PRIMARY KEY ("USER_ID")
);

CREATE TABLE STAFF (
	"USER_ID" VARCHAR(50) NOT NULL,
	"IS_ADMIN" BOOLEAN,
	FOREIGN KEY ("USER_ID") REFERENCES ACCOUNTS ("USER_ID"),
	PRIMARY KEY ("USER_ID")
);

CREATE TABLE PAYMENT_INFORMATION (
	"CARD_NUMBER" VARCHAR(50) NOT NULL,
	"USER_ID" VARCHAR(50) NOT NULL,
	"CVV_NUMBER" VARCHAR(50),
	"EXPIRY_MONTH" VARCHAR(50),
	"EXPIRY_YEAR" VARCHAR(50),
	PRIMARY KEY (CARD_NUMBER),
	FOREIGN KEY (USER_ID) REFERENCES ACCOUNTS (USER_ID)
);

CREATE TABLE ORDERS (
	"ORDER_ID" VARCHAR(50) NOT NULL, 
	"ORDER_DATE_TIME" TIMESTAMP,
	"ORDER_SHIPPING_ADDRESS" VARCHAR(255),
	"ORDER_TOTAL" DOUBLE,
	"USER_ID" VARCHAR(50),
	"TRACKING_ID" VARCHAR(30),
	"CARD_NUMBER" VARCHAR(50),
	PRIMARY KEY (ORDER_ID),
	FOREIGN KEY (USER_ID) REFERENCES ACCOUNTS (USER_ID),
	FOREIGN KEY (CARD_NUMBER) REFERENCES PAYMENT_INFORMATION (CARD_NUMBER)
);

CREATE TABLE PRODUCT_CATEGORIES (
	"PRODUCT_CATEGORY" VARCHAR(50) NOT NULL,
	"ARCHIVED" BOOLEAN,
	PRIMARY KEY (PRODUCT_CATEGORY)
);

CREATE TABLE PRODUCTS (
	"PRODUCT_ID" VARCHAR(50),
	"PRODUCT_NAME" VARCHAR(255),
	"STOCK" INTEGER,
	"PRODUCT_PRICE" DOUBLE,
	"PRODUCT_CATEGORY" VARCHAR(50),
	"PRODUCT_DESCRIPTION" VARCHAR(255),
	"ARCHIVED" BOOLEAN,
    PRIMARY KEY (PRODUCT_ID),
	FOREIGN KEY (PRODUCT_CATEGORY) REFERENCES PRODUCT_CATEGORIES (PRODUCT_CATEGORY)
);

CREATE TABLE ORDER_LINE (
	"ORDER_ID" VARCHAR(50), 
	"PRODUCT_ID" VARCHAR(50),
	"QUANTITY_ORDERED" INTEGER,
	"PRODUCT_PRICE" DOUBLE,
	FOREIGN KEY (ORDER_ID) REFERENCES ORDERS (ORDER_ID),
	FOREIGN KEY(PRODUCT_ID) REFERENCES PRODUCTS (PRODUCT_ID),
	PRIMARY KEY (ORDER_ID, PRODUCT_ID)
);

/* 	Creation Scripts for Dashboard & BI Configuration */

CREATE TABLE DASHBOARDS (
	"DASHBOARD_ID" VARCHAR(50),
	"DASHBOARD_NAME" VARCHAR(50),
	"DASHBOARD_DESCRIPTION" VARCHAR(255),
	PRIMARY KEY (DASHBOARD_ID)
);

CREATE TABLE DASHBOARD_ITEMS (
	"ITEM_ID" VARCHAR(50) NOT NULL,
	"ITEM_NAME" VARCHAR(50),
	"ITEM_DESCRIPTION" VARCHAR(255),
	PRIMARY KEY (ITEM_ID)
);

CREATE TABLE DASHBOARD_LINE_ITEMS (
	"DASHBOARD_ID" VARCHAR(50),
	"ITEM_ID" VARCHAR(50),
	FOREIGN KEY (DASHBOARD_ID) REFERENCES DASHBOARDS (DASHBOARD_ID),
	FOREIGN KEY (ITEM_ID) REFERENCES DASHBOARD_ITEMS (ITEM_ID),
	PRIMARY KEY (DASHBOARD_ID, ITEM_ID)
);