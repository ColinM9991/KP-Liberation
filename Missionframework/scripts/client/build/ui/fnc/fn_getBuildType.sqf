/*
    File: fn_getBuildType.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-28
    Last Update: 2022-07-28
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Retrieves the build type by performing a lookup for the _item in the KPLIB_buildList jagged array.

    Parameter(s):

    Returns:
		The index of the array that contains the requested _item details.
*/
params[
	["_item", [], [[]], 4]
];

KPLIB_buildList findIf { _item in _x }