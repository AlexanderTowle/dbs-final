import mysql.connector
from mysql.connector import Error
import sys

#try to connect
try:
    cnx = mysql.connector.connect(user='com303atowle', password='at2289at',
                                  host='136.244.224.221',
                                  database='com303fpad')
    if cnx.is_connected():
        print("\nWelcome to Walmart!\nPlease enter the address of the store you would like to shop at, in the following format: 270 Mohegan Ave, New London CT 06320.\n")

        while True:
            #Ask user for store location and wait for response (must be in specified format)
            address = input()

            #Get the relevant data and separate it so it can be queries according to how we organized the tables
            num_street, city_state_zip = address.split(', ')
            address_num, street = num_street.split(' ', 1)
            city, state, zip = city_state_zip.rsplit(' ', 2)

            #Create cursor and query to get the products available at that store
            address_cursor = cnx.cursor()
            address_query = "select p.product_type, p.product_id, i.price from inventory i join product p on (i.product_id = p.product_id) where address_num = %s and street = %s and city = %s and state = %s and zip = %s"
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
        #Keep track of the total cost
        total = 0.00
        print("Please enter the product IDs of the products you would like to purchase one at a time. When you are finished please type \"Checkout\".\n")
        #Continues prompting until checkout is entered
        while True:
            product = input()
            if product == "Checkout":
                #Check against the items in the store to fetch the data for what is being bought and add to total cost
                for item in address_results:
                    if str(item[1]) in cart:
                        total += float(item[2])
                print("\nYour total is $" + str(total))
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
        card_num = input("\nPlease enter your card number\n")


#except so we know if we're having trouble connecting (hopefully shouldn't be an issue now that password stuff is figured out)
except Error as e:
    print("Error while connecting to Walmart", e)
