Aspen Adsorption Automation using Python COM Interface

Author: Mohammad Yazdani  
Email: mohamad.yazdani7990@gmail.com  
Year: 2025  


Project Overview:  
This repository demonstrates how to control and extract data from Aspen Adsorption using Python through the Aspen Custom Modeler (ACM) COM interface.

Aspen Adsorption operates within the Aspen Custom Modeler framework, allowing users to automate simulations and directly access process variables programmatically.  
Here, a simple Pressure Swing Adsorption (PSA) model for hydrogen purification is used as an example.  


Features:  
- Launch Aspen Adsorption automatically via Python  
- Modify model inputs such as pressure, step times, and geometry  
- Initialize all simulation units programmatically  
- Run initialization and cyclic simulations  
- Extract process outputs such as hydrogen purity and recovery  
- Close Aspen safely after completion  


File Structure:  
Aspen-Adsorption-Automation/  
│  
├── H2PSA.ada         (Aspen Adsorption simulation file)  
├── H2PSA.py          (Python automation script)  
├── *.f               (Fortran subprocedure files)  
└── README.md         (Documentation)  


Note:  
All supporting files (.ada, .f) must be in the same folder so that Aspen Adsorption can locate and compile subroutines correctly.  


How It Works:  
The Python script uses the COM interface to communicate with Aspen Adsorption.  


Launch Aspen Adsorption:  
subprocess.Popen([ASPEN_PATH, ADA_FILE])  

Connect to ACM:  
ACM = client.GetActiveObject("ACM application")  

Modify process parameters:  
Flowsheet.F1.P.Value = 10.0  
Flowsheet.B1.Layer[0].Hb.Value = 2.1  
Flowsheet.B1.Layer[0].Db.Value = 0.06  
Flowsheet.Cycle_Organizer.Cycle_Data[0].Step_Data[1].StepTime.Value = 4.0  

Initialize simulation units:  
Flowsheet.B1.Initialize_Unit  
Flowsheet.TD1.Initialize_Unit  
Flowsheet.TD2.Initialize_Unit  

Run the simulation:  
Simulation.RunMode = "Initialization"  
Simulation.Run(True)  
Simulation.RunMode = "Dynamic"  
Simulation.Run(True)  

Extract results:  
purity = Flowsheet.P1.Cycle_Avg_Composition_Fwd[0].Value * 100  
recovery = (Flowsheet.P1.Cycle_Total_Component_Fwd[0].Value /  
            Flowsheet.F1.Cycle_Total_Component_Fwd[0].Value) * 100  
print(f"H2 Purity: {purity:.2f}%")  
print(f"H2 Recovery: {recovery:.2f}%")  


Example Output:  
Opening Aspen Adsorption...  
Connected to Aspen Adsorption (Aspen Custom Modeler).  
Input parameters have been set.  
Bed and gas tank voids initialized successfully.  
Simulation run completed.  
H2 Purity: 99.85%  
H2 Recovery: 92.31%  
Aspen Adsorption closed (ACM session terminated).  


Requirements:  
- Aspen Adsorption v14.0 or newer  
- Python 3.8 or newer  
- comtypes Python package  
- Windows OS (COM required)  

To install dependencies:  
pip install comtypes  


Usage:  
1. Clone the repository:  
   git clone https://github.com/mohammadyazdani/Aspen-Adsorption-Automation.git  
   cd Aspen-Adsorption-Automation  

2. Open the Python file and edit your local Aspen paths:  
   ASPEN_PATH = r"C:\Program Files\AspenTech\AMSystem V14.0\Bin\AspenModeler.exe"  
   ADA_FILE   = r"D:\GitHub\Aspen-Adsorption-Automation\H2PSA.ada"  

3. Run the script:  
   python H2PSA.py  


Author:  
Mohammad Yazdani  
Process Simulation & Machine Learning Researcher  
Email: mohamad.yazdani7990@gmail.com  


License:  
Released for educational and research purposes.  
Please credit the author when using or adapting this work.  

© 2025 Mohammad Yazdani. All rights reserved.
