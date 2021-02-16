#!/bin/bash

usage()
{
cat << EOM
usage:
    $0 [--submodule] [--image [name]] [--run [name]]
    --submodule update submodules
    --image create a docker image for fsm
        [name] the image name, defaults to fsm
    --run run a docker container interactivaly
        [name] the container name, defaults to fsm-container
EOM
exit
}

destdir=stdfsm
image_name=fsm
container_name=fsm-container

submodule=false
image=false
run=false

while :; do
    case $1 in
        --submodule) 
            submodule=true
            shift
        ;;
        --image) 
            image=true
            shift
            if [[ $1 != --* ]] 
            then
                image_name=$1
                shift
            fi            
        ;;
        --run) 
            run=true
            shift
            if [[ $1 != --* ]] 
            then
                container_name=$1
                shift
            fi            
	;;
        *) break
    esac    
done

if [ submodule=false -a image=false -a run=false ]
then
    usage
fi

cat << EODEBUG
submodule:      $submodule

image:          $image
image_name:     $image_name

run:            $run
container_name: $container_name
EODEBUG

exit

### submodule

## fsm
if [ submodule = true ]
then
	git submodule update --init --recursive
fi


### docker 

# create fsm image
docker image build -t fsm .

# start the fsm container
docker container run -it -v ${PWD}:/home/fsm/ --name fsm-container fsm

#### from within the container ####

# build graph library
cd graph
mkdir build
cmake -B build
make -C build
cd /home/fsm/

# for generating pdf paper
cd papers
make P2284.pdf
# P2284.pdf file is in generated/ directory

# build fsm library
cd home/fsm/stdfsm
mkdir build
cmake
cmake -B build
make -C build
cd /home/fsm

