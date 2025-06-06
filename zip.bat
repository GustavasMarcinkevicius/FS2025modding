@echo off
set MODNAME=SmartAgrometer
echo Creating %MODNAME%.zip...
powershell -Command "Compress-Archive -Path * -DestinationPath %MODNAME%.zip -Force"
echo Done.
