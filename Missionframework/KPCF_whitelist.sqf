/*
    Killah Potatoes Cratefiller v1.1.0

    Author: Mildly Interested - https://github.com/MildlyInterested

    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    This will define the array of whitelisted Steam64IDs that are able to use Cratefiller.
*/
KPCF_enable_whitelist = false; //set to "true" if you want to limit Cratefiller only to certain users (users to be defined further down)

//Whitelist based on Steam64ID, can be obtained here: https://steamid.io/
KP_cratefiller_whitelist_steam_id = [
    "Steam64ID",
    "Another_Steam64ID",
	"Last_Steam64ID_NO_COMMA"
];

//Whitelist based on player name
KP_cratefiller_whitelist_player_name = [
    "Playername",
    "Another_Playername",
	"Last_Playername_NO_COMMA"
];

//Whitelist based on player group/squad name
KP_cratefiller_whitelist_group_name = [
    "Groupname",
    "Another_Groupname",
	"Last_Groupname_NO_COMMA"
];