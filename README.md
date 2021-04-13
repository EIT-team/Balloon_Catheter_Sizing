# Balloon Catheter Sizing #
#### Master Project Cristina Fiani - Supervisors: Dr. James Avery & Dr. Kirill Aristovich ####


## PYTHON gmsh ##
### Mesh ###
- Python gmsh (mesh generation) based on tutorial t1 https://gitlab.onelab.info/gmsh/gmsh/-/blob/master/tutorial/python/t10.py 
- Models step files (modelled on Fusion 360) into vtu files (these are used with point electrodes) 9FR, 14FR, 16FR - including fine and coarse models


## EIDORS http://eidors3d.sourceforge.net/ ##
Download Netgen
Run startup.m

### Analytical Approach ###
- Point_electrodes:
  1. Get models vtu in right directory
  2. Run with 22 electrodes for 9FR, 34 electrodes for 14FR, 38 electrodes for 16FR
- Surface_electrodes_netgen:
  1. Run with 16 electrodes if electrodes placed with 2*pi (this does not work for 16FR) or 8 electrodes if electrodes placed with pi


### EIT RECONSTRUCTIONS ###
- EIT_reconstructions_3D_abs_point:
  1. Use 8 electrodes per ring and protocol sp_mp1920.xlsx
  2. Change corresponding coarse and fine models if reconstructing for 9FR, 14FR or 16FR
- Hyperparameter_matrix 
- test_reconstruction_blob
- Additional protocols (560 measurements, 56 measurements)


### EXPERIMENTAL WITH ARDUINO ###
- Two-electrode method
- Four-electrode method
