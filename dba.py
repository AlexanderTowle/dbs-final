import mysql.connector
from mysql.connector import Error

def connect_to_database(host, user, password, database):#create a function to connect, gives error if failed
    try:
        cnx = mysql.connector.connect(user='com303dsandoval', password='ds8498ds',
                                      host='136.244.224.221',
                                      database='com303fpad')
        if cnx.is_connected():
            return cnx
    except Error as e:
        print("There was an error connecting to the database:", e)
        return None

def execute_query(cnx, query):
    try:
        cursor = cnx.cursor()
        cursor.execute(query)
        return cursor.fetchall()
    except Error as e:
        print("An error occurred:", e)
        return None

def main():
    cnx = connect_to_database('136.244.224.221', 'com303dsandoval', 'ds8498ds', 'com303fpad')
    if cnx is None:
        return

    #get user/dba query input
    query = input("Please enter your SQL query: ")

    results = execute_query(cnx, query)
    if results is not None:
        #return the results
        for row in results:
            print(row)

    cnx.close()
    print("Now disconnecting from the database. Goodbye")

if __name__ == "__main__":
    main()
