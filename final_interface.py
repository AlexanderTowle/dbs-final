import mysql.connector
from mysql.connector import Error
import sys

#try to connect
try:
    cnx = mysql.connector.connect(user='com303atowle', password='at2289at',
                                  host='136.244.224.221',
                                  database='com303fpad')
    if cnx.is_connected():
        print("\nWelcome to Walmart!\n")

        #Ask user for store location and wait for response (must be in specified format)
        address = input("Please enter the address of the store you would like to shop at, in the following format: 270 Mohegan Ave, New London CT 06320.\n")

        #Get the relevant data and separate it so it can be queries according to how we organized the tables
        num_street, city_state_zip = address.split(', ')
        address_num, street = num_street.split(' ', 1)
        city, state, zip = city_state_zip.rsplit(' ', 2)

        #Create cursor and query to get the products available at that store
        address_cursor = cnx.cursor()
        address_query = "select p.product_type from inventory i join product p on (i.product_id = p.product_id) where address_num = %s and street = %s and city = %s and state = %s and zip = %s"
        address_cursor.execute(address_query, (address_num, street, city, state, zip))

        #Results
        address_results = address_cursor.fetchall()

        #Either show products or it isn't a valid store
        if address_results:
            print("\nProducts available at this location:\n")
            for product in address_results:
                print(product[0], "\n")
        else:
            print("\nInvalid store location\n")
            sys.exit()

        

#except so we know if we're having trouble connecting (hopefully shouldn't be an issue now that password stuff is figured out)
except Error as e:
    print("Error while connecting to Walmart", e)