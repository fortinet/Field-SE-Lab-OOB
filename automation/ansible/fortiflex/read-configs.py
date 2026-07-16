import ast
import sys

#print(f"Number of arguments: {len(sys.argv)}")
#print(f"Arguments list: {sys.argv}")

#if len(sys.argv) > 1:
#    print(f"First argument: {sys.argv[1]}")

file_path = sys.argv[1] 

try:
    with open(file_path, 'r') as f:
        dict_string = f.read()
        my_dict = ast.literal_eval(dict_string)
#    print("Dictionary loaded using ast.literal_eval():", my_dict)
except FileNotFoundError:
    print(f"Error: File '{file_path}' not found.")
except ValueError as e:
    print(f"Error: Invalid dictionary format in '{file_path}': {e}")

print(f"Active Config ID's")
print(f"------------------")
print(f" ")
for dictionary in my_dict:
    # Only print if the status is Active
    if dictionary.get("status") == "ACTIVE":
        print(f"configId:      {dictionary["id"]}")
        print(f"name:          {dictionary["name"]}")
        #print(f"Status:        {dictionary["status"]}")
        print(" ")
