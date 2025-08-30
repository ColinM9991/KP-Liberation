/*
    File: fn_handleBuildRotation.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-22
    Last Update: 2022-07-22
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Rotates the build object.

    Parameters:
        _rotateRight		        - Should the object be rotated to the right. Default is false to rotate left.
        _fastMode			        - Speed up rotation by a factor of 2.

    Returns:
        void
*/
#ifndef MAX_DISTANCE
#include "..\ui\liberation_build_info.hpp"
#endif

params[
    ["_rotateRight", false, [false]],
    ["_fastMode", false, [false]],
    ["_object", objNull, [objNull]]
];

if ([player, _object] call KPLIB_fnc_getBoundingDistance < MIN_DISTANCE) then {
  [true, false, _object] call KPLIB_fnc_handleBuildDistance;
};

private _moveBy = [0.25, 0.5] select _fastMode;
private _direction = [(0 - _moveBy), _moveBy] select _rotateRight;

build_rotation = build_rotation + _direction;