/*
    File: fn_getBoundingBoxColor.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-23
    Last Update: 2026-01-25
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
	["_object", objNull, [objNull]],
    ["_isBuilding", false, [false]]
];

private _cursorObject = GVAR(cursorObject);
private _validPlacement = _object getVariable["KPLIB_build_validPlacement", true];

if (!_validPlacement) exitWith { [1, 0, 0, 1] }; // Red - invalid placement
if (_isBuilding) exitWith { [0, 1, 1, 1] }; // Cyan
if (!(isNull _cursorObject) && { _object isEqualTo _cursorObject }) exitWith { [1, 1, 0, 1] }; // Yellow

[0, 1, 0, 1] // Green - valid placement