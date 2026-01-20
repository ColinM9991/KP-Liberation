/*
    File: fn_build_getCursorObject.sqf
    Author:
		* KP Liberation Dev Team - https://github.com/KillahPotatoes
		* Veteran29
    Date: 2026-01-21
    Last Update: 2026-01-24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns object from build queue that is currently under the cursor

    Parameter(s):
        NONE

    Returns:
       Object that is currently under the cursor [OBJECT]
*/
#include "defines.hpp"

private _camera = GVAR(camera);
private _queue = GVAR(buildCart);
private _mousePos = GVAR(mousePos);

private _target = objNull;
private _cursorWorldPosASL = AGLtoASL _mousePos;
private _camPos = getPosASLVisual _camera;

private _objects = lineIntersectsSurfaces [
	_camPos,
	_cursorWorldPosASL,
	_camera,
	objNull,
	true,
	5
];

if (_objects isNotEqualTo []) then {
	{
		private _obj = _x select 2;

		if (_obj in _queue) exitWith {
			_target = _obj;
		};

	} forEach _objects;
};
// If we were not able to find any item directly under cusror try to get one nearest to
if (isNull _target) then {
	private _nearest = nearestObjects [_mousePos, ["All"], 1] arrayIntersect _queue;

	if (_nearest isNotEqualTo []) then {
		_target = _nearest select 0;
	};
};

vehicle _target