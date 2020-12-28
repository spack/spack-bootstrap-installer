@ECHO OFF
pushd %~dp0
set spackinstdir=%CD%
popd
set SPACK_ROOT=%spackinstdir%\spack-0.16.0\
set PATH=%spackinstdir%\scripts\;%spackinstdir%\Python-3.9.0\;%PATH%

python "%spackinstdir%\scripts\haspywin.py"

%comspec% /k "echo ********************************************************************** & echo ** Spack Package Manager & echo ** ^(c^) 2020 Lawrence Livermore National Laboratories & echo **********************************************************************"
