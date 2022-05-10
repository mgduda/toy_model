#!/usr/bin/env sh

################################################################################
# import_physics.sh
#
# The purpose of this script is to obtain a specific version of physics schemes
#   from an external git repository. At present, the only method for acquiring
#   these tables is through git, though in future additional methods could be
#   employed, e.g., using svn or by downloading a physics release from a website
#   with curl.
#
#
# Set the variables, below, to match the requirements of the host model:
#  - which version of physics are to be obtained,
#  - the repository from which physics will be obtained, and
#  - the local directory where physics will be placed.
#
################################################################################

physics_version=v2.0

physics_repo=git@github.com:mgduda/shared_physics.git

physics_dir=phys



##### Generally no need to modify script beyond this point #####

if [ ! -d ${physics_dir} ]; then
    git clone ${physics_repo} ${physics_dir}
    if [ ! -d ${physics_dir} -o $? -ne 0 ]; then
        printf "***********************************************************\n"
        printf "Error: Failed to clone ${physics_repo} into ${physics_dir}!\n"
        printf "***********************************************************\n"
        exit 1
    fi

    cd ${physics_dir}
    git checkout ${physics_version}
    if [ $? -ne 0 ]; then
        printf "***********************************************************\n"
        printf "Error: Failed to checkout physics version ${physics_version}!\n"
        printf "***********************************************************\n"
	cd ..
	rm -rf ${physics_dir}
        exit 1
    fi
else
    printf "Physics directory ${physics_dir} already exists!\n"

    cd ${physics_dir}
    vers=`git describe`
    versdirty=`git describe --dirty`

    if [ "${vers}" != "${physics_version}" ]; then
        printf "Need to switch from physics version ${vers} to ${physics_version}...\n"

        if [ "${vers}" != "${versdirty}" ]; then
            printf "***********************************************************\n"
            printf "Error: Cannot obtain physics version ${physics_version}.\n"
            printf "       Physics version ${vers} is currently checked out and\n"
            printf "       has local modifications.\n"
            printf "***********************************************************\n"
            exit 1
        fi

        git checkout ${physics_version}
        if [ $? -ne 0 ]; then
            printf "***********************************************************\n"
            printf "Error: Failed to checkout physics version ${physics_version}!\n"
            printf "***********************************************************\n"
            exit 1
        fi

        printf "\nPhysics are now at version ${physics_version}\n\n"
        exit 0

    elif [ "${vers}" != "${versdirty}" ]; then
        printf "***********************************************************\n"
        printf "NOTE: physics contain local modifications to version ${vers}\n"
        printf "***********************************************************\n"
        exit 0
    fi

    printf "\nPhysics are already at version ${physics_version}\n"
    exit 0
fi

printf "\nSuccessfully obtained physics version ${physics_version}!\n"
exit 0
