/*
    File: fn_build_buildItem.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-24
    Last Update: 2026-02-01
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
#include "defines.hpp"

params[
    ["_className", "", [""]],
    ["_position", [], [[]]],
    ["_dir", -1, [-1]],
    ["_vectorUp", [], [[]]],
    ["_buildType", -1, [-1]]
];

private _vehicle = createVehicle [_className, zeroPos, [], 0, "NONE"];
_vehicle allowDamage false;
_vehicle enableSimulationGlobal false;

_vehicle setPosATL _position;
_vehicle setDir _dir;
_Vehicle setVectorUp _vectorUp;

if(_buildType isEqualTo BUILD_TYPE_SECTOR) then {
    _vehicle setVariable ["KPLIB_storage_type", 1, true];
} else {
    [_vehicle] call KPLIB_fnc_addObjectInit;
    [_vehicle] call KPLIB_fnc_clearCargo;
};

if(unitIsUAV _vehicle) then {
    [_vehicle] call KPLIB_fnc_forceBluforCrew;
};

if(_buildType != BUILD_TYPE_BUILDING) then {
    _vehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
    { _x addMPEventHandler ["MPKilled", {_this spawn kill_manager}]; true } count (crew _vehicle);
};

_vehicle enableSimulationGlobal true;
_vehicle setDamage 0;
_vehicle allowDamage true;