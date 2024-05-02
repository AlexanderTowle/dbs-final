create table customer
	(
    customer_id numeric(8,0),
    email varchar(20),
    phone_num varchar(12),
    first_name varchar(15),
    last_name varchar(15),
    primary key (customer_id)
    );

create table store
	(
    address_num numeric(4,0),
    street varchar(10),
    city varchar(10),
    state varchar(2),
    zip numeric(5,0),
    open_time time,
    close_time time,
    primary key (address_num, street, city, state, zip)
    );
    
create table vendor
	(
    ven_name varchar(15),
    service_num varchar(12),
    primary key (ven_name)
    );
    
create table trans
	(
    transaction_num numeric(8,0),
    total_cost numeric(6,2),
    card_num numeric(16,0),
    transaction_date date,
    transaction_time time,
    address_num numeric(4,0),
    street varchar(10),
    city varchar(10),
    state varchar(2),
    zip numeric(5,0),
    primary key (transaction_num),
    foreign key (address_num, street, city, state, zip) references store (address_num, street, city, state, zip)
    );
    
create table brand
	(
    brand_name varchar(15),
    ven_name varchar(15),
    primary key (brand_name),
    foreign key (ven_name) references vendor (ven_name)
    );
    
create table product
	(
    product_id numeric(8,0),
    UPC numeric(12,0),
    size varchar(15),
    packaging_type varchar(12),
    product_type varchar(12),
    brand_name varchar(12),
    primary key (product_id),
    foreign key (brand_name) references brand (brand_name)
    );
    
create table member
	(
    customer_id numeric(8,0),
    point_balance numeric(6,0),
    primary key (customer_id, point_balance),
    foreign key (customer_id) references customer (customer_id)
    );
    
create table inventory
	(
	address_num numeric(4,0),
    street varchar(10),
    city varchar(10),
    state varchar(2),
    zip numeric(5,0),
    product_id numeric(8,0),
    quantity_stocked numeric(8,0),
    price numeric(6,2),
    quantity_ordered numeric(2,0),
    restock_value numeric(2,0),
    primary key (address_num, street, city, state, zip, product_id),
    foreign key (address_num, street, city, state, zip) references store (address_num, street, city, state, zip),
    foreign key (product_id) references product (product_id)
    );
    
create table purchased
	(
    transaction_num numeric(8,0),
    customer_id numeric(8,0),
    primary key (transaction_num, customer_id),
    foreign key (transaction_num) references trans (transaction_num),
    foreign key (customer_id) references customer (customer_id)
    );
    
create table ordered
	(
    product_id numeric(8,0),
    transaction_num numeric(8,0),
    primary key (product_id, transaction_num),
    foreign key (product_id) references product (product_id),
    foreign key (transaction_num) references trans (transaction_num)
    );
    
create table sells_to
	(
    ven_name varchar(15),
	address_num numeric(4,0),
    street varchar(10),
    city varchar(10),
    state varchar(2),
    zip numeric(5,0),
    primary key (ven_name, address_num, street, city, state, zip),
    foreign key (address_num, street, city, state, zip) references store (address_num, street, city, state, zip)
    );
    
create table appliance
	(
    product_id numeric(8,0),
    used_in varchar(15),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
create table gas
	(
    product_id numeric(8,0),
    horsepower numeric(3,0),
    type varchar(15),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
create table electric
	(
    product_id numeric(8,0),
    wattage numeric(3,0),
    type varchar(15),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
create table food
	(
    product_id numeric(8,0),
    calories numeric(4,0),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );

create table beverage
	(
    product_id numeric(8,0),
    calories numeric(4,0),
    fl_oz numeric(4,0),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
create table soda
	(
    product_id numeric(8,0),
    diet varchar(1),
    type varchar(15),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
create table water
	(
    product_id numeric(8,0),
    flavor varchar(15),
    carbonated varchar(1),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
create table comestible
	(
    product_id numeric(8,0),
    organic varchar(1),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
create table meat
	(
    product_id numeric(8,0),
    type varchar(15),
    free_range varchar(1),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
create table produce
	(
    product_id numeric(8,0),
    type varchar(15),
    locally_grown varchar(1),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
create table other
	(
    product_id numeric(8,0),
    type varchar(15),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
create table cleaner
	(
    product_id numeric(8,0),
    purpose varchar(15),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
create table dry_clean
	(
    product_id numeric(8,0),
    weight_grams numeric(4,0),
    type varchar(15),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
create table wet_clean
	(
    product_id numeric(8,0),
    type varchar(15),
    percent_concentration numeric(3,1),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
create table drug
	(
    product_id numeric(8,0),
    mg numeric(4,0),
    type varchar(15),
    primary key (product_id),
    foreign key (product_id) references product (product_id)
    );
    
alter table customer modify email varchar(30);
alter table store modify street varchar(30);
alter table trans modify street varchar(30);
alter table inventory modify street varchar(30);
alter table sells_to modify street varchar(30);
alter table vendor modify ven_name varchar(30);
alter table brand modify ven_name varchar(30);
alter table sells_to modify ven_name varchar(30);
alter table product modify product_type varchar(30);
alter table product modify packaging_type varchar(30);
alter table inventory drop column quantity_stocked;
alter table inventory drop column quantity_ordered;
alter table inventory drop column price;
alter table inventory drop column restock_value;
alter table inventory add column amount_stocked numeric(2,0);
update inventory set amount_stocked = 1;
alter table product add column base_price numeric(6,2);
alter table store add column restock_value numeric(2,0) default 2;
alter table store add column price_scale numeric(2,1);
alter table store add column quantity_ordered numeric(2,0) default 5;
UPDATE `com303fpad`.`product` SET `base_price` = '3.50' WHERE (`product_id` = '12345678');
UPDATE `com303fpad`.`product` SET `base_price` = '7.60' WHERE (`product_id` = '12007645');
UPDATE `com303fpad`.`product` SET `base_price` = '11.00' WHERE (`product_id` = '44433312');
UPDATE `com303fpad`.`product` SET `base_price` = '12.50' WHERE (`product_id` = '123476');
UPDATE `com303fpad`.`product` SET `base_price` = '15.00' WHERE (`product_id` = '22990989');
UPDATE `com303fpad`.`product` SET `base_price` = '9.95' WHERE (`product_id` = '87654321');
UPDATE `com303fpad`.`product` SET `base_price` = '2.94' WHERE (`product_id` = '87654323');
UPDATE `com303fpad`.`product` SET `base_price` = '3.00' WHERE (`product_id` = '23456789');
UPDATE `com303fpad`.`product` SET `base_price` = '39.88' WHERE (`product_id` = '87690012');
UPDATE `com303fpad`.`product` SET `base_price` = '459.99' WHERE (`product_id` = '56722123');
UPDATE `com303fpad`.`product` SET `base_price` = '5.00' WHERE (`product_id` = '12789887');
UPDATE `com303fpad`.`product` SET `base_price` = '40.00' WHERE (`product_id` = '98788890');
UPDATE `com303fpad`.`store` SET `price_scale` = '1.1', `quantity_ordered` = '6' WHERE (`address_num` = '12') and (`street` = 'Bank St') and (`city` = 'New London') and (`state` = 'CT') and (`zip` = '6320');
UPDATE `com303fpad`.`store` SET `restock_value` = '3', `price_scale` = '0.9' WHERE (`address_num` = '23') and (`street` = 'Travis St') and (`city` = 'Houston') and (`state` = 'TX') and (`zip` = '77080');
UPDATE `com303fpad`.`store` SET `price_scale` = '1.0', `quantity_ordered` = '8' WHERE (`address_num` = '57') and (`street` = 'Grove St') and (`city` = 'Portland') and (`state` = 'OR') and (`zip` = '97035');
UPDATE `com303fpad`.`store` SET `price_scale` = '1.2' WHERE (`address_num` = '67') and (`street` = 'Bank St') and (`city` = 'Austin') and (`state` = 'TX') and (`zip` = '78707');
UPDATE `com303fpad`.`store` SET `price_scale` = '0.8', `quantity_ordered` = '9' WHERE (`address_num` = '87') and (`street` = 'Main St') and (`city` = 'Boston') and (`state` = 'MA') and (`zip` = '2112');
UPDATE `com303fpad`.`store` SET `restock_value` = '1', `price_scale` = '1.3', `quantity_ordered` = '4' WHERE (`address_num` = '123') and (`street` = 'High St') and (`city` = 'Boston') and (`state` = 'MA') and (`zip` = '2112');
UPDATE `com303fpad`.`store` SET `price_scale` = '1.3' WHERE (`address_num` = '270') and (`street` = 'Mohegan Ave') and (`city` = 'New London') and (`state` = 'CT') and (`zip` = '6320');
