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

# Description: arm-none-eabi-gcc CMake toolchain.

cmake_minimum_required( VERSION 3.16.3 )

mark_as_advanced(
    CMAKE_TOOLCHAIN_FILE
    CMAKE_INSTALL_PREFIX
    )

set( CMAKE_SYSTEM_NAME      "Generic"   )
set( CMAKE_SYSTEM_PROCESSOR "Arm Cortex-M/Cortex-R" )

find_program( CMAKE_C_COMPILER arm-none-eabi-gcc )
mark_as_advanced( CMAKE_C_COMPILER )
if( "${CMAKE_C_COMPILER}" STREQUAL "CMAKE_C_COMPILER-NOTFOUND" )
    message( FATAL_ERROR "arm-none-eabi-gcc not found" )
endif( "${CMAKE_C_COMPILER}" STREQUAL "CMAKE_C_COMPILER-NOTFOUND" )

find_program( CMAKE_CXX_COMPILER arm-none-eabi-g++ )
mark_as_advanced( CMAKE_CXX_COMPILER )
if( "${CMAKE_CXX_COMPILER}" STREQUAL "CMAKE_CXX_COMPILER-NOTFOUND" )
    message( FATAL_ERROR "arm-none-eabi-g++ not found" )
endif( "${CMAKE_CXX_COMPILER}" STREQUAL "CMAKE_CXX_COMPILER-NOTFOUND" )

find_program( CMAKE_LINKER arm-none-eabi-ld )
mark_as_advanced( CMAKE_LINKER )
if( "${CMAKE_LINKER}" STREQUAL "CMAKE_LINKER-NOTFOUND" )
    message( FATAL_ERROR "arm-none-eabi-ld not found" )
endif( "${CMAKE_LINKER}" STREQUAL "CMAKE_LINKER-NOTFOUND" )

find_program( CMAKE_NM arm-none-eabi-nm )
mark_as_advanced( CMAKE_NM )
if( "${CMAKE_NM}" STREQUAL "CMAKE_NM-NOTFOUND" )
    message( FATAL_ERROR "arm-none-eabi-nm not found" )
endif( "${CMAKE_NM}" STREQUAL "CMAKE_NM-NOTFOUND" )

find_program( CMAKE_OBJCOPY arm-none-eabi-objcopy )
mark_as_advanced( CMAKE_OBJCOPY )
if( "${CMAKE_OBJCOPY}" STREQUAL "CMAKE_OBJCOPY-NOTFOUND" )
    message( FATAL_ERROR "arm-none-eabi-objcopy not found" )
endif( "${CMAKE_OBJCOPY}" STREQUAL "CMAKE_OBJCOPY-NOTFOUND" )

find_program( CMAKE_OBJDUMP arm-none-eabi-objdump )
mark_as_advanced( CMAKE_OBJDUMP )
if( "${CMAKE_OBJDUMP}" STREQUAL "CMAKE_OBJDUMP-NOTFOUND" )
    message( FATAL_ERROR "arm-none-eabi-objdump not found" )
endif( "${CMAKE_OBJDUMP}" STREQUAL "CMAKE_OBJDUMP-NOTFOUND" )

find_program( CMAKE_AR arm-none-eabi-ar )
mark_as_advanced( CMAKE_AR )
if( "${CMAKE_AR}" STREQUAL "CMAKE_AR-NOTFOUND" )
    message( FATAL_ERROR "arm-none-eabi-ar not found" )
endif( "${CMAKE_AR}" STREQUAL "CMAKE_AR-NOTFOUND" )

find_program( CMAKE_RANLIB arm-none-eabi-ranlib )
mark_as_advanced( CMAKE_RANLIB )
if( "${CMAKE_RANLIB}" STREQUAL "CMAKE_RANLIB-NOTFOUND" )
    message( FATAL_ERROR "arm-none-eabi-ranlib not found" )
endif( "${CMAKE_RANLIB}" STREQUAL "CMAKE_RANLIB-NOTFOUND" )

find_program( CMAKE_STRIP arm-none-eabi-strip )
mark_as_advanced( CMAKE_STRIP )
if( "${CMAKE_STRIP}" STREQUAL "CMAKE_STRIP-NOTFOUND" )
    message( FATAL_ERROR "arm-none-eabi-strip not found" )
endif( "${CMAKE_STRIP}" STREQUAL "CMAKE_STRIP-NOTFOUND" )

set( CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY" )
