# Analog-Design-Toolkit
A small collection of tools to allow for ease of analog design. These tools aim to enable the characterisation of the analog performance and its capabilities in the sky130A PDK. Contributions of differing tools and results are encouraged.

## Gm over ID 
The "gm over id" tool is a simple spice script that sweeps a FET placed in the same test bench. The fundamental principle of the tool hinges upon the gm/id theorem, also known as transconductance efficiency. There are many resources on the internet explaining this concept, but to summarise, it is a methodology to indicate how much "gm" you get per "id" (i.e. how well you have control over the channel, thus indicating the inversion region). The tool generates four plots that are intended to provide basic transistor performance:
 - gm/id versus Vgs
 - gm / gds ("intrinsic" gain) versus gm/id
 - gm / Cgg (transistor "ft") versus gm/id
 - gds / Cgd (transistor "3db") versus gm/id

It should be noted that a critical assumption is made: The dominant pole is formed from a combination of the drain-source conductance and the drain-source capacitance. In reality, this is only an approximation as there are certainly more capacitances present on the drain (along with Cgs).

Some indicative results for transition frequency, gain and current density produced by gmid.sch can be found below:
![image](https://github.com/user-attachments/assets/d6006216-9e5c-4494-a7c2-ebe284461503)
![image](https://github.com/user-attachments/assets/ac3daebf-5ea6-492b-b59d-943ddb33b000)
![image](https://github.com/user-attachments/assets/d947f3e8-f030-429d-a8a9-cc7b87b615d3)
