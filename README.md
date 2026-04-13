# Tower of Fantasy Game Resources

This repository contains various resources extracted from the Tower of Fantasy game. Below is a description of the directory structure and the usage of the provided script.

## Directory Structure

1. **DataTable**  
   Contains characteristics and data related to in-game opponents, such as stats.

2. **Game/en**  
   Includes all the text content of the game in English, such as dialogues, item descriptions, and UI text.

3. **Icon**  
   Contains all the icons used in the game, including items, buffs, and other visual elements.

4. **UI**  
   Stores all the images and assets related to the game's user interface, such as buttons, backgrounds, and menus.

---

## Script: `copy_from_commit.bat`

This script is used to extract and copy files from a specific commit in the repository. It automates the process of cloning the repository, checking out a specific commit, and copying the files added in that commit to a designated folder.

### Requirements

1. **Git**  
   The script requires Git to be installed on your system.  
   - Download Git from [https://git-scm.com/](https://git-scm.com/).

2. **Windows Command Prompt**  
   The script is designed to run on Windows using the Command Prompt.

### Usage

1. **Clone the Repository**  
   Ensure the script is placed in the desired directory. When executed, it will clone the repository if it hasn't been cloned already.

2. **Run the Script**  
   Open the Command Prompt and navigate to the directory containing the script. Run the script by typing:
   ```bat
   copy_from_commit.bat
   ```

3. **Enter the Commit Hash**  
   The script will prompt you to enter the commit hash. Provide the hash of the commit you want to extract files from.
