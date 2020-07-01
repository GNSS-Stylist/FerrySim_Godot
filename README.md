# FerrySim_Godot

Godot-project for simulating a ferry and to ease prototyping/testing of a location/orientation solver utilizing "simulated" GNSS-receivers. Location/orientation solver (and a simple autopilot) is implemented in this "controller": https://github.com/GNSS-Stylist/SimFerryController (coded with Qt/C++). Communication between the controller and this simulator is done with a very simple UDP-based protocol.

Note that this needs a special compilation of Godot to work (compiled with a slightly modified hydrodynamics module and a few tweaks to Godot itself). You can download the sources from https://github.com/GNSS-Stylist/godot/tree/FerrySim_V100 and a win32-executable from https://github.com/GNSS-Stylist/godot/releases/download/FerrySim_V100/godot.windows.tools.32.exe

This is heavily based (in addition to Godot's functionality) on these (thanks a lot for sharing!):

# HydroSimpleDemo

Simple Godot 3.1+ project to demonstrate the HydroRigidBody node from https://gitlab.com/ringtechsolutions/godot-tools/hydro/hydro

Contains three cubes of various weights, and two very simple boats that will automatically drive in a circle.  One has debugging enabled, so you can see the forces acting upon the 
boat.

The ocean was shamelessly stolen from https://github.com/SIsilicon/Godot-Ocean-Demo and you can adjust the wave parameters to see the effect on the objects.  You can also collide 
with the objects to push them around, attempt to sink them, or play water polo.

Ocean demo readme follows below:

# Godot-Ocean-Demo
An ocean demo in Godot 3.0.
I am very proud of this demo and I want to thank you for trying it out.

## How to customize the ocean
The ocean demo uses what's known as Gerstner waves. A constant collection of them is used to create that *wavy* feel of the waters. It also uses a lil bit of noise to really sell the effect. Both of these features are customizable with almost self-explanatory parameters.

### Main wave parameters

-**Amplitude** defines how high your waves will be.

-**Wavelength** defines how long your waves will be.

-**Steepness** defines how 'choppy' your waves will be. Don't set this too high or else your waves will start self-intersecting.

-**Wind Direction** controls the direction the overall waves would go.

-**Wind Align** also determines each wave's individual direction. A value of *one* means they all go in the exact same direction. A value of *zero* means waves go in completely random directions.

-**Speed** controls how fast the waves propagates.

-**Seed** determines the final parameters of each wave. Find the seed that you like the best.

### Noise parameters

-**Noise Enabled**. Yeah. Whether to use noise at all.

-**Noise Amp** controls how high the noise looks.

-**Noise Freq** controls the smoothness/granularity of the noise. Higher values make it smoother and less granular.

-**Noise Speed** controls how fast the waves propagate.

## First Person Control

When running the project(sorry if it's slow to load. I'm looking into that.) You can fly around. Look at your ocean from every angle. And you can do so like this.

-Use your **mouse** to look around.

-**W key** go forward.

-**S key** go backward.

-**A key** go left.

-**D key** go right.

-**CTRL key** toggle between fly and edit mode. You cant play with the ocean parameters and fly at the same time.

-**Q key** go down.

-**E key** go up.

-**R key** randomize new GNSS-antenna positions.

-**T key** Increase fly speed.

-**G key** Decrease fly speed.

-**C key** Move GNSS-antennas to the corners of the ferry.

-**B key** Spawn a new 1 m3 buoyant **b**ox (cube).

-**Left mouse button** activate stick-type manipulator.

-**Right mouse button** activate plate-type manipulator.

-**Number keys** Change camera.

# Credits

The flying code is from Jeremy Bullock's youtube tutorial series on first person control.
