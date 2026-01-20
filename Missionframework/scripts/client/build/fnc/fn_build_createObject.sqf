/*
    File: fn_build_createObject.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-22
    Last Update: 2026-01-25
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_className", "", [""]],
	["_supplyCost", 0, [0]],
	["_ammoCost", 0, [0]],
	["_fuelCost", 0, [0]]
];

if (_className isEqualTo "") exitWith {objNull};

private _object = _className createVehicleLocal zeroPos;
_object enableSimulation false;
_object setVariable ["KPLIB_buildPrice", [_supplyCost, _ammoCost, _fuelCost]];

_object