/*
    File: fn_setCaptive.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2025-08-31
    Last Update: 2025-08-31
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Handles the captivity status of a unit.
    
    Parameter(s):
        _unit 		- The unit whose captivity status is being set  [Object, defaults to objNull]
        _isCaptive 	- Whether the unit is captive or not            [Bool, defaults to true]
    
    Returns:
        Void
*/
params [
	["_unit", objNull, [objNull]],
	["_isCaptive", true, [true]]
];

if (isNull _unit || { (captive _unit) == _isCaptive }) exitWith {};

if (KPLIB_ace) then {
	["ace_captives_setSurrendered", [_unit, _isCaptive], _unit] call CBA_fnc_targetEvent;
} else {
    if (_isCaptive) then {
        _unit disableAI "ANIM";
        _unit disableAI "MOVE";
        _unit playmove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
    } else {
        _unit enableAI "ANIM";
        _unit enableAI "MOVE";
    };

	_unit setCaptive _isCaptive;
};

if (_isCaptive) then {
    _unit addAction ["<t color='#FFFF00'>" + localize "STR_SECONDARY_CAPTURE" + "</t>", {[_this select 0] join (group player);}, "", -850, true, true, "", "(vehicle player == player) && (side group _target != KPLIB_side_player) && (captive _target) && !(_target getVariable ['ACE_isUnconscious', false]) && [5] call KPLIB_fnc_hasPermission", 5];
};