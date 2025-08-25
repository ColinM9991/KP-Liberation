/*
    File: fn_handleBuildPlacement.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-20
    Last Update: 2022-08-02
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Builds the object, repeating the next build if requested and allowed.

    Returns:
        void
*/
params[
    ["_shouldRepeat", false, [false]],
    ["_buildType", -1, [-1]]
];

if(_shouldRepeat && _buildType isEqualTo 6) then {
    KPLIB_isBuilding = false;
    KPLIB_hasCancelledBuild = false;
} else {
    build_rotation = 0;
    build_elevation = 0;
    build_distance = 0;
    build_vector = false;
    
    KPLIB_isBuilding = false;
    KPLIB_hasCancelledBuild = false;
    KPLIB_buildingInProgress = false;
}