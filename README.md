# gocia
This project is a practical part of Master's thesis research in world generation and social simulation. It involves procedural generation, combinatorics and a lot of specific algorithms in order to reach sufficient levels of plausibility in simulation of landscape, water, people, objects and institutions.

# Overview
There are two parts in Socia main lifecycle - initial world generator and stepping engine(stepper). 

**Intial world generator** procedurally generates terrain, water, resources and vegetation along with initial constraints and features of the world(like earthquake possibility and damage, meteor strikes, high radiation levels, etc.). Depending on the initial settings, people, transport communications and institution may be also generated initially. Initial world generator should be able to receive a serializable settings object(most likely JSON) and use its configuration info in the process of generation. The result of **generator** should be applicable as the initial state of **stepper** and also be serializable into a dump(also most likely a JSON).

**Stepping engine** is a main loop of the application. It updates state of each objects depending on states of related objects, constraints of the world and object itself. It should be able to be initialized with the output of **initial world generator** and to dump global state of the world into a serializable object.

Ecosystem of generated worlds consists of four parts: environment, objects, subjects and institutions.
