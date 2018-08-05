set OLDDIR=%CD%

REM construct DOCNAME
for %%* in (.) do set DOCNAME=%%~nx*
set DOCNAME=%DOCNAME:~4%
echo %DOCNAME%

REM construct PROCT
cd ..\..
for %%* in (.) do set PROCT=%%~nx*
echo %PROCT%

REM set Path
REM goto skip_set_path
cd ..\share000\ext\tgt\texlive\2018\bin\win32
set Path=%CD%
echo %Path%
:skip_set_path

REM construct PROCTS_DIR
chdir /d %OLDDIR%
cd ..\..\..
set PROCTS_DIR=%CD%
echo %PROCTS_DIR%

mkdir %PROCT%\obj\doc\
set OUTPUT_DIR=%CD%\%PROCT%\obj\doc\
latex -output-directory=%OUTPUT_DIR% %PROCT%/comp/doc_%DOCNAME%/%DOCNAME%.tex
biber %OUTPUT_DIR%%DOCNAME%
latex -output-directory=%OUTPUT_DIR% %PROCT%/comp/doc_%DOCNAME%/%DOCNAME%.tex
cd %OUTPUT_DIR%
dvips %DOCNAME%.dvi
ps2pdf %DOCNAME%.ps
mkdir %PROCTS_DIR%\%PROCT%\tgt\doc\
move %DOCNAME%.pdf %PROCTS_DIR%\%PROCT%\tgt\doc\
chdir /d %OLDDIR%