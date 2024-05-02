#dba interface
use com303fpad;
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


