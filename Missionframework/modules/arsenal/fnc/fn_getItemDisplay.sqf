/*
    File: fn_getItemDisplay.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-06
    Last Update: 2022-08-13
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Gets the display name and picture for the item.
    
    Parameter(s):
        _className - The classname of the item [STRING, defaults to "]
    
    Returns:
        [Display Name, Picture Path]
*/
params[
    ["_className", "", [""]]
];

if (isNil "TVG_itemDisplayCache") then {TVG_itemDisplayCache = createHashMap};

if (_className in TVG_itemDisplayCache) exitWith {TVG_itemDisplayCache get _className};

private _itemClass = configNull;

switch true do {
    case (isClass (configFile >> "CfgWeapons" >> _className)): {
        _itemClass = configFile >> "CfgWeapons" >> _className;
    };
    case (isClass (configFile >> "CfgMagazines" >> _className)): {
        _itemClass = configFile >> "CfgMagazines" >> _className;
    };
    case (isClass (configFile >> "CfgVehicles" >> _className)): {
        _itemClass = configFile >> "CfgVehicles"  >> _className;
    };
    case (isClass (configFile >> "CfgGlasses" >> _className)): {
        _itemClass = configFile >> "CfgGlasses" >> _className;
    };
};

if (_itemClass isEqualTo configNull) exitWith {["", ""]};

private _displayName = getText (_itemClass >> "displayName");
private _picture = getText (_itemClass >> "picture");

private _retVal = [_displayName, _picture];

TVG_itemDisplayCache set[_className, _retVal];

_retVal;