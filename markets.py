import mysql.connector
from mysql.connector import Error

class OLAPInterface:
    def __init__(self, cnx):
        self.cnx = cnx
        self.commands = {
            "pivot": self.pivot,
            "cube": self.cube,
            "help": self.display_help,
            "exit": self.exit_interface
        }

    def start(self):
        print("Hello, welcome to Walmart! \nThis program runs various OLAP queries (ie pivot, cube, rollup)\n")
        self.display_help()
        while True:
            command = input("Enter the command: ").strip().split()
            if not command:
                continue
            if command[0] in self.commands:
                self.commands[command[0]](*command[1:])
            else:
                print("Invalid command. Type 'help' for available commands.")


    def pivot(self, *args):
        if len(args) != 4:
            print("Please enter using the following format: pivot your_table d1 d2 num_col")#takes 2 args
            return
    
        table_name, dimension1, dimension2, measure = args #for 2 dimensions
        table_name = f"`{table_name}`" #table input is user friendly
    
        #constructing the pivot query
        #pivot command doesnt work on sql, so use sum
        pivot_query = f"select {dimension1}, {dimension2}, sum({measure}) from {table_name} group by {dimension1}, {dimension2};" #for 2 dims
        cursor = self.cnx.cursor()
        cursor.execute(pivot_query)
        result = cursor.fetchall()
        cursor.close()

        for row in result:
            print(row)
        
        exit_choice = input("Do you want to exit? (yes/no): ").lower()
        if exit_choice == "yes":
            self.exit_interface()
       
    def cube(self, *args):
        if len(args) < 4:
            print("Please enter using the following format: cube your_table d1 d2 num_col") #using 3 dims, could go to 2, num_col is for numerical column
            return
    
        table_name, dim1, dim2, measure = args[0], args[1], args[2], args[-1]
        table_name = f"`{table_name}`"  

        cube_query = (
                        f"select {dim1}, {dim2}, "
                        f"sum({measure}) as total "
                        f"from {table_name} "
                        f"group by {dim1}, {dim2} with rollup "
                        f"union "  #union since cube doesnt work on mysql
                        f"select 'null', {dim2}, sum({measure}) as total " #null depending on num of cols
                        f"from {table_name} "
                        f"group by {dim2};")

        #create the cube query using the vars
        cursor = self.cnx.cursor()
        cursor.execute(cube_query)
        result = cursor.fetchall()
        cursor.close()

        for row in result:
            print(row)
        
        exit_choice = input("Do you want to exit? (yes/no): ").lower()
        if exit_choice == "yes":
            self.exit_interface()

    def display_help(self):
        print("Available commands:")
        print("-pivot")
        print("-cube")
        print("-help (display available commands)")
        print("-exit\n")

    def exit_interface(self):
        print("Thank you. Bye!")
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
