@echo off
set MODNAME=FS25_SmartAgrometer
set TARGETDIR=%USERPROFILE%\Documents\My Games\FarmingSimulator2025\mods

echo Creating zip archive...
powershell -Command "Compress-Archive -Path * -DestinationPath '%MODNAME%.zip' -Force"

echo Moving to mods folder...
move /Y "%MODNAME%.zip" "%TARGETDIR%\%MODNAME%.zip"

echo Done. Mod deployed to FS25 mods folder.

