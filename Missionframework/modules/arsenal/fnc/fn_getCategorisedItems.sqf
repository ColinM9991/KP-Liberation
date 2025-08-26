/*
    File: fn_getItemCategories.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
            Credits to the ACE development team for their work on their Arsenal which adopts a similar method of categorising items
            https://github.com/acemod/ACE3/blob/76676eee462cb0bbe400a482561c148d8652b550/addons/arsenal/functions/fnc_addVirtualItems.sqf
    Date: 2022-08-06
    Last Update: 2022-08-09
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Categorises the arsenal items based on the type of item.
    
    Parameter(s):
        _items - Array of arsenal items [ARRAY, defaults to []]
    
    Returns:
        Array of categorised items.
*/
#ifndef TYPE_ITEM
#include "..\defines.hpp"
#endif

params[
    ["_items", [], [[]]]
];

if (!isNil "TVG_itemRanksCategories") exitWith {TVG_itemRanksCategories};

if (_items isEqualTo []) exitWith {};

private _categorisedData = createHashMapFromArray [
    ["Weapons - Primary", []],
    ["Weapons - Secondary", []],
    ["Weapons - Launchers", []],
    ["Magazines", []],
    ["Grenades", []],
    ["Cosmetic - Headgear", []],
    ["Cosmetic - Goggles", []],
    ["Cosmetic - Backpacks", []],
    ["Cosmetic - Uniforms", []],
    ["Cosmetic - Vests", []],
    ["Attachments", []],
    ["Miscellaneous", []]
];

private _attachmentIds = [TYPE_MUZZLE, TYPE_OPTICS, TYPE_FLASHLIGHT, TYPE_BIPOD];

private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgVehicles = configFile >> "CfgVehicles";
private _cfgGlasses = configfile >> "CfgGlasses";

{
    if (!(isClass (_cfgWeapons >> _x) || {isClass(_cfgMagazines >> _x) || {isClass (_cfgVehicles >> _x) || {isClass (_cfgGlasses >> _x)}}})) then { continue };
    private _configItemInfo = _cfgWeapons >> _x >> "ItemInfo";
    switch true do {
        case (isClass (_cfgWeapons >> _x)): {
            private _configItemInfoType = getNumber (_configItemInfo >> "type");

            switch true do {
                // Attachments
                case (_configItemInfoType in _attachmentIds && {!(_x isKindOf["CBA_MiscItem", _cfgWeapons])}): {
                    (_categorisedData get "Attachments") pushBackUnique _x;
                };
                // Headgear
                case (_configItemInfoType isEqualTo TYPE_HEADGEAR): {
                    (_categorisedData get "Cosmetic - Headgear") pushBackUnique _x;
                };
                // Cosmetic - Uniforms
                case (_configItemInfoType isEqualTo TYPE_UNIFORM): {
                    (_categorisedData get "Cosmetic - Uniforms") pushBackUnique _x;
                };
                // Cosmetic - Vests
                case (_configItemInfoType isEqualTo TYPE_VEST): {
                    (_categorisedData get "Cosmetic - Vests") pushBackUnique _x;
                };
                // Weapons - Primary
                case (_x isKindOf ["Rifle", _cfgWeapons]): {
                    (_categorisedData get "Weapons - Primary") pushBackUnique _x;
                };
                // Weapons - Launchers
                case (_x isKindOf ["Launcher", _cfgWeapons]): {
                    (_categorisedData get "Weapons - Launchers") pushBackUnique _x;
                };
                // Weapons - Secondary
                case (_x isKindOf ["Pistol", _cfgWeapons]): {
                    (_categorisedData get "Weapons - Secondary") pushBackUnique _x;
                };
                // Misc
                default {
                    (_categorisedData get "Miscellaneous") pushBackUnique _x;
                };
            };
        };
        case (isClass (_cfgMagazines >> _x)): {
            switch true do {
                // Throwables
                case (_x call BIS_fnc_isThrowable): {
                    (_categorisedData get "Grenades") pushBackUnique _x;
                };
                // Magazines
                case (_x isKindOf ["CA_Magazine", _cfgMagazines]): {
                    (_categorisedData get "Magazines") pushBackUnique _x;
                };
                // Misc
                default {
                    (_categorisedData get "Miscellaneous") pushBackUnique _x;
                };
            }
        };
        // Cosmetic - Backpacks
        case (isClass (_cfgVehicles >> _x) && {(getNumber (_cfgVehicles >> _x >> "isBackpack")) isEqualTo 1}): {
            (_categorisedData get "Cosmetic - Backpacks") pushBackUnique _x;
        };
        // Cosmetic - Goggles
        case (isClass (_cfgGlasses >> _x)): {
            (_categorisedData get "Cosmetic - Goggles") pushBackUnique _x;
        };
        // Misc
        default {
            (_categorisedData get "Miscellaneous") pushBackUnique _x;
        };
    };
} forEach _items;

TVG_itemRanksCategories = _categorisedData;

_categorisedData;