mob
	proc
		Log_admin(adminaction)
			file("logs/Adminlog.html")<<"[time2text(world.realtime,"MMM DD - hh:mm:ss")]:[src.key] - [adminaction]<br />"
		Log_player(action)
			file("logs/Log([src.key]).html")<<"[time2text(world.realtime,"MMM DD - hh:mm:ss")]: [action]<br />"
		Log_reports(report)
			file("logs/Reports.html")<<"[time2text(world.realtime,"MMM DD - hh:mm:ss")]: [report]<br />"
	verb
		Music()
			set hidden = 1
			usr << sound(null)
			usr << "Music is now off, relog if you want it back on again.<br>"
		AdminChat()
			set hidden = 1
			if(usr.Admin)
				var/T = input("Admin Chat")as null|text
				if(!T)
					return
				if(T)
					for(var/mob/M in Players)
						if(M.Admin)
							M << "<font color = teal>Admin Chat - {Lvl [usr.Admin]}([usr.key])[usr] - [usr.OrginalName]: [T]<br>"
		OOC()
			set hidden = 1
			usr.OOCToggle()
		CheckAdmins()
			set hidden = 1
			for(var/M in Admins)
				usr << "Is A Admin - [M]"
			for(var/mob/M in Players)
				if(M.Admin == 1)
					usr << "Online - Level [M.Admin] Admin - ([M.key])[M]"
		Rename(var/mob/M in Players)
			set hidden = 1
			if(usr.Admin)
				var/N = input("Rename")as null|text
				if(!N)
					return
				M.name = N
				M << "<b>[usr] Renames you to [M.name]!<br>"
		Who()
			set hidden = 1
			usr.WhoProc()
