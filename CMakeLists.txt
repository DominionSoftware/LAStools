##
# @brief LAStools project script
##

CMAKE_MINIMUM_REQUIRED(VERSION 3.5)

# ==================================================
# Parse project properties
# --------------------------------------------------

OPTION(BUILD_EXAMPLES "Build LASlib and LASzip example applications." OFF)
OPTION(BUILD_LASLIB "Build LASlib library." ON)
OPTION(BUILD_LASTOOLS "Build LAStools executables." ON)
OPTION(BUILD_LASZIP "Build LASzip library." ON)
SET(INSTALL_DIR "dist/$<CONFIG>" CACHE STRING "Install base directory.")

# ==================================================
# Create project
# --------------------------------------------------

PROJECT("LAStools")

IF (BUILD_EXAMPLES OR BUILD_LASTOOLS OR BUILD_LASLIB)
    ADD_SUBDIRECTORY("LASlib/src")
ENDIF()

IF (BUILD_EXAMPLES OR BUILD_LASTOOLS OR BUILD_LASZIP)
    ADD_SUBDIRECTORY("LASzip/src")
ENDIF()

IF (BUILD_LASTOOLS)
    ADD_SUBDIRECTORY("src")
ENDIF()

IF (BUILD_EXAMPLES)
    ADD_SUBDIRECTORY("LASlib/example")
    ADD_SUBDIRECTORY("LASzip/example")
ENDIF()
