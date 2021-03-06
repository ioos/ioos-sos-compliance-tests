@echo off

SET DIR=%~dp0
SET CONFIGFILE=%~f1
SET TESTS=%2
SET CTLDIR=%DIR%m1.0\ctl
SET TE_BASE=%DIR%.te_base

IF [%CONFIGFILE%] == [] (
  ECHO Must provide config file path as argument 1>&2
  EXIT /B 1
)

IF NOT EXIST %CONFIGFILE% (
  ECHO Config file %CONFIGFILE% doesn't exist 1>&2
  EXIT /B 1
)

IF NOT EXIST %CTLDIR% (
  ECHO CTL directory %CTLDIR% not found 1>&2
  EXIT /B 1
)

IF NOT [%TESTS%] == [] (
  SET TESTSPARAM=@tests=%TESTS%
)

SET CONFIGPARAM=%CONFIGFILE:\=/%
SET ROOTDIRPARAM=%DIR:\=/%

REM Remove TE_BASE if exists
IF EXIST %TE_BASE% RD /S /Q %TE_BASE%

%DIR%\teamengine\bin\windows\test.bat -source="%CTLDIR%" @configFile="%CONFIGPARAM%" @rootDir="%ROOTDIRPARAM%" %TESTSPARAM%