/*
    File: fn_build_confirmBuild.sqf
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

private _validItems = GVAR(buildCart) select { _x getVariable ["KPLIB_build_validPlacement", true]; };
private _buildType = GVAR(buildType);

private _nearestFob = [] call KPLIB_fnc_getNearestFob;
private _storageAreas = [];

if (_nearestFob isNotEqualTo []) then {
	_storageAreas = (_nearestFob nearObjects (KPLIB_range_fob * 2)) select {(_x getVariable ["KPLIB_storage_type",-1]) == 0};
};

{
	private _className = typeOf _x;
	private _position = getPosATL _x;
	private _dir = vectorDir _x;
    private _vectorUp = vectorUp _x;
	private _price = _x getVariable ["KPLIB_buildPrice", [0, 0, 0]];

    _x setPosATL zeroPos;
	deleteVehicle _x;

	[[_className, _position, [_dir, _vectorUp], _price], _buildType, _storageAreas, player] remoteExecCall ["KPLIB_fnc_build_confirmBuildServer", 2];
} forEach _validItems;

[] call KPLIB_fnc_build_end;