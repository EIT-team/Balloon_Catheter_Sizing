# Balloon Catheter Sizing #
#### Master Project Cristina Fiani - Supervisors: Dr. James Avery & Dr. Kirill Aristovich ####


## PYTHON gmsh ##
### Mesh ###
- Python gmsh (mesh generation) based on tutorial t10 https://gitlab.onelab.info/gmsh/gmsh/-/blob/master/tutorial/python/t10.py 
- Models step files (modelled on Fusion 360) into vtu files (these are used with point electrodes) 9FR, 14FR, 16FR - including fine and coarse models
- Mesh quality obtained with Joe-Liu metric (Download folder https://github.com/fangq/iso2mesh)


## EIDORS http://eidors3d.sourceforge.net/ ##
Download Netgen and run startup.m
Prepare models vtu and excel files needed in right directory

### Analytical Approach ###
- Point electrodes:
  1. Get models vtu in right directory
  2. Run with 22 electrodes for 9FR, 34 electrodes for 14FR, 38 electrodes for 16FR (use corresponding protocol excel file)
- Surface electrodes Netgen:
  1. Run with 16 electrodes if electrodes placed with 2*pi (this does not work for 16FR) or 8 electrodes if electrodes placed with pi (use corresponding protocol excel file)
- Sensitivity analysis calculating Jacobian and observing on ParaView


### EIT RECONSTRUCTIONS ###
- EIT_reconstructions_3D_abs_point:
  1. Use 8 electrodes per ring and protocol sp_mp1920.xlsx
  2. Change corresponding coarse and fine models if reconstructing for 9FR, 14FR or 16FR
- Hyperparameter matrix (heuristic approach)
- Test Reconstruction Blob
- Additional protocols (560 measurements, 56 measurements)


### EXPERIMENTAL WITH ARDUINO ###
- Two-electrode method
- Four-electrode method
- Test multiplexers
