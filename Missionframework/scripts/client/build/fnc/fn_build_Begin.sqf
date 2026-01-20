/*
    File: fn_buildBegin.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-20
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
	["_pos", player getVariable ["KPLIB_fobPos", position player], [[]]],
	["_radius", KPLIB_range_fob, [0]]
];

private _camera = [_pos] call KPLIB_fnc_build_createCamera;
private _spheres = [_pos, _radius] call KPLIB_fnc_build_createBorder;
private _draw3DHandle = addMissionEventHandler["Draw3D",
{
    private _cursorObject = GVAR(cursorObject);
    private _buildCart = GVAR(buildCart);
    private _isBuilding = GVAR(isBuilding);
    
    // If rotating an object then draw rotation point
    // Doing this per frame prevents the line from disappearing when mouse is idle
    if (!(isNull _cursorObject) && GVAR(shiftDown)) then {
        drawLine3D [
            _cursorObject modelToWorldVisual [0, 0, 0],
            GVAR(mousePos),
            [1, 1, 1, 1]];
    };

    // Draw bounding boxes
    {
        [_x] call KPLIB_fnc_build_drawBoundingBox; 
    } forEach _buildCart;

    // Bounding box for current build item
    if (_isBuilding) then {
        [_cursorObject, true] call KPLIB_fnc_build_drawBoundingBox;
    };
}];

KPLIB_buildLogic = [] call CBA_fnc_createNamespace;
SVAR(camera, _camera);
SVAR(drawHandler, _draw3DHandle);
SVAR(buildCart, []);
SVAR(buildRadius, _radius);
SVAR(buildPosition, _pos);
SVAR(cursorObject, objNull);
SVAR(mousePos, []);
SVAR(display, displayNull);
SVAR(borderSpheres, _spheres);

// States
SVAR(cameraUseNvg, false);
SVAR(isSingleBuild, false);
SVAR(isBuilding, false);
SVAR(isVectorMode, true);

// Keys
SVAR(ctrlDown, false);
SVAR(shiftDown, false);
SVAR(mouseDown, false);
SVAR(repeatBuild, false);

(findDisplay 46) createDisplay "RscBuildDialog";