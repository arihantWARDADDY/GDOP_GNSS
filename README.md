# Urban Canyon Simulation for GNSS Positioning Accuracy

This repository contains the MATLAB implementation and analysis of Geometric Dilution of Precision (GDOP) in urban canyon environments. Urban canyons, characterized by tall buildings and narrow streets, pose significant challenges to GNSS positioning due to obstructed satellite visibility and increased multipath effects. This project simulates these effects and explores strategies to improve positioning accuracy.

## Features

- **Urban Canyon Simulation:**
  - Models the impact of obstructed satellite visibility and multipath on GDOP.
  - Incorporates real-world constraints such as tall structures blocking GNSS signals.

- **Dynamic Satellite Visibility:**
  - Simulates scenarios where some satellites are blocked and calculates resulting GDOP.
  - Automatically adds additional satellites to improve GDOP when visibility is insufficient.

- **Visualization:**
  - 3D plots of satellite and receiver positions.
  - Highlights blocked satellites and the effect on positioning geometry.

- **Improvement Strategies:**
  - Simulates the addition of multi-GNSS systems (e.g., GPS and Galileo) to mitigate high GDOP.
  - Explores advanced techniques like cloud-assisted positioning.

## Key Results

- **GDOP Analysis:**
  - High GDOP values (~6.67) indicate poor satellite geometry in urban canyon scenarios, leading to significant positioning errors.
  - Improving satellite visibility through multi-system GNSS integration can reduce GDOP and enhance accuracy.

- **Impact of Obstructions:**
  - Physical obstructions and multipath effects degrade positioning reliability.
  - Simulation results show how strategically adding satellites or systems can mitigate these effects.

## Dependencies

- MATLAB R2020a or later
- GNSS Toolbox (optional but recommended for advanced functionalities)


