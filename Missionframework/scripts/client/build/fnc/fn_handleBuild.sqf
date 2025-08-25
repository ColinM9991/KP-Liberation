/*
    File: fn_handleBuild.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-01
    Last Update: 2022-08-02
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Adds the key handler and begins the build preview mode.
    
    Parameter(s):
        _className          - Classname for the item to build                               [STRING or Array, defaults to ""]
        _supplyCost         - How many supplies this item costs                             [NUMBER, defaults to 0]
        _ammoCost           - How much ammo this item costs                                 [NUMBER, defaults to 0]
        _fuelCost           - How much fuel this item costs                                 [NUMBER, defaults to 0]
        _buildType          - The build type, determined by the item                        [NUMBER, defaults to -1]
        _buildManned        - Should it be built with units                                 [BOOLEAN, defaults to false]
        _startingPosition   - The starting position which will define the max build radius  [ARRAY, defaults to player or nearest FOB position, depending on the build type]
    
    Returns:
        NONE
*/
#ifndef BUILD_TYPE_BUILDING
#include "..\ui\build_types.hpp"
#endif

params[
    ["_className", "", [[], ""]],
    ["_supplyCost", 0, [0]],
    ["_ammoCost", 0, [0]],
    ["_fuelCost", 0, [0]],
    ["_buildType", -1, [-1]],
    ["_buildManned", false, [false]],
    ["_startingPosition", [], [[]]]
];

private _nearestFob = [] call KPLIB_fnc_getNearestFob;
private _storageAreas = (_nearestFob nearobjects (GRLIB_fob_range * 2)) select {(_x getVariable ["KP_liberation_storage_type",-1]) == 0};
private _processPurchase = {
    [_supplyCost, _ammoCost, _fuelCost, _className, _buildType, _storageAreas] remoteExec ["build_remote_call",2];
};

if (_buildType isEqualTo BUILD_TYPE_GROUPS) exitWith {
    [_className, _supplyCost, _ammoCost, _fuelCost] call KPLIB_fnc_buildSquad;
    call _processPurchase;
};

if (_buildType isEqualTo BUILD_TYPE_INFANTRY) exitWith {
    [_className, _supplyCost, _ammoCost, _fuelCost] call KPLIB_fnc_buildAi;
    call _processPurchase;
};

KPLIB_buildType = _buildType;

private _idKeyDownHandler = (findDisplay 46) displayAddEventHandler["KeyDown", {
    params["", "_key", "_shift", "_ctrl"];
    
    [_key, _shift, _ctrl] call KPLIB_fnc_handleBuildAction;
}];

KPLIB_buildingInProgress = true;
while { KPLIB_buildingInProgress } do {
    private _ghostSpot = (markerPos "ghost_spot") findEmptyPosition [0, 100];
    private _vehicle = _className createVehicleLocal _ghostSpot;
    private _startingPoint = _startingPosition;
    if(_startingPoint isEqualTo []) then {
        _startingPoint = if(_buildType != BUILD_TYPE_FOB) then [{_nearestFob},{getPos player}];
    };

    _vehicle allowdamage false;
    _vehicle setVehicleLock "LOCKED";
    _vehicle enableSimulationGlobal false;
    _vehicle setVariable ["KP_liberation_preplaced", true, true];
    { _vehicle setObjectTextureGlobal [_forEachIndex, '#(rgb,8,8,3)color(0,1,0,0.8)']; } forEach (getObjectTextures _vehicle);

    KPLIB_buildPreview = _vehicle;

    if(build_distance isEqualTo 0) then {
        private _dist = 0.6 * (sizeOf _classname);
        if (_dist < 3.5) then { _dist = 3.5 };
        _dist = _dist + 1;

        build_distance = _dist;
    };
    
    KPLIB_isBuilding = true;
    while { KPLIB_isBuilding && {!KPLIB_hasCancelledBuild} && {alive player} } do {
        private _playerDirection = getDir player;
        private _trueDir = 90 - _playerDirection;
        private _truePos = [];
        if ((toLower (typeOf _vehicle)) in KPLIB_b_static_classes) then {
            _truePos = [((getposATL player) select 0) + (build_distance * (cos _trueDir)), ((getposATL player) select 1) + (build_distance * (sin _trueDir)),((getposATL player) select 2)];
        } else {
            _truePos = [((getpos player) select 0) + (build_distance * (cos _trueDir)), ((getpos player) select 1) + (build_distance * (sin _trueDir)),0];
        };

        private _actualdir = _playerDirection + build_rotation;
        if ( _classname == "Land_Cargo_Patrol_V1_F" || _classname == "Land_PortableLight_single_F" ) then { _actualdir = _actualdir + 180 };
        if ( _classname == FOB_typename ) then { _actualdir = _actualdir + 270 };

        while { _actualdir > 360 } do { _actualdir = _actualdir - 360 };
        while { _actualdir < 0 } do { _actualdir = _actualdir + 360 };

        _vehicle setDir _actualdir;

        _truePos = [_truePos select 0, _truePos select 1, (_truePos select 2) + build_elevation];

        if (((_truePos distance _startingPoint) < GRLIB_fob_range) && (((!surfaceIsWater _truePos) && (!surfaceIsWater getpos player)) || (_className in boats_names))) then {
            KPLIB_buildInvalid = false;
            if ((toLower _className) in KPLIB_b_static_classes) then {
                _vehicle setPosATL _truePos;
            } else {
                _vehicle setpos _truePos;
            };

            if (!build_vector && {_buildType isEqualTo BUILD_TYPE_BUILDING || _buildType isEqualTo BUILD_TYPE_FOB || (toLower _className) in KPLIB_storageBuildings || _className isEqualTo KP_liberation_recycle_building || _className isEqualTo KP_liberation_air_vehicle_building}) then {
                _vehicle setVectorUp [0,0,1];
            } else {
                _vehicle setVectorUp surfaceNormal position _vehicle;
            };
        } else {
            KPLIB_buildInvalid = true;
            _vehicle setpos _ghostSpot;
            if( ((surfaceIsWater _truePos) || (surfaceIsWater getpos player)) && !(_className in boats_names)) then {
                GRLIB_ui_notif = localize "STR_BUILD_ERROR_WATER";
            };
            if((_truePos distance _startingPoint) > GRLIB_fob_range) then {
                GRLIB_ui_notif = format [localize "STR_BUILD_ERROR_DISTANCE",GRLIB_fob_range];
            };
        };

        uiSleep 0.01;
    };
    
    if (KPLIB_hasCancelledBuild) exitWith {
        deleteVehicle _vehicle;
        KPLIB_hasCancelledBuild = false;
        KPLIB_buildingInProgress = false;
        KPLIB_isBuilding = false;
    };

    [_className, _vehicle, _buildType, _buildManned] call KPLIB_fnc_buildItem;

    call _processPurchase;
};

KPLIB_buildType = -1;
KPLIB_buildPreview = objNull;

(findDisplay 46) displayRemoveEventHandler["KeyDown", _idKeyDownHandler];