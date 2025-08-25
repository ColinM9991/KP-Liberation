/*
    File: fn_postInit.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-01
    Last Update: 2022-08-02
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Initializes the build variables in a single file.
    
    Parameter(s):
        NONE

    Returns:
        NONE
*/

KPLIB_isBuilding = false;
KPLIB_buildInvalid = false;
KPLIB_hasCancelledBuild = false;
KPLIB_buildingInProgress = false;
KPLIB_buildType = -1;
KPLIB_buildPreview = objNull;

build_rotation = 0;
build_elevation = 0;
build_distance = 0;
build_vector = false;