/*
    File: defines.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-20
    Last Update: 2026-01-24
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
*/
#define SVAR(var, val) (KPLIB_buildLogic setVariable [#var, val])
#define GVAR(var) (KPLIB_buildLogic getVariable #var)

#define BUILD_TYPE_SECTOR 98
#define BUILD_TYPE_FOB 99
#define BUILD_TYPE_BUILDING 5