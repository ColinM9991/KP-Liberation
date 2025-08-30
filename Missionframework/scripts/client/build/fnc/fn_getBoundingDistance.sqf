/*
    File: fn_getBoundingDistance.sqf
    Author: Somebody on the Bohemia Interactive forums
    Date: 2022-07-20
    Last Update: 2022-07-20
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Checks the relative distance between an object's bounding box against another object.

    Returns:
        Distance from one object's bounding box to another object.
*/
params [
	["_unit", objNull, [objNull]],
	["_obj", objNull, [objNull]]];
	
_uPos = _obj worldToModel (getPos _unit);
_oBox = boundingBoxReal _obj;

_oBoxMin = _oBox select 0;
_oBoxMax = _oBox select 1;

_uPos set [2, 0];
_oBoxMin set [2, 0];
_oBoxMax set [2, 0];

_pt = [0, 0, 0];

{
	if (_x < (_oBoxMin select _forEachIndex)) then {
		_pt set [_forEachIndex, (_oBoxMin select _forEachIndex) - _x];
	} else {
		if ((_oBoxMax select _forEachIndex) < _x) then {
			_pt set [_forEachIndex, _x - (_oBoxMax select _forEachIndex)];
		}
	}
} forEach _uPos;
_pt distance [0, 0, 0]