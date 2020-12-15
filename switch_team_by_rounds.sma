#include <amxmodx>
#include <cstrike>

#define SWITCH_ROUND_TEAM	15	// Менять команды каждые ? раундов (По умолчанию: 15)

new g_iRoundCount[33];

new const g_PluginInit[][] =
{
	"Switch teams by rounds",
	"1.0",
	"https://vk.com/bullzzzeye"
}

public plugin_init()
{
	register_plugin(g_PluginInit[0], g_PluginInit[1], g_PluginInit[2])
}

public RoundStart()
{
	for(new id = 1; id <= get_maxplayers(); id++) 
	{
		g_iRoundCount[id]++
	}
}

public Switch_Team_Main(id)
{
	if(g_iRoundCount[id] == SWITCH_ROUND_TEAM-1)
	{
		client_print(id, print_chat, "* Смена команд произойдёт в следующем раунде *")
		return PLUGIN_HANDLED;
	}
	
	if(g_iRoundCount[id] == SWITCH_ROUND_TEAM)
	{
		switch(cs_get_user_team(id))
		{
			case CS_TEAM_T: cs_set_user_team(id, CS_TEAM_CT)
			case CS_TEAM_CT: cs_set_user_team(id, CS_TEAM_T)
		}
		g_iRoundCount[id] = 0
		cs_reset_user_model(id)
		server_cmd("sv_restart 1")
	}
	return PLUGIN_HANDLED;
}