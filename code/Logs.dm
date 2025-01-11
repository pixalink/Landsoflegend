mob
	proc
		Log_admin(adminaction)
			file("logs/Adminlog.html")<<"[time2text(world.realtime,"MMM DD - hh:mm:ss")]:[src.key] - [adminaction]<br />"
		Log_player(action)
			file("logs/Log([src.key]).html")<<"[time2text(world.realtime,"MMM DD - hh:mm:ss")]: [action]<br />"
		Log_reports(report)
			file("logs/Reports.html")<<"[time2text(world.realtime,"MMM DD - hh:mm:ss")]: [report]<br />"
