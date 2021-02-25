#!/bin/bash

usage()
{
cat << EOM
usage:
    $0 [--submodule] [--image [name]] [--run [name]] [--help]
    --submodule update submodules
    --image create a docker image for fsm
        [name] the image name, defaults to fsm
    --run run a docker container interactivaly
        [name] the container name, defaults to fsm-container
    --help show this help and exit
EOM
exit
}

destdir=stdfsm
image_name=fsm:latest
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
            if [[ $1 != --* ]] && [[ $1 != "" ]]
            then
                image_name=$1
                shift
            fi            
        ;;
        --run) 
            run=true
            shift
            if [[ $1 != --* ]] && [[ $1 != "" ]]
            then
                container_name=$1
                shift
            fi            
	;;
	--help)
	    usage;
	;;
        *) break
    esac    
done

if ! $submodule && ! $image && ! $run
then
    usage
fi

### submodule
if $submodule
then
	echo "git submodule update --init --recursive"
	git submodule update --init --recursive
fi

### docker 

# create fsm image
if $image
then
    echo "docker image build -t ${image_name}"
    docker image build --tag ${image_name} .
fi

# start the fsm container
if $run 
then
    echo "docker container run -it -v ${PWD}:/home/fsm/ --name ${container_name} $image_name"
    docker container run -it -v ${PWD}:/home/fsm/ --name ${container_name} $image_name
fi

