mob
	Logout()
		for(var/mob/M in Players)
			M << "<font color = teal>([usr.key])[usr] Logs Out!<br>"
		usr.RemoveOwnedItems()
		usr.Save()
		del(usr)
	Login()
		if(usr.client.address in BanList)
			usr << "You are banned..."
			del(usr)
			return
		if(usr.key in BanList)
			usr << "You are banned..."
			del(usr)
			return
		Players += usr
		var/image/I = new('Target.dmi',usr)
		loadadmins()
		usr.TargetIcon = I
		usr.loc = locate(11,11,2)
		usr.density = 0
		usr.CanMove = 0
		usr.luminosity = 0
		usr.client.mouse_pointer_icon = 'Cursor.dmi'
		usr << sound('Intro.mid',1)
		for(var/mob/M in Players)
			M << "<font color = teal>[usr] Logs In!<br>"
		// var/html_doc="<head><title>Public Notes</title></head><body bgcolor=#000000 text=#FFFF00><center>[PublicNotes]"
		// usr<<browse(Rules,"window=Rules")
		// usr<<browse(html_doc,"window=Public Notes")
		usr << "<font color = blue><b>.:Rules:. - This is a RP game, you must never use Out of Character (OOC) information in a In Character (IC) Role Play (RP), failure to follow this -VERY- simple rule will most likely end up in a Punish.<p>"
		usr << "This version is open source using the GNU AGPLv3 license and is available at: https://github.com/pixalink/Landsoflegend<br>A full list of changes can be accessed by pressing G and selecting 'Updates'.<br>"
		usr << "Macros - S = Say, O = OOC, R = RolePlay<p>"
		usr << "<font color =teal>It is Year [Year], Month [Month]<p>"
