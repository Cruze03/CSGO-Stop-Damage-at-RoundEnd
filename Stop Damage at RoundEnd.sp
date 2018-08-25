#include <sourcemod>


public Plugin myinfo=
{
	name= "Stop Damage at Round End",
	author= "Cruze",
	description= "Stop taking damage when round ends",
	version= "1.0",
	url= ""
}

public OnPluginStart()
{
	HookEvent("round_end", WhenRoundEnd);
}

public Action WhenRoundEnd(Handle event, const char[] name, bool dontBroadcast)
{
	for(int i = 1;i <= MaxClients; i++)
	{
		if(IsValidClient(i) && IsPlayerAlive(i))
		{
			SetEntProp(i, Prop_Data, "m_takedamage", 0, 1);
		}
	}
	return Plugin_Continue;
}
bool IsValidClient(client, bool bAllowBots = true, bool bAllowDead = true)
{
    if(!(1 <= client <= MaxClients) || !IsClientInGame(client) || (IsFakeClient(client) && !bAllowBots) || IsClientSourceTV(client) || IsClientReplay(client) || (!bAllowDead && !IsPlayerAlive(client)))
    {
        return false;
    }
    return true;
}