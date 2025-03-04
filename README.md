# Automated System Logging
A simple Bash script for Linux forensic and security log analysis. Counterpart of the PowerShell Forensic Suite

## DESCRIPTION
This script performs three security functions:
  1. Forensic Collection: Gathers system info, user list, processes, network connections, and event logs.
  2. Syslog Analysis: Extracts successful login events from auth logs.
  3. Security Report: Generates an HTML report summarizing key data.
     
The execution level is determined by the numeric parameter:
  - Level 1: Forensic Collection only.
  - Level 2: Forensic Collection and Syslog Analysis.
  - Level 3 (or unspecified): All three functions are executed.

## PS
This bash script is only the counterpart of my PowerShell Forensic Suite. That project is based on the its respective course capstone. So is this project.

## EXAMPLE
- **./SysLog.sh [level]**
- Run all features (default Level = 3):
   ```bash
   ./SysLog.sh 3
   ```
- Run only forensic collection:
   ```bash
   ./SysLog.sh 1
   ```
- Run forensic + system logging/analysis:
   ```bash
   ./SysLog.sh 2
   ```

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/C0deRhin0/Automated-System-Logging.git
   ```

2. Navigate to the project directory:
   ```bash
   cd Automated-System-Logging
   ```
   
3. Make the script executable:
   ```bash
   chmod +x SysLog.sh
   ```

4. Running the script:
   Refer to "Example" section

OR you can just download the file in this repo and run it as administrator.

## License
This project is licensed under the [MIT License](LICENSE).

## Acknowledgments

- This project was inspired by and utilizes concepts from the Security Blue Team PowerShell course AND Bash course.
- Special thanks to the Security Blue Team for providing excellent training and resources.

## Contact

For any inquiries or support, please contact:

- **Author**: C0deRhin0 
- **GitHub**: [C0deRhin0](https://github.com/C0deRhin0)

---
