#!/bin/bash

# ----------------------------------------------------------------------
#   DESCRIPTION:
#       Developer script to build LAStools.
#   USAGE
#       Run "build.sh -h" for available options.
#   REQUIREMENTS:
#       Add the following to the PATH.
#           - CMake 3.5 or later
#           - g++ 5.3.0 or later
# ----------------------------------------------------------------------

set -eu

# Define build defaults.
BUILD_EXAMPLES=OFF
BUILD_GENERATOR="Unix Makefiles"
BUILD_TYPE=Release

DIR_BATCH=$(readlink -f $(dirname ${BASH_SOURCE[0]}))
pushd $DIR_BATCH > /dev/null
DIR_SRC=$PWD
popd > /dev/null
DIR_BUILD=$PWD/build

# Display usage
__usage()
{
    echo "Usage: $0 [options]"
    echo ""
    echo "    -b = <Directory>      Build directory (Default: build)"
    echo "    -c = <Release|Debug>  Build type (Default: $BUILD_TYPE)"
    echo "    -e =                  Build example executables"
    echo "    -g = <Generator>      CMake generator (Default: $BUILD_GENERATOR)"
    echo "    -h =                  Display this usage"
}

# Parse arguments
while getopts :hb:c:eg: flag ; do
    case $flag in
        b) DIR_BUILD=$OPTARG; ;;
        c) BUILD_TYPE=$OPTARG; ;;
        e) BUILD_EXAMPLES=ON; ;;
        g) BUILD_GENERATOR=$OPTARG; ;;
        h) __usage; exit 0; ;;
        *) echo "Invalid option: -$OPTARG" >&2; exit 1; ;;
    esac
done
shift $((OPTIND-1))

# Create build directory
mkdir -p $DIR_BUILD
pushd $DIR_BUILD > /dev/null
DIR_BUILD=$PWD

echo -------------------------------------------------------------------
echo Configuration
echo        Build Type: $BUILD_TYPE
echo   Build Generator: $BUILD_GENERATOR
echo  Source Directory: $DIR_SRC
echo   Build Directory: $DIR_BUILD
echo Install Directory: $DIR_BUILD/dist

echo -------------------------------------------------------------------
echo Generating project ...

pushd $DIR_BUILD > /dev/null
cmake -G"$BUILD_GENERATOR" \
      -DCMAKE_INSTALL_PREFIX="$DIR_BUILD" \
      -DBUILD_EXAMPLES=$BUILD_EXAMPLES \
      "$DIR_SRC"

echo -------------------------------------------------------------------
echo Building project ...

cmake --build "$DIR_BUILD" \
      --target install \
      --config $BUILD_TYPE
