/*
    File: fn_build_end.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-24
    Last Update: 2026-01-31
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/

#include "defines.hpp"

private _camera = GVAR(camera);
private _drawHandler = GVAR(drawHandler);
private _spheres = GVAR(borderSpheres);
private _buildCart = GVAR(buildCart);
private _display = GVAR(display);

removeMissionEventHandler ["Draw3D", _drawHandler];

if (!(isNull _camera)) then {
    camUseNVG false;
	_camera cameraEffect ["terminate","back"];
    camDestroy _camera;
};

private _objectsToClean = [];

if (_spheres isNotEqualTo []) then {
    _objectsToClean = _objectsToClean + _spheres;
};

if (_buildCart isNotEqualTo []) then {
    _objectsToClean = _objectsToClean + _buildCart;
};

if (GVAR(isBuilding)) then {
    _objectsToClean pushBack GVAR(cursorObject);
};

{
	deleteVehicle _x;
} forEach _objectsToClean;

if (!(isNull _display)) then {
    _display closeDisplay 1;
};

KPLIB_buildLogic call CBA_fnc_deleteNamespace;

KPLIB_isBuilding = false;