@ECHO OFF
pushd %~dp0
set spackinstdir=%CD%
popd
@echo %spackinstdir%
set PATH=%spackinstdir%\scripts\;%spackinstdir%\Python-3.9.0\;%PATH%
"%inst_dir%\Python-3.9.0\python.exe" "%spackinstdir%\scripts\haspywin.py"
set SPACK_ROOT=%CD%\spack-0.16.0\


%comspec% /k "echo ********************************************************************** & echo ** Spack Package Manager & echo ** ^(c^) 2020 Lawrence Livermore National Laboratories & echo **********************************************************************"