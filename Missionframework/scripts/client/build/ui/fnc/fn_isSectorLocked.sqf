/*
    File: fn_isSectorLocked.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-28
    Last Update: 2022-07-28
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Determines whether the classname is linked to a sector, and locked by that sector.

    Parameter(s):
		STRING	- Classname

    Returns:
        ARRAY	- [Sector Marker, Is Locked]
*/
params[
	["_className", "", [""]]
];

if(isNil "BUILD_cache_vehicleBaseLinks") then {BUILD_cache_vehicleBaseLinks = createHashMapFromArray KPLIB_vehicle_to_military_base_links};

// Check if the vehicle is sector locked
if(!(_className in BUILD_cache_vehicleBaseLinks)) exitWith{["", false]};
// Retrieve the sector corresponding to the classname
private _sector = BUILD_cache_vehicleBaseLinks get _className;

// Sector marker, and is the sector unlocked by BLUFOR
[_sector, !(_sector in KPLIB_sectors_player)]