/*
    File: fn_handleBuildDistance.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-22
    Last Update: 2022-07-22
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Moves the build object closer to or further from the the player.

    Parameters:
        _moveAway           - Should the object be moved away from the player. Default is false to move closer.
        _fastMode           - Speed up distance manipulation by a factor of 5.

    Returns:
        void
*/
#ifndef MAX_DISTANCE
#include "..\ui\liberation_build_info.hpp"
#endif

params[
	["_moveAway", false, [false]],
	["_fastMode", false, [false]],
	["_object", objNull, [objNull]]
];

private _distanceBetweenPlayerAndObject = [player, _object] call KPLIB_fnc_getBoundingDistance;

if ((!_moveAway && {
	_distanceBetweenPlayerAndObject < MIN_DISTANCE
})
|| (_moveAway && {
	_distanceBetweenPlayerAndObject > MAX_DISTANCE
})) exitWith {};

private _moveBy = [0.1, 0.5] select _fastMode;
private _moveDistance = [(0 - _moveBy), _moveBy] select _moveAway;

if (!_moveAway && {
	(_distanceBetweenPlayerAndObject - _moveBy) < MIN_DISTANCE
}) then {
	_moveDistance = (MIN_DISTANCE - _distanceBetweenPlayerAndObject);
};

build_distance = build_distance + _moveDistance;