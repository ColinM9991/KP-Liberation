/*
    File: fn_drawBoundingBox.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-23
    Last Update: 2026-01-26
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [
	["_object", objNull, [objNull]],
    ["_isBuilding", false, [false]]
];

if (isNull _object) exitWith {};

(0 boundingBoxReal _object) params ["_p1", "_p2"];

private _color = [_object, _isBuilding] call KPLIB_fnc_build_getBoundingBoxColor;

private _p1X = _p1 select 0;
private _p1Y = _p1 select 1;
private _p1Z = _p1 select 2;

private _p2X = _p2 select 0;
private _p2Y = _p2 select 1;
private _p2Z = _p2 select 2;

{
	drawLine3D [
		_object modelToWorldVisual (_x select 0),
		_object modelToWorldVisual (_x select 1),
        _color
	];
} forEach [
    [_p1, [_p2X, _p1Y, _p1Z]], // Lower front left to lower front right
    [_p1, [_p1X, _p2Y, _p1Z]], // Lower front left to lower back left
    [_p1, [_p1X, _p1Y, _p2Z]], // Lower front left to upper left
    
    [_p2, [_p1X, _p2Y, _p2Z]], // Upper back right to back left
    [_p2, [_p2X, _p1Y, _p2Z]], // Upper back right to upper front right
    [_p2, [_p2X, _p2Y, _p1Z]], // Upper back right to lower back right

    [[_p2X, _p1Y, _p1Z], [_p2X, _p2Y, _p1Z]], // Front right to back right
    [[_p2X, _p1Y, _p1Z], [_p2X, _p1Y, _p2Z]], // Front right to upper right

    [[_p2X, _p1Y, _p2Z], [_p1X, _p1Y, _p2Z]], // Upper right to front left
    [[_p1X, _p1Y, _p2Z], [_p1X, _p2Y, _p2Z]], // Front left to back left

    [[_p1X, _p2Y, _p2Z], [_p1X, _p2Y, _p1Z]], // Back left to bottom back left
    [[_p1X, _p2Y, _p1Z], [_p2X, _p2Y, _p1Z]] // Bottom back left back to bottom back right
]