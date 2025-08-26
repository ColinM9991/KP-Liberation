/*
    File: fn_itemRanksPreInit.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-06
    Last Update: 2022-08-09
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Configures the preinitialization code.
    
    Parameter(s):
    
    Returns:
        NONE
*/

if (isServer) then {
    TVG_itemRankRestrictions = profileNamespace getVariable ["TVG_itemRankRestrictions", createHashMapFromArray []];

    publicVariable "TVG_itemRankRestrictions";
};