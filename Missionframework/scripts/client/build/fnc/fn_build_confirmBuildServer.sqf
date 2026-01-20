/*
    File: fn_build_confirmBuildServer.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-25
    Last Update: 2026-01-26
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
#include "defines.hpp"

params [
	["_buildParams", [], [[]]],
	["_buildType", -1, [-1]],
	["_fobStorageAreas", [], [[]]],
	["_player", objNull, [objNull]]
];

_buildParams params [
	["_className", "", [""]],
	["_position", [], [[]]],
	["_direction", 0, [0]],
	["_price", [], [[]], 3]
];

// private _isAffordable = _price call KPLIB_fnc_build_canAffordBuildItem;

// if (!_isAffordable) exitWith {
// 	[format["Cannot afford to build %1", _className]] remoteExecCall ["systemChat", owner player];
// };

private ["_object"];
if (_className isKindOf "Man") then {
    [_className, _position, group _player] call KPLIB_fnc_createManagedUnit;
} else {
	_object = [_className, _position, _direction, _buildType] call KPLIB_fnc_build_buildItem;
};

switch (_buildType) do {
	case BUILD_TYPE_FOB: { [_position, false] spawn build_fob_remote_call; };
	case BUILD_TYPE_SECTOR: { 
		recalculate_sectors = true;
		publicVariable "recalculate_sectors"; 
	};
	default {
		_price params ["_supplyCost", "_ammoCost", "_fuelCost"];
		[_supplyCost, _ammoCost, _fuelCost, _className, -1, _fobStorageAreas] call build_remote_call;
	};
};