/*
    File: fn_createBuildCamera.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-20
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
    ["_centerPos", eyePos player, [[]]],
    ["_radius", KPLIB_range_fob, [0]]
];

private _camera = "CamCurator" camCreate (eyePos player);

_camera cameraEffect ["internal", "back"];
{ 
    _camera camCommand _x; 
} forEach [
    "maxPitch 89",
    "minPitch -89",
    "atl on",
    "surfaceSpeed off",
    "manual on",
    "speedDefault 1",
    "speedMax 1.5"
];

cameraEffectEnableHUD true;

[_camera, _centerPos, _radius] call KPLIB_fnc_build_cameraRangeLimiter;

_camera