##
# @brief LASzip example executables script
##

CMAKE_MINIMUM_REQUIRED(VERSION 3.5)

# ==================================================
# Create executable
# --------------------------------------------------

ADD_EXECUTABLE("laszippertest" "laszippertest.cpp")

TARGET_LINK_LIBRARIES("laszippertest" "LASzip-static")
IF (UNIX OR MINGW)
    TARGET_COMPILE_OPTIONS("laszippertest" PRIVATE $<$<CONFIG:Release>: "-O3" >)
    TARGET_COMPILE_OPTIONS("laszippertest" PRIVATE
        "-Wall"
        "-Wno-strict-aliasing"
        "-std=gnu++11")
ENDIF()

INSTALL(TARGETS "laszippertest" RUNTIME DESTINATION "${INSTALL_DIR}/bin")
