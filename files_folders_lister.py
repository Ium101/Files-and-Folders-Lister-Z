import os
from docx import Document

def list_files_and_folders(directory, mode="B", list_option=1, recursive=False, specific_subfolders=None):
    folder_name = os.path.basename(os.path.normpath(directory))
    disk_letter = os.path.splitdrive(os.path.abspath(directory))[0].replace(":", "")
    output_filename_base = f"{folder_name} ({disk_letter})"

    # Gather folders and files
    folders = []
    files = []
    for entry in os.scandir(directory):
        if entry.is_dir():
            if not specific_subfolders:
                folders.append(entry.path)
            else:
                # Only include folders that exactly match the filter (case-insensitive, ignore trailing/leading whitespace and non-alphanumeric chars)
                import re
                entry_name_clean = re.sub(r'\W+', '', entry.name).lower()
                for sub in specific_subfolders:
                    sub_clean = re.sub(r'\W+', '', sub).lower()
                    if sub_clean == entry_name_clean:
                        folders.append(entry.path)
                        break
        elif entry.is_file():
            files.append(entry.path)

    # If filtering, do NOT recurse into filtered folders
    def get_all_sub_files(folder):
        sub_files = []
        if not specific_subfolders:
            for root, _, file_list in os.walk(folder):
                for f in file_list:
                    sub_files.append(os.path.join(root, f))
        else:
            for entry in os.scandir(folder):
                if entry.is_file():
                    sub_files.append(entry.path)
        return sub_files

    sub_files_map = {}
    if recursive:
        for folder in folders:
            sub_files_map[folder] = get_all_sub_files(folder)

    # Output
    output_file_path = os.path.join(directory, f"{output_filename_base}.{'docx' if mode.upper() == 'A' else 'txt'}")
    if mode.upper() == "A":
        try:
            doc = Document()
            doc.add_heading(f"File List for {folder_name}", level=1)
            # Folders
            if list_option in [1, 2]:
                for folder in folders:
                    write_folder_structure_docx(doc, folder)
            # Files
            if list_option in [1, 3]:
                for file in files:
                    p = doc.add_paragraph()
                    p.add_run("• ")
                    base, ext = os.path.splitext(os.path.basename(file))
                    run = p.add_run(base)
                    run.bold = True
                    p.add_run(ext)
            doc.save(output_file_path)
            print(f"List generated successfully: {output_file_path}")
            print("The List has been generated")
        except Exception as e:
            print(f"DOCX generation failed: {e}. Falling back to TXT mode.")
            output_file_path = os.path.join(directory, f"{output_filename_base}.txt")
            with open(output_file_path, "w", encoding="utf-8") as txt_file:
                txt_file.write(f"File List for {folder_name}\n\n")
                # Folders
                if list_option in [1, 2]:
                    for folder in folders:
                        write_folder_structure_txt(txt_file, folder)
                # Files
                if list_option in [1, 3]:
                    for file in files:
                        base, ext = os.path.splitext(os.path.basename(file))
                        txt_file.write(f"• {base}{ext}\n")
            print(f"List generated successfully: {output_file_path}")
            print("The List has been generated")
    else:
        with open(output_file_path, "w", encoding="utf-8") as txt_file:
            txt_file.write(f"File List for {folder_name}\n\n")
            # Folders
            if list_option in [1, 2]:
                for folder in folders:
                    write_folder_structure_txt(txt_file, folder)
            # Files
            if list_option in [1, 3]:
                for file in files:
                    base, ext = os.path.splitext(os.path.basename(file))
                    txt_file.write(f"• {base}{ext}\n")
        print(f"List generated successfully: {output_file_path}")
        print("The List has been generated")

def write_folder_structure_docx(doc, folder, indent=0):
    # Write the folder name
    p = doc.add_paragraph("    " * indent)
    p.add_run("• ")
    run = p.add_run(os.path.basename(folder))
    run.bold = True
    entries = sorted(os.scandir(folder), key=lambda e: (not e.is_dir(), e.name.lower()))
    subfolder_count = 0
    subfile_count = 0
    import inspect
    specific_subfolders = inspect.currentframe().f_back.f_locals.get('specific_subfolders', None)
    for entry in entries:
        if entry.is_dir():
            if not specific_subfolders:
                subfolder_count += 1
                write_folder_structure_docx(doc, entry.path, indent + 1)
        elif entry.is_file():
            subfile_count += 1
            sub_p = doc.add_paragraph("    " * (indent + 1) + f"{subfile_count}. ")
            base, ext = os.path.splitext(entry.name)
            sub_run = sub_p.add_run(base)
            sub_run.italic = True
            sub_p.add_run(ext)

def write_folder_structure_txt(txt_file, folder, indent=0):
    txt_file.write(f"{'    ' * indent}• {os.path.basename(folder)}\n")
    entries = sorted(os.scandir(folder), key=lambda e: (not e.is_dir(), e.name.lower()))
    subfolder_count = 0
    subfile_count = 0
    import inspect
    specific_subfolders = inspect.currentframe().f_back.f_locals.get('specific_subfolders', None)
    for entry in entries:
        if entry.is_dir():
            if not specific_subfolders:
                subfolder_count += 1
                write_folder_structure_txt(txt_file, entry.path, indent + 1)
        elif entry.is_file():
            subfile_count += 1
            base, ext = os.path.splitext(entry.name)
            txt_file.write(f"{'    ' * (indent + 1)}{subfile_count}. {base}{ext}\n")

if __name__ == "__main__":
    directory_to_list = input("Enter the directory to list: ")
    recursive = True  # Always list sub-folders
    filter_input = input("Enter sub-folder names or keywords to filter (comma-separated, case-insensitive, substring match), or leave blank to include all: ").strip()
    if filter_input:
        specific_subfolders = [folder.strip() for folder in filter_input.split(",") if folder.strip()]
    else:
        specific_subfolders = None
    while True:
        mode = input("Do you want to generate the output as Mode A / DOCX or Mode B / TXT? ").strip().lower()
        if mode in ["a", "docx", "b", "txt"]:
            mode = "A" if mode in ["a", "docx"] else "B"
            break
        else:
            print("Invalid input. Please enter A/a/DOCX/docx for Mode A or B/b/TXT/txt for Mode B.")
    list_option = 0
    while True:
        try:
            print("Choose listing option:")
            print("  1. List both folders and files")
            print("  2. List only folders")
            print("  3. List only files")
            choice = input("Enter your choice (1/2/3): ")
            list_option = int(choice)
            if list_option in [1, 2, 3]:
                break
            else:
                print("Invalid choice. Please enter 1, 2, or 3.")
        except ValueError:
            print("Invalid input. Please enter a number (1, 2, or 3).")
    list_files_and_folders(directory_to_list, mode=mode, list_option=list_option, recursive=recursive, specific_subfolders=specific_subfolders)