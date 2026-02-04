/*
    File: fn_consumeFobResources.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-27
    Last Update: 2026-02-03
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/

params [
	["_fobPosition", [], [[]]],
	["_supplyCost", 0, [0]],
	["_ammoCost", 0, [0]],
	["_fuelCost", 0, [0]]
];

private _storagePositions = nearestObjects [_fobPosition, KPLIB_storageBuildings, KPLIB_range_fob];
private _crates = _storagePositions apply { attachedObjects _X };

private _supplyCrates = [];
private _ammoCrates = [];
private _fuelCrates = [];

{
	switch (typeOf _x) do {
		case KPLIB_b_crateSupply: { _supplyCrates pushBack _x };
		case KPLIB_b_crateAmmo: { _ammoCrates pushBack _x };
		case KPLIB_b_crateFuel: { _fuelCrates pushBack _x };
	}
} forEach flatten (_crates);

private _costsAndCrates = [[_supplyCost, _supplyCrates], [_ammoCost, _ammoCrates], [_fuelCost, _fuelCrates]];

{
	_x params ["_cost", "_crates"];
	
	while {_cost > 0} do {
		private _crate = _crates deleteAt 0;
		private _crateValue = _crate getVariable ["KPLIB_crate_value", 0];
		if (_crateValue > _cost) then {
			_crate setVariable ["KPLIB_crate_value", _crateValue - _cost, true];
			_cost = 0;
		} else {
			detach _crate;
			deleteVehicle _crate;
			_cost = _cost - _crateValue;
		};
	};
} forEach _costsAndCrates;

["KPLIB_event_fobResourcesSpent", [_fobPosition, [_supplyCost, _ammoCost, _fuelCost]]] call KPLIB_fnc_serverEvent;