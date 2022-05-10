#!/usr/bin/env sh

if [ ! -d phys ]; then
    git clone git@github.com:mgduda/shared_physics.git phys
else
    printf "Physics directory already exists!\n\n"
fi
