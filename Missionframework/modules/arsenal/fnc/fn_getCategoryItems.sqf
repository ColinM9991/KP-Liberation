/*
    File: fn_getCategoryItems.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-07
    Last Update: 2022-08-09
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        NONE
*/
params[
	["_categoryName", "", [""]]
];

private _categories = [] call TVG_fnc_getCategorisedItems;

_categories get _categoryName;