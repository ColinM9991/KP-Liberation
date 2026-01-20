/*
    File: fn_canBuildItem.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-28
    Last Update: 2026-01-25
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

params[
	["_className", "", [[], ""]],
	["_supplyCost", 0, [0]],
	["_ammoCost", 0, [0]],
	["_fuelCost", 0, [0]]
];

// private _buildType = KPLIB_buildList findIf { [_className, _supplyCost, _ammoCost, _fuelCost] in _x };

// If it's AI, execute the relevant checks.
// if(_buildType isEqualTo BUILD_TYPE_INFANTRY || _buildType isEqualTo BUILD_TYPE_GROUPS) exitWith {
//     [_className, _supplyCost, _ammoCost, _fuelCost, _buildType] call KPLIB_fnc_canBuildAI;
// };

private _fob = player getVariable ["KPLIB_fobPos", position player];

// Is the item affordable
private _isAffordable = [_fob, _supplyCost, _ammoCost, _fuelCost] call KPLIB_fnc_build_canAffordBuildItem;
// Is the unit cap exceeded
private _exceedsUnitCap = unitcap >= ([] call KPLIB_fnc_getLocalCap);
// Is the vehicle allowed to be built
private _isVehicleAllowed = [_className] call KPLIB_fnc_build_isVehicleAllowed;
// Is the item sector locked
([_className] call KPLIB_fnc_build_isSectorLocked) params ["", "_isSectorLocked"];

_isAffordable && {!_isSectorLocked && {_isVehicleAllowed}}