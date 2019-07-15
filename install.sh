#!/bin/bash
cd mapbox-gl-native
git submodule init
git submodule update
# # This takes like 20 mins
time make iframework FORMAT=static BUILDTYPE=Release
<<<<<<< HEAD
=======

>>>>>>> 75fe45da41778428877d7ea2bf5bb422b6ea002c
