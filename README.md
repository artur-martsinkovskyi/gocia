[![Build Status](https://travis-ci.com/artur-martsinkovskyi/gocia.svg?branch=master)](https://travis-ci.com/artur-martsinkovskyi/gocia)

# gocia
This project is a practical part of Master's thesis research in world generation and social simulation. It involves procedural generation, combinatorics and a lot of specific algorithms in order to reach sufficient levels of plausibility in simulation of landscape, water, and people(rather monkeys at this stage but still).

# Overview
There are two parts in Socia main lifecycle - initial world generator and stepping engine(stepper). 

**Intial world generator** procedurally generates terrain, water, resources and vegetation along with initial constraints and features of the world(like earthquake possibility and damage, meteor strikes, high radiation levels, etc.). Depending on the initial settings, people, transport communications and other things may be also generated initially.

**Stepping engine** is a main loop of the application. It updates state of each object depending on the states of related objects, constraints of the world and object itself. The engine also allows for backtracking, so each step can be reverted to any point in history.
