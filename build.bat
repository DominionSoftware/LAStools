@echo off

@rem ======================================================================
@rem    DESCRIPTION
@rem        Developer script to build LAStools.
@rem    USAGE
@rem        Run "build.bat -h" for available options.
@rem    REQUIREMENTS
@rem        Add the following to the PATH.
@rem            - CMake 3.5 or later
@rem            - Visual Studio
@rem                - Run the VC environment script (e.g., vcvarsx86_amd64.bat)
@rem                  so that CMake can discover its compiler.
@rem ----------------------------------------------------------------------

setlocal

@rem Define build defaults.
set BUILD_EXAMPLES=OFF
set BUILD_GENERATOR=Visual Studio 14 2015 Win64
set BUILD_TYPE=Release

set DIR_BATCH=%~dp0
pushd %DIR_BATCH%
set DIR_SRC=%CD%
popd
set DIR_BUILD=%CD%\build

@rem Check if default parameters are used
if (%1)==() goto :START

:ARGUMENTS

    @rem Parse arguments
    if /I %1 == -b set DIR_BUILD=%~2& shift
    if /I %1 == -c set BUILD_TYPE=%~2& shift
    if /I %1 == -e set BUILD_EXAMPLES=ON
    if /I %1 == -g set BUILD_GENERATOR=%~2& shift
    if /I %1 == -h goto :USAGE
    shift
    if not (%1)==() goto :ARGUMENTS

    goto :START

:USAGE

    @rem Display usage
    echo Usage: %~nx0 [options]
    echo:
    echo    -b ^<Directory^>      Build directory (Default: build)
    echo    -c ^<Release^|Debug^>  Build type (Default: %BUILD_TYPE%)
    echo    -e                  Build example executables
    echo    -g ^<Generator^>      CMake generator (Default: %BUILD_GENERATOR%)
    echo    -h                  Display this usage

    goto :EOF

:START

    @rem Create build directory
    if not exist %DIR_BUILD% mkdir %DIR_BUILD%
    pushd %DIR_BUILD%
    set DIR_BUILD=%CD%

    echo -------------------------------------------------------------------
    echo Configuration
    echo        Build Type: %BUILD_TYPE%
    echo   Build Generator: %BUILD_GENERATOR%
    echo  Source Directory: %DIR_SRC%
    echo   Build Directory: %DIR_BUILD%
    echo Install Directory: %DIR_BUILD%\dist

    echo -------------------------------------------------------------------
    echo Generating project ...

    pushd "%DIR_BUILD%"
    cmake -G"%BUILD_GENERATOR%" ^
          -DCMAKE_INSTALL_PREFIX="%DIR_BUILD%" ^
          -DBUILD_EXAMPLES=%BUILD_EXAMPLES% ^
          "%DIR_SRC%" || goto :END

    echo -------------------------------------------------------------------
    echo Building project ...

    cmake --build "%DIR_BUILD%" ^
          --target INSTALL ^
          --config %BUILD_TYPE% || goto :END

endlocal

:END
