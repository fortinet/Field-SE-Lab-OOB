import json
import os
import sys
import shutil

# Ensure the user provided all three required arguments
if len(sys.argv) < 1:
    print("Usage: python script.py <file_name>")
    print("Example: python script.py entitlements.txt")
    sys.exit(1)

# Assign inputs from command line arguments
file_name = sys.argv[1]

files_created = 0

try:
    with open(file_name, "r") as file:
        data = json.load(file)
    
    files_created = 0

    for item in data:
        # Clean up the description string for safe filenames
        description = item.get("description", "unknown_device").replace("/", "_").replace(" ", "_")
        token = item.get("token", "NO_TOKEN_FOUND")
        configId = item.get("configId", "NO_CONFIG_ID_FOUND")
        tokenStatus = item.get("tokenStatus", "NO_TOKEN_STATUS_FOUND")
        status = item.get("status", "NO_STATUS_FOUND")
        serialNumber = item.get("serialNumber", "NO_SERIAL_NUMBER_FOUND")
            
        print(f"configId:     {configId}")
        print(f"description:  {description}")
        print(f"serialNumber: {serialNumber}")
        print(f"status:       {status}")
        print(f"token:        {token}")
        print(f"tokenStatus:  {tokenStatus}")
        print(f" ")
            
        files_created += 1

    print(f"\nDone! {files_created} tokens")

except FileNotFoundError:
    print(f"Error: The source file '{file_name}' was not found.")
    sys.exit(1)
except json.JSONDecodeError:
    print("Error: The source file content is not valid JSON.")
    sys.exit(1)

