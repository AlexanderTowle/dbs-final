Hello user,
This manual serves to instruct the user on how to navigate around specific interfaces for Walmart’s database.


Instructions for the database administrator interface: The database administrator file is named dba.py. Once executed on the command line, the database administrator has complete freedom to execute any query or action. Before running any queries or altering any tables, the database administrator must install the mysql.connector module in case it is not already on the machine. The administrator can do so by typing ‘pip install mysql-connector-python’ on the command line. This ensures the altering of tables to be successful. After doing so, there is one limitation on how to complete any action considering the actions are run through a command line (meaning hitting enter in a query will run the entire thing even if the query is not fully written). Instead of the usual formatting used for SQL ie:
 
select v.ven_name, s.address_num, s.street, s.city, s.state, s.zip
from sells_to st
join vendor v on st.ven_name = v.ven_name
join store s on st.address_num = s.address_num 
            and st.street = s.street 
            and st.city = s.city 
            and st.state = s.state 
            and st.zip = s.zip;

The database administrator must write the action in one singular line, so it should look like this instead:
  
select v.ven_name, s.address_num, s.street, s.city, s.state, s.zip from sells_to st join vendor v on st.ven_name = v.ven_name join store s on st.address_num = s.address_num and st.street = s.street and st.city = s.city and st.state = s.state and st.zip = s.zip;

The database administrator is then told that their action was successfully ran, otherwise an error message appears in the terminal.




Instructions for the markets interface (to run OLAP queries): The markets interface to run OLAP queries is called markets.py. The interface gives the user the option to run CUBE or PIVOT operators that aren’t supported by MySQL. Once entered on the command line, the user is given a welcome message and has the option to execute either a PIVOT/CUBE operator on their desired table. The PIVOT operator transforms row-level data into columns based on aggregate functions. In this program, the user has the option to pick which table to perform the action for using the format ‘pivot your_table d1 d2 num_col’. The same logic applies to CUBE. The user is limited to two chosen columns from the chosen table to analyze and one numerical column to perform a summation.


Instructions for the customer interface: The customer interface file is called final_customer_interface.py. Upon running, a user will be prompted in the terminal to enter the location of the store they would like to shop at. A query will be made to display all products available at that store, along with their id and the price. Upon typing checkout, the products in the card will be deleted from the inventory table, the total price will be calculated, and the user will be prompted for their card information. Once entered, the transaction table will be updated and the user will be asked if they have a customer id with Walmart. If the user says no, they will be entered in the database as an anonymous customer. If the user says yes, they will be prompted for it and once entered a query is made to find their name and whether or not they are a member. If they are a member, a query will be made to find their point balance as well. A customer gets a point for every $5 they spend, and the points they earn from the current purchase are added to the total and updated in the database. Then the purchased table is updated with the transaction.


Instructions for the vendor interface: The vendor interface is a file called restocker.py, and is less of an interface and more of a program meant to run in the background at all times. Upon running, it connects to the database and constantly monitors the current time. As it is now, it is set to restock at midnight since this is part of our business rules, but this can be changed by altering the if statement on line 16 and setting it to the desired hour and minute. Upon the desired time being reached, it will query to find which store locations have product UPCs that are below the restock value for that store. Then new products of that type will be added to that store according to the quantity_ordered value for that store. The sells_to table is also updated with the date of the most recent restock.


Credits to owners:
-Alex Towle
-Danna Sandoval