﻿# WIX INSTALLER GENERATOR FOR SPACK ON WINDOWS
# 
cmake_minimum_required (VERSION 3.13)
project(spack_installer)
include(CPackComponent)
set(PYTHON_VERSION "3.9.0" CACHE STRING "Version of Python to build.")
set(SPACK_VERSION "0.16.0" CACHE STRING "Version of Spack to build.")
set(PY_DOWNLOAD_LINK "https://www.paraview.org/files/dependencies")
set(PY_FILENAME "Python-${PYTHON_VERSION}-win64.tar.xz")
set(SPACK_DL "https://github.com/spack/spack/releases/download/v${SPACK_VERSION}")
set(SPACK_FILENAME "spack-${SPACK_VERSION}.tar.gz")
add_subdirectory(images)
configure_file("spack_cmd.bat.in" "scripts/spack_cmd.bat")


#PYTHON DOWLOAD AND EXTRACTION-----------------------------------
file(DOWNLOAD "${PY_DOWNLOAD_LINK}/${PY_FILENAME}" 
	"${CMAKE_CURRENT_BINARY_DIR}/${PY_FILENAME}"
	STATUS download_status 
	EXPECTED_HASH "SHA256=f6aeebc6d1ff77418678ed5612b64ce61be6bc9ef3ab9c291ac557abb1783420"
)
list(GET download_status 0 res)
if(res)
	list(GET download_status 1 err)
	message(FATAL_ERROR "Failed to download ${PY_FILENAME}")
endif()
message(STATUS "Successfully downloaded ${PY_FILENAME}")

execute_process(COMMAND ${CMAKE_COMMAND} -E tar xfz "${CMAKE_CURRENT_BINARY_DIR}/${PY_FILENAME}"
				WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
				RESULT_VARIABLE res)
if(NOT res EQUAL 0)
	message(FATAL_ERROR "Extraction of ${PY_FILENAME} failed.")
endif()
message(STATUS "Extracted ${PY_FILENAME}.")

#SPACK DOWNLOAD AND EXTRACTION---------------------------------------
#NOTE: Commented code is for download of official releases of Spack

#file(DOWNLOAD "${SPACK_DL}/${SPACK_FILENAME}" 
#	"${CMAKE_CURRENT_BINARY_DIR}/${SPACK_FILENAME}"
#	STATUS download_status 
#	EXPECTED_HASH "SHA256=064b2532c70916c7684d4c7c973416ac32dd2ea15f5c392654c75258bfc8c6c2"
#)
#list(GET download_status 0 res)
#if(res)
#	list(GET download_status 1 err)
#	message(FATAL_ERROR "Failed to download ${SPACK_FILENAME} : ${err}")
#endif()
#message(STATUS "Successfully downloaded ${SPACK_FILENAME}")
execute_process(COMMAND ${CMAKE_COMMAND} -E tar xfz "${CMAKE_CURRENT_SOURCE_DIR}/spack-windows.tar.gz"
				WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
				RESULT_VARIABLE res)
if(NOT res EQUAL 0)
	message(FATAL_ERROR "Extraction of ${SPACK_FILENAME} failed.")
endif()
message(STATUS "Extracted ${SPACK_FILENAME}.")


#INSTALLATION COMMANDS---------------------------------------------------
install(DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/spack-windows/" DESTINATION "spack-${SPACK_VERSION}")
install(DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/Python-${PYTHON_VERSION}-win64/" DESTINATION "Python-${PYTHON_VERSION}")
install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/scripts/" DESTINATION "scripts")

set(CPACK_PACKAGE_NAME "Spack")
set(CPACK_PACKAGE_VENDOR "Lawrence Livermore National Laboratories")
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "16")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_PACKAGE_DESCRIPTION "A flexible package manager designed to support multiple versions, configurations, platforms, and compilers.")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://spack.io")
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}")
set(CPACK_PACKAGE_ICON "images/spack-logo.ico")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE-APACHE.rtf")
set(CPACK_RESOURCE_FILE_WELCOME "${CMAKE_CURRENT_SOURCE_DIR}/NOTICE")
set(CPACK_GENERATOR "WIX")
set(CPACK_WIX_UI_BANNER "${CMAKE_CURRENT_SOURCE_DIR}/images/banner493x58.bmp")
set(CPACK_WIX_PATCH_FILE "${CMAKE_CURRENT_SOURCE_DIR}/patch.xml")
set(CPACK_WIX_UPGRADE_GUID "B9DBDE20-C6C8-4644-AC39-6F5F4D5039CB")
set(CPACK_WIX_EXTRA_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/spack.wxs")
include(CPack)