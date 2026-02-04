/*
    File: fn_reorderStorage.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-27
    Last Update: 2026-01-27
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [
	["_storageArea", objNull, [objNull]]
];

([_storageArea] call KPLIB_fnc_getStoragePositions) params ["_storage_positions"];

{
	private _height = [typeOf _x] call KPLIB_fnc_getCrateHeight;
	detach _x;
	_x attachTo [
		_storageArea,
		[(_storage_positions select _forEachIndex) select 0,
		(_storage_positions select _forEachIndex) select 1,
		_height]];
} forEach (attachedObjects _storageArea);