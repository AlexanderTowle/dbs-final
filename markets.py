import mysql.connector
from mysql.connector import Error

class OLAPInterface:
    def __init__(self, cnx):
        self.cnx = cnx
        self.commands = {
            "pivot": self.pivot,
            #"cube": self.cube,
            # "rollup": self.rollup,
            "help": self.display_help,
            "exit": self.exit_interface
        }

    def start(self):
        print("Hello, welcome to Walmart! \nThis program runs various OLAP queries (ie pivot, cube, rollup)\n")
        self.display_help()
        while True:
            command = input("Enter the command (pivot, cube, rollup): ").strip().split()
            if not command:
                continue
            if command[0] in self.commands:
                self.commands[command[0]](*command[1:])
            else:
                print("Invalid command. Type 'help' for available commands.")

    def pivot(self, *args):
        if len(args) != 3:
            print("Please enter using the following format: pivot <table_name> <dimension1> (optional) <dimension2> <measure>")
            return
    
        #table_name, dimension1, dimension2, measure = args #for 2 dimensions
        table_name, dimension1, measure = args
        table_name = f"`{table_name}`" #table input is user friendly
    
        #print(f"Pivoting on table {table_name} by {dimension1}, {dimension2}, and calculating {measure}") #for 2 dimensions
        print(f"Pivoting on table {table_name} by {dimension1}, and calculating {measure}")
    
        #constructing the pivot query
        #pivot command doesnt work on sql, so use sum
        #pivot_query = f"select {dimension1}, {dimension2}, sum({measure}) from {table_name} group by {dimension1}, {dimension2};" #for 2 dims
        pivot_query = f"select {dimension1}, sum({measure}) from {table_name} group by {dimension1};"
        cursor = self.cnx.cursor()
        cursor.execute(pivot_query)
        result = cursor.fetchall()
        cursor.close()

        print("Pivot result:")
        for row in result:
            print(row)

    def display_help(self):
        print("Available Commands:")
        print("1. pivot")
        #print("2. cube")
        #print("3. rollup")
        print("4. help (display available commands)")
        print("5. exit\n")

    def exit_interface(self):
        print("Bye!")
        self.cnx.close()
        exit()


#try to connect to the database
try:
    cnx = mysql.connector.connect(user='com303dsandoval', password='ds8498ds',
                                  host='136.244.224.221',
                                  database='com303fpad')
    if cnx.is_connected():
        interface = OLAPInterface(cnx)
        interface.start()

#except so we know if we're having trouble connecting
except Error as e:
    print("Error while connecting to Walmart database:", e)
