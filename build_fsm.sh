#!/bin/bash

# build fsm library
build_dir=build
cd fsm
if [ ! -d ${build_dir} ]
then
    mkdir ${build_dir}
fi
cmake -B ${build_dir}
make -C ${build_dir}

