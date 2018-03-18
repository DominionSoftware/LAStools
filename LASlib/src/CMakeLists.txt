##
# @brief LASlib library script
##

CMAKE_MINIMUM_REQUIRED(VERSION 3.5)

# ==================================================
# Define library files
# --------------------------------------------------

SET(sources
    "fopen_compressed.cpp"
    "lasfilter.cpp"
    "lasreader.cpp"
    "lasreader_asc.cpp"
    "lasreader_bil.cpp"
    "lasreader_bin.cpp"
    "lasreader_dtm.cpp"
    "lasreader_las.cpp"
    "lasreader_qfit.cpp"
    "lasreader_shp.cpp"
    "lasreader_txt.cpp"
    "lasreaderbuffered.cpp"
    "lasreadermerged.cpp"
    "lasreaderpipeon.cpp"
    "lasreaderstored.cpp"
    "lastransform.cpp"
    "lasutility.cpp"
    "laswaveform13reader.cpp"
    "laswaveform13writer.cpp"
    "laswriter.cpp"
    "laswriter_bin.cpp"
    "laswriter_las.cpp"
    "laswriter_qfit.cpp"
    "laswriter_txt.cpp"
    "laswriter_wrl.cpp"
    "laswritercompatible.cpp")

SET(headers
    "../inc/lasdefinitions.hpp"
    "../inc/lasfilter.hpp"
    "../inc/lasreader.hpp"
    "../inc/lasreaderbuffered.hpp"
    "../inc/lasreadermerged.hpp"
    "../inc/lasreaderpipeon.hpp"
    "../inc/lasreaderstored.hpp"
    "../inc/lasreader_asc.hpp"
    "../inc/lasreader_bil.hpp"
    "../inc/lasreader_bin.hpp"
    "../inc/lasreader_dtm.hpp"
    "../inc/lasreader_las.hpp"
    "../inc/lasreader_qfit.hpp"
    "../inc/lasreader_shp.hpp"
    "../inc/lasreader_txt.hpp"
    "../inc/lastransform.hpp"
    "../inc/lasutility.hpp"
    "../inc/laswaveform13reader.hpp"
    "../inc/laswaveform13writer.hpp"
    "../inc/laswriter.hpp"
    "../inc/laswritercompatible.hpp"
    "../inc/laswriter_bin.hpp"
    "../inc/laswriter_las.hpp"
    "../inc/laswriter_qfit.hpp"
    "../inc/laswriter_txt.hpp"
    "../inc/laswriter_wrl.hpp")

# ==================================================
# Create library
# --------------------------------------------------

ADD_LIBRARY("LASlib" STATIC ${sources} ${headers})

TARGET_INCLUDE_DIRECTORIES("LASlib" PUBLIC "../inc" PRIVATE "../../LASzip/src")
TARGET_COMPILE_DEFINITIONS("LASlib" PRIVATE $<$<CONFIG:Release>:"NDEBUG">)
IF (UNIX OR MINGW)
    TARGET_COMPILE_OPTIONS("LASlib" PRIVATE $<$<CONFIG:Release>: "-O3" >)
    TARGET_COMPILE_OPTIONS("LASlib" PRIVATE
        "-Wall"
        "-Wno-deprecated"
        "-Wno-strict-aliasing"
        "-Wno-write-strings"
        "-Wno-unused-result"
        "-std=gnu++11")
    SET_TARGET_PROPERTIES("LASlib" PROPERTIES OUTPUT_NAME "las")
ENDIF()

INSTALL(TARGETS "LASlib" ARCHIVE DESTINATION "${INSTALL_DIR}/lib")
