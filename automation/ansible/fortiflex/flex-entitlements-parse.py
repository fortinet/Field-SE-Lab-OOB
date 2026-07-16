import json
import os
import sys
import shutil

# Ensure the user provided all three required arguments
if len(sys.argv) < 4:
    print("Usage: python script.py <file_name> <config_id> <destination_directory>")
    print("Example: python script.py data.txt 41105 my_tokens_folder")
    sys.exit(1)

# Assign inputs from command line arguments
file_name = sys.argv[1]
output_dir = sys.argv[3]

try:
    # Convert the config ID argument to an integer
    TARGET_CONFIG_ID = int(sys.argv[2])
except ValueError:
    print("Error: The config_id argument must be a valid integer.")
    sys.exit(1)

# Create the user-specified output directory
os.makedirs(output_dir, exist_ok=True)

# Ensure the directory is completely empty
# for item in os.listdir(output_dir):
#    item_path = os.path.join(output_dir, item)
#    if os.path.isfile(item_path) or os.path.islink(item_path):
#        os.unlink(item_path) # Deletes the file or link
#    elif os.path.isdir(item_path):
#        shutil.rmtree(item_path) # Deletes the subdirectory and its contents

try:
    with open(file_name, "r") as file:
        data = json.load(file)
    
    files_created = 0

    for item in data:
        if item.get("configId") == TARGET_CONFIG_ID:
            # Clean up the description string for safe filenames
            description = item.get("description", "unknown_device").replace("/", "_").replace(" ", "_")
            token = item.get("token", "NO_TOKEN_FOUND")
            
            # Handle duplicate descriptions safely within the custom folder
            base_filename = os.path.join(output_dir, f"{description}.lic")
            final_filename = base_filename
#            counter = 1
            
#            while os.path.exists(final_filename):
#                final_filename = os.path.join(output_dir, f"{description}_{counter}.lic")
#                counter += 1
            
            # Write token to the file
            with open(final_filename, "w") as out_file:
                out_file.write(token)
                
            print(f"Created: {final_filename}")
            files_created += 1

    print(f"\nDone! Created {files_created} token files inside the '{output_dir}' directory.")

except FileNotFoundError:
    print(f"Error: The source file '{file_name}' was not found.")
    sys.exit(1)
except json.JSONDecodeError:
    print("Error: The source file content is not valid JSON.")
    sys.exit(1)

