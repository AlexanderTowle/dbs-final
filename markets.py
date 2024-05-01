import mysql.connector
from mysql.connector import Error

class OLAPInterface:
    def __init__(self, cnx):
        self.cnx = cnx
        self.commands = {
            "pivot": self.pivot,
            "cube": self.cube,
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
            print("Please enter using the following format: pivot your_table d1 d2 num_col")
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

        for row in result:
            print(row)
            
    def cube(self, *args):
        if len(args) < 4:
            print("Please enter using the following format: cube your_table d1 d2 num_col") #using 3 dims, could go to 2, num_col is for numerical column
            return
    
        table_name, dimensions, measure = args[0], args[1:-1], args[-1]
        table_name = f"`{table_name}`"  
    
        print(f"Generating cube for {', '.join(dimensions)}, and calculating {measure}")
    
        select_clause = ", ".join(dimensions) #create a select variable to specify which values are retrieved
        group_by_clause = ", ".join(dimensions)
        cube_query = f"select {select_clause}, sum({measure}) from {table_name} group by {group_by_clause};" #create the cube query using the vars
        cursor = self.cnx.cursor()
        cursor.execute(cube_query)
        result = cursor.fetchall()
        cursor.close()

        for row in result:
            print(row)

    def display_help(self):
        print("Available Commands:")
        print("1. pivot")
        print("2. cube")
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
