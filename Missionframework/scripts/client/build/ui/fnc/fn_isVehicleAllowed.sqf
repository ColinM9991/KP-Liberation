/*
    File: fn_isVehicleAllowed.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-28
    Last Update: 2022-08-05
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Determines whether the vehicle can be built based on the type of vehicle.
        Example:
        Ground vehicle, true.
        UAV, true.
        Jet, without the required resources, hangers and air building
        Helicopter, without the required helipads and air building

    Parameter(s):

    Returns:
        Boolean
*/
params[
    ["_className", "", [""]]
];

private _lowerCaseClassName = toLower _className;

// If it's not an aircraft, return true
if (!(_lowerCaseClassName in KPLIB_airSlots) && !(_lowerCaseClassName in KPLIB_b_air_classes)) exitWith { true };

// It's a UAV, return true
if ([_className] call KPLIB_fnc_isClassUAV) exitWith { true };

// If it's a plane or helicopter and doesn't have the relevant resource requirements, return false
if (((_className isKindOf "Plane") && (KP_liberation_plane_count >= KP_liberation_plane_slots))
    || ((_className isKindOf "Helicopter") && (KP_liberation_heli_count >= KP_liberation_heli_slots))) exitWith { false };

// Is there an air vehicle building nearby
if (!KP_liberation_air_vehicle_building_near) exitWith { false };

true