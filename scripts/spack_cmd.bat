@ECHO OFF
pushd %~dp0
set PATH="%spackinstdir%/Python-3.9.0;%PATH%"
set SPACK_ROOT="%spackinstdir%/spack-0.16.0"
set spack="%CD%/spack.bat"
popd
@echo **********************************************************************
@echo ** Spack Package Manager
@echo ** ^(c^) 2020 Lawrence Livermore National Laboratories
@echo **********************************************************************