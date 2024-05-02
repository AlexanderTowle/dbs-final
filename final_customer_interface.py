import mysql.connector
from mysql.connector import Error
from datetime import datetime
from datetime import date

#try to connect
try:
    cnx = mysql.connector.connect(user='com303atowle', password='at2289at',
                                  host='136.244.224.221',
                                  database='com303fpad')
    if cnx.is_connected():
        print("\nWelcome to Walmart!\nPlease enter the address of the store you would like to shop at, in the following format: 270 Mohegan Ave, New London CT 06320.\n")

        address_num = ""
        street = ""
        city = ""
        state = ""
        zip = ""
        while True:
            #Ask user for store location and wait for response (must be in specified format)
            address = input()

            #Get the relevant data and separate it so it can be queries according to how we organized the tables
            num_street, city_state_zip = address.split(', ')
            address_num, street = num_street.split(' ', 1)
            city, state, zip = city_state_zip.rsplit(' ', 2)

            #Create cursor and query to get the products available at that store
            address_cursor = cnx.cursor()
            address_query = "select p.product_type, p.product_id, p.base_price * s.price_scale as scaled_price from inventory i join product p on (i.product_id = p.product_id) join store s on (i.address_num = s.address_num and i.street = s.street and i.city = s.city and i.state = s.state and i.zip = s.zip) where i.address_num = %s and i.street = %s and i.city = %s and i.state = %s and i.zip = %s and i.amount_stocked > 0"
            address_cursor.execute(address_query, (address_num, street, city, state, zip))

            #Results
            address_results = address_cursor.fetchall()
            address_cursor.close()

            #Either show products or it isn't a valid store
            product_ids = []
            if address_results:
                print("\nProducts available at this location:\n\nProduct   Product ID   Price\n")
                for product in address_results:
                    product_ids.append(str(product[1]))
                    print(str(product[0]) + " " + str(product[1]) + " $" + str(product[2]) + "\n")
                break
            else:
                print("\nInvalid store location, please choose a valid location.\n")

        #cart holds product_ids 
        cart = []
        #cart_upc holds upcs of items in the cart
        cart_upc = []
        #Keep track of the total cost
        total = 0.00
        print("Please enter the product IDs of the products you would like to purchase one at a time. When you are finished please type \"Checkout\".\n")
        #Continues prompting until checkout is entered
        while True:
            product = input()
            if product.lower() == "checkout":
                inventory_cursor = cnx.cursor()
                #Check against the items in the store to fetch the data for what is being bought and add to total cost
                for item in address_results:
                    if str(item[1]) in cart:
                        total += float(item[2])
                for id in cart:
                    upc_query = "select UPC from product where product_id = %s"
                    inventory_cursor.execute(upc_query, (id,))
                    upc_result = inventory_cursor.fetchall()
                    actual_upc = str(upc_result[0][0])
                    decrement_query = "update inventory set amount_stocked = amount_stocked - 1 where product_id in (select product_id from product where UPC = %s) and address_num = %s and street = %s and city = %s and state = %s and zip = %s"
                    inventory_cursor.execute(decrement_query, (actual_upc, address_num, street, city, state, zip))
                print("\nYour total is $" + str(total))
                inventory_cursor.close()
                break
            #add product_id to cart
            else:
                if product not in cart and product in product_ids:
                    cart.append(product)
                elif product in cart:
                    print("\nProduct already in cart, please select another product or Checkout.\n")
                else:
                    print("\nInvalid product ID, please select another product or Checkout.\n")
        
        #Transaction information
        print("\nPlease enter your card number.\n")
        while True:
            card_num = input()
            #Check if valid card
            if len(card_num) == 16 and card_num.isdigit():
                trans_cursor = cnx.cursor()
                #Assign new transaction num
                trans_id_assignment_query = "select max(transaction_num) + 1 from trans"
                trans_cursor.execute(trans_id_assignment_query)
                trans_num = trans_cursor.fetchall()
                new_trans_num = str(trans_num[0][0])
                #insert and commit
                trans_insertion_query = "insert into trans values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
                trans_cursor.execute(trans_insertion_query, (new_trans_num, total, card_num, date.today(), datetime.now().strftime("%H:%M:%S"), address_num, street, city, state, zip))
                ordered_cursor = cnx.cursor()
                #add to the ordered table for every item ordered in a single transaction
                for product in cart:
                    ordered_query = "insert into ordered values (%s, %s)"
                    ordered_cursor.execute(ordered_query, (product, new_trans_num))
                cnx.commit()
                trans_cursor.close()
                ordered_cursor.close()
                break
            else:
                print("\nInvalid card number, please enter a valid card number.\n")

        #Membership
        print("\nDo you have a customer ID with us?\n")
        while True:
            id_exists = input()
            if id_exists.lower() == "yes":
                customer_id = input("\nPlease enter your customer ID.\n")
                #name query
                name_cursor = cnx.cursor()
                name_query = "select first_name from customer where customer_id = %s"
                name_cursor.execute(name_query, (customer_id,))
                name_result = name_cursor.fetchone()
                name = name_result[0]
                name_cursor.close()
                #check if customer is a member
                member_cursor = cnx.cursor()
                member_query = "select point_balance from member where customer_id = %s"
                member_cursor.execute(member_query, (customer_id,))
                member_result = member_cursor.fetchone()
                if member_result:
                    #update point balance
                    point_increment = int(total / 5) #point for evey 5 dollars you spend
                    new_points = member_result[0] + point_increment
                    update_points_query = "update member set point_balance = %s where customer_id = %s"
                    member_cursor.execute(update_points_query, (new_points, customer_id))
                    print("\nCongratulations " + name + "! As a member, you have earned " + str(point_increment) + " points with this purchase for a total of " + str(new_points) + ".\n")
                    cnx.commit()
                #update purchased
                purchased_query = "insert into purchased values (%s, %s)"
                member_cursor.execute(purchased_query, (new_trans_num, customer_id))
                print("\nTransaction complete. Thank you for choosing Walmart, " + name + "!\n")
                member_cursor.close()
                cnx.commit()
                break
            elif id_exists.lower() == "no":
                #create new customer ID
                customer_cursor = cnx.cursor()
                new_customer_id_query = "select max(customer_id) + 1 from customer"
                customer_cursor.execute(new_customer_id_query)
                new_customer_id = customer_cursor.fetchone()[0]
                insert_customer_query = "insert into customer values (%s, 'Anonymous', '0000000000', 'Anonymous', 'Anonymous')"
                customer_cursor.execute(insert_customer_query, (new_customer_id,))
                #update purchased
                purchased_insert_query = "insert into purchased values (%s, %s)"
                customer_cursor.execute(purchased_insert_query, (new_trans_num, new_customer_id))
                print("\nTransaction complete. Thank you for choosing Walmart!\n")
                customer_cursor.close()
                cnx.commit()
                break
            else:
                print("\nPlease enter yes or no.\n")
    #Close connection
    cnx.close()
#except so we know if we're having trouble connecting (hopefully shouldn't be an issue now that password stuff is figured out)
except Error as e:
    print("Error while connecting to Walmart", e)
