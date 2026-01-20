/*
    File: fn_build_cameraRangeLimiter.sqf
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

params [
	["_camera", objNull, [objNull]],
	["_centerPos", [], [[]]],
	["_radius", KPLIB_range_fob, [0]]
];

[{
	params ["_args", "_handle"];
	_args params ["_camera", "_centerPos", "_radius"];

	if (isNull _camera) exitWith {
		_handle call CBA_fnc_removePerFrameHandler;
	};

	private _cameraPosition = getPos _camera;

	private _isInArea = _cameraPosition inArea [_centerPos, _radius, _radius];
	if (_isInArea) exitWith {};

	private _direction = _cameraPosition getDir _centerPos;
	private _distance = (_cameraPosition distance2D _centerPos) - _radius;
	
	private _updatedPos = _camera getPos [_distance, _direction];
	_updatedPos set[2, _cameraPosition select 2];

	_camera setPos _updatedPos;
}, 0, [_camera, _centerPos, _radius]] call CBA_fnc_addPerFrameHandler;