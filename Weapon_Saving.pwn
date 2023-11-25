
#include <a_samp>
#include <dini> // INI PERNGARUH / BUAT OTAK DARI SCRIPT AGAR TERSIMPAN DI SCRIPTFILES

new bool:LoadWeaponSaved[MAX_PLAYERS]; // INI VARIABLE UNTUK SAVE SENJATA

public OnPlayerConnect(playerid)
{
    LoadWeaponSaved[playerid] = false; // INI MENGECEK SENJATA PLAYER
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new arq[50], str[50], wid, wammo;
	format(arq, sizeof(arq), "WeaponSaved/%s.ini", PlayerName(playerid));
    if(!dini_Exists(arq)) dini_Create(arq);
    for(new i = 0; i < 13; i++)
	{
	    GetPlayerWeaponData(playerid, i, wid, wammo);
	    format(str,sizeof(str),"Senjata%d", i);
	    dini_IntSet(arq, str, wid);
	    format(str, sizeof(str),"Peluru%d", i);
	    dini_IntSet(arq, str, wammo);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(!LoadWeaponSaved[playerid]) // INI DETECT BUAT PLAYER APAKAH PUNYA SENJATA
	{
	    new arq[50], str[50], wid, wammo;
	    ResetPlayerWeapons(playerid);
	    format(arq, sizeof(arq), "WeaponSaved/%s.ini", PlayerName(playerid));
	    for(new i = 0; i < 13; i++)
		{
		    format(str, sizeof(str), "Senjata%d", i);
		    wid = dini_Int(arq, str);
		    format(str, sizeof(str),"Peluru%d", i);
		    wammo = dini_Int(arq, str);
		    GivePlayerWeapon(playerid, wid, wammo);
		}
		LoadWeaponSaved[playerid] = true; // INI UNTUK MELOAD SENJATA
	}
	return 1;
}

stock PlayerName(playerid) // WEKAWEKA WIK
{
    static pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
    return pname;
}