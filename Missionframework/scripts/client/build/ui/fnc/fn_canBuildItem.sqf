/*
    File: fn_canBuildItem.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-28
    Last Update: 2022-07-28
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Can the item be built.

    Parameter(s):

    Returns:
        [
            Boolean // Can Build Item,
            Boolean // Can Build with AI/Manned
        ]
*/
#ifndef BUILD_TYPE_BUILDING
#include "..\build_types.hpp"
#endif

params[
	["_className", "", [[], ""]],
	["_supplyCost", 0, [0]],
	["_ammoCost", 0, [0]],
	["_fuelCost", 0, [0]]
];

if(isNil "BUILD_cache_mannedBuildTypes") then {BUILD_cache_mannedBuildTypes = [BUILD_TYPE_LIGHT, BUILD_TYPE_ARMOUR, BUILD_TYPE_AIR, BUILD_TYPE_DEFENCE]};

private _buildType = [[_className, _supplyCost, _ammoCost, _fuelCost]] call KPLIB_fnc_getBuildType;

// If it's AI, execute the relevant checks.
if(_buildType isEqualTo BUILD_TYPE_INFANTRY || _buildType isEqualTo BUILD_TYPE_GROUPS) exitWith {
    [_className, _supplyCost, _ammoCost, _fuelCost, _buildType] call KPLIB_fnc_canBuildAI;
};

// Is the item affordable
private _isAffordable = [_supplyCost, _ammoCost, _fuelCost] call KPLIB_fnc_canAffordBuildItem;
// Is the unit cap exceeded
private _exceedsUnitCap = unitcap >= ([] call KPLIB_fnc_getLocalCap);
// Is the vehicle allowed to be built
private _isVehicleAllowed = [_className] call KPLIB_fnc_isVehicleAllowed;
// Is the item sector locked
([_className] call KPLIB_fnc_isSectorLocked) params ["", "_isSectorLocked"];

private _canBuild = _isAffordable && {!_isSectorLocked && {_isVehicleAllowed}};
private _canBuildManned = _buildType in BUILD_cache_mannedBuildTypes && {_canBuild && {!_exceedsUnitCap}};

[_canBuild, _canBuildManned];