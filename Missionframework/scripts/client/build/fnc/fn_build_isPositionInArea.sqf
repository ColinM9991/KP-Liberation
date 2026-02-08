/*
    File: fn_build_isPositionInArea.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-24
    Last Update: 2026-01-24
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [
	["_targetPos", [], [[]]],
	["_centerPos", [], [[]]],
	["_radius", -1, [-1]]
];

if (_radius isEqualTo -1) exitWith {};

_targetPos inArea [_centerPos, _radius, _radius]