# Balloon Catheter Sizing

Software and firmware for "Lumen Shape Reconstruction using a Soft Robotic Balloon Catheter and Electrical Impedance Tomography" as presented at IROS 2022 [figshare](https://doi.org/10.6084/m9.figshare.16784038) or [arxiv](https://arxiv.org/abs/2207.12536)

## Requirements

- MATLAB tested only with >2019b
- [EIDORS](http://eidors3d.sourceforge.net/) - for forward modelling and absolute solvers
- [gmsh](https://gmsh.info/) - for meshing CAD files drawings
- [meshio2matlab](https://github.com/Jimbles/meshio2matlab) - to write VTU files and load gmsh files into matlab
- [Reconstruction](https://github.com/EIT-team/Reconstruction) - MATLAB library with cross validated Tikhonov 0 EIT solvers
- [ElikoQuadraMatlab](https://github.com/Jimbles/ElikoQuadra) - Library to load Eliko Quadra data
- [MS5903 Library](https://github.com/sparkfun/SparkFun_MS5803-14BA_Breakout_Arduino_Library) - for the pressure sensor
- [uStepper S-Lite](https://github.com/uStepper/uStepper-S-lite) - library for the [uStepper S-lite](https://ustepper.com/store/ustepper-boards/26-ustepper-s-lite.html) motor board for the syringe pump

## Folder overview

- [Cristina Masters](/Cristina_Masters/) - Files for Cristina's Masters and [conference paper](https://zenodo.org/record/4940249) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4940249.svg)](https://doi.org/10.5281/zenodo.4940249)
- [hardware](/hardware/) - CAD files for Catheter and FPC, Arduino Motor controllers
- [numerical_analysis](/numerical_analysis/) - Scripts for analysis of the optimal electrode configuration
- [imaging](/imaging/) - Scripts to generate EIT images
