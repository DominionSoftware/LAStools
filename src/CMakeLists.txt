##
# @brief LAStools executables script
##

CMAKE_MINIMUM_REQUIRED(VERSION 3.5)

# ==================================================
# Define library files
# --------------------------------------------------

SET(sources
    "las2las.cpp"
    "las2txt.cpp"
    "lasdiff.cpp"
    "lasindex.cpp"
    "lasinfo.cpp"
    "lasmerge.cpp"
    "lasprecision.cpp"
    "laszip.cpp"
    "txt2las.cpp")

# ==================================================
# Create executables
# --------------------------------------------------

FOREACH(source ${sources})

    # Build project name by trimming extension
    STRING(REPLACE ".cpp" "" executable ${source})
    ADD_EXECUTABLE(${executable} ${source}
        "geoprojectionconverter.cpp"
        "geoprojectionconverter.hpp")

    TARGET_LINK_LIBRARIES(${executable} "LASlib" "LASzip-static")
    IF (UNIX OR MINGW)
        TARGET_COMPILE_OPTIONS(${executable} PRIVATE $<$<CONFIG:Release>: "-O3" >)
        TARGET_COMPILE_OPTIONS(${executable} PRIVATE
            "-Wall"
            "-Wno-deprecated"
            "-Wno-strict-aliasing"
            "-Wno-write-strings"
            "-Wno-unused-result"
            "-std=gnu++11")
    ENDIF()

    INSTALL(TARGETS ${executable} RUNTIME DESTINATION "${INSTALL_DIR}/bin")

ENDFOREACH()
