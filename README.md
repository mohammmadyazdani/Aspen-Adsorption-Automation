Aspen Adsorption Automation using Python COM Interface

Author: Mohammad Yazdani  
Email: mohamad.yazdani7990@gmail.com  
Year: 2025  


Project Overview:  
This repository demonstrates how to automate and extract data from Aspen Adsorption using Python through the Aspen Custom Modeler (ACM) COM interface.  
Aspen Adsorption operates within the Aspen Custom Modeler environment, allowing users to access, modify, and control process simulations programmatically.  

The example focuses on a Pressure Swing Adsorption (PSA) process for hydrogen purification, serving as a foundation for automation in other cyclic adsorption processes such as VSA, TVSA, and DAC systems.  

This project is intended for master’s students, researchers, and engineers in Chemical and Process Engineering who are interested in integrating process modeling with Python-based automation and optimization workflows.  


Main Features:  
- Automate Aspen Adsorption simulations via Python  
- Modify process variables such as feed pressure, step duration, and bed geometry  
- Initialize and execute cyclic adsorption models programmatically  
- Extract process performance indicators (e.g., hydrogen purity and recovery)  
- Enable data-driven modeling, process optimization, and surrogate model generation  


File Structure:  
Aspen-Adsorption-Automation/  
│  
├── H2PSA.ada        (Aspen Adsorption simulation file)  
├── H2PSA.py         (Python automation script)  
├── *.f              (User-defined Fortran subprocedure files)  
└── README.md        (Documentation)  


Important Notes:  
All simulation and subroutine files (.ada and .f) must be located in the same directory.  
This ensures that Aspen Adsorption can properly locate and compile user-defined subroutines during model execution.  


Requirements:  
- Aspen Adsorption v14.0 or newer (recommended)  
- Python 3.8 or newer  
- comtypes Python package  
- Windows OS (COM interface required)  

Compatibility Note:  
This script can also work with older Aspen Adsorption versions (v9–v13).  
For older versions, ensure that the Aspen Custom Modeler COM server is properly registered.  
You can do this by running the following command in an Administrator Command Prompt (adjusting for your version path):  
"C:\Program Files\AspenTech\AMSystem V10.0\Bin\AspenModeler.exe" /regserver  

To install the required Python dependency:  
pip install comtypes  


Usage Instructions:  
1. Clone the repository:  
   git clone https://github.com/mohammadyazdani/Aspen-Adsorption-Automation.git  
   cd Aspen-Adsorption-Automation  

2. Update your local Aspen paths inside the Python script:  
   ASPEN_PATH = r"C:\Program Files\AspenTech\AMSystem V14.0\Bin\AspenModeler.exe"  
   ADA_FILE   = r"D:\GitHub\Aspen-Adsorption-Automation\H2PSA.ada"  

3. Run the script:  
   python H2PSA.py  


Applications:  
- Automated data generation for process design and optimization  
- Development of machine learning surrogate models  
- Process parameter sensitivity and feasibility studies  
- Integration of Aspen models into Python-based workflows for research and education  


Author:  
Mohammad Yazdani  
MSc Candidate in Chemical Engineering  
Process Systems Engineering Enthusiast  
Email: mohamad.yazdani7990@gmail.com  


License:  
Released for academic and research purposes.  
Please credit the author when using or adapting this work.  

© 2025 Mohammad Yazdani. All rights reserved.
