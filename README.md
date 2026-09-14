Asynchronous FIFO in SystemVerilog

Overview

This repository contains a robust, fully synthesizable Asynchronous FIFO (First-In-First-Out) memory buffer implemented in SystemVerilog. It is designed to safely and reliably transfer data between two independent, asynchronous clock domains.

The design relies on Gray code pointers and 2-stage flip-flop synchronizers to mitigate metastability issues during Clock Domain Crossing (CDC). The architecture ensures that "Full" and "Empty" flags are generated accurately and pessimistically to prevent data overflow and underflow.

References

This design is heavily inspired by the techniques described in Clifford E. Cummings' SNUG paper: "Simulation and Synthesis Techniques for Asynchronous FIFO Design".