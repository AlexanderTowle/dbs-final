import mysql.connector
from mysql.connector import Error

def connect_to_database(host, user, password, database):#create a function to connect, gives error if failed
    try:
        cnx = mysql.connector.connect(user='com303atowle', password='at2289at',
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
        print("Query executed successfully!!!")
        return cursor.fetchall()
    except Error as e:
        print("Error executing query:", e)
        return None

def main():
    host = '136.244.224.221'
    user = 'com303dsandoval'
    password = 'ds8498ds'
    database = 'com303fpad'

    cnx = connect_to_database(host, user, password, database)
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
