# toolchain-arm-none-eabi-gcc
#
# Copyright 2023-2024, Andrew Countryman <apcountryman@gmail.com> and the
# toolchain-arm-none-eabi-gcc contributors
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
# file except in compliance with the License. You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under
# the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the specific language governing
# permissions and limitations under the License.

# Description: CMake OpenOCD utilities.

find_program( CMAKE_OPENOCD openocd )
mark_as_advanced( CMAKE_OPENOCD )
if ( CMAKE_OPENOCD STREQUAL "CMAKE_OPENOCD-NOTFOUND" )
    message( FATAL_ERROR "openocd not found" )
endif ( CMAKE_OPENOCD STREQUAL "CMAKE_OPENOCD-NOTFOUND" )

# Add OpenOCD target.
#
# SYNOPSIS
#     add_openocd_target(
#         <target>
#         [DEPENDS <dependency>...]
#         [SEARCH_PATH <path>...]
#         [FILES <file>...]
#         [DEBUG_LEVEL ERRORS|WARNINGS|INFORMATIONAL_MESSAGES|DEBUG_MESSAGES]
#         [COMMANDS <command>...]
#     )
# OPTIONS
#     <target>
#         Specify the name of the created OpenOCD target.
#     COMMANDS <command>...
#         Specify the OpenOCD commands to execute on server startup. Equivalent to
#         OpenOCD's "--command <command>" option.
#     DEBUG_LEVEL ERRORS|WARNINGS|INFORMATIONAL_MESSAGES|DEBUG_MESSAGES
#         Specify OpenOCD's debug level. "ERRORS" is equivalent to OpenOCD's "--debug 0"
#         option. "WARNINGS" is equivalent to OpenOCD's "--debug 1" option.
#         "INFORMATIONAL_MESSAGES" is equivalent to OpenOCD's "--debug 2" option.
#         "DEBUG_MESSAGES" is equivalent to OpenOCD's "--debug 3" option.
#     DEPENDS <dependency>...
#         Specify the target's dependencies.
#     FILES <file>...
#         Specify the configuration files to load and scripts to execute. Equivalent to
#         OpenOCD's "--file <file>" option.
#     SEARCH_PATH <path>...
#         Specify paths to add to the configuration files and scripts search path.
#         Equivalent to OpenOCD's "--search <path>" option.
# EXAMPLES
#     add_openocd_target(
#         example-program-flash
#         DEPENDS  example
#         FILES    "${PROJECT_SOURCE_DIR}/openocd.cfg"
#         COMMANDS
#             "telnet_port disabled"
#             "program example verify reset"
#             "shutdown"
#     )
#     add_openocd_target(
#         example-program-flash
#         DEPENDS     example
#         DEBUG_LEVEL WARNINGS
#         COMMANDS
#             "source [find interface/cmsis-dap.cfg]"
#             "set CHIPNAME at91samd21g18"
#             "set ENDIAN little"
#             "source [find target/at91samdXX.cfg]"
#             "telnet_port disabled"
#             "program example verify reset"
#             "shutdown"
#     )
function( add_openocd_target target )
    cmake_parse_arguments(
        add_openocd_target
        ""
        "DEBUG_LEVEL"
        "COMMANDS;DEPENDS;FILES;SEARCH_PATH"
        ${ARGN}
        )

    if( DEFINED add_openocd_target_UNPARSED_ARGUMENTS )
        message(
            FATAL_ERROR
            "'${add_openocd_target_UNPARSED_ARGUMENTS}' are not supported arguments"
            )
    endif( DEFINED add_openocd_target_UNPARSED_ARGUMENTS )

    set( openocd_arguments "" )

    if( DEFINED add_openocd_target_SEARCH_PATH )
        foreach( path ${add_openocd_target_SEARCH_PATH} )
            list( APPEND openocd_arguments "--search" "${path}" )
        endforeach( path ${add_openocd_target_SEARCH_PATH} )
    endif( DEFINED add_openocd_target_SEARCH_PATH )

    if( DEFINED add_openocd_target_FILES )
        foreach( file ${add_openocd_target_FILES} )
            list( APPEND openocd_arguments "--file" "${file}" )
        endforeach( file ${add_openocd_target_FILES} )
    endif( DEFINED add_openocd_target_FILES )

    if( DEFINED add_openocd_target_DEBUG_LEVEL )
        if( add_openocd_target_DEBUG_LEVEL STREQUAL "ERRORS" )
            list( APPEND openocd_arguments "--debug" "0" )
        elseif( add_openocd_target_DEBUG_LEVEL STREQUAL "WARNINGS" )
            list( APPEND openocd_arguments "--debug" "1" )
        elseif( add_openocd_target_DEBUG_LEVEL STREQUAL "INFORMATIONAL_MESSAGES" )
            list( APPEND openocd_arguments "--debug" "2" )
        elseif( add_openocd_target_DEBUG_LEVEL STREQUAL "DEBUG_MESSAGES" )
            list( APPEND openocd_arguments "--debug" "3" )
        else( add_openocd_target_DEBUG_LEVEL STREQUAL "ERRORS" )
            message( FATAL_ERROR "'${add_openocd_target_DEBUG_LEVEL}' is not a supported debug level" )
        endif( add_openocd_target_DEBUG_LEVEL STREQUAL "ERRORS" )
    endif( DEFINED add_openocd_target_DEBUG_LEVEL )

    if( DEFINED add_openocd_target_COMMANDS )
        foreach( command ${add_openocd_target_COMMANDS} )
            list( APPEND openocd_arguments "--command" "${command}" )
        endforeach( command ${add_openocd_target_COMMANDS} )
    endif( DEFINED add_openocd_target_COMMANDS )

    add_custom_target(
        "${target}"
        COMMAND "${CMAKE_OPENOCD}" ${openocd_arguments}
        DEPENDS ${add_openocd_target_DEPENDS}
        VERBATIM
        )
endfunction( add_openocd_target )

# Add OpenOCD flash programming target for an executable.
#
# SYNOPSIS
#     add_openocd_flash_programming_target(
#         <executable>
#         [SEARCH_PATH <path>...]
#         [FILES <file>...]
#         [DEBUG_LEVEL ERRORS|WARNINGS|INFORMATIONAL_MESSAGES|DEBUG_MESSAGES]
#         [COMMANDS <command>...]
#     )
# OPTIONS
#     <executable>
#         Specify the name of the executable that the flash programming target
#         ("<executable>-program-flash") will be created for.
#     COMMANDS <command>...
#         Specify the OpenOCD commands to execute on server startup. Equivalent to
#         OpenOCD's "--command <command>" option.
#     DEBUG_LEVEL ERRORS|WARNINGS|INFORMATIONAL_MESSAGES|DEBUG_MESSAGES
#         Specify OpenOCD's debug level. "ERRORS" is equivalent to OpenOCD's "--debug 0"
#         option. "WARNINGS" is equivalent to OpenOCD's "--debug 1" option.
#         "INFORMATIONAL_MESSAGES" is equivalent to OpenOCD's "--debug 2" option.
#         "DEBUG_MESSAGES" is equivalent to OpenOCD's "--debug 3" option.
#     FILES <file>...
#         Specify the configuration files to load and scripts to execute. Equivalent to
#         OpenOCD's "--file <file>" option.
#     SEARCH_PATH <path>...
#         Specify paths to add to the configuration files and scripts search path.
#         Equivalent to OpenOCD's "--search <path>" option.
# EXAMPLES
#     add_openocd_flash_programming_target(
#         example
#         FILES "${PROJECT_SOURCE_DIR}/openocd.cfg"
#     )
#     add_openocd_flash_programming_target(
#         example
#         DEBUG_LEVEL WARNINGS
#         COMMANDS
#             "source [find interface/cmsis-dap.cfg]"
#             "set CHIPNAME at91samd21g18"
#             "set ENDIAN little"
#             "source [find target/at91samdXX.cfg]"
#     )
function( add_openocd_flash_programming_target executable )
    cmake_parse_arguments(
        add_openocd_flash_programming_target
        ""
        "DEBUG_LEVEL"
        "COMMANDS;FILES;SEARCH_PATH"
        ${ARGN}
        )

    if( DEFINED add_openocd_flash_programming_target_UNPARSED_ARGUMENTS )
        message(
            FATAL_ERROR
            "'${add_openocd_flash_programming_target_UNPARSED_ARGUMENTS}' are not supported arguments"
            )
    endif( DEFINED add_openocd_flash_programming_target_UNPARSED_ARGUMENTS )

    add_openocd_target(
        "${executable}-program-flash"
        DEPENDS "${executable}"
        SEARCH_PATH ${add_openocd_flash_programming_target_SEARCH_PATH}
        FILES       ${add_openocd_flash_programming_target_FILES}
        DEBUG_LEVEL ${add_openocd_flash_programming_target_DEBUG_LEVEL}
        COMMANDS
            ${add_openocd_flash_programming_target_COMMANDS}
            "telnet_port disabled"
            "program ${executable} verify reset"
            "shutdown"
        )
endfunction( add_openocd_flash_programming_target )
