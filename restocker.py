import mysql.connector
from mysql.connector import Error
from datetime import datetime
import time

#try to connect
try:
    cnx = mysql.connector.connect(user='com303atowle', password='at2289at',
                                  host='136.244.224.221',
                                  database='com303fpad')
    if cnx.is_connected():
        while True:
            current_datetime = datetime.now()
            current_date = datetime.now().date()
            #Only update at specified time
            if current_datetime.hour == 0 and current_datetime.minute == 0:
                print("restock")
                #Stuff that needs restocking
                inventory_cursor = cnx.cursor()
                inventory_query = """
                select i.address_num, i.street, i.city, i.state, i.zip, p.UPC, s.restock_value, s.quantity_ordered, count(p.UPC) as upc_count, p.size, p.packaging_type, p.product_type, p.brand_name, p.base_price 
                from inventory i join product p on (i.product_id = p.product_id) join store s on i.address_num = s.address_num and i.street = s.street and i.city = s.city and i.state = s.state and i.zip = s.zip 
                group by i.address_num, i.street, i.city, i.state, i.zip, p.UPC, p.size, p.packaging_type, p.product_type, p.brand_name, p.base_price 
                having upc_count < s.restock_value
                """
                inventory_cursor.execute(inventory_query)
                restocking = inventory_cursor.fetchall()
                
                #for each thing that needs restocking add more stock in the inventory, update the date sold, and add products with new ids
                for item in restocking:
                    address_num = item[0]
                    street = item[1]
                    city = item[2]
                    state = item[3]
                    zip = item[4]
                    upc = item[5]
                    restock_value = item[6]
                    quantity_ordered = item[7]
                    count = item[8]
                    size = item[9]
                    packaging_type = item[10]
                    product_type = item[11]
                    brand_name = item[12]
                    base_price = item[13]

                    #add new products
                    id_generation_query = "select max(product_id) from product"
                    inventory_cursor.execute(id_generation_query)
                    max_product_id = inventory_cursor.fetchone()[0]
                    for i in range(int(quantity_ordered)):
                        new_product_id = max_product_id + 1 + i
                        insert_product_query = "insert into product values (%s, %s, %s, %s, %s, %s, %s)"
                        inventory_cursor.execute(insert_product_query, (new_product_id, upc, size, packaging_type, product_type, brand_name, base_price))

                        #increase amount of products stocked at a location
                        new_inventory_query = "insert into inventory values (%s, %s, %s, %s, %s, %s, %s)"
                        inventory_cursor.execute(new_inventory_query, (address_num, street, city, state, zip, new_product_id, 1))

                    #update sells_to with the date of the last restock
                    sells_to_query = "update sells_to set restock_date = %s where ven_name = (select ven_name from brand where brand_name = %s) and address_num = %s and street = %s and city = %s and state = %s and zip = %s"
                    inventory_cursor.execute(sells_to_query, (current_date, brand_name, address_num, street, city, state, zip))
                inventory_cursor.close()
                cnx.commit()
                #Sleep for 1 minute so we aren't trying to query nonstop for the specified time
                time.sleep(60)


    #Close connection
    cnx.close()
#except so we know if we're having trouble connecting (hopefully shouldn't be an issue now that password stuff is figured out)
except Error as e:
    print("Error while connecting to Walmart", e)
