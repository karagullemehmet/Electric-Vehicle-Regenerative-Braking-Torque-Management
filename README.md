# Electric Vehicle Regenerative Braking & Torque Management  
### MATLAB/Simulink Integrated EV Powertrain Model

This project presents a fully integrated **EV powertrain simulation**, including vehicle dynamics, a battery model, regenerative braking control, and a Stateflow-based ECU torque management system. The model reproduces the interaction between traction, braking, and energy recovery similar to real automotive BMS–ECU systems.

---

## 🚗 System Overview

### **1. Vehicle Dynamics**
- Longitudinal dynamics modeled using Newton’s law \( F = m a \)
- Wheel torque → vehicle speed mapping  
- Acceleration/braking response based on pedal inputs  
- Motor angular speed and tractive effort calculation  

---

## 🔋 Battery Model
- Simplified **1-RC equivalent circuit**
- SOC estimation using Coulomb counting  
- Terminal voltage computation \( T_{cell} \)  
- Accurate representation of negative charging current during regen

---

## ⚡ Regenerative Braking Controller
A complete regen strategy is implemented:

- Motor transitions to **generator mode** during braking  
- Torque is computed using \( P = T \omega \)
- **2-D Lookup Table** (SOC × Motor Speed) → maximum regen power  
- Regen limits based on:
  - High SOC  
  - Low vehicle speed  
  - Excessive charge current  
  - Cell voltage  
- Smooth blending with mechanical braking

---

## 🧠 ECU Stateflow Controller
The ECU manages torque requests and state transitions:

- Driving states: **Idle → Drive → Braking**
- Supervisory control of:
  - Requested torque  
  - Regen torque  
  - Motor torque command  
- Integration of BMS limits  
- Low-speed cutoff and ABS flag support

---

## 📊 Simulation Results
The model outputs:

- Battery SOC evolution  
- Battery current (positive = discharge, negative = regen)  
- Terminal voltage \(T_{cell}\)  
- Vehicle speed profile  
- ECU torque request  
- Motor vs wheel torque comparison  

All results are plotted automatically using the provided MATLAB analysis script.

---

## 📂 File Structure
