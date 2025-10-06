"""
Author: Mohammad Yazdani
Email:  mohamad.yazdani7990@gmail.com
Date:   2025

Description:
    This script demonstrates how to control and extract data from Aspen Adsorption
    using Python through the Aspen Custom Modeler (ACM) COM interface.

    Aspen Adsorption runs as a specialized Aspen Custom Modeler (ACM) environment,
    allowing direct communication with its simulation objects, parameters, and variables.

    The example uses a simple Pressure Swing Adsorption (PSA) model for hydrogen purification.
    It shows how to:
        - Launch Aspen Adsorption (via Aspen Custom Modeler)
        - Modify model input variables (e.g., bed geometry, step times)
        - Initialize and run the simulation
        - Extract performance results (e.g., purity and recovery)
        - Safely close the Aspen session

Important Note:
    All attached or supporting files must be located in the same folder
    as the Aspen simulation (.ada) file. This includes:
        - .ada → Aspen Adsorption simulation file
        - .f   → User-defined Fortran subprocedure files

    Keeping these files together ensures that Aspen Adsorption can locate
    and compile any custom subroutines required for the simulation to run correctly.

For more details or collaboration inquiries, please contact:
    Mohammad Yazdani — mohamad.yazdani7990@gmail.com
"""

import subprocess
import time
from comtypes import client

"""
Step 1: Define Aspen Adsorption paths

Replace the ADA_FILE path with the actual location of your Aspen Adsorption model (.ada).
"""
ASPEN_PATH = r"C:\Program Files\AspenTech\AMSystem V14.0\Bin\AspenModeler.exe"   # Path to Aspen Modeler executable
ADA_FILE = r"C:\Path\To\Your\Simulation\H2PSA.ada"                               # Example: r"C:\Users\YourName\Desktop\H2PSA\H2PSA.ada"

"""
Step 2: Launch Aspen Adsorption using subprocess

This opens the Aspen Modeler application with your PSA model file.
"""
subprocess.Popen([ASPEN_PATH, ADA_FILE])
print("Opening Aspen Adsorption...")

"""
Step 3: Wait until Aspen Adsorption (ACM) is ready to connect through COM interface

The script checks every few seconds until the Aspen COM object becomes available.
"""
while True:
    try:
        ACM = client.GetActiveObject("ACM application")
        print("Connected to Aspen Adsorption (Aspen Custom Modeler).")
        break
    except Exception:
        time.sleep(5)

"""
Step 4: Access the main simulation and flowsheet objects

These objects give control over the units and variables inside Aspen Adsorption.
"""
Simulation = ACM.Simulation
Flowsheet = Simulation.Application.Simulation.Flowsheet

"""
Step 5: Set process input variables for the PSA model

These include feed pressure, bed geometry, and the adsorption/repressurization step time.

Note:
All other parameters can be changed in the same way explained below.
These are just conventional examples to show how to locate and modify variables.

In Aspen Adsorption, you can access or modify any block variable (such as time, pressure, or temperature)
by following this structure in the Exploring Panel:

    Flowsheet > Blocks > [Block Name] > AllVariables > [Parameter]

Example:
    Cycle_Organizer > Cycle_Data(1).Step_Data(1).StepTime

Note that Aspen uses 1-based indexing, while Python uses 0-based indexing.
So the above example in Python becomes:
    Flowsheet.Cycle_Organizer.Cycle_Data[0].Step_Data[0].StepTime

To change the value:
    Flowsheet.Cycle_Organizer.Cycle_Data[0].Step_Data[1].StepTime.Value = 4.0

Here, Step_Data[1] corresponds to Step 2 in Aspen,
which represents the "Adsorption & Supply to Repressurization" step.
"""
Flowsheet.F1.P.Value = 10.0         # Feed pressure during adsorption (bar)
Flowsheet.B1.Layer[0].Hb.Value = 2.1  # Bed height (m)
Flowsheet.B1.Layer[0].Db.Value = 0.06 # Bed diameter (m)
Flowsheet.Cycle_Organizer.Cycle_Data[0].Step_Data[1].StepTime.Value = 4.0  # Step 2 duration = 4 minutes

print("Input parameters have been set.")

"""
Step 6: Initialize simulation units

This step initializes the adsorption bed and the corresponding gas tank voids
before running the full cyclic simulation.

To initialize each unit, follow this structure:
    Flowsheet.[Block Name].Initialize_Unit

Example:
    Flowsheet.B1.Initialize_Unit
    Flowsheet.TD1.Initialize_Unit
    Flowsheet.TD2.Initialize_Unit

Initialization ensures that all units in Aspen Adsorption have valid starting
conditions (pressure, temperature, and concentration) before running the simulation.
"""
Flowsheet.B1.Initialize_Unit
Flowsheet.TD1.Initialize_Unit
Flowsheet.TD2.Initialize_Unit
print("Bed and gas tank voids initialized successfully.")

"""
Step 7: Run the simulation

Aspen Adsorption includes several run modes, but in this example
we only use two:
    - Initialization (to prepare the system)
    - Dynamic (to perform the cyclic simulation)
"""
Simulation.RunMode = "Initialization"
Simulation.Run(True)
Simulation.RunMode = "Dynamic"
Simulation.Run(True)
print("Simulation run completed.")

"""
Step 8: Accessing simulation results

You can extract performance and operating data directly from Aspen Adsorption using Python.
Results can be accessed from both Streams and Blocks as follows:

Exploring Panel:
    Flowsheet > Streams > [Stream Name] > AllVariables > [Variable Name]
    Flowsheet > Blocks  > [Block Name]  > AllVariables > [Variable Name]

Examples in Python:
    Flowsheet.S2.Cycle_Avg_Composition_Fwd[0].Value   # H2 composition in Stream S2
    Flowsheet.B1.Layer[0].Tg[0]                       # Gas temperature in the first node of Bed B1
"""

"""
Step 9: Extract key performance results

Here we extract and print hydrogen purity and recovery.
"""
purity = Flowsheet.P1.Cycle_Avg_Composition_Fwd[0].Value * 100
recovery = (
    Flowsheet.P1.Cycle_Total_Component_Fwd[0].Value /
    Flowsheet.F1.Cycle_Total_Component_Fwd[0].Value
) * 100

print(f"H2 Purity: {purity:.2f}%")
print(f"H2 Recovery: {recovery:.2f}%")

"""
Step 10: Close Aspen Adsorption

This terminates the Aspen Custom Modeler session safely after results are extracted.
"""
ACM.Quit()
print("Aspen Adsorption closed (ACM session terminated).")
