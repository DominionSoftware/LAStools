##
# @brief LASzip library script
##

CMAKE_MINIMUM_REQUIRED(VERSION 3.5)

# ==================================================
# Define library files
# --------------------------------------------------

SET(sources
    "arithmeticdecoder.cpp"
    "arithmeticencoder.cpp"
    "arithmeticmodel.cpp"
    "integercompressor.cpp"
    "lasindex.cpp"
    "lasinterval.cpp"
    "lasquadtree.cpp"
    "lasreaditemcompressed_v1.cpp"
    "lasreaditemcompressed_v2.cpp"
    "lasreaditemcompressed_v3.cpp"
    "lasreaditemcompressed_v4.cpp"
    "lasreadpoint.cpp"
    "lasunzipper.cpp"
    "laswriteitemcompressed_v1.cpp"
    "laswriteitemcompressed_v2.cpp"
    "laswriteitemcompressed_v3.cpp"
    "laswriteitemcompressed_v4.cpp"
    "laswritepoint.cpp"
    "laszip.cpp"
    "laszipper.cpp")

SET(headers
    "arithmeticdecoder.hpp"
    "arithmeticencoder.hpp"
    "arithmeticmodel.hpp"
    "bytestreamin_array.hpp"
    "bytestreamin_file.hpp"
    "bytestreamin.hpp"
    "bytestreamin_istream.hpp"
    "bytestreamout_array.hpp"
    "bytestreamout_file.hpp"
    "bytestreamout.hpp"
    "bytestreamout_nil.hpp"
    "bytestreamout_ostream.hpp"
    "integercompressor.hpp"
    "lasattributer.hpp"
    "lasindex.hpp"
    "lasinterval.hpp"
    "laspoint.hpp"
    "lasquadtree.hpp"
    "lasquantizer.hpp"
    "lasreaditemcompressed_v1.hpp"
    "lasreaditemcompressed_v2.hpp"
    "lasreaditemcompressed_v3.hpp"
    "lasreaditemcompressed_v4.hpp"
    "lasreaditem.hpp"
    "lasreaditemraw.hpp"
    "lasreadpoint.hpp"
    "lasunzipper.hpp"
    "laswriteitemcompressed_v1.hpp"
    "laswriteitemcompressed_v2.hpp"
    "laswriteitemcompressed_v3.hpp"
    "laswriteitemcompressed_v4.hpp"
    "laswriteitem.hpp"
    "laswriteitemraw.hpp"
    "laswritepoint.hpp"
    "laszip_common_v1.hpp"
    "laszip_common_v2.hpp"
    "laszip_common_v3.hpp"
    "laszip_decompress_selective_v3.hpp"
    "laszip.hpp"
    "laszipper.hpp"
    "mydefs.hpp")

# ==================================================
# Macro to create static or shared library
# --------------------------------------------------

MACRO(CreateLibrary target type sources headers output destination)

    ADD_LIBRARY(${target} ${type} ${sources} ${headers})

    TARGET_INCLUDE_DIRECTORIES(${target} PUBLIC "." PRIVATE "../../LASlib/inc")
    TARGET_COMPILE_DEFINITIONS(${target} PRIVATE $<$<CONFIG:Release>:"NDEBUG">)
    TARGET_COMPILE_DEFINITIONS(${target} PRIVATE "UNORDERED")
    IF (UNIX OR MINGW OR (WIN32 AND MSVC_VERSION GREATER 1500))
            TARGET_COMPILE_DEFINITIONS(${target} PRIVATE "HAVE_UNORDERED_MAP")
    ENDIF()
    IF (UNIX OR MINGW)
        TARGET_COMPILE_OPTIONS(${target} PRIVATE $<$<CONFIG:Release>: "-O3" >)
        TARGET_COMPILE_OPTIONS(${target} PRIVATE
            "-Wall"
            "-Wno-deprecated"
            "-Wno-strict-aliasing"
            "-Wno-write-strings"
            "-Wno-unused-result"
            "-std=gnu++11")
    ENDIF()
    SET_TARGET_PROPERTIES("${target}" PROPERTIES OUTPUT_NAME "${output}")

    INSTALL(TARGETS ${target} LIBRARY DESTINATION "${destination}"
                              ARCHIVE DESTINATION "${destination}"
                              RUNTIME DESTINATION "${destination}")

ENDMACRO()

# Define library output name to conform to Windows vs. Linux naming conventions
SET(output "LASzip")
IF (UNIX OR MINGW)
    SET(output "laszip")
ENDIF()

# ==================================================
# Create static library
# --------------------------------------------------

CreateLibrary("LASzip-static" STATIC "${sources}" "${headers}" "${output}-static" "${INSTALL_DIR}/lib")

# ==================================================
# Create shared library
# --------------------------------------------------

IF (WIN32 OR CYGWIN)
    LIST(APPEND sources "laszip_dll.cpp")
ENDIF()

CreateLibrary("LASzip-shared" SHARED "${sources}" "${headers}" "${output}" "${INSTALL_DIR}/bin")

IF (WIN32 OR CYGWIN)
    TARGET_INCLUDE_DIRECTORIES("LASzip-shared" PRIVATE "../dll")
    TARGET_COMPILE_DEFINITIONS("LASzip-shared" PRIVATE "LASZIPDLL_EXPORTS")
ENDIF()
