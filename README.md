[![Build Status](https://travis-ci.com/artur-martsinkovskyi/gocia.svg?branch=master)](https://travis-ci.com/artur-martsinkovskyi/gocia)

[![Build Status](https://travis-ci.com/artur-martsinkovskyi/gocia.svg?branch=master)](https://travis-ci.com/artur-martsinkovskyi/gocia)
# Gocia

This project is a practical part of Master's thesis research in world generation and social simulation. It involves procedural generation, combinatorics and a lot of specific algorithms in order to reach sufficient levels of plausibility in simulation of landscape, water, and people(rather monkeys at this stage but still).

# Overview
There are two parts in Socia main lifecycle - initial world generator and stepping engine(stepper).

**Intial world generator** procedurally generates terrain, water, resources and vegetation along with initial constraints and features of the world(like earthquake possibility and damage, meteor strikes, high radiation levels, etc.). Depending on the initial settings, people, transport communications and other things may be also generated initially.

**Stepping engine** is a main loop of the application. It updates state of each object depending on the states of related objects, constraints of the world and object itself. The engine also allows for backtracking, so each step can be reverted to any point in history.

## Installation

Clone this repo, install the dependencies required to run the visual part of Gosu framework depending on your system [here](https://github.com/gosu/gosu/wiki). Then run `bundle` and you should be good to go. It is better to use the newer version of ruby like 2.7. It can be installed using [rvm](https://rvm.io/). Once bundle is done you are good to go.

## Usage

You can run the app running the file `./exe/gocia`. It will launch the Gocia window and show you the terrain. To start simulation press `Y`, to go back `T`. `M` turns music on/off. Have fun.

## Code of Conduct

Everyone interacting in the Gocia project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/artur-martsinkovskyi/hackasm/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2020 Artur Martsinkovskyi. See [MIT License](LICENSE.txt) for further details.

