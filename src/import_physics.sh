#!/usr/bin/env sh

#
# Set the following to match the requirements of the host model:
# which version of physics are to be obtained,
# the repository from which physics will be obtained, and
# the local directory where physics will be placed.
#
physics_version=v1.0

physics_repo=git@github.com:mgduda/shared_physics.git

physics_dir=phys


##### Generally no need to modify script beyond this point #####

if [ ! -d ${physics_dir} ]; then
    git clone ${physics_repo} ${physics_dir}
    if [ ! -d ${physics_dir} -o $? -ne 0 ]; then
        printf "\nFailed to clone ${physics_repo} into ${physics_dir}!\n\n"
        exit 1
    fi

    cd ${physics_dir}
    git checkout ${physics_version}
    if [ $? -ne 0 ]; then
        printf "\nFailed to checkout physics version ${physics_version}!\n\n"
	cd ..
	rm -rf ${physics_dir}
        exit 1
    fi
else
    printf "Physics directory already exists!\n\n"
    exit 0
fi

printf "\nSuccessfully obtained physics version ${physics_version}!\n\n"
