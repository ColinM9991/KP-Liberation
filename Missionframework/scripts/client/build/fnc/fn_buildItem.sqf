/*
    File: fn_buildItem.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-01
    Last Update: 2022-08-02
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        NONE
*/

#ifndef BUILD_TYPE_BUILDING
#include "..\ui\build_types.hpp"
#endif

params[
    ["_className", "", [""]],
    ["_previewVehicle", objNull, [objNull]],
    ["_buildType", -1, [-1]],
    ["_buildManned", false, [false]]
];

private _position = getPos _previewVehicle;
private _direction = getDir _previewVehicle;

deleteVehicle _previewVehicle;

_vehicle = _classname createVehicle _position;
_vehicle allowDamage false;
_vehicle setDir _direction;

if ((toLower (typeOf _vehicle)) in KPLIB_b_static_classes) then {
    _vehicle setPosATL _position;
} else {
    _vehicle setPos _position;
};

if (!build_vector && {_buildType isEqualTo BUILD_TYPE_BUILDING || _buildType isEqualTo BUILD_TYPE_FOB || (toLower _className) in KPLIB_storageBuildings || _classname isEqualTo KP_liberation_recycle_building || _classname isEqualTo KP_liberation_air_vehicle_building}) then {
    _vehicle setVectorUp [0,0,1];
} else {
    _vehicle setVectorUp surfaceNormal position _vehicle;
};

if(_buildType isEqualTo BUILD_TYPE_SECTOR) then {
    _vehicle setVariable ["KP_liberation_storage_type", 1, true];
} else {
    [_vehicle] call KPLIB_fnc_addObjectInit;
    [_vehicle] call KPLIB_fnc_clearCargo;
};

if(unitIsUAV _vehicle || _buildManned) then {
    [_vehicle] call KPLIB_fnc_forceBluforCrew;
};

if(_buildType != BUILD_TYPE_BUILDING) then {
    _vehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
    { _x addMPEventHandler ["MPKilled", {_this spawn kill_manager}]; true } count (crew _vehicle);
};

_vehicle allowDamage true;
_vehicle setDamage 0;