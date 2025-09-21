/*
    File: fn_canAffordBuildItem.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-28
    Last Update: 2022-07-28
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Determines whether an item can be afforded

    Parameter(s):
		_buildMode		- Numberical value representing the build mode

    Returns:
        Boolean			- True if the item is affordable, otherwise false
*/
params[
	["_suppliesCost", 0, [0]],
	["_ammoCost", 0, [0]],
	["_fuelCost", 0, [0]]
];

([[] call KPLIB_fnc_getNearestFob] call KPLIB_fnc_getFobResources) params ["", "_actualSupplies", "_actualAmmo", "_actualFuel"];

private _isAffordable = !((_suppliesCost > 0 && _suppliesCost > _actualSupplies)
	|| (_ammoCost > 0 && _ammoCost > _actualAmmo)
	|| (_fuelCost > 0 && _fuelCost > _actualFuel));

_isAffordable