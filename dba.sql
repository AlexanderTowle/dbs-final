#dba interface
use com303fpad;
select * from product;
SELECT * FROM brand;
#query test from professor
select c.first_name, c.last_name, s.street, s.city, s.state, s.zip, t.transaction_date, p.base_price, 
count(*) as quantity_bought 
from customer c 
join purchased pu on c.customer_id = pu.customer_id
join trans t on pu.transaction_num = t.transaction_num 
join sells_to st on t.address_num = st.address_num and t.street = st.street and t.city = st.city and t.state = st.state and t.zip = st.zip 
join store s on st.address_num = s.address_num and st.street = s.street and st.city = s.city and st.state = s.state and st.zip = s.zip 
join ordered o on t.transaction_num = o.transaction_num join product p on o.product_id = p.product_id 
group by c.customer_id, t.transaction_num;

#top 20 products from each store
with ranked_prods as (
    select 
        s.address_num,
        s.street,
        s.city,
        s.state,
        s.zip,
        p.product_id,
        p.base_price,
        count(*) as total_sales,
        row_number() over (partition by s.address_num order by count(*) desc) as "rank"
    from 
        sells_to st
    join 
        trans t on st.address_num = t.address_num and st.street = t.street and st.city = t.city and st.state = t.state and st.zip = t.zip
    join 
        ordered o on t.transaction_num = o.transaction_num
    join 
        product p on o.product_id = p.product_id
    join 
        store s on st.address_num = s.address_num and st.street = s.street and st.city = s.city and st.state = s.state and st.zip = s.zip
    group by
        s.address_num, s.street, s.city, s.state, s.zip, p.product_id, p.base_price
)
select 
    address_num,
    street,
    city,
    state,
    zip,
    product_id,
    base_price,
    total_sales
from 
    ranked_prods
where 
    "rank" <= 20;
    
#top 20 prods from each state
with ranked_prods as (
    select 
        s.address_num,
        s.street,
        s.city,
        s.state,
        s.zip,
        p.product_id,
        p.base_price,
        count(*) as total_sales,
        row_number() over (partition by s.address_num order by count(*) desc) as "rank"
    from 
        sells_to st
    join 
        trans t on st.address_num = t.address_num and st.street = t.street and st.city = t.city and st.state = t.state and st.zip = t.zip
    join 
        ordered o on t.transaction_num = o.transaction_num
    join 
        product p on o.product_id = p.product_id
    join 
        store s on st.address_num = s.address_num and st.street = s.street and st.city = s.city and st.state = s.state and st.zip = s.zip
    group by
        s.address_num, s.street, s.city, s.state, s.zip, p.product_id, p.base_price
)
select 
    state,
    product_id,
    base_price,
    total_sales
from 
    ranked_prods
where 
    "rank" <= 20;
    
#5 stores with the most sales so far this year
select 
    s.address_num,
    s.street,
    s.city,
    s.state,
    s.zip,
    sum(t.total_cost) as total_sales
from 
    store s
join 
    trans t on s.address_num = t.address_num and s.street = t.street and s.city = t.city and s.state = t.state and s.zip = t.zip
where 
    year(t.transaction_date) = year(curdate())  #filtering the transactions for this year
group by
    s.address_num, s.street, s.city, s.state, s.zip
order by
    total_sales desc
limit 
    5;
    
#what if we wanna add a new product to a store. here's the dba's query:
insert into product (product_id, upc, size, packaging_type, product_type, base_price) values ('89988998', '089345533255', '4 oz', 'Metal', 'Dairy', '1.67');
insert into inventory (address_num, street, city, state, zip, product_id, amount_stocked)
values ('12', 'Bank St', 'New London', 'CT', '06320', '89988998', '5');
insert into sells_to (ven_name, address_num, street, city, state, zip)
values ('Borden', '12', 'Bank St', 'New London', 'CT', '06320');

#which vendors ship to which store
select v.ven_name, s.address_num, s.street, s.city, s.state, s.zip
from sells_to st
join vendor v on st.ven_name = v.ven_name
join store s on st.address_num = s.address_num 
            and st.street = s.street 
            and st.city = s.city 
            and st.state = s.state 
            and st.zip = s.zip;
SELECT 
    c.first_name,
    c.last_name,
    s.street,
    s.city,
    s.state,
    s.zip,
    t.transaction_date,
    p.product_id,
    p.base_price,
    COUNT(*) AS quantity_bought
FROM 
    customer c
JOIN 
    purchased pu ON c.customer_id = pu.customer_id
JOIN 
    trans t ON pu.transaction_num = t.transaction_num
JOIN 
    sells_to st ON t.address_num = st.address_num 
JOIN 
    store s ON st.address_num = s.address_num 
JOIN 
    ordered o ON t.transaction_num = o.transaction_num
JOIN 
    product p ON o.product_id = p.product_id
GROUP BY 
    c.customer_id, 
    t.transaction_num,
    p.product_id;
