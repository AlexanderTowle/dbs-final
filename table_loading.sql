
create table customer
	(
    customer_id numeric(8,0),
    email varchar(20),
    phone_num varchar(12),
    first_name varchar(15),
    last_name varchar(15),
    primary key (customer_id)
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
    foreign key (address_num) references store (address_num),
    foreign key (street) references store (street),
    foreign key (city) references store (city),
    foreign key (state) references store (state),
    foreign key (zip) references store (zip)
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
    
create table brand
	(
    brand_name varchar(15),
    ven_name varchar(15),
    primary key (brand_name),
    foreign key (ven_name) references vendor (ven_name)
    );
    
create table vendor
	(
    ven_name varchar(25),
    service_num varchar(12),
    primary key (ven_name)
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
	foreign key (address_num) references store (address_num),
    foreign key (street) references store (street),
    foreign key (city) references store (city),
    foreign key (state) references store (state),
    foreign key (zip) references store (zip),
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
    foreign key (ven_name) references vendor (ven_name),
	foreign key (address_num) references store (address_num),
    foreign key (street) references store (street),
    foreign key (city) references store (city),
    foreign key (state) references store (state),
    foreign key (zip) references store (zip)
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
    foreign key (address_num, street, city, state, zip) references store (address_num, street, city, state, zip)
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
