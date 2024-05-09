import mysql.connector
from mysql.connector import Error

def main():
    #try to connect to db
    try:
        cnx = mysql.connector.connect(user='com303dsandoval', password='ds8498ds',
                                      host='136.244.224.221',
                                      database='com303fpad', autocommit=True)
        if cnx.is_connected():
            print("Successfully connected to the database")

            while True:
                #give prompt for user input
                query = input("\nHello Database Admin! Please enter your SQL query/action: ")

                #try executing the action
                try:
                    cursor = cnx.cursor()
                    cursor.execute(query)
                    results = cursor.fetchall()

                    #if successful print result
                    if results:
                        for row in results:
                            print(row)
                        print("Action has successfully executed!")
                    #let dba know it still executed if no results
                    else:
                        print("Query executed successfully.")
                except Error as e:
                    print("An error ocurred", e)

                #give user option to quit or keep doing stuff
                exit_choice = input("\nDo you want to exit? (yes/no): ").lower()
                if exit_choice == "yes":
                    print("Now disconnecting from the database. Goodbye!")
                    cnx.close()
                    break
                
    except Error as e:
        print("There was an error connecting to the database:", e)

if __name__ == "__main__":
    main()