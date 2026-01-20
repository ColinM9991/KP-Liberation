/*
    File: fn_build_getSurfaceVector.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-26
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
	["_position", [], [[]]]
];

if (GVAR(isVectorMode) || _position isEqualTo []) exitWith { [0, 0, 1] };

surfaceNormal _position;