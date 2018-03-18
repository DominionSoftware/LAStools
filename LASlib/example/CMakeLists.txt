##
# @brief LASlib example executables script
##

CMAKE_MINIMUM_REQUIRED(VERSION 3.5)

# ==================================================
# Define library files
# --------------------------------------------------

SET(sources
    "lasexample.cpp"
    "lasexample_add_rgb.cpp"
    "lasexample_simple_classification.cpp"
    "lasexample_write_only.cpp"
    "lasexample_write_only_with_extra_bytes.cpp")

# ==================================================
# Create executables
# --------------------------------------------------

FOREACH(source ${sources})

    # Build project name by removing source file extension
    STRING(REPLACE ".cpp" "" executable ${source})

    ADD_EXECUTABLE(${executable} ${source})

    TARGET_LINK_LIBRARIES(${executable} "LASlib" "LASzip-static")
    IF (UNIX OR MINGW)
        TARGET_COMPILE_OPTIONS(${executable} PRIVATE $<$<CONFIG:Release>: "-O3" >)
        TARGET_COMPILE_OPTIONS(${executable} PRIVATE
            "-Wall"
            "-Wno-strict-aliasing"
            "-Wno-unused-result"
            "-std=gnu++11")
    ENDIF()

    INSTALL(TARGETS ${executable} RUNTIME DESTINATION "${INSTALL_DIR}/bin")

ENDFOREACH()
