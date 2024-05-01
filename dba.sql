#dba interface
use com303fpad;
#execute queries
#select * from inventory
select * from customer
#modify tables
#query test from professor
select
    c.first_name,
    c.last_name,
    s.address_num,
    s.street,
    s.city,
    s.state,
    s.zip,
    t.transaction_date,
    p.brand_name,
    p.size,
    i.price,
    count(o.product_id) as quantity_bought #somehow doesnt give the right quantity_bought
from 
    customer c
join 
    purchased pc on c.customer_id = pc.customer_id
join 
    trans t on pc.transaction_num = t.transaction_num
join 
    sells_to st on t.city = st.city and t.state = st.state and t.zip = st.zip
join 
    store s on st.address_num = s.address_num and st.street = s.street
join 
    ordered o on t.transaction_num = o.transaction_num
join 
    product p on o.product_id = p.product_id
join 
    inventory i on s.address_num = i.address_num and s.street = i.street and p.product_id = i.product_id
where 
    c.customer_id = "00437650"
group by
    c.first_name,
    c.last_name,
    s.address_num,
    s.street,
    s.city,
    s.state,
    s.zip,
    t.transaction_date,
    p.brand_name,
    p.size,
    i.price;