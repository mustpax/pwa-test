#!/usr/bin/env python3
import os
import re


def normalize_filename(filename):
    # Convert to lowercase
    filename = filename.lower()
    # Replace spaces with hyphens
    filename = filename.replace(" ", "-")
    # Remove any non-alphanumeric characters except hyphens and dots
    filename = re.sub(r"[^a-z0-9\-\.]", "", filename)
    # Remove multiple consecutive hyphens
    filename = re.sub(r"-+", "-", filename)
    # Remove leading/trailing hyphens
    filename = filename.strip("-")
    return filename


def clean_deck_images():
    deck_dir = "public/deck"

    # Check if directory exists
    if not os.path.exists(deck_dir):
        print(f"Directory {deck_dir} does not exist")
        return

    # Get all files in the directory
    files = os.listdir(deck_dir)

    for old_name in files:
        # Skip if not a file
        if not os.path.isfile(os.path.join(deck_dir, old_name)):
            continue

        # Get file extension
        name, ext = os.path.splitext(old_name)

        # Normalize the filename
        new_name = normalize_filename(name) + ext.lower()

        # Skip if filename is already normalized
        if old_name == new_name:
            continue

        # Create full paths
        old_path = os.path.join(deck_dir, old_name)
        new_path = os.path.join(deck_dir, new_name)

        # Rename the file
        try:
            os.rename(old_path, new_path)
            print(f"Renamed: {old_name} -> {new_name}")
        except Exception as e:
            print(f"Error renaming {old_name}: {str(e)}")


if __name__ == "__main__":
    clean_deck_images()
