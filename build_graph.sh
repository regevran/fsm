#!/bin/bash

home=PWD

# build graph library
build_dir=build
cd graph
if [ ! -d ${build_dir} ]
then
    mkdir ${build_dir}
fi
cmake -B ${build_dir}
make -C ${build_dir}

