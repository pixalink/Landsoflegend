mob
	var
		MouseLocationX = null
		MouseLocationY = null
		tmp/InvenUp = 0

mob/proc
	textlist(var/textlist)
		writing=list();for(var/t=1,t<=length(textlist),t++)writing+=copytext(textlist,t,t+1)
	Text(var/N,mob/m,var/x,var/y,var/offx,var/offy,var/t)
		if(m.key!=null)
			textlist(t)
			for(var/w in writing)
				var/obj/HUD/Text/s=new(m.client)
				s.screen_loc="[x]:[offx],[y]:[offy]"
				s.icon_state=w
				s.name="\proper[w]"
				s.Type = N
				offx+=8
				if(offx >= 32) {/*sleep(0.1);*/offx-=32 ; x++}
var/writing

mob
	proc
		DeleteInventoryMenu()
			for(var/obj/HUD/Menus/Buildings/O in src.client.screen)
				del(O)
			for(var/obj/HUD/Menus/Inventory/O in src.client.screen)
				del(O)
			for(var/obj/HUD/Text/T in src.client.screen)
				del(T)
			for(var/obj/Items/I in src.client.screen)
				src.client.screen -= I
				I.layer = 4
			return
		CreateAdminMenu()
			var/obj/BG = new/obj/HUD/Menus/Admin/BackGround(src.client)
			var/obj/TM = new/obj/HUD/Menus/Admin/TMiddle(src.client)
			var/obj/T = new/obj/HUD/Menus/Admin/Top(src.client)
			var/obj/TR = new/obj/HUD/Menus/Admin/TR(src.client)
			var/obj/TL = new/obj/HUD/Menus/Admin/TL(src.client)
			var/obj/L = new/obj/HUD/Menus/Admin/Left(src.client)
			var/obj/R = new/obj/HUD/Menus/Admin/Right(src.client)
			var/obj/BR = new/obj/HUD/Menus/Admin/BR(src.client)
			var/obj/BL = new/obj/HUD/Menus/Admin/BL(src.client)
			var/obj/B = new/obj/HUD/Menus/Admin/Bottom(src.client)

			var/obj/Summon = new/obj/HUD/AdminButtons/AdminSummon(src.client)
			var/obj/Teleport = new/obj/HUD/AdminButtons/AdminTeleport(src.client)
			var/obj/Create = new/obj/HUD/AdminButtons/AdminCreate(src.client)
			var/obj/Edit = new/obj/HUD/AdminButtons/AdminEdit(src.client)
			var/obj/Ban = new/obj/HUD/AdminButtons/AdminBan(src.client)
			var/obj/Mute = new/obj/HUD/AdminButtons/AdminMute(src.client)
			var/obj/ChangeDensity = new/obj/HUD/AdminButtons/AdminChangeDensity(src.client)
			var/obj/Invisibility = new/obj/HUD/AdminButtons/AdminInvisibility(src.client)
			var/obj/Reboot = new/obj/HUD/AdminButtons/AdminReboot(src.client)
			var/obj/Prison = new/obj/HUD/AdminButtons/AdminInprison(src.client)
			var/obj/EditStory = new/obj/HUD/AdminButtons/AdminEditStory(src.client)
			var/obj/Reward = new/obj/HUD/AdminButtons/AdminReward(src.client)
			var/obj/Announce = new/obj/HUD/AdminButtons/AdminAnnounce(src.client)
			var/obj/Heal = new/obj/HUD/AdminButtons/AdminHeal(src.client)
			var/obj/ServerOptions = new/obj/HUD/AdminButtons/AdminServerOptions(src.client)
			var/obj/GiveAdmin = new/obj/HUD/AdminButtons/AdminGiveAdmin(src.client)
			BG.screen_loc = "4,4 to 12,12"
			TM.screen_loc = "8,12"
			T.screen_loc = "4,12 to 12,12"
			TL.screen_loc = "4,12"
			TR.screen_loc = "12,12"
			L.screen_loc = "4,4 to 4,12"
			R.screen_loc = "12,12 to 12,4"
			BL.screen_loc = "4,4"
			BR.screen_loc = "12,4"
			B.screen_loc = "4,4 to 12,4"

			Summon.screen_loc = "5,11"
			Teleport.screen_loc = "7,11"
			Create.screen_loc = "9,11"
			Edit.screen_loc = "11,11"
			Ban.screen_loc = "5,9"
			Mute.screen_loc = "7,9"
			ChangeDensity.screen_loc = "9,9"
			if(src.AdminDelete)
				Edit.icon_state = "edit on"
			if(src.AdminEdit)
				Edit.icon_state = "edit on"
			if(src.density == 0)
				ChangeDensity.icon_state = "turn non-dense on"
			if(src.AdminInvis)
				Invisibility.icon_state = "turn invisible on"
			Invisibility.screen_loc = "11,9"
			Reboot.screen_loc = "5,7"
			Prison.screen_loc = "7,7"
			EditStory.screen_loc = "9,7"
			Reward.screen_loc = "11,7"
			Announce.screen_loc = "5,5"
			Heal.screen_loc = "7,5"
			ServerOptions.screen_loc = "9,5"
			GiveAdmin.screen_loc = "11,5"
			src.client.screen += BG
			src.client.screen += TM
			src.client.screen += T
			src.client.screen += TL
			src.client.screen += TR
			src.client.screen += L
			src.client.screen += R
			src.client.screen += BL
			src.client.screen += BR
			src.client.screen += B

			src.client.screen += Summon
			src.client.screen += Teleport
			src.client.screen += Create
			src.client.screen += Edit
			src.client.screen += Ban
			src.client.screen += Mute
			src.client.screen += ChangeDensity
			src.client.screen += Invisibility
			src.client.screen += Reboot
			src.client.screen += Prison
			src.client.screen += EditStory
			src.client.screen += Reward
			src.client.screen += Announce
			src.client.screen += Heal
			src.client.screen += ServerOptions
			src.client.screen += GiveAdmin
		CreateMasonaryMenu(var/obj/Stone)
			src.DeleteInventoryMenu()
			src.InvenUp = 0
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/Cl = new/obj/HUD/Menus/Inventory/CloseMasonary(src.client)
			H.screen_loc = "2,2 to 12,10"
			O.screen_loc = "2,10"
			A.screen_loc = "12,10"
			B.screen_loc = "2,2"
			C.screen_loc = "12,2"
			D.screen_loc = "2,10 to 12,10"
			E.screen_loc = "2,2 to 12,2"
			F.screen_loc = "2,2 to 2,10"
			G.screen_loc = "12,2 to 12,10"
			Cl.screen_loc = "12,2"
			src.client.screen += H
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Cl
			H.Type = "Masonary"
			O.Type = "Masonary"
			A.Type = "Masonary"
			B.Type = "Masonary"
			C.Type = "Masonary"
			D.Type = "Masonary"
			E.Type = "Masonary"
			F.Type = "Masonary"
			G.Type = "Masonary"
			src.Text("Masonary",src,4,10,0,10,"--Masonary Menu--")
			var/X = 3
			var/Y = 9
			if(Stone)
				for(var/obj/Items/I in src.CreateList)
					if(I.Material == Stone.Material)
						if(X != 11)
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							X += 1
						else
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							Y -= 1
							X = 3
		CreateCarpentryMenu(var/obj/Wood)
			src.DeleteInventoryMenu()
			src.InvenUp = 0
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/Cl = new/obj/HUD/Menus/Inventory/CloseCarpentry(src.client)
			H.screen_loc = "2,2 to 12,10"
			O.screen_loc = "2,10"
			A.screen_loc = "12,10"
			B.screen_loc = "2,2"
			C.screen_loc = "12,2"
			D.screen_loc = "2,10 to 12,10"
			E.screen_loc = "2,2 to 12,2"
			F.screen_loc = "2,2 to 2,10"
			G.screen_loc = "12,2 to 12,10"
			Cl.screen_loc = "12,2"
			src.client.screen += H
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Cl
			H.Type = "Carpentry"
			O.Type = "Carpentry"
			A.Type = "Carpentry"
			B.Type = "Carpentry"
			C.Type = "Carpentry"
			D.Type = "Carpentry"
			E.Type = "Carpentry"
			F.Type = "Carpentry"
			G.Type = "Carpentry"
			src.Text("Carpentry",src,4,10,0,10,"--Carpentry Menu--")
			var/X = 3
			var/Y = 9
			if(Wood)
				for(var/obj/Items/I in src.CreateList)
					if(I.Material == Wood.Material)
						if(X != 11)
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							X += 1
						else
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							Y -= 1
							X = 3
		CreateBoneMenu(var/obj/Bone)
			src.DeleteInventoryMenu()
			src.InvenUp = 0
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/Cl = new/obj/HUD/Menus/Inventory/CloseBone(src.client)
			H.screen_loc = "2,2 to 12,10"
			O.screen_loc = "2,10"
			A.screen_loc = "12,10"
			B.screen_loc = "2,2"
			C.screen_loc = "12,2"
			D.screen_loc = "2,10 to 12,10"
			E.screen_loc = "2,2 to 12,2"
			F.screen_loc = "2,2 to 2,10"
			G.screen_loc = "12,2 to 12,10"
			Cl.screen_loc = "12,2"
			src.client.screen += H
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Cl
			H.Type = "Bone"
			O.Type = "Bone"
			A.Type = "Bone"
			B.Type = "Bone"
			C.Type = "Bone"
			D.Type = "Bone"
			E.Type = "Bone"
			F.Type = "Bone"
			G.Type = "Bone"
			src.Text("Bone",src,4,10,0,10,"--Bone Menu--")
			var/X = 3
			var/Y = 9
			if(Bone)
				for(var/obj/Items/I in src.CreateList)
					if(I.Material == Bone.Material)
						if(X != 11)
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							X += 1
						else
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							Y -= 1
							X = 3
		CreateLeatherMenu(var/obj/Leather)
			src.DeleteInventoryMenu()
			src.InvenUp = 0
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/Cl = new/obj/HUD/Menus/Inventory/CloseLeather(src.client)
			H.screen_loc = "2,2 to 12,10"
			O.screen_loc = "2,10"
			A.screen_loc = "12,10"
			B.screen_loc = "2,2"
			C.screen_loc = "12,2"
			D.screen_loc = "2,10 to 12,10"
			E.screen_loc = "2,2 to 12,2"
			F.screen_loc = "2,2 to 2,10"
			G.screen_loc = "12,2 to 12,10"
			Cl.screen_loc = "12,2"
			src.client.screen += H
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Cl
			H.Type = "Leather"
			O.Type = "Leather"
			A.Type = "Leather"
			B.Type = "Leather"
			C.Type = "Leather"
			D.Type = "Leather"
			E.Type = "Leather"
			F.Type = "Leather"
			G.Type = "Leather"
			src.Text("Leather",src,4,10,0,10,"--Leather Menu--")
			var/X = 3
			var/Y = 9
			if(Leather)
				for(var/obj/Items/I in src.CreateList)
					if(I.Material == Leather.Material)
						if(X != 11)
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							X += 1
						else
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							Y -= 1
							X = 3
		CreateForgeMenu(var/obj/Ingot)
			src.DeleteInventoryMenu()
			src.InvenUp = 0
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/Cl = new/obj/HUD/Menus/Inventory/CloseForgeing(src.client)
			H.screen_loc = "2,2 to 12,13"
			O.screen_loc = "2,13"
			A.screen_loc = "12,13"
			B.screen_loc = "2,2"
			C.screen_loc = "12,2"
			D.screen_loc = "2,13 to 12,13"
			E.screen_loc = "2,2 to 12,2"
			F.screen_loc = "2,2 to 2,13"
			G.screen_loc = "12,2 to 12,13"
			Cl.screen_loc = "12,2"
			src.client.screen += H
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Cl
			H.Type = "Forge"
			O.Type = "Forge"
			A.Type = "Forge"
			B.Type = "Forge"
			C.Type = "Forge"
			D.Type = "Forge"
			E.Type = "Forge"
			F.Type = "Forge"
			G.Type = "Forge"
			src.Text("Forge",src,4,13,0,10,"--Forge Menu--")
			var/X = 3
			var/Y = 12
			if(Ingot)
				for(var/obj/Items/I in src.CreateList)
					if(I.Material == Ingot.Material)
						if(X != 11)
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							X += 1
						else
							I.layer = 100
							I.screen_loc = "[X],[Y]"
							src.client.screen += I
							Y -= 1
							X = 3
		CreateBuildMenu()
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)

			var/obj/B1 = new/obj/HUD/Menus/Buildings/BrickWall(src.client)
			var/obj/B2 = new/obj/HUD/Menus/Buildings/LargeBrickWall(src.client)
			var/obj/B3 = new/obj/HUD/Menus/Buildings/StoneSlab(src.client)
			var/obj/B4 = new/obj/HUD/Menus/Buildings/WoodenFloor(src.client)
			var/obj/B5 = new/obj/HUD/Menus/Buildings/WoodenWall(src.client)
			var/obj/B6 = new/obj/HUD/Menus/Buildings/StoneStairs(src.client)
			H.screen_loc = "2,2 to 8,6"
			O.screen_loc = "2,6"
			A.screen_loc = "8,6"
			B.screen_loc = "2,2"
			C.screen_loc = "8,2"
			D.screen_loc = "2,6 to 8,6"
			E.screen_loc = "2,2 to 8,2"
			F.screen_loc = "2,2 to 2,6"
			G.screen_loc = "8,2 to 8,6"

			B1.screen_loc = "3,5"
			B2.screen_loc = "5,5"
			B3.screen_loc = "7,5"
			B4.screen_loc = "3,3"
			B5.screen_loc = "5,3"
			B6.screen_loc = "7,3"
			src.client.screen += H
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += B1
			src.client.screen += B2
			src.client.screen += B3
			src.client.screen += B4
			src.client.screen += B5
			src.client.screen += B6
			H.Type = "Building"
			O.Type = "Building"
			A.Type = "Building"
			B.Type = "Building"
			C.Type = "Building"
			D.Type = "Building"
			E.Type = "Building"
			F.Type = "Building"
			G.Type = "Building"
			B1.Type = "Building"
			B2.Type = "Building"
			B3.Type = "Building"
			B4.Type = "Building"
			B5.Type = "Building"
			B6.Type = "Building"
			src.Text("Building",src,2,6,55,10,"--Build Menu--")
			return
		CheckContainer(var/obj/Con)
			var/NearCon = 0
			if(Con in range(1,src))
				NearCon = 1
			if(NearCon == 0)
				if(src.Container)
					var/obj/C = src.Container
					if(C.ClosedState)
						C.icon_state = C.ClosedState
						C.overlays = null
						for(var/obj/Items/Misc/Lock/L in C)
							if(L.suffix == "Fitted")
								L.icon_state = "[L.Material] lock fitted chest"
								C.overlays += L
				src.Container = null
				src.DeleteInventoryMenu()
				return
			spawn(10) CheckContainer(Con)
		CreateContainerMenu(var/obj/Con)
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/Slot = new/obj/HUD/Menus/Inventory/Slot(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/T = new/obj/HUD/Menus/Inventory/Transfer(src.client)
			var/obj/Cl = new/obj/HUD/Menus/Inventory/Close(src.client)
			H.screen_loc = "10,2 to 14,6"
			Slot.screen_loc = "11,3 to 13,5"
			O.screen_loc = "10,6"
			A.screen_loc = "14,6"
			B.screen_loc = "10,2"
			C.screen_loc = "14,2"
			T.screen_loc = "14,4"
			Cl.screen_loc = "14,3"
			D.screen_loc = "10,6 to 14,6"
			E.screen_loc = "10,2 to 14,2"
			F.screen_loc = "10,2 to 10,6"
			G.screen_loc = "14,2 to 14,6"
			if(src.Function == "Transfer")
				T.icon_state = "trade button on"

			src.client.screen += H
			src.client.screen += Slot
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += T
			src.client.screen += Cl

			src.Text("Container",src,11,6,1,10,"--Container--")
			src.Text("Weight",src,10,2,1,10,"Weight - [Con.Weight]/[Con.WeightMax]")
			src.CheckContainer(Con)
			return
		CreateInventoryMenu()
			var/obj/H = new/obj/HUD/Menus/Inventory/Middle(src.client)
			var/obj/Slot = new/obj/HUD/Menus/Inventory/Slot(src.client)
			var/obj/O = new/obj/HUD/Menus/Inventory/TopLeft(src.client)
			var/obj/A = new/obj/HUD/Menus/Inventory/TopRight(src.client)
			var/obj/B = new/obj/HUD/Menus/Inventory/BottomLeft(src.client)
			var/obj/C = new/obj/HUD/Menus/Inventory/BottomRight(src.client)
			var/obj/D = new/obj/HUD/Menus/Inventory/TopMiddle(src.client)
			var/obj/E = new/obj/HUD/Menus/Inventory/BottomMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Inventory/LeftMiddle(src.client)
			var/obj/G = new/obj/HUD/Menus/Inventory/RightMiddle(src.client)
			var/obj/Eat = new/obj/HUD/Menus/Inventory/Eat(src.client)
			var/obj/Equip = new/obj/HUD/Menus/Inventory/Equip(src.client)
			H.screen_loc = "1,8 to 7,15"
			Slot.screen_loc = "2,9 to 6,14"
			O.screen_loc = "1,15"
			A.screen_loc = "7,15"
			B.screen_loc = "1,8"
			C.screen_loc = "7,8"
			D.screen_loc = "2,15 to 6,15"
			E.screen_loc = "2,8 to 6,8"
			F.screen_loc = "1,9 to 1,14"
			G.screen_loc = "7,9 to 7,14"
			Eat.screen_loc = "7,10"
			Equip.screen_loc = "7,9"

			src.client.screen += H
			src.client.screen += Slot
			src.client.screen += O
			src.client.screen += A
			src.client.screen += B
			src.client.screen += C
			src.client.screen += D
			src.client.screen += E
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Eat
			src.client.screen += Equip

			src.Text("Inventory",src,1,15,13,10,"Inventory")
			src.Text("Weight",src,4,15,0,10,"Weight - [src.Weight]/[src.WeightMax]")
			return
		Delete(var/N,var/N2)
			for(var/obj/HUD/H in src.client.screen)
				if(H.Type == N)
					del(H)
			for(var/obj/HUD/Text/T in src.client.screen)
				if(T.Type == N2)
					del(T)
			return
		Box()
			var/obj/H = new/obj/HUD/Menus/Box(src.client)
			var/NameX = src.MouseLocationX + 1
			var/NameY = src.MouseLocationY - 1
			var/PurityX = src.MouseLocationX + 1
			var/PurityY = src.MouseLocationY - 3
			var/WeightLocX = src.MouseLocationX + 1
			var/WeightLocY = src.MouseLocationY - 2
			var/SlotLocX = src.MouseLocationX + 1
			var/SlotLocY = src.MouseLocationY - 3
			var/DuraLocX = src.MouseLocationX + 1
			var/DuraLocY = src.MouseLocationY - 4
			var/LocationX = src.MouseLocationX + 1
			var/LocationY = src.MouseLocationY - 1
			var/MiddleX = src.MouseLocationX + 5
			var/MiddleY = src.MouseLocationY - 5
			H.screen_loc = "[LocationX],[LocationY] to [MiddleX],[MiddleY]"
			H.Type = "ScrollMiddle"
			src.client.screen += H
			for(var/obj/Items/I in src)
				if(I.Xloc == src.MouseLocationX)
					if(I.Yloc == src.MouseLocationY)
						src.Text("BoxDelete",src,NameX,NameY,8,13,"[I.name]")
						src.Text("BoxDelete",src,WeightLocX,WeightLocY,8,13,"Weight-[I.Weight]")
						if(I.CraftPotential)
							src.Text("BoxDelete",src,PurityX,PurityY,8,13,"Potential-[I.CraftPotential]")
						if(I.Defence)
							src.Text("BoxDelete",src,SlotLocX,SlotLocY,8,13,"Defence-[I.Defence]")
						if(I.Quality)
							var/DMG = I.Quality
							src.Text("BoxDelete",src,SlotLocX,SlotLocY,8,13,"Damage-[DMG]")
						if(I.Dura)
							src.Text("BoxDelete",src,DuraLocX,DuraLocY,8,13,"Durability-[I.Dura]")
			return
		CreateContainerContents(var/obj/Con)
			src.CreateContainerMenu(Con)
			var/count = 0
			var/x = 11
			var/y = 5
			for(var/obj/Items/O in Con.contents)
				if(O && O.suffix != "Fitted")
					if(y >= 3)
						if(count < 3)
							count++
							O.layer = 20
							src.client.screen += O
							O.screen_loc = "[x],[y]"
							O.Xloc = x
							O.Yloc = y
							x++
						else
							count = 0
							count++
							y -= 1
							x = 11
							if(y >= 3)
								O.layer = 20
								src.client.screen += O
								O.screen_loc = "[x],[y]"
								O.Xloc = x
								O.Yloc = y
								x++
			return
		CreateInventory()
			for(var/obj/HUD/Menus/H in src.client.screen)
				if(H.Type != "Book")
					del(H)
			src.CreateInventoryMenu()
			var/count = 0
			var/x = 2
			var/y = 14
			for(var/obj/O in src.contents)
				if(O)
					if(y >= 9)
						if(count < 5)
							count++
							O.layer = 20
							O.screen_loc = "[x],[y]"
							src.client.screen += O
							O.Xloc = x
							O.Yloc = y
							x++
						else
							count = 0
							count++
							y -= 1
							x = 2
							if(y >= 9)
								O.layer = 20
								src.client.screen += O
								O.screen_loc = "[x],[y]"
								O.Xloc = x
								O.Yloc = y
								x++
			return
		CreateRaceSelection()
			var/obj/H = new/obj/HUD/Menus/Scroll/ScrollMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Scroll/ScrollLeft(src.client)
			var/obj/G = new/obj/HUD/Menus/Scroll/ScrollRight(src.client)
			var/obj/Scroll1 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/Scroll2 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/ScrollLeft1 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollLeft2 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollRight1 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			var/obj/ScrollRight2 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)

			var/obj/Human = new/obj/HUD/RaceSelection/Human(src.client)
			var/obj/Wolfman = new/obj/HUD/RaceSelection/Wolfman(src.client)
			var/obj/Alther = new/obj/HUD/RaceSelection/Alther(src.client)
			var/obj/Cyclops = new/obj/HUD/RaceSelection/Cyclops(src.client)
			var/obj/Frogman = new/obj/HUD/RaceSelection/Frogman(src.client)
			var/obj/Giant = new/obj/HUD/RaceSelection/Giant(src.client)
			var/obj/Ratling = new/obj/HUD/RaceSelection/Ratling(src.client)
			var/obj/Stahlite = new/obj/HUD/RaceSelection/Stahlite(src.client)
			var/obj/Snakeman = new/obj/HUD/RaceSelection/Snakeman(src.client)

			var/obj/Cancel = new/obj/HUD/RaceSelection/Cancel(src.client)
			var/obj/Accept = new/obj/HUD/RaceSelection/Accept(src.client)
			var/obj/Male = new/obj/HUD/RaceSelection/Male(src.client)
			var/obj/Female = new/obj/HUD/RaceSelection/Female(src.client)
			Scroll1.screen_loc = "2,15 to 14,15"
			ScrollLeft1.screen_loc = "1,15"
			ScrollLeft2.screen_loc = "1,2"
			ScrollRight1.screen_loc = "15,15"
			ScrollRight2.screen_loc = "15,2"
			H.screen_loc = "2,14 to 14,3"
			F.screen_loc = "2,3 to 2,14"
			G.screen_loc = "14,3 to 14,14"
			Scroll2.screen_loc = "2,2 to 14,2"

			Human.screen_loc = "2,14"
			Wolfman.screen_loc = "3,14"
			Alther.screen_loc = "4,14"
			Cyclops.screen_loc = "6,14"
			Stahlite.screen_loc = "14,14"
			Snakeman.screen_loc = "13,14"
			Frogman.screen_loc = "8,14"
			Giant.screen_loc = "10,14"
			Ratling.screen_loc = "12,14"

			Accept.screen_loc = "2,3"
			Cancel.screen_loc = "4,3"
			Male.screen_loc = "14,3"
			Female.screen_loc = "12,3"
			src.client.screen += H
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Scroll1
			src.client.screen += Scroll2
			src.client.screen += ScrollLeft1
			src.client.screen += ScrollLeft2
			src.client.screen += ScrollRight1
			src.client.screen += ScrollRight2

			src.client.screen += Human
			src.client.screen += Wolfman
			src.client.screen += Alther
			src.client.screen += Snakeman
			src.client.screen += Cyclops
			src.client.screen += Frogman
			src.client.screen += Giant
			src.client.screen += Ratling
			src.client.screen += Stahlite

			src.client.screen += Accept
			src.client.screen += Cancel
			src.client.screen += Male
			src.client.screen += Female
			H.Type = "RaceSelection"
			F.Type = "RaceSelection"
			G.Type = "RaceSelection"
			Scroll1.Type = "RaceSelection"
			Scroll2.Type = "RaceSelection"
			ScrollLeft1.Type = "RaceSelection"
			ScrollLeft2.Type = "RaceSelection"
			ScrollRight1.Type = "RaceSelection"
			ScrollRight2.Type = "RaceSelection"
			if(src.key in IllithidList)
				var/obj/Illithid = new/obj/HUD/RaceSelection/Illithid(src.client)
				Illithid.screen_loc = "5,14"
				src.client.screen += Illithid
		CreateSkillDisplay()
			var/obj/H = new/obj/HUD/Menus/Scroll/ScrollMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Scroll/ScrollLeft(src.client)
			var/obj/G = new/obj/HUD/Menus/Scroll/ScrollRight(src.client)
			var/obj/Scroll1 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/Scroll2 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/ScrollLeft1 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollLeft2 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollRight1 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			var/obj/ScrollRight2 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			Scroll1.screen_loc = "2,15 to 14,15"
			ScrollLeft1.screen_loc = "1,15"
			ScrollLeft2.screen_loc = "1,2"
			ScrollRight1.screen_loc = "15,15"
			ScrollRight2.screen_loc = "15,2"
			H.screen_loc = "2,14 to 14,3"
			F.screen_loc = "2,3 to 2,14"
			G.screen_loc = "14,3 to 14,14"
			Scroll2.screen_loc = "2,2 to 14,2"
			src.client.screen += H
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Scroll1
			src.client.screen += Scroll2
			src.client.screen += ScrollLeft1
			src.client.screen += ScrollLeft2
			src.client.screen += ScrollRight1
			src.client.screen += ScrollRight2
			H.Type = "SkillDisplay"
			F.Type = "SkillDisplay"
			G.Type = "SkillDisplay"
			Scroll1.Type = "SkillDisplay"
			Scroll2.Type = "SkillDisplay"
			ScrollLeft1.Type = "SkillDisplay"
			ScrollLeft2.Type = "SkillDisplay"
			ScrollRight1.Type = "SkillDisplay"
			ScrollRight2.Type = "SkillDisplay"
			src.Text("SkillDisplay",src,2,14,10,14,"--Skill Information--")
			src.Text("SkillDisplay",src,2,13,10,14,"SwordSkill-[src.SwordSkill]")
			src.Text("SkillDisplay",src,2,12,10,14,"SpearSkill-[src.SpearSkill]")
			src.Text("SkillDisplay",src,2,11,10,14,"BluntSkill-[src.BluntSkill]")
			src.Text("SkillDisplay",src,2,10,10,14,"AxeSkill-[src.AxeSkill]")
			src.Text("SkillDisplay",src,2,9,10,14,"DaggerSkill-[src.DaggerSkill]")
			src.Text("SkillDisplay",src,2,8,10,14,"RangedSkill-[src.RangedSkill]")
			src.Text("SkillDisplay",src,2,7,10,14,"UnarmedSkill-[src.UnarmedSkill]")
			src.Text("SkillDisplay",src,2,6,10,14,"ShieldSkill-[src.ShieldSkill]")
			src.Text("SkillDisplay",src,2,5,10,14,"Mining-[src.MiningSkill]")
			src.Text("SkillDisplay",src,2,4,10,14,"Smelting-[src.SmeltingSkill]")
			src.Text("SkillDisplay",src,2,3,10,14,"FirstAid-[src.FirstAidSkill]")
			src.Text("SkillDisplay",src,6,13,10,14,"Forging-[src.ForgingSkill]")
			src.Text("SkillDisplay",src,6,12,10,14,"Masonary-[src.MasonarySkill]")
			src.Text("SkillDisplay",src,6,11,10,14,"Cooking-[src.CookingSkill]")
			src.Text("SkillDisplay",src,6,10,10,14,"Fishing-[src.FishingSkill]")
			src.Text("SkillDisplay",src,6,9,10,14,"Alchemy-[src.AlchemySkill]")
			src.Text("SkillDisplay",src,6,8,10,14,"LeatherCraft-[src.LeatherCraftSkill]")
			src.Text("SkillDisplay",src,6,7,10,14,"WoodCutting-[src.WoodCuttingSkill]")
			src.Text("SkillDisplay",src,6,6,10,14,"Building-[src.BuildingSkill]")
			src.Text("SkillDisplay",src,6,5,10,14,"Farming-[src.FarmingSkill]")
			src.Text("SkillDisplay",src,6,4,10,14,"Weaving-[src.WeavingSkill]")
			src.Text("SkillDisplay",src,6,3,10,14,"Carpentry-[src.CarpentrySkill]")
			src.Text("SkillDisplay",src,10,13,10,14,"Skinning-[src.SkinningSkill]")
			src.Text("SkillDisplay",src,10,12,10,14,"Butchery-[src.ButcherySkill]")
			src.Text("SkillDisplay",src,10,11,10,14,"Engraving-[src.EngravingSkill]")
			src.Text("SkillDisplay",src,10,10,10,14,"Swimming-[src.SwimmingSkill]")
			src.Text("SkillDisplay",src,10,9,10,14,"BoneCraft-[src.BoneCraftSkill]")
			src.Text("SkillDisplay",src,10,8,10,14,"Astral Magic-[src.AstralMagic]")
			src.Text("SkillDisplay",src,10,7,10,14,"Necromancy-[src.Necromancery]")
			src.Text("SkillDisplay",src,10,6,10,14,"Blood Magic-[src.BloodMagic]")
		CreateHealthDisplay()
			var/obj/H = new/obj/HUD/Menus/Scroll/ScrollMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Scroll/ScrollLeft(src.client)
			var/obj/G = new/obj/HUD/Menus/Scroll/ScrollRight(src.client)
			var/obj/Scroll1 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/Scroll2 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/ScrollLeft1 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollLeft2 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollRight1 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			var/obj/ScrollRight2 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			Scroll1.screen_loc = "2,15 to 14,15"
			ScrollLeft1.screen_loc = "1,15"
			ScrollLeft2.screen_loc = "1,3"
			ScrollRight1.screen_loc = "15,15"
			ScrollRight2.screen_loc = "15,3"
			H.screen_loc = "2,14 to 14,4"
			F.screen_loc = "2,4 to 2,14"
			G.screen_loc = "14,4 to 14,14"
			Scroll2.screen_loc = "2,3 to 14,3"
			src.client.screen += H
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Scroll1
			src.client.screen += Scroll2
			src.client.screen += ScrollLeft1
			src.client.screen += ScrollLeft2
			src.client.screen += ScrollRight1
			src.client.screen += ScrollRight2
			H.Type = "HealthDisplay"
			F.Type = "HealthDisplay"
			G.Type = "HealthDisplay"
			Scroll1.Type = "HealthDisplay"
			Scroll2.Type = "HealthDisplay"
			ScrollLeft1.Type = "HealthDisplay"
			ScrollLeft2.Type = "HealthDisplay"
			ScrollRight1.Type = "HealthDisplay"
			ScrollRight2.Type = "HealthDisplay"
			var/Blood
			if(src.Bleed)
				Blood = src.Bleed
			else
				Blood = "None"
			src.Text("HealthDisplay",src,4,14,1,14,"--Health Information--")
			if(src.Race != "Snakeman")
				src.Text("HealthDisplay",src,2,13,1,14,"RightLeg-[src.RightLeg]%")
				src.Text("HealthDisplay",src,2,12,1,14,"LeftLeg-[src.LeftLeg]%")
			src.Text("HealthDisplay",src,2,11,1,14,"RightArm-[src.RightArm]%")
			src.Text("HealthDisplay",src,2,10,1,14,"LeftArm-[src.LeftArm]%")
			src.Text("HealthDisplay",src,2,9,1,14,"Nose-[src.Nose]%")
			src.Text("HealthDisplay",src,2,8,1,14,"LeftEar-[src.LeftEar]%")
			src.Text("HealthDisplay",src,2,7,1,14,"RightEar-[src.RightEar]%")
			src.Text("HealthDisplay",src,2,6,1,14,"Teeth-[src.Teeth]%")
			if(src.Race != "Cyclops")
				src.Text("HealthDisplay",src,2,5,1,14,"LeftEye-[src.LeftEye]%")
				src.Text("HealthDisplay",src,2,4,1,14,"RightEye-[src.RightEye]%")
			else
				src.Text("HealthDisplay",src,2,5,1,14,"Eye-[src.RightEye]%")
			src.Text("HealthDisplay",src,7,13,1,14,"Tongue-[src.Tongue]%")
			src.Text("HealthDisplay",src,7,12,1,14,"Skull-[src.Skull]%")
			src.Text("HealthDisplay",src,7,11,1,14,"Brain-[src.Brain]%")
			src.Text("HealthDisplay",src,7,10,1,14,"Heart-[src.Heart]%")
			src.Text("HealthDisplay",src,7,9,1,14,"LeftLung-[src.LeftLung]%")
			src.Text("HealthDisplay",src,7,8,1,14,"RightLung-[src.RightLung]%")
			src.Text("HealthDisplay",src,7,7,1,14,"Liver-[src.Liver]%")
			src.Text("HealthDisplay",src,7,6,1,14,"Spleen-[src.Spleen]%")
			src.Text("HealthDisplay",src,7,5,1,14,"LeftKidney-[src.LeftKidney]%")
			src.Text("HealthDisplay",src,7,4,1,14,"RightKidney-[src.RightKidney]%")
			src.Text("HealthDisplay",src,11,13,-5,14,"Intestines-[src.Intestine]%")
			src.Text("HealthDisplay",src,11,12,-5,14,"Stomach-[src.Stomach]%")
			src.Text("HealthDisplay",src,11,11,-5,14,"Throat-[src.Throat]%")
			if(src.Claws != 0)
				src.Text("HealthDisplay",src,11,10,-5,14,"Claws-[src.Claws]%")
			src.Text("HealthDisplay",src,10,14,10,14,"Bleeding-[Blood]")
		CreateInfoDisplay()
			var/obj/H = new/obj/HUD/Menus/Scroll/ScrollMiddle(src.client)
			var/obj/F = new/obj/HUD/Menus/Scroll/ScrollLeft(src.client)
			var/obj/G = new/obj/HUD/Menus/Scroll/ScrollRight(src.client)
			var/obj/Scroll1 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/Scroll2 = new/obj/HUD/Menus/Scroll/Scroll(src.client)
			var/obj/ScrollLeft1 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollLeft2 = new/obj/HUD/Menus/Scroll/ScrollLeft2(src.client)
			var/obj/ScrollRight1 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			var/obj/ScrollRight2 = new/obj/HUD/Menus/Scroll/ScrollRight2(src.client)
			Scroll1.screen_loc = "4,15 to 14,15"
			ScrollLeft1.screen_loc = "3,15"
			ScrollLeft2.screen_loc = "3,3"
			ScrollRight1.screen_loc = "15,15"
			ScrollRight2.screen_loc = "15,3"
			H.screen_loc = "4,14 to 14,4"
			F.screen_loc = "4,4 to 4,14"
			G.screen_loc = "14,4 to 14,14"
			Scroll2.screen_loc = "4,3 to 14,3"
			src.client.screen += H
			src.client.screen += F
			src.client.screen += G
			src.client.screen += Scroll1
			src.client.screen += Scroll2
			src.client.screen += ScrollLeft1
			src.client.screen += ScrollLeft2
			src.client.screen += ScrollRight1
			src.client.screen += ScrollRight2
			H.Type = "InfoDisplay"
			F.Type = "InfoDisplay"
			G.Type = "InfoDisplay"
			Scroll1.Type = "InfoDisplay"
			Scroll2.Type = "InfoDisplay"
			ScrollLeft1.Type = "InfoDisplay"
			ScrollLeft2.Type = "InfoDisplay"
			ScrollRight1.Type = "InfoDisplay"
			ScrollRight2.Type = "InfoDisplay"
			src.Text("InfoDisplay",src,4,14,10,10,"--General Information--")
			src.Text("InfoDisplay",src,4,13,10,10,"Name-[src.name]")
			src.Text("InfoDisplay",src,4,12,10,10,"Age-[src.Age]")
			src.Text("InfoDisplay",src,4,11,10,10,"Gender-[src.Gender]")
			src.Text("InfoDisplay",src,4,10,10,10,"Hunger-[src.Hunger]")
			src.Text("InfoDisplay",src,4,9,10,10,"Tiredness-[src.Sleep]")
			src.Text("InfoDisplay",src,4,8,10,10,"Strength-[src.Strength]")
			src.Text("InfoDisplay",src,4,7,10,10,"Agility-[src.Agility]")
			src.Text("InfoDisplay",src,4,6,10,10,"Endurance-[src.Endurance]")
			src.Text("InfoDisplay",src,4,5,10,10,"Intelligence-[src.Intelligence]")

obj
	MouseEntered()
		if(src in usr)
			if(src.suffix)
				if(usr.InvenUp)
					usr.MouseLocationX = src.Xloc
					usr.MouseLocationY = src.Yloc
					usr.Box()
	MouseExited()
		usr.MouseLocationX = null
		usr.MouseLocationY = null
		usr.Delete("ScrollMiddle","BoxDelete")

	HUD
		E
			icon = 'HUD.dmi'
			icon_state = "equipped marker"
			layer = 11
		C
			icon = 'HUD.dmi'
			icon_state = "carrying marker"
			layer = 11
		Text
			icon = 'txt.dmi'
			layer = 100
			New(client/C)
				C.screen += src
				..()
		Menus
			layer = 11
			Box
				icon = 'HUD.dmi'
				icon_state = "box"
			Buildings
				icon = 'terrain.dmi'
				LargeBrickWall
					icon_state = "bulky brick wall"
					Click()
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						var/Arms = 1
						if(usr.LeftArm <= 25)
							Arms = 0
						if(usr.RightArm <= 25)
							Arms = 0
						if(Arms == 0)
							usr << "<font color =red>Your arms are too damaged!<br>"
							return
						if(usr.Dead == 0)
							if(usr.Job == null)
								var/Bricks = list()
								var/Num = 0
								var/Loc = usr.loc
								for(var/obj/Items/Resources/LargeBrick/P in usr)
									if(Num != 3)
										Num += 1
										Bricks += P
								if(Num == 3)
									view(usr) << "<font color=yellow>[usr] begins to construct a large brick wall from large bricks!<br>"
									usr.Job = "MakeBrickWall"
									usr.CanMove = 0
									var/Time = 350
									Time -= usr.MasonarySkill * 1.5
									Time -= usr.BuildingSkill * 1.5
									if(Time <= 75)
										Time = 75
									spawn(Time)
										if(usr)
											if(usr.loc == Loc)
												if(usr.Job == "MakeBrickWall")
													usr.Job = null
													usr.BuildingSkill += usr.BuildingSkillMulti
													usr.MasonarySkill += usr.MasonarySkillMulti
													usr.GainStats(3)
													usr << "<font color =green>You finish construction of a large brick wall!<br>"
													for(var/obj/I in Bricks)
														usr.Weight -= I.Weight
														del(I)
													for(var/turf/T in range(0,usr))
														T.Type = "Inside"
														T.icon_state = "bulky brick wall"
														T.density = 1
														T.opacity = 1
														T.Dura += 75
														T.AttachedKey = "[usr.key]"
														T.ManMade = 1
														T.Material = "Stone"
														T.Dura += usr.MasonarySkill
														T.Dura += usr.BuildingSkill
														T.desc = "Made by ([usr])[usr.name]"
														T.name = "Large Brick Wall"
														for(var/obj/Items/Misc/M in range(0,usr))
															if(M.loc != usr)
																if(M.density == 0 && M.suffix == null)
																	M.loc = locate(0,0,0)
														for(var/obj/Items/Plants/P in range(0,usr))
															if(P.density == 0)
																P.loc = locate(0,0,0)
														Tiles += T
													usr.MovementCheck()
											else
												usr << "<font color=red>You moved from the position you were building at, you failed to construct a large brick wall!<br>"
												return
								else
									usr << "<font color =red>You need three large bricks to construct a large brick wall!<br>"
									return
				BrickWall
					icon_state = "brick wall"
					Click()
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						var/Arms = 1
						if(usr.LeftArm <= 25)
							Arms = 0
						if(usr.RightArm <= 25)
							Arms = 0
						if(Arms == 0)
							usr << "<font color =red>Your arms are too damaged!<br>"
							return
						if(usr.Dead == 0)
							if(usr.Job == null)
								var/Bricks = list()
								var/Num = 0
								var/Loc = usr.loc
								for(var/obj/Items/Resources/Brick/P in usr)
									if(Num != 4)
										Num += 1
										Bricks += P
								if(Num == 4)
									view(usr) << "<font color=yellow>[usr] begins to construct a brick wall from bricks!<br>"
									usr.Job = "MakeBrickWall"
									usr.CanMove = 0
									var/Time = 300
									Time -= usr.MasonarySkill * 1.5
									Time -= usr.BuildingSkill * 1.5
									if(Time <= 75)
										Time = 75
									spawn(Time)
										if(usr)
											if(usr.loc == Loc)
												if(usr.Job == "MakeBrickWall")
													usr.Job = null
													usr.BuildingSkill += usr.BuildingSkillMulti
													usr.MasonarySkill += usr.MasonarySkillMulti
													usr.GainStats(3)
													usr << "<font color =green>You finish construction of a brick wall!<br>"
													for(var/obj/I in Bricks)
														usr.Weight -= I.Weight
														del(I)
													for(var/turf/T in range(0,usr))
														T.Type = "Inside"
														T.icon_state = "brick wall"
														T.density = 1
														T.opacity = 1
														T.Dura += 50
														T.AttachedKey = "[usr.key]"
														T.ManMade = 1
														T.Material = "Stone"
														T.Dura += usr.MasonarySkill
														T.Dura += usr.BuildingSkill
														T.desc = "Made by ([usr])[usr.name]"
														T.name = "Brick Wall"
														for(var/obj/Items/Misc/M in range(0,usr))
															if(M.loc != usr)
																if(M.density == 0 && M.suffix == null)
																	M.loc = locate(0,0,0)
														for(var/obj/Items/Plants/P in range(0,usr))
															if(P.density == 0)
																P.loc = locate(0,0,0)
														Tiles += T
													usr.MovementCheck()
											else
												usr << "<font color=red>You moved from the position you were building at, you failed to construct a brick wall!<br>"
												return
								else
									usr << "<font color =red>You need four bricks to construct a brick wall!<br>"
									return
				StoneStairs
					icon_state = "stairs up"
					Click()
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						var/Arms = 1
						if(usr.LeftArm <= 25)
							Arms = 0
						if(usr.RightArm <= 25)
							Arms = 0
						if(Arms == 0)
							usr << "<font color =red>Your arms are too damaged!<br>"
							return
						if(usr.Dead == 0 && usr.z != 2)
							if(usr.Job == null)
								var/Bricks = list()
								var/Num = 0
								var/Loc = usr.loc
								for(var/obj/Items/Resources/LargeBrick/P in usr)
									if(Num != 4)
										Num += 1
										Bricks += P
								if(Num == 4)
									var/CanEnter = 0
									var/obj/Q = new
									var/Z
									if(usr.z == 1)
										Z = 2
									if(usr.z == 3)
										Z = 1
									Q.loc = locate(usr.x,usr.y,Z)
									for(var/turf/T2 in range(0,Q))
										if(T2.Dura == 0 && T2.density == 0)
											CanEnter = 1
										if(T2.icon_state == "clouds" && usr.z == 1)
											CanEnter = 1
									if(Q.x <= 20 && Q.y <= 20 && Q.z == 2)
										CanEnter = 0
									del(Q)
									if(CanEnter)
										view(usr) << "<font color=yellow>[usr] begins to construct a stairs from large bricks!<br>"
										usr.Job = "MakeStoneStair"
										usr.CanMove = 0
										var/Time = 300
										Time -= usr.MasonarySkill
										Time -= usr.BuildingSkill
										if(Time <= 75)
											Time = 75
										spawn(Time)
											if(usr)
												if(usr.loc == Loc)
													if(usr.Job == "MakeStoneStair")
														usr.Job = null
														usr.BuildingSkill += usr.BuildingSkillMulti
														usr.MasonarySkill += usr.MasonarySkillMulti
														usr.GainStats(3)
														usr << "<font color =green>You finish construction of a stairs!<br>"
														for(var/obj/I in Bricks)
															usr.Weight -= I.Weight
															del(I)
														var/obj/Misc/StairsUp/S = new
														S.loc = usr.loc
														S.Dura += usr.BuildingSkill
														S.Dura += usr.MasonarySkill
														var/obj/Q2 = new
														Q2.loc = locate(usr.x,usr.y,Z)
														for(var/turf/T3 in range(0,Q2))
															var/obj/Misc/StairsDown/S2 = new
															S2.loc = Q2.loc
															S2.Dura += usr.BuildingSkill
															S2.Dura += usr.MasonarySkill
															Tiles += T3
															for(var/obj/Misc/Hole/H in range(0,S2))
																del(H)
														del(Q2)
														for(var/turf/T in range(0,usr))
															Tiles += T
														usr.MovementCheck()
												else
													usr << "<font color=red>You moved from the position you were building at, you failed to construct a stone slab!<br>"
													return
									else
										usr << "<font color =red>Something above stops you from creating a stairs!<br>"
										return
								else
									usr << "<font color =red>You need four large brick to construct a stairs!<br>"
									return
				StoneSlab
					icon_state = "slab stone floor"
					Click()
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						var/Arms = 1
						if(usr.LeftArm <= 25)
							Arms = 0
						if(usr.RightArm <= 25)
							Arms = 0
						if(Arms == 0)
							usr << "<font color =red>Your arms are too damaged!<br>"
							return
						if(usr.Dead == 0)
							if(usr.Job == null)
								var/Bricks = list()
								var/Num = 0
								var/Loc = usr.loc
								for(var/obj/Items/Resources/LargeBrick/P in usr)
									if(Num != 1)
										Num += 1
										Bricks += P
								if(Num == 1)
									view(usr) << "<font color=yellow>[usr] begins to construct a stone slab from a large brick!<br>"
									usr.Job = "MakeStoneSlab"
									usr.CanMove = 0
									var/Time = 300
									Time -= usr.MasonarySkill * 1.5
									Time -= usr.BuildingSkill * 1.5
									if(Time <= 75)
										Time = 75
									spawn(Time)
										if(usr)
											if(usr.loc == Loc)
												if(usr.Job == "MakeStoneSlab")
													usr.Job = null
													usr.BuildingSkill += usr.BuildingSkillMulti
													usr.MasonarySkill += usr.MasonarySkillMulti
													usr.GainStats(3)
													usr << "<font color =green>You finish construction of a stone slab!<br>"
													for(var/obj/I in Bricks)
														usr.Weight -= I.Weight
														del(I)
													for(var/turf/T in range(0,usr))
														T.icon_state = "slab stone floor"
														T.name = "Stone Slab"
														T.Type = "Inside"
														T.density = 0
														T.AttachedKey = "[usr.key]"
														T.ManMade = 1
														T.Material = "Stone"
														T.desc = "Made by ([usr])[usr.name]"
														T.opacity = 0
														for(var/obj/Items/Misc/M in range(0,usr))
															if(M.loc != usr)
																if(M.density == 0 && M.suffix == null)
																	M.loc = locate(0,0,0)
														for(var/obj/Items/Plants/P in range(0,usr))
															if(P.density == 0)
																P.loc = locate(0,0,0)
														Tiles += T
													usr.MovementCheck()
											else
												usr << "<font color=red>You moved from the position you were building at, you failed to construct a stone slab!<br>"
												return
								else
									usr << "<font color =red>You need one large brick to construct a stone slab!<br>"
									return
				WoodenWall
					icon_state = "wood wall"
					Click()
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						var/Arms = 1
						if(usr.LeftArm <= 25)
							Arms = 0
						if(usr.RightArm <= 25)
							Arms = 0
						if(Arms == 0)
							usr << "<font color =red>Your arms are too damaged!<br>"
							return
						if(usr.Dead == 0)
							if(usr.Job == null)
								var/Planks = list()
								var/Num = 0
								var/Loc = usr.loc
								for(var/obj/Items/Resources/Plank/P in usr)
									if(Num != 3)
										Num += 1
										Planks += P
								if(Num == 3)
									view(usr) << "<font color=yellow>[usr] begins to construct a wooden wall from planks!<br>"
									usr.Job = "MakeWoodWall"
									usr.CanMove = 0
									var/Time = 300
									Time -= usr.CarpentrySkill * 1.5
									Time -= usr.BuildingSkill * 1.5
									if(Time <= 75)
										Time = 75
									spawn(Time)
										if(usr)
											if(usr.loc == Loc)
												if(usr.Job == "MakeWoodWall")
													usr.Job = null
													usr.BuildingSkill += usr.BuildingSkillMulti
													usr.CarpentrySkill += usr.CarpentrySkillMulti
													usr.GainStats(2.5)
													usr << "<font color =green>You finish construction of a wooden wall!<br>"
													for(var/obj/I in Planks)
														usr.Weight -= I.Weight
														del(I)
													for(var/turf/T in range(0,usr))
														T.icon_state = "wood wall"
														T.density = 1
														T.opacity = 1
														T.Dura += 25
														T.Fuel = 100
														T.AttachedKey = "[usr.key]"
														T.ManMade = 1
														T.Type = "Inside"
														T.Material = "Wood"
														T.desc = "Made by ([usr])[usr.name]"
														T.Dura += usr.CarpentrySkill
														T.Dura += usr.BuildingSkill
														T.name = "Wooden Wall"
														for(var/obj/Items/Misc/M in range(0,usr))
															if(M.loc != usr)
																if(M.density == 0 && M.suffix == null)
																	M.loc = locate(0,0,0)
														for(var/obj/Items/Plants/P in range(0,usr))
															if(P.density == 0)
																P.loc = locate(0,0,0)
														Tiles += T
													usr.MovementCheck()
											else
												usr << "<font color=red>You moved from the position you were building at, you failed to construct a wooden wall!<br>"
												return
								else
									usr << "<font color =red>You need three planks to construct a wall!<br>"
									return
				WoodenFloor
					icon_state = "wood floor"
					Click()
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						var/Arms = 1
						if(usr.LeftArm <= 25)
							Arms = 0
						if(usr.RightArm <= 25)
							Arms = 0
						if(Arms == 0)
							usr << "<font color =red>Your arms are too damaged!<br>"
							return
						if(usr.Dead == 0)
							if(usr.Job == null)
								var/Planks = list()
								var/Num = 0
								var/Loc = usr.loc
								for(var/obj/Items/Resources/Plank/P in usr)
									if(Num != 3)
										Num += 1
										Planks += P
								if(Num == 3)
									view(usr) << "<font color=yellow>[usr] begins to construct a wooden floor from planks!<br>"
									usr.Job = "MakeWoodFloor"
									usr.CanMove = 0
									var/Time = 300
									Time -= usr.CarpentrySkill * 1.5
									Time -= usr.BuildingSkill * 1.5
									if(Time <= 75)
										Time = 75
									spawn(Time)
										if(usr)
											if(usr.loc == Loc)
												if(usr.Job == "MakeWoodFloor")
													usr.Job = null
													usr.BuildingSkill += usr.BuildingSkillMulti
													usr.CarpentrySkill += usr.CarpentrySkillMulti
													usr.GainStats(2.5)
													usr << "<font color =green>You finish construction of a wooden floor!<br>"
													for(var/obj/I in Planks)
														usr.Weight -= I.Weight
														del(I)
													for(var/turf/T in range(0,usr))
														T.icon_state = "wood floor"
														T.density = 0
														T.opacity = 0
														T.Fuel = 100
														T.AttachedKey = "[usr.key]"
														T.ManMade = 1
														T.Material = "Wood"
														T.Type = "Inside"
														T.desc = "Made by ([usr])[usr.name]"
														T.name = "Wooden Floor"
														for(var/obj/Items/Misc/M in range(0,usr))
															if(M.loc != usr)
																if(M.density == 0 && M.suffix == null)
																	M.loc = locate(0,0,0)
														for(var/obj/Items/Plants/P in range(0,usr))
															if(P.density == 0)
																P.loc = locate(0,0,0)
														Tiles += T
													usr.MovementCheck()
											else
												usr << "<font color=red>You moved from the position you were building at, you failed to construct a wooden floor!<br>"
												return
								else
									usr << "<font color =red>You need three planks to construct a wooden floor!<br>"
									return
			Admin
				layer = 100
				icon = 'adminhud.dmi'
				Type = "AdminHuds"
				BackGround
					icon_state = "background"
				TMiddle
					icon_state = "Tmiddle"
				Left
					icon_state = "L"
				Right
					icon_state = "R"
				Top
					icon_state = "T"
				Bottom
					icon_state = "B"
				TR
					icon_state = "TR"
				TL
					icon_state = "TL"
				BL
					icon_state = "BL"
				BR
					icon_state = "BR"
			Scroll
				layer = 100
				name = ""
				ScrollTrans
					icon = 'books.dmi'
					icon_state = "transparent"
				ScrollLeft
					icon = 'books.dmi'
					icon_state = "Left"
				ScrollRight
					icon = 'books.dmi'
					icon_state = "Right"
				Scroll
					icon = 'books.dmi'
					icon_state = "Scroll"
				ScrollRight2
					icon = 'books.dmi'
					icon_state = "ScrollRight"
				ScrollLeft2
					icon = 'books.dmi'
					icon_state = "ScrollLeft"
				ScrollMiddle
					icon_state = "Middle"
					icon = 'books.dmi'
			Inventory
				BottomRight
					icon_state = "BR"
					icon = 'HUD.dmi'
				BottomLeft
					icon_state = "BL"
					icon = 'HUD.dmi'
				TopRight
					icon_state = "TR"
					icon = 'HUD.dmi'
				TopLeft
					icon_state = "TL"
					icon = 'HUD.dmi'
				TopMiddle
					icon_state = "TM"
					icon = 'HUD.dmi'
				BottomMiddle
					icon_state = "BM"
					icon = 'HUD.dmi'
				LeftMiddle
					icon_state = "LM"
					icon = 'HUD.dmi'
				RightMiddle
					icon_state = "RM"
					icon = 'HUD.dmi'
				Middle
					icon_state = "M"
					icon = 'HUD.dmi'
				CloseMasonary
					icon_state = "close"
					Type = "Close"
					icon = 'HUD.dmi'
					Click()
						usr.Delete("Masonary","Masonary")
						usr.Ref = null
						for(var/obj/I in usr.client.screen)
							if(I in usr.CreateList)
								usr.client.screen -= I
						del(src)
				CloseCarpentry
					icon_state = "close"
					Type = "Close"
					icon = 'HUD.dmi'
					Click()
						usr.Delete("Carpentry","Carpentry")
						usr.Ref = null
						for(var/obj/I in usr.client.screen)
							if(I in usr.CreateList)
								usr.client.screen -= I
						del(src)
				CloseBone
					icon_state = "close"
					Type = "Close"
					icon = 'HUD.dmi'
					Click()
						usr.Delete("Bone","Bone")
						usr.Ref = null
						for(var/obj/I in usr.client.screen)
							if(I in usr.CreateList)
								usr.client.screen -= I
						del(src)
				CloseLeather
					icon_state = "close"
					Type = "Close"
					icon = 'HUD.dmi'
					Click()
						usr.Delete("Leather","Leather")
						usr.Ref = null
						for(var/obj/I in usr.client.screen)
							if(I in usr.CreateList)
								usr.client.screen -= I
						del(src)
				CloseForgeing
					icon_state = "close"
					Type = "Close"
					icon = 'HUD.dmi'
					Click()
						usr.Delete("Forge","Forge")
						usr.Ref = null
						for(var/obj/I in usr.client.screen)
							if(I in usr.CreateList)
								usr.client.screen -= I
						del(src)
				Close
					icon_state = "close"
					Type = "Close"
					icon = 'HUD.dmi'
					Click()
						if(usr.Container)
							var/obj/C = usr.Container
							if(C.ClosedState)
								C.icon_state = C.ClosedState
								C.overlays = null
								for(var/obj/Items/Misc/Lock/L in C)
									if(L.suffix == "Fitted")
										L.icon_state = "[L.Material] lock fitted chest"
										C.overlays += L
						if(usr.Function == "Transfer")
							usr.ResetButtons()
						usr.DeleteInventoryMenu()
				Transfer
					icon_state = "trade button off"
					Type = "Transfer"
					icon = 'HUD.dmi'
					Click()
						if(usr.Sleeping || usr.Dead || usr.Fainted || usr.Job)
							usr << "<font color = red>You are busy doing somthing else!<br>"
							return
						if(usr.Dead)
							usr << "<b>Cant do that while dead!<br>"
							return
						if(src.icon_state == "trade button off")
							usr.Function = "Transfer"
							src.icon_state = "trade button on"
							usr << "Click an item to transfer it between you and a container!<br>"
							return
						if(src.icon_state == "trade button on")
							usr.Function = null
							src.icon_state = "trade button off"
							return
				Eat
					icon_state = "eat button off"
					Type = "Eat"
					icon = 'HUD.dmi'
					Click()
						if(usr.Sleeping || usr.Dead || usr.Fainted || usr.Job)
							usr << "<font color = red>You are busy doing somthing else!<br>"
							return
						if(usr.Dead)
							usr << "<b>Cant do that while dead!<br>"
							return
						if(usr.CanEat == 0)
							usr << "<font color =red>You cant eat anything!<br>"
							return
						if(src.icon_state == "eat button off")
							usr.Function = "Eat"
							src.icon_state = "eat button on"
							usr << "Click food to eat it!<br>"
							return
						if(src.icon_state == "eat button on")
							usr.Function = null
							src.icon_state = "eat button off"
							return
				Equip
					icon_state = "equip button off"
					Type = "Equip"
					icon = 'HUD.dmi'
					Click()
						if(usr.Sleeping || usr.Dead || usr.Fainted || usr.Job)
							usr << "<font color = red>You are busy doing somthing else!<br>"
							return
						if(usr.Dead)
							usr << "<b>Cant do that while dead!<br>"
							return
						if(src.icon_state == "equip button off")
							usr.ResetButtons()
							usr.Function = "Equip"
							src.icon_state = "equip button on"
							return
						if(src.icon_state == "equip button on")
							usr.Function = null
							src.icon_state = "equip button off"
							return
				Slot
					icon_state = "inv slot"
					icon = 'HUD.dmi'
		RaceSelection
			icon = 'menu.dmi'
			layer = 100
			Male
				icon_state = "male off"
				Type = "male"
				Click()
					if(usr.Race)
						if(usr.Gender == null)
							src.icon_state = "male on"
							usr.Gender = "Male"
					else
						usr << "<b>Choose a race first!<br>"
						return
			Female
				icon_state = "female off"
				Type = "female"
				Click()
					if(usr.Race)
						if(usr.Gender == null)
							src.icon_state = "female on"
							usr.Gender = "Female"
					else
						usr << "<b>Choose a race first!<br>"
						return
			Accept
				icon = 'books.dmi'
				icon_state = "accept"
				Type = "DontChange"
				Click()
					if(usr.Race)
						if(usr.Gender)
							usr << sound(null)
							usr.MusicProc()
							usr.density = 1
							usr.CreateCharacter()
						else
							usr << "<b>Choose a gender first!<br>"
							return
					else
						usr << "<b>Choose a race by clicking a portrait!<br>"
						return
			Cancel
				icon = 'books.dmi'
				icon_state = "cancel"
				Type = "DontChange"
				Click()
					usr.ResetSelections()
			Human
				icon_state = "human off"
				Type = "human"
				Click()
					if(usr.Race ==null)
						src.icon_state = "human on"
						usr.Race = "Human"
						usr.Text("RaceInfo",usr,7,13,10,14,"--Humans--")
						usr.Text("RaceInfo",usr,2,12,10,14,"The Humans are the most balanced of all the races.")
						usr.Text("RaceInfo",usr,2,11,10,14,"Within the Empire there are various guilds")
						usr.Text("RaceInfo",usr,2,10,10,14,"Most of which revolve around the worship of")
						usr.Text("RaceInfo",usr,2,9,10,14,"the God of Order. Humans have average Strength,")
						usr.Text("RaceInfo",usr,2,8,10,14,"Agility, Endurance and slightly above average")
						usr.Text("RaceInfo",usr,2,7,10,14,"Intelligence. They have good skill in swords and")
						usr.Text("RaceInfo",usr,2,6,10,14,"shields and are also very good at carpentry and")
						usr.Text("RaceInfo",usr,2,5,10,14,"farming. Humans tend to live for around 85 years.")
			Giant
				icon_state = "giant off"
				Type = "giant"
				Click()
					if(usr.Race ==null)
						src.icon_state = "giant on"
						usr.Race = "Giant"
						usr.Text("RaceInfo",usr,7,13,10,14,"--Giants--")
						usr.Text("RaceInfo",usr,2,12,10,14,"The Giants are a strong but dim race. They")
						usr.Text("RaceInfo",usr,2,11,10,14,"tend to live in caves or small villages. Due")
						usr.Text("RaceInfo",usr,2,10,10,14,"to their intelligence they tend to worship any")
						usr.Text("RaceInfo",usr,2,9,10,14,"God they hear of. Giants have very good Strength,")
						usr.Text("RaceInfo",usr,2,8,10,14,"Endurance and very bad Agility and Intelligence.")
						usr.Text("RaceInfo",usr,2,7,10,14,"They have very good skill with blunt weapons but")
						usr.Text("RaceInfo",usr,2,6,10,14,"lack skill with others.Giants are very skilled at")
						usr.Text("RaceInfo",usr,2,5,10,14,"tree chopping and mining,aswell as contruction.")
						usr.Text("RaceInfo",usr,2,4,10,14,"They tend to live for 100 years.")
			Stahlite
				icon_state = "dwarf off"
				Type = "dwarf"
				Click()
					if(usr.Race ==null)
						src.icon_state = "dwarf on"
						usr.Race = "Stahlite"
						usr.Text("RaceInfo",usr,7,13,10,14,"--Stahlites--")
						usr.Text("RaceInfo",usr,2,12,10,14,"The Stahlite are a very reclusive race of short")
						usr.Text("RaceInfo",usr,2,11,10,14,"beared humans. They love to mine for riches and")
						usr.Text("RaceInfo",usr,2,10,10,14,"constantly drink to keep their spirits high, the")
						usr.Text("RaceInfo",usr,2,9,10,14,"Stahlite tend to worship the God of Crafts,Stahlite")
						usr.Text("RaceInfo",usr,2,8,10,14,"have good Strength and Endurance but slightly poor")
						usr.Text("RaceInfo",usr,2,7,10,14,"Agility.They are as smart as humans. They are very")
						usr.Text("RaceInfo",usr,2,6,10,14,"good with Axes and Blunts,as well as ranged weapons")
						usr.Text("RaceInfo",usr,2,5,10,14,"Stahlite are good at most crafting skill,especially")
						usr.Text("RaceInfo",usr,2,4,10,14,"contruction.Stahlite tend to live for 150 years.")
			Cyclops
				icon_state = "cyclops off"
				Type = "cyclops"
				Click()
					if(usr.Race ==null)
						src.icon_state = "cyclops on"
						usr.Race = "Cyclops"
						usr.Text("RaceInfo",usr,7,13,10,14,"--Cyclops--")
						usr.Text("RaceInfo",usr,2,12,10,14,"The Cyclops are a primitive race of cave dwellers")
						usr.Text("RaceInfo",usr,2,11,10,14,"who love to raid other settlements. They are very")
						usr.Text("RaceInfo",usr,2,10,10,14,"anti social and incredibily stupid. They only")
						usr.Text("RaceInfo",usr,2,9,10,14,"worship the God of Destruction. Cyclops have good")
						usr.Text("RaceInfo",usr,2,8,10,14,"Strength and Endurance but bad Agility and very")
						usr.Text("RaceInfo",usr,2,7,10,14,"bad Intelligence. They are very skilled in blunt")
						usr.Text("RaceInfo",usr,2,6,10,14,"weapons but lack the skill of others. They are")
						usr.Text("RaceInfo",usr,2,5,10,14,"also good at hunting and trap making.")
						usr.Text("RaceInfo",usr,2,4,10,14,"They tend to live for 90 years.")
			Frogman
				icon_state = "frogman off"
				Type = "frogman"
				Click()
					if(usr.Race ==null)
						src.icon_state = "frogman on"
						usr.Race = "Frogman"
						usr.Text("RaceInfo",usr,7,13,10,14,"--Frogmen--")
						usr.Text("RaceInfo",usr,2,12,10,14,"The Frogmen are a very agile race of swamp dwellers")
						usr.Text("RaceInfo",usr,2,11,10,14,"who constantly fight over breeding grounds. They")
						usr.Text("RaceInfo",usr,2,10,10,14,"tend to worship the Gods of Harvest and Beasts.")
						usr.Text("RaceInfo",usr,2,9,10,14,"Frogmen have very good Agility but poor Strength")
						usr.Text("RaceInfo",usr,2,8,10,14,"and Endurnace they also have poor Intelligence.They")
						usr.Text("RaceInfo",usr,2,7,10,14,"are skilled with spears,shields and ranged weapons.")
						usr.Text("RaceInfo",usr,2,6,10,14,"They have good skills at trap making,hunting")
						usr.Text("RaceInfo",usr,2,5,10,14,"and Swimming. Frogmen tend to live for 80 years.")
			Wolfman
				icon_state = "wolfman off"
				Type = "wolfman"
				Click()
					if(usr.Race ==null)
						src.icon_state = "wolfman on"
						usr.Race = "Wolfman"
						usr.Text("RaceInfo",usr,7,13,10,14,"--Wolfmen--")
						usr.Text("RaceInfo",usr,2,12,10,14,"Wolfmen are a brutal race of hunters and stalkers")
						usr.Text("RaceInfo",usr,2,11,10,14,"of the night. Their great strength and speed")
						usr.Text("RaceInfo",usr,2,10,10,14,"make them a worthy foe for any opponent. Wolfmen")
						usr.Text("RaceInfo",usr,2,9,10,14,"worship the gods of Beasts, Destruction and")
						usr.Text("RaceInfo",usr,2,8,10,14,"rarely Death. They have amazing un-armed skill,but")
						usr.Text("RaceInfo",usr,2,7,10,14,"below average weapon skill in all other areas.")
						usr.Text("RaceInfo",usr,2,6,10,14,"They are great trackers, skinners, and fishers")
						usr.Text("RaceInfo",usr,2,5,10,14,"and tend to live for around 90 years.")
			Snakeman
				icon_state = "snakeman off"
				Type = "snakeman"
				Click()
					if(usr.Race ==null)
						src.icon_state = "snakeman on"
						usr.Race = "Snakeman"
						usr.Text("RaceInfo",usr,7,13,10,14,"--Snakemen--")
						usr.Text("RaceInfo",usr,2,12,10,14,"The Snakemen are one of the oldest races in")
						usr.Text("RaceInfo",usr,2,11,10,14,"the world,third to the Stahlites and Altherians.")
						usr.Text("RaceInfo",usr,2,10,10,14,"They are a desert dwelling nomad race, with no")
						usr.Text("RaceInfo",usr,2,9,10,14,"true home or loyalties. They tend to worship the")
						usr.Text("RaceInfo",usr,2,8,10,14,"gods of Wisdom, Blood and Death, but are not truly")
						usr.Text("RaceInfo",usr,2,7,10,14,"good or evil. Snakeman are strong and fast,but lack")
						usr.Text("RaceInfo",usr,2,6,10,14,"the endruance of others. They have great skills in")
						usr.Text("RaceInfo",usr,2,5,10,14,"most weapons.They are good at stone work & alchemy.")
						usr.Text("RaceInfo",usr,2,4,10,14,"Snakemen tend to live for around 100 years.")
			Lizardman
				icon_state = "lizardman off"
				Type = "lizardman"
				Click()
					if(usr.Race ==null)
						src.icon_state = "lizardman on"
						usr.Race = "Illithid"
						usr.Text("RaceInfo",usr,7,13,10,14,"--Lizardmen--")
						usr.Text("RaceInfo",usr,2,12,10,14,"Illithids are not native to this world, coming")
						usr.Text("RaceInfo",usr,2,11,10,14,"from a strange star long ago.They are super")
						usr.Text("RaceInfo",usr,2,10,10,14,"Intelligent and rather agile, but lack strength")
						usr.Text("RaceInfo",usr,2,9,10,14,"and endurance.They gain in every skill at an")
						usr.Text("RaceInfo",usr,2,8,10,14,"above average rate and start with some Astral")
						usr.Text("RaceInfo",usr,2,7,10,14,"Magic.They speak Ancient,regrow lost limbs and")
						usr.Text("RaceInfo",usr,2,6,10,14,"need not breathe.They make excellent magic users")
						usr.Text("RaceInfo",usr,2,5,10,14,"and learn it with great speed.Illithids live for")
						usr.Text("RaceInfo",usr,2,4,10,14,"200 years and worship no earthly god.")
			Illithid
				icon_state = "illithid off"
				Type = "illithid"
				Click()
					if(usr.Race ==null)
						src.icon_state = "illithid on"
						usr.Race = "Illithid"
						usr.Text("RaceInfo",usr,7,13,10,14,"--Illithids--")
						usr.Text("RaceInfo",usr,2,12,10,14,"Illithids are not native to this world, coming")
						usr.Text("RaceInfo",usr,2,11,10,14,"from a strange star long ago.They are super")
						usr.Text("RaceInfo",usr,2,10,10,14,"Intelligent and rather agile, but lack strength")
						usr.Text("RaceInfo",usr,2,9,10,14,"and endurance.They gain in every skill at an")
						usr.Text("RaceInfo",usr,2,8,10,14,"above average rate and start with some Astral")
						usr.Text("RaceInfo",usr,2,7,10,14,"Magic.They speak Ancient,regrow lost limbs and")
						usr.Text("RaceInfo",usr,2,6,10,14,"need not breathe.They make excellent magic users")
						usr.Text("RaceInfo",usr,2,5,10,14,"and learn it with great speed.Illithids live for")
						usr.Text("RaceInfo",usr,2,4,10,14,"200 years and worship no earthly god.")
			Alther
				icon_state = "elf off"
				Type = "elf"
				Click()
					if(usr.Race ==null)
						src.icon_state = "elf on"
						usr.Race = "Alther"
						usr.Text("RaceInfo",usr,7,13,10,14,"--Altherions--")
						usr.Text("RaceInfo",usr,2,12,10,14,"The Altherions are a highly intelligent race")
						usr.Text("RaceInfo",usr,2,11,10,14,"who specialize in magical and spiritial culture.")
						usr.Text("RaceInfo",usr,2,10,10,14,"They worship the Gods of Harvest,Beasts and")
						usr.Text("RaceInfo",usr,2,9,10,14,"Wisdom and somtimes the God of Order.They have good")
						usr.Text("RaceInfo",usr,2,8,10,14,"Agility and very good intelligence but lack in")
						usr.Text("RaceInfo",usr,2,7,10,14,"Strength and Endurance. Altherions have good skill")
						usr.Text("RaceInfo",usr,2,6,10,14,"in all weapons except axes.They are skilled at")
						usr.Text("RaceInfo",usr,2,5,10,14,"Stone Work,Contruction and Hunting.They tend to")
						usr.Text("RaceInfo",usr,2,4,10,14,"live for 200 years.")
			Ratling
				icon_state = "ratling off"
				Type = "ratling"
				Click()
					if(usr.Race ==null)
						src.icon_state = "ratling on"
						usr.Race = "Ratling"
						usr.Text("RaceInfo",usr,7,13,10,14,"--Ratlings--")
						usr.Text("RaceInfo",usr,2,12,10,14,"The Ratlings are a disgusting race of warped rodent")
						usr.Text("RaceInfo",usr,2,11,10,14,"who specialize in death and detruction. They were")
						usr.Text("RaceInfo",usr,2,10,10,14,"created by Chaos Energy and worship the Gods of")
						usr.Text("RaceInfo",usr,2,9,10,14,"Destruction,Death and Chaos. They have incredible")
						usr.Text("RaceInfo",usr,2,8,10,14,"Agility, but very poor Strength and Endurance.They")
						usr.Text("RaceInfo",usr,2,7,10,14,"have average Intelligence and are very skilled with")
						usr.Text("RaceInfo",usr,2,6,10,14,"Daggers, Spears and Ranged weapons.They are good at")
						usr.Text("RaceInfo",usr,2,5,10,14,"making traps, hunting and stealth.Ratlings tend to")
						usr.Text("RaceInfo",usr,2,4,10,14,"live for 75 years.")

		AdminButtons
			icon = 'adminhud.dmi'
			AdminSummon
				icon_state = "summon off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin)
						src.icon_state = "summon on"
						var/list/menu = new()
						var/Mobs = list()
						for(var/mob/M in world)
							menu += "[M.name]"
							if(M.OriginalName)
								menu += "[M.OriginalName]"
							Mobs += M
						menu += "Cancel"
						var/Result = input("Who do you wish to summon?", "Choose", null) in menu
						if (Result == "Cancel")
							src.icon_state = "summon off"
							return
						if(Result)
							var/mob/Found = null
							for(var/mob/M in Mobs)
								if(M.name == Result)
									Found = M
								if(M.OriginalName == Result)
									Found = M
							if(Found)
								Found.loc = usr.loc
								Found.overlays -= /obj/Misc/Bubbles/
								Found.overlays -= /obj/Misc/Swim/
								Found.InWater = 0
								src.icon_state = "summon off"
								Found << "<font color =yellow>[usr] summons you!<br>"
								usr << "<font color =green>You summon [Found]!<br>"
								usr.Log_admin("([usr.key])[usr] summons [Found] to [usr.x],[usr.y],[usr.z]")
			AdminTeleport
				icon_state = "teleport off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin)
						usr << "<font color = yellow>Location - [usr.x],[usr.y],[usr.z]<br>"
						switch(alert("Teleport to Object? Or Teleport to location?",,"Object","Location"))
							if("Location")
								var/X=input("X Location??")as num
								var/Y=input("Y Location??")as num
								var/Z=input("Z Location??")as num
								if(X)
									if(Y)
										if(Z)
											usr.loc = locate(X,Y,Z)
											usr.overlays -= /obj/Misc/Bubbles/
											usr.overlays -= /obj/Misc/Swim/
											usr.InWater = 0
											usr << "<font color = green>You teleport to [X],[Y],[Z]!<br>"
											usr.Log_admin("([usr.key])[usr] teleports to [X],[Y],[Z]")
								return
							if("Object")
								src.icon_state = "teleport on"
								var/list/menu = new()
								var/Mobs = list()
								for(var/mob/M in world)
									menu += "[M.name]"
									if(M.OriginalName)
										menu += "[M.OriginalName]"
									Mobs += M
								menu += "Cancel"
								var/Result = input("Who do you wish to teleport to?", "Choose", null) in menu
								if (Result == "Cancel")
									src.icon_state = "teleport off"
									return
								if(Result)
									var/mob/Found = null
									for(var/mob/M in Mobs)
										if(M.name == Result)
											Found = M
										if(M.OriginalName == Result)
											Found = M
									if(Found)
										usr.loc = Found.loc
										usr.overlays -= /obj/Misc/Bubbles/
										usr.overlays -= /obj/Misc/Swim/
										usr.InWater = 0
										src.icon_state = "teleport off"
										usr.Log_admin("([usr.key])[usr] teleports to [Found]")
			AdminCreate
				icon_state = "create off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin >= 2)
						src.icon_state = "create on"
						var/T=input("Create what??")as null|anything in typesof(/obj,/mob)
						if(T == null)
							src.icon_state = "create off"
							return
						if(T)
							var/N=input("How many?? No more than 50")as null|num
							if(N == 0)
								return
							if(N >= 51)
								usr << "That number is too high!<br>"
								return
							if(N == null)
								return
							if(N)
								usr.Log_admin("([usr.key])[usr] creates [N] [T] at [usr.x],[usr.y],[usr.z]")
								while(N)
									N -= 1
									var/obj/O = new T()
									O.loc = usr.loc
									src.icon_state = "create off"
					else
						usr << "<font color = teal>Your Admin Level is not High enough.<br>"
						return
			AdminEdit
				icon_state = "edit off"
				Type = "AdminHuds"
				layer = 100
				Click()
					src.icon_state = "edit on"
					if(usr.AdminDelete)
						usr << "<font color = green>Admin Delete Mode Off!<br>"
						usr.AdminDelete = 0
						src.icon_state = "edit off"
						return
					if(usr.AdminEdit)
						usr << "<font color = green>Admin Edit Mode Off!<br>"
						usr.AdminEdit = 0
						src.icon_state = "edit off"
						return
					switch(alert("Double Click an object to Delete? Or Double Click an object to Edit?",,"DoubleClick","Delete"))
						if("Delete")
							if(usr.Admin >= 2)
								usr.AdminDelete = 1
								usr << "<font color = green> Double Click an object to Delete/Boot it!<br>"
								return
							else
								usr << "<font color = teal>Your Admin Level is not High enough.<br>"
								return
						if("DoubleClick")
							if(usr.Admin >= 3)
								usr.AdminEdit = 1
								usr << "<font color = green> Double Click an object to Edit it!<br>"
								return
							else
								usr << "<font color = teal>Your Admin Level is not High enough.<br>"
								return
			AdminBan
				icon_state = "ban off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin >= 1)
						src.icon_state = "ban on"
						switch(alert("Ban or Un-Ban?",,"Ban","Un-Ban"))
							if("Un-Ban")
								var/T=input("Which address would you like to unban?")as null|anything in BanList
								BanList -= T
								src.icon_state = "ban off"
								SaveMisc()
								return
							if("Ban")
								switch(alert("Ban or Manual Ban?",,"Ban","Manual Ban"))
									if("Manual Ban")
										var/B = input("Enter the IP or Key of a Player to Ban","Ban")as null|text
										if(!B)
											src.icon_state = "ban off"
											return
										BanList += B
										src.icon_state = "ban off"
										world << "<font color = teal>[B] was Manually Banned by [usr]<br>"
										SaveMisc()
										return
									if("Ban")
										var/Ban = list()
										var/list/menu = new()
										for(var/mob/M in world)
											if(M.client)
												usr << "([M.key])[M]<br>"
												menu += "[M.key]"
												Ban += M
										menu += "Cancel"
										var/Result = input("Who do you wish to Ban?", "Choose", null) in menu
										if (Result == "Cancel")
											src.icon_state = "ban off"
											return
										if(Result)
											if(Result == "Ginseng")
												world << "<font color = teal><b><font size = 6>[usr] Tried to Ban Ginseng, but fails!<br>"
												src.icon_state = "ban off"
												return
											if(Result == "Ginseng")
												src.icon_state = "ban off"
												return
											var/R = input("Reason")as null|text
											for(var/mob/M in Ban)
												if(M.key == Result)
													BanList += M.client.address
													world << "<font color = teal>([Result]) [M] has been Banned by ([usr.key])[usr] for [R]!<br>"
													src.icon_state = "ban off"
													usr.Log_admin("([usr.key])[usr] bans ([M.key])[M] for [R]")
													del(M)
													SaveMisc()
											return
					else
						usr << "<font color = teal>Your Admin Level is not High enough.<br>"
						return
			AdminInprison
				icon_state = "prison off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin)
						src.icon_state = "prison on"
						var/list/menu = new()
						var/Mobs = list()
						for(var/mob/M in world)
							menu += "[M.name]"
							if(M.OriginalName)
								menu += "[M.OriginalName]"
							Mobs += M
						menu += "Cancel"
						var/Result = input("Who do you wish to In-Prison?", "Choose", null) in menu
						if (Result == "Cancel")
							src.icon_state = "prison off"
							return
						if(Result)
							var/mob/Found = null
							for(var/mob/M in Mobs)
								if(M.name == Result)
									Found = M
								if(M.OriginalName == Result)
									Found = M
							if(Found)
								switch(alert("Send them to a Prison, or to Hell?",,"Prison","Hell"))
									if("Prison")
										var/R = input("Reason")as null|text
										world << "<font color = teal>([Found.key]) [Found] has been In-Prisoned by ([usr.key]) [usr] for [R]!<br>"
										Found << "<font color = teal><font size = 3>You will be automatically released after one in game month!<br>"
										src.icon_state = "prison off"
										var/LOC = rand(1,6)
										if(LOC == 1)
											Found.loc = locate(25,105,1)
										if(LOC == 2)
											Found.loc = locate(25,103,1)
										if(LOC == 3)
											Found.loc = locate(25,100,1)
										if(LOC == 4)
											Found.loc = locate(31,105,1)
										if(LOC == 5)
											Found.loc = locate(31,103,1)
										if(LOC == 6)
											Found.loc = locate(31,100,1)
										Found.overlays -= /obj/Misc/Bubbles/
										Found.overlays -= /obj/Misc/Swim/
										Found.InWater = 0
										Found.Jailed = 1
										Found.JailTime()
										usr.Log_admin("([usr.key])[usr] jails [Found] for [R]")
										return
									if("Hell")
										usr << "Not added Hell yet."
										return
										var/R = input("Reason")as null|text
										world << "<font color = teal>([Found.key]) [Found] has been sent to Hell by ([usr.key]) [usr] for [R]!<br>"
										src.icon_state = "prison off"
										Found.loc = locate(250,250,4)
										usr.Log_admin("([usr.key])[usr] sends [Found] to Hell.")
			AdminMute
				icon_state = "mute off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin)
						src.icon_state = "mute on"
						switch(alert("Mute a Player? Or Mute the World?",,"Player","World"))
							if("World")
								if(Mute)
									Mute = 0
									world << "<font color = teal>OOC is now Enabled!<br>"
									src.icon_state = "mute off"
									usr.Log_admin("([usr.key])[usr] turns on OOC")
									return
								if(Mute == 0)
									Mute = 1
									world << "<font color = teal>OOC is now Disabled!<br>"
									src.icon_state = "mute off"
									usr.Log_admin("([usr.key])[usr] turns off OOC")
									return
							if("Player")
								var/list/menu = new()
								var/Mobs = list()
								for(var/mob/M in Players)
									menu += "[M.name]"
									if(M.OriginalName)
										menu += "[M.OriginalName]"
									Mobs += M
								menu += "Cancel"
								var/Result = input("Who do you wish to Mute?", "Choose", null) in menu
								if (Result == "Cancel")
									src.icon_state = "mute off"
									return
								if(Result)
									var/mob/Found = null
									for(var/mob/M in Mobs)
										if(M.name == Result)
											Found = M
										if(M.OriginalName == Result)
											Found = M
									if(Found)
										if(Found.Muted == 0)
											Found.Muted = 1
											world << "<font color = teal>([Found.key]) [Found] has been Muted!<br>"
											src.icon_state = "mute off"
											usr.Log_admin("([usr.key])[usr] mutes [Found]")
											return
										if(Found.Muted)
											Found.Muted = 0
											world << "<font color = teal>([Found.key]) [Found] has been Un-Muted!<br>"
											src.icon_state = "mute off"
											usr.Log_admin("([usr.key])[usr] un-mutes [Found]")
											return
			AdminChangeDensity
				icon_state = "turn non-dense off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin)
						if(usr.density)
							src.icon_state = "turn non-dense on"
							usr.density = 0
							usr << "<font color = green>You are now non-dense!<br>"
							usr.Log_admin("([usr.key])[usr] turns non-dense")
							return
						if(usr.density == 0)
							src.icon_state = "turn non-dense off"
							usr.density = 1
							usr << "<font color = green>You are now dense!<br>"
							usr.Log_admin("([usr.key])[usr] turns dense")
							return
			AdminInvisibility
				icon_state = "turn invisible off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin)
						if(usr.AdminInvis)
							src.icon_state = "turn invisible off"
							usr.icon = usr.AdminInvis
							usr.AdminInvis = null
							if(usr.Hair)
								usr.overlays += usr.Hair
							if(usr.Beard)
								usr.overlays += usr.Beard
							for(var/obj/Items/I in usr)
								if(I.suffix == "Equip")
									usr.overlays+=image(I.icon,I.icon_state,I.ItemLayer)
							usr.Faction = usr.StoredFaction
							usr << "<font color = green>You can now be seen by others!<br>"
							usr.Log_admin("([usr.key])[usr] turns visible")
							return
						if(usr.AdminInvis == null)
							src.icon_state = "turn invisible on"
							usr.AdminInvis = usr.icon
							usr.icon = null
							usr.overlays = null
							if(usr.StoredFaction == null)
								usr.StoredFaction = usr.Faction
							usr.Faction = "Admin"
							for(var/obj/I in usr)
								usr.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
							usr << "<font color = green>You are now invisible!<br>"
							usr.Log_admin("([usr.key])[usr] turns invisible")
							return

			AdminServerOptions
				icon_state = "options off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin)
						src.icon_state = "options on"
						var/list/menu = new()
						menu += "Read Admin Logs"
						menu += "Read Player Logs"
						menu += "Read/Edit Notes"
						menu += "Read/Edit Public Notes"
						menu += "Read Bugs/Player Reports"
						menu += "Read Map Logs"
						menu += "Read Errors"
						menu += "Edit Rules"
						menu += "Mob/Obj Count"
						menu += "Save Map"
						menu += "Load Map"
						menu += "Wipe Map"
						menu += "Set Server Status"
						menu += "Set Year"
						menu += "Set World Skill/Stat Cap"
						menu += "Set Gain Bonus"
						menu += "Force Repop"
						menu += "Check Players Contents"
						menu += "Cancel"
						var/Result = input("Choose a option?", "Choose", null) in menu
						if (Result == "Cancel")
							src.icon_state = "options off"
							return
						if(Result == "Read Admin Logs")
							usr<<browse(file("logs/Adminlog.html"))
							return
						if(Result == "Check Players Contents")
							var/list/menu2 = new()
							var/Mobs = list()
							for(var/mob/M in world)
								menu2 += "[M.name]"
								if(M.OriginalName)
									menu2 += "[M.OriginalName]"
								Mobs += M
							menu2 += "Cancel"
							var/Result2 = input("Who do you wish to Check?", "Choose", null) in menu2
							if (Result2 == "Cancel")
								src.icon_state = "options off"
								return
							if(Result2)
								var/mob/Found = null
								for(var/mob/M in Mobs)
									if(M.name == Result2)
										Found = M
									if(M.OriginalName == Result2)
										Found = M
								if(Found)
									for(var/obj/Items/I in Found)
										usr << "<font color = teal>[Found] has [I] [I.suffix]<br>"
									return
						if(Result == "Force Repop")
							Populate()
							usr << "<font color = teal>Repopulation of NPC sucessful, please remember that this happens every in game year automatically.<br>"
							usr.Log_admin("([usr.key])[usr] Forces a Repop.")
						if(Result == "Load Map")
							LoadMap()
							SaveMisc()
							src.icon_state = "options off"
							usr.Log_admin("([usr.key])[usr] loads the map.")
							return
						if(Result == "Save Map")
							SaveMap()
							SaveMisc()
							src.icon_state = "options off"
							usr.Log_admin("([usr.key])[usr] saves the map.")
							return
						if(Result == "Read Map Logs")
							usr << browse(file("logs/Maplog.html"))
							src.icon_state = "options off"
							return
						if(Result == "Read Errors")
							usr << browse(file("ErrorLog.txt"))
							src.icon_state = "options off"
							return
						if(Result == "Edit Rules")
							for(var/mob/M in Players)
								if(M.Admin)
									M << "([usr.key])[usr] is Editing the Rules...<br>"
							var/N = input("Please do not delete the current Rules when you are finished editing","Rules","[Rules]")as null|message
							if(!N)
								src.icon_state = "options off"
								for(var/mob/M in Players)
									if(M.Admin)
										M << "([usr.key])[usr] has Finished Editing the Rules...<br>"
								return
							else
								switch(alert("Are you sure you are done editing the Rules correctly?",,"Yes","No"))
									if("Yes")
										Rules = N
										src.icon_state = "options off"
										for(var/mob/M in Players)
											if(M.Admin)
												M << "[usr] has Finished Editing the Rules...<br>"
										return
									if("No")
										src.icon_state = "options off"
										for(var/mob/M in Players)
											if(M.Admin)
												M << "[usr] has Canceled Editing the Rules...<br>"
										return
						if(Result == "Read/Edit Public Notes")
							switch(alert("Read or Edit?",,"Read","Edit"))
								if("Read")
									var/html_doc="<head><title>Public Notes</title></head><body bgcolor=#000000 text=#FFFF00><center>[PublicNotes]"
									usr<<browse(html_doc,"window=Public Notes")
									src.icon_state = "options off"
									return
								if("Edit")
									for(var/mob/M in Players)
										if(M.Admin)
											M << "([usr.key])[usr] is Editing the Public Notes...<br>"
									var/N = input("Please do not delete the current Public Notes when you are finished editing","Public Notes","[PublicNotes]")as null|message
									if(!N)
										src.icon_state = "options off"
										for(var/mob/M in Players)
											if(M.Admin)
												M << "([usr.key])[usr] has Finished Editing the Public Notes...<br>"
										return
									else
										switch(alert("Are you sure you are done editing the Public Notes correctly?",,"Yes","No"))
											if("Yes")
												PublicNotes = N
												src.icon_state = "options off"
												for(var/mob/M in Players)
													if(M.Admin)
														M << "[usr] has Finished Editing the Public Notes...<br>"
												return
											if("No")
												src.icon_state = "options off"
												for(var/mob/M in Players)
													if(M.Admin)
														M << "[usr] has Canceled Editing the Public Notes...<br>"
												return
						if(Result == "Read/Edit Notes")
							switch(alert("Read or Edit?",,"Read","Edit"))
								if("Read")
									var/html_doc="<head><title>Notes</title></head><body bgcolor=#000000 text=#FFFF00><center>[Notes]"
									usr<<browse(html_doc,"window=Notes")
									src.icon_state = "options off"
									return
								if("Edit")
									for(var/mob/M in Players)
										if(M.Admin)
											M << "([usr.key])[usr] is Editing the Notes...<br>"
									var/N = input("Please do not delete the current Notes when you are finished editing","Notes","[Notes]")as null|message
									if(!N)
										src.icon_state = "options off"
										for(var/mob/M in Players)
											if(M.Admin)
												M << "([usr.key])[usr] has Finished Editing the Notes...<br>"
										return
									else
										switch(alert("Are you sure you are done editing the Notes correctly?",,"Yes","No"))
											if("Yes")
												Notes = N
												src.icon_state = "options off"
												for(var/mob/M in Players)
													if(M.Admin)
														M << "[usr] has Finished Editing the Notes...<br>"
												return
											if("No")
												src.icon_state = "options off"
												for(var/mob/M in Players)
													if(M.Admin)
														M << "[usr] has Canceled Editing the Notes...<br>"
												return
						if(Result == "Wipe Map")
							switch(alert("Wipe Map?",,"Yes","No"))
								if("No")
									src.icon_state = "options off"
									return
								if("Yes")
									if(usr.Admin >= 1)
										fdel("map/")
										world << "<font color = teal><font size = 4>Map has been wiped by [usr]!<br>"
										usr.Log_admin("([usr.key])[usr] Wipes the Map Save Files.")
										src.icon_state = "options off"
										return
									else
										usr << "<font color = teal>Your Admin Level is not High enough.<br>"
										return
						if(Result == "Set Gain Bonus")
							var/S = input("The default gain chance for players is 22% per hit on a mob. Raising this will increase the speed they gain by the percent you enter. Current Gains are [GainRate].")as null|num
							if(!S)
								src.icon_state = "options off"
								return
							if(S)
								GainRate = S
								src.icon_state = "options off"
								world << "<font color = teal>World Gain Bonus has been set to [S] by ([usr.key])[usr], Now saving map!<br>"
								SaveMap()
								SaveMisc()
								usr.Log_admin("([usr.key])[usr] sets the Bonus Gain to [S].")
								return
						if(Result == "Set World Skill/Stat Cap")
							var/S = input("This sets the games World Skill/Stat Cap, the Default is 11, at year 0.Current is [WorldSkillsCap].")as null|num
							if(!S)
								src.icon_state = "options off"
								return
							if(S)
								WorldSkillsCap = S
								WorldStrCap = S
								WorldAgilCap = S
								WorldEndCap = S
								WorldIntCap = S
								src.icon_state = "options off"
								world << "<font color = teal>World Skill/Stat Cap has been set to [S] by ([usr.key])[usr], Now saving map!<br>"
								SaveMap()
								SaveMisc()
								usr.Log_admin("([usr.key])[usr] sets the Worlds Skill Cap to [S].")
								return
						if(Result == "Set Year")
							var/S = input("This sets the game year.")as null|num
							if(!S)
								src.icon_state = "options off"
								return
							if(S)
								Year = S
								WorldSkillsCap = 0
								WorldStrCap = 0
								WorldAgilCap = 0
								WorldEndCap = 0
								WorldIntCap = 0
								WorldSkillsCap += 36 * S
								WorldStrCap += 36 * S
								WorldAgilCap += 36 * S
								WorldEndCap += 36 * S
								WorldIntCap += 36 * S
								src.icon_state = "options off"
								world << "<font color = teal>Year as been set to [Year] by ([usr.key])[usr], Now saving map!<br>"
								SaveMap()
								SaveMisc()
								usr.Log_admin("([usr.key])[usr] sets the Worlds Year to [Year].")
								return
						if(Result == "Set Server Status")
							var/S = input("This sets the status of the game on someones pager.")as null|text
							if(!S)
								src.icon_state = "options off"
								return
							if(S)
								world.status = S
								src.icon_state = "options off"
								world << "World status set to [S] by [usr]<br>"
								usr.Log_admin("([usr.key])[usr] sets the Server Status to [S]")
								return
						if(Result == "Mob/Obj Count")
							var/mobs = 0
							var/objs = 0
							for(var/mob/m in world)
								mobs += 1
							for(var/obj/I in world)
								objs += 1
							usr << "<font color = teal> There are [mobs] Mobs and [objs] Objs!<br>"
							src.icon_state = "options off"
							return
						if(Result == "Read Bugs/Player Reports")
							usr<<browse(file("logs/Reports.html"))
							src.icon_state = "options off"
							return
						if(Result == "Read Error Logs")
							usr<<browse(file("logs/Errorlog.html"))
							src.icon_state = "options off"
							return
						if(Result == "Read Player Logs")
							var/list/players = new()
							var/Mobs = list()
							for(var/mob/M in Players)
								players += "[M.name]"
								if(M.OriginalName)
									players += "[M.OriginalName]"
								Mobs += M
							players += "Cancel"
							var/Results = input("Read Which Log?", "Choose", null) in players
							if (Results == "Cancel")
								src.icon_state = "options off"
								return
							if(Results)
								var/mob/Found = null
								for(var/mob/M in Mobs)
									if(M.name == Results)
										Found = M
									if(M.OriginalName == Results)
										Found = M
								if(Found)
									usr<<browse(file("logs/Log([Found.key]).html"))
									src.icon_state = "options off"
								return
			AdminReboot
				icon_state = "reboot off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin >= 1)
						src.icon_state = "reboot on"
						switch(alert("Choose Option",,"Reboot","Shut Down"))
							if("Reboot")
								switch(alert("Reboot Server?",,"Yes","No"))
									if("No")
										src.icon_state = "reboot off"
										return
									if("Yes")
										src.icon_state = "reboot off"
										world << "<font color=yellow><font size =10>Server will reboot in one minute!<br>"
										usr.Log_admin("([usr.key])[usr] reboots world")
										RebootProc()
										return
							if("Shut Down")
								switch(alert("Shut Server?",,"Yes","No"))
									if("No")
										src.icon_state = "reboot off"
										return
									if("Yes")
										src.icon_state = "reboot off"
										world << "<font color=yellow><font size =10>Server will now shut down - ([usr.key])[usr] - [usr.OriginalName]<br>"
										usr.Log_admin("([usr.key])[usr] shuts the world down")
										SaveMap()
										SaveMisc()
										del(world)
					else
						usr << "<font color = teal>Your Admin Level is not High enough.<br>"
						return
			AdminEditStory
				icon_state = "edit story off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin)
						src.icon_state = "edit story on"
						switch(alert("Edit Story?? Or Edit Ranks??",,"Story","Ranks"))
							if("Story")
								for(var/mob/M in Players)
									if(M.Admin)
										M << "([usr.key])[usr] is Editing the Story...<br>"
								var/N = input("Please do not delete the current Story when you are finished editing","Story","[Story]")as null|message
								if(!N)
									src.icon_state = "edit story off"
									for(var/mob/M in Players)
										if(M.Admin)
											M << "([usr.key])[usr] has Finished Editing the Story...<br>"
									return
								else
									switch(alert("Are you sure you are done editing the Story correctly?",,"Yes","No"))
										if("Yes")
											Story = N
											src.icon_state = "edit story off"
											for(var/mob/M in Players)
												if(M.Admin)
													M << "([usr.key])[usr] has Finished Editing the Story...<br>"
											return
										if("No")
											src.icon_state = "edit story off"
											for(var/mob/M in Players)
												if(M.Admin)
													M << "([usr.key])[usr] has Canceled Editing the Story...<br>"
											return
							if("Ranks")
								for(var/mob/M in Players)
									if(M.Admin)
										M << "([usr.key])[usr] is Editing the Ranks...<br>"
								var/N = input("Please do not delete the current Ranks when you are finished editing","Ranks","[Ranks]")as null|message
								if(!N)
									src.icon_state = "edit story off"
									for(var/mob/M in Players)
										if(M.Admin)
											M << "([usr.key])[usr] has Finished Editing the Ranks...<br>"
									return
								else
									switch(alert("Are you sure you are done editing the Ranks correctly?",,"Yes","No"))
										if("Yes")
											Ranks = N
											src.icon_state = "edit story off"
											for(var/mob/M in Players)
												if(M.Admin)
													M << "([usr.key])[usr] has Finished Editing the Ranks...<br>"
											return
										if("No")
											src.icon_state = "edit story off"
											for(var/mob/M in Players)
												if(M.Admin)
													M << "([usr.key])[usr] has Canceled Editing the Ranks...<br>"
											return
						return
			AdminReward
				icon_state = "max stats off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin)
						src.icon_state = "max stats on"
						var/list/rewards = new()
						rewards += "Reward Rank"
						rewards += "Reward Language"
						rewards += "Reward Stats"
						rewards += "Reward Race"
						rewards += "Cancel"
						var/Rewarded = input("Choose a Reward to give.", "Choose", null) in rewards
						if(Rewarded == "Reward Race")
							if(usr.Admin >= 3)
								var/list/menu = new()
								var/Mobs = list()
								for(var/mob/M in world)
									if(M.client)
										menu += "[M.name]"
										if(M.OriginalName)
											menu += "[M.OriginalName]"
										Mobs += M
								menu += "Cancel"
								var/Result = input("Who do you wish to Reward with a Race?", "Choose", null) in menu
								if (Result == "Cancel")
									src.icon_state = "max stats off"
									return
								if(Result)
									var/mob/Found = null
									for(var/mob/M in Mobs)
										if(M.name == Result)
											Found = M
										if(M.OriginalName == Result)
											Found = M
									if(Found)
										var/list/races = new()
										races += "Lizardmen"
										races += "Illithids"
										races += "Cancel"
										var/R = input("Choose a Race to give.", "Choose", null) in races
										if(R == "Cancel")
											return
										if(R == "Illithids")
											IllithidList += Found.key
											src.icon_state = "max stats off"
											usr.Log_admin("([usr.key])[usr] gives [Found] the ability to create Illithids.")
											usr << "<font color = teal>([Found.key])[Found] was added to the list of keys allowed to create Illithids. This will not save and only be available until a reboot.<br>"
											Found << "<font color = teal><b>([usr.key])[usr] gave you the ability to create Illithids. This will not save and only be available until a reboot.<br>"
										if(R == "Lizardmen")
											LizardmanList += Found.key
											src.icon_state = "max stats off"
											usr.Log_admin("([usr.key])[usr] gives [Found] the ability to create Lizardmen.")
											usr << "<font color = teal>([Found.key])[Found] was added to the list of keys allowed to create Lizardmen. This will not save and only be available until a reboot.<br>"
											Found << "<font color = teal><b>([usr.key])[usr] gave you the ability to create Lizardmen. This will not save and only be available until a reboot.<br>"
						if(Rewarded == "Reward Language")
							var/list/menu = new()
							var/Mobs = list()
							for(var/mob/M in world)
								if(M.client)
									menu += "[M.name]"
									if(M.OriginalName)
										menu += "[M.OriginalName]"
									Mobs += M
							menu += "Cancel"
							var/Result = input("Who do you wish to Reward with a Language?", "Choose", null) in menu
							if (Result == "Cancel")
								src.icon_state = "max stats off"
								return
							if(Result)
								var/mob/Found = null
								for(var/mob/M in Mobs)
									if(M.name == Result)
										Found = M
									if(M.OriginalName == Result)
										Found = M
								if(Found)
									var/Langs = list()
									Langs += typesof(/obj/Misc/Languages/)
									var/list/menu2 = new()
									for(var/O in Langs)
										menu2 += O
									menu2 += "Cancel"
									var/Result2 = input("Choose a Language to Give", "Choose", null) in menu2
									if(Result2 == "Cancel")
										return
									if(Result2)
										var/obj/I = new Result2()
										if(Found.LangKnow == null)
											Found.LangKnow = list()
										for(var/obj/L in Found.LangKnow)
											if(I.type == L.type)
												del(L)
												break
										I.SpeakPercent = 100
										I.WritePercent = 100
										Found.LangKnow += I
										Found.CurrentLanguage = I
										Found << "<font color = purple>[usr] gave you the [I] language!<br>"
										usr.Log_admin("([usr.key])[usr] gives [Found] the [I] language.")
										src.icon_state = "max stats off"
										return
						if(Rewarded == "Reward Rank")
							if(usr.Admin >= 1)
								var/list/menu = new()
								menu += "BlackSmith"
								menu += "King/Queen"
								menu += "Weapon Master"
								menu += "Diplomat"
								menu += "Human Empire Priest"
								menu += "Cancel"
								var/Result = input("Choose a Rank to give.", "Choose", null) in menu
								if(Result)
									var/list/menu2 = new()
									var/Mobs = list()
									for(var/mob/M in world)
										menu2 += "[M.name]"
										if(M.OriginalName)
											menu2 += "[M.OriginalName]"
										Mobs += M
									menu2 += "Cancel"
									var/Result2 = input("Who do you wish to Rank as [Result]?", "Choose", null) in menu2
									if (Result2 == "Cancel")
										src.icon_state = "max stats off"
										return
									if(Result2)
										var/mob/Found = null
										for(var/mob/M in Mobs)
											if(M.name == Result2)
												Found = M
											if(M.OriginalName == Result2)
												Found = M
										if(Found)
											Found.GiveRank(Result)
											src.icon_state = "max stats off"
											usr.Log_admin("([usr.key])[usr] gives [Found] the [Result] Rank.")
									if(Result2 == "Cancel")
										src.icon_state = "max stats off"
										return
						if(Rewarded == "Reward Stats")
							switch(alert("Manually Reward Players or Auto-Reward?",,"Manual","Auto"))
								if("Auto")
									for(var/mob/M in Players)
										if(M.RPpoints >= 1)
											while(M.RPpoints >= 1)
												M.RPpoints -= 1
												M.Strength += M.StrengthMulti
												M.WeightMax += 1
												if(M.Strength >= M.StrengthMax)
													M.Strength = M.StrengthMax
												M.Endurance += M.EnduranceMulti
												if(M.Endurance >= M.EnduranceMax)
													M.Endurance = M.EnduranceMax
												M.Agility += M.AgilityMulti
												if(M.Agility >= M.AgilityMax)
													M.Agility = M.AgilityMax
												M.Intelligence += M.IntelligenceMulti
												if(M.Intelligence >= M.IntelligenceMax)
													M.Intelligence = M.IntelligenceMax
									usr << "<font color = teal>Stats have been rewarded based on RP Points.<br>"
									return
								if("Manual")
									var/list/menu = new()
									var/Mobs = list()
									for(var/mob/M in Players)
										menu += "[M.name]"
										if(M.OriginalName)
											menu += "[M.OriginalName]"
										Mobs += M
									menu += "Cancel"
									var/Result = input("Who do you wish to Reward?", "Choose", null) in menu
									if (Result == "Cancel")
										src.icon_state = "max stats off"
										return
									if(Result)
										var/mob/Found = null
										for(var/mob/M in Mobs)
											if(M.name == Result)
												Found = M
											if(M.OriginalName == Result)
												Found = M
										if(Found)
											usr << "<font color = teal>[Found] has [Found.Strength] Strength<br>"
											usr << "<font color = teal>[Found] has [Found.Endurance] Endurance<br>"
											usr << "<font color = teal>[Found] has [Found.Agility] Agility<br>"
											usr << "<font color = teal>[Found] has [Found.Intelligence] Intelligence<br>"
											usr << "<font color = teal>[Found] has [Found.RPpoints] RP Points<br>"
											var/S = input("Enter the ammount of Strength you want to reward [Found], this number will be times by their Strength Mod then added.")as null|num
											if(S)
												Found.Strength += Found.StrengthMulti * S
												Found.WeightMax += S * 2
												Found.RPpoints -= S / 4
												if(Found.Strength >= Found.StrengthMax)
													Found.Strength = Found.StrengthMax
											var/E = input("Enter the ammount of Endurance you want to reward [Found], this number will be times by their Endurance Mod then added.")as null|num
											if(E)
												Found.Endurance += Found.EnduranceMulti * E
												Found.RPpoints -= S / 4
												if(Found.Endurance >= Found.EnduranceMax)
													Found.Endurance = Found.EnduranceMax
											var/A = input("Enter the ammount of Agility you want to reward [Found], this number will be times by their Agility Mod then added.")as null|num
											if(A)
												Found.Agility += Found.AgilityMulti * A
												Found.RPpoints -= S / 4
												if(Found.Agility >= Found.AgilityMax)
													Found.Agility = Found.AgilityMax
											var/I = input("Enter the ammount of Intelligence you want to reward [Found], this number will be times by their Intelligence Mod then added.")as null|num
											if(I)
												Found.Intelligence += Found.IntelligenceMulti * I
												Found.RPpoints -= S / 4
												if(Found.Intelligence >= Found.IntelligenceMax)
													Found.Intelligence = Found.IntelligenceMax
											if(S)
												Found.StrCap += Found.StrengthMulti * S
											if(E)
												Found.EndCap += Found.EnduranceMulti * E
											if(A)
												Found.AgilCap += Found.AgilityMulti * A
											if(I)
												Found.IntCap += Found.IntelligenceMulti * I
											if(Found.RPpoints <= 0)
												Found.RPpoints = 0
											usr.Log_admin("([usr.key])[usr] Rewards ([Found.key])[Found] with [S] Strength, [E] Endurance, [I] Intelligence and [A] Agility")
					else
						usr << "<font color = teal>Your Admin Level is not High enough.<br>"
						return
			AdminHeal
				icon_state = "heal off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin)
						src.icon_state = "heal on"
						switch(alert("Revive a Player? Or Heal a Player?",,"Revive","Heal"))
							if("Heal")
								var/list/menu = new()
								var/Mobs = list()
								for(var/mob/M in world)
									menu += "[M.name]"
									if(M.OriginalName)
										menu += "[M.OriginalName]"
									Mobs += M
								menu += "Cancel"
								var/Result = input("Who do you wish to Heal?", "Choose", null) in menu
								if (Result == "Cancel")
									src.icon_state = "heal off"
									return
								if(Result)
									var/mob/Found = null
									for(var/mob/M in Mobs)
										if(M.name == Result)
											Found = M
										if(M.OriginalName == Result)
											Found = M
									if(Found)
										src.icon_state = "heal off"
										Found.Heal()
										Found << "<font color = blue>[usr] Heals you!<br>"
										usr << "<font color = blue>You Heal [Found]!<br>"
										usr.Log_admin("([usr.key])[usr] heals [Found]")
										return
							if("Revive")
								var/list/menu = new()
								var/Mobs = list()
								for(var/mob/M in Players)
									if(M.Dead && M.client)
										menu += "[M.name]"
										if(M.OriginalName)
											menu += "[M.OriginalName]"
										Mobs += M
								menu += "Cancel"
								var/Result = input("Who do you wish to Revive?", "Choose", null) in menu
								if (Result == "Cancel")
									src.icon_state = "heal off"
									return
								if(Result)
									var/mob/Found = null
									for(var/mob/M in Mobs)
										if(M.name == Result)
											Found = M
										if(M.OriginalName == Result)
											Found = M
									if(Found)
										var/Bod = 0
										for(var/obj/Items/Body/B in world)
											if(B.Owner == Found.name)
												Found.GoodRevive(B)
												Found << "<font color = blue>A mysterious force fills your dead body, as it does you begin to feel life flow through your veins once more, it seems the gods have blessed you with new life!<br>"
												usr << "<font color = blue>You Revived [Found]!<br>"
												usr.Log_admin("([usr.key])[usr] revive [Found]")
												Bod = 1
												del(B)
										if(Bod == 0)
											usr << "<font color = red>[Found] has no Body to Revive!<br>"
											switch(alert("Make a new body for [Found]?",,"Yes","No"))
												if("Yes")
													var/obj/Items/Body/B = new
													B.loc = usr.loc
													B.icon = Found.DeadIcon
													B.Owner = Found.name
													Found.GoodRevive(B)
											usr.Log_admin("([usr.key])[usr] tried to revive [Found]")
										src.icon_state = "heal off"
										return
			AdminGiveAdmin
				icon_state = "give admin off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin >= 3)
						src.icon_state = "give admin on"
						switch(alert("Give or Remove Admin?",,"Give","Remove"))
							if("Give")
								var/T = input("Type the key of the person you wish to give Admin to")as null|text
								if(!T)
									src.icon_state = "give admin off"
									return
								if(T in Admins)
									usr << "<font color = teal><b>They already have Admin!<br>"
									return
								for(var/mob/M in Players)
									if(T == M.key && M.client)
										var/N = input("Which Level should this Admin be? Level 1 are Basics, Level 3 are all Commands.")as null|num
										if(N >= 3)
											N = 3
										var/obj/Misc/Admins/Ad = new
										Ad.name = M.key
										Ad.Value = N
										Admins += Ad
										M.Admin = N
										var/obj/HUD/AdminButtons/AdminButton/Z = new
										M.client.screen += Z
										M << "<font color = teal><b><font size = 4>([usr.key])[usr] has given you Admin!<br>"
										usr << "<font color = teal>You gave [T] Admin level [N]<br>"
										var/admin_sav = "players/admins.sav"
										var/savefile/A = new(admin_sav)
										A["Admins"] << Admins
										src.icon_state = "give admin off"
										usr.Log_admin("([usr.key])[usr] gives ([M.key]) [M] Admin level [N]")
										return
								src.icon_state = "give admin off"
								return
							if("Remove")
								var/T = input("Type the key of the person you wish to remove Admin from")as null|text
								if(!T)
									src.icon_state = "give admin off"
									return
								if(T == "Ginseng")
									usr << "<font color = teal><b><font size = 4>You can -NOT- Remove the Owners Admin....<br>"
									for(var/mob/M in world)
										if(M.key == "Ginseng")
											M << "<font color = teal><b><font size = 6>[usr] Tried to Remove your Admin!<br>"
									return
								if(T == "Ginseng")
									usr << "<font color = teal><b><font size = 4>You can -NOT- Remove that Admins powers....<br>"
									for(var/mob/M in world)
										if(M.key == "Ginseng")
											M << "<font color = teal><b><font size = 6>[usr] Tried to Remove your Admin!<br>"
									return
								world << "<font color = teal><b><font size = 4>[T] was removed as an Admin!<br>"
								for(var/obj/Z in Admins)
									if(Z.name == T)
										del(Z)
								for(var/mob/M in Players)
									if(T == M.key && M.client)
										M.Admin = 0
										M.Save()
										usr.Log_admin("([usr.key])[usr] removes [M] as Admin")
										del(M)
										src.icon_state = "give admin off"
								src.icon_state = "give admin off"
								return
					else
						usr << "<font color = teal>Your Admin Level is not High enough.<br>"
						return
			AdminAnnounce
				icon_state = "announce off"
				Type = "AdminHuds"
				layer = 100
				Click()
					if(usr.Admin)
						switch(alert("Normal Announce, or Role Play Announce??",,"Normal","RolePlay"))
							if("RolePlay")
								var/T = input("Announce")as null|message
								if(!T)
									return
								world << "<font color = yellow><font size = 3><center>[T]"
								usr.Log_admin("([usr.key])[usr] role play announces [T]")
							if("Normal")
								var/T = input("Announce")as null|message
								if(!T)
									return
								world << "<font color = teal><font size = 3><center>.:([usr.key]) [usr] Announces:.<br> [T]"
								usr.Log_admin("([usr.key])[usr] announce [T]")
			AdminButton
				icon_state = "admin button off"
				Type = "AdminButton"
				screen_loc = "1,2"
				layer = 10
				Click()
					if(usr.Admin)
						if(usr.InvenUp)
							usr << "<b>Close your inventory first!<br>"
							return
						if(src.icon_state == "admin button off")
							usr.ResetButtons()
							if(usr.Function != "Burn")
								usr.Function = "AdminButton"
							src.icon_state = "admin button on"
							usr.CreateAdminMenu()
							return
						if(src.icon_state == "admin button on")
							usr.ResetButtons()
							if(usr.Function != "Burn")
								usr.Function = null
							src.icon_state = "admin button off"
							usr.Delete("AdminHuds","AdminHuds")
							return
		Buttons
			icon = 'HUD2.dmi'
			IllithidPowers
				name = "Powers"
				icon_state = "illithid powers"
				screen_loc = "15,2"
				layer = 10
				Click()
					if(usr.Dead)
						return
					if(usr.Fainted)
						return
					var/list/menu = new()
					menu += "Telepath"
					menu += "Locate"
					menu += "Observe"
					menu += "Mind Blast"
					menu += "Mind Probe"
					menu += "Cancel"
					var/Result = input("Choose a power to use.", "Choose", null) in menu
					if (Result == "Cancel")
						return
					if(Result == "Mind Blast")
						if(usr.CanUseMagic == 0)
							usr << "<font color = red>You must wait a while!<br>"
							return
						var/list/menu2 = new()
						for(var/mob/M in view(6,usr))
							if(M != usr)
								menu2 += M
						menu2 += "Cancel"
						var/Result2 = input("Choose someone you want to Mind Blast.", "Choose", null) in menu2
						if(Result2 == "Cancel")
							return
						if(Result2)
							if(usr.CanUseMagic == 0)
								usr << "<font color = red>You must wait a while!<br>"
								return
							var/mob/M = Result2
							if(M in view(6,usr))
								usr.CanUseMagic = 0
								spawn(200)
									if(usr)
										usr.CanUseMagic = 1
								var/EnterMind = 0
								EnterMind = prob(100 - M.Intelligence / 2)
								if(M.Fainted)
									EnterMind = 1
								if(M.Faction == "Undead")
									EnterMind = 0
								if(EnterMind == 0)
									usr << "<font color = red>[M] blocks you from entering their mind!<br>"
									M << "<font color = red>[usr] tried to enter your mind with their powers, but you resist!<br>"
									return
								if(EnterMind)
									usr << "<font color = red>You enter [M]'s Mind...<br>"
									M << "<font color = red>([usr.key])[usr] enters your mind!<br>"
									spawn(200)
										if(usr && M && M.Dead == 0 && usr.Dead == 0)
											if(M in range(6,usr))
												var/HurtMind = 0
												HurtMind = prob(100 - M.Intelligence / 2)
												if(HurtMind == 0)
													usr << "<font color = red>[M] blocks you from Blasting their mind!<br>"
													M << "<font color = red>([usr.key])[usr] tried to Blast your mind with their powers, but you resist!<br>"
													return
												if(HurtMind)
													usr << "<font color = red>You manage to Blast [M]'s Mind!<br>"
													M << "<font color = red>([usr.key])[usr] manages to Blast your mind!<br>"
													M.Pain += rand(10,20)
													M.Brain -= rand(3,6)
													M.Brain -= usr.Intelligence / 5
													M.CanMove = 0
													if(M.Fainted == 0)
														M.Stunned = 1
														M.Stun()
														view(6,M) << "<font color=red>[M] has been stunned!<br>"
													if(M.Target == null && M.client == null)
														M.Target = usr
													var/Critical = prob(5 + usr.Intelligence / 3)
													if(Critical)
														M.Brain -= rand(5,7)
														M.Brain -= usr.Intelligence / 10
														view(6,M) << "<font color = yellow>[M]'s head becomes ruptured!<br>"
														M.Blood -= rand(15,30)
														M.Bleed()
														M.Splat()
													if(M.Brain <= 1 && M.Humanoid)
														view(6,M) << "<font color = yellow>[M]'s Brain begins to leak through their nose! Slowly they drop down to the ground, dead.<br>"
														M.Brain = 0
														M.Death()
													return
					if(Result == "Mind Probe")
						if(usr.CanUseMagic == 0)
							usr << "<font color = red>You must wait a while!<br>"
							return
						var/list/menu2 = new()
						for(var/mob/M in view(6,usr))
							if(M != usr)
								menu2 += M
						menu2 += "Cancel"
						var/Result2 = input("Choose someone you want to Mind Probe.", "Choose", null) in menu2
						if(Result2 == "Cancel")
							return
						if(Result2)
							var/mob/M = Result2
							if(M in view(6,usr))
								usr.CanUseMagic = 0
								spawn(200)
									if(usr)
										usr.CanUseMagic = 1
								var/EnterMind = 0
								EnterMind = prob(100 - M.Intelligence)
								if(M.Fainted)
									EnterMind = 1
								if(M.Faction == "Undead")
									EnterMind = 0
								if(EnterMind == 0)
									usr << "<font color = red>[M] blocks you from entering their mind!<br>"
									M << "<font color = red>[usr] tried to enter your mind with their powers, but you resist!<br>"
									return
								if(EnterMind)
									usr << "<font color = red>You enter [M]'s Mind...<br>"
									M << "<font color = red>([usr.key])[usr] enters your mind!<br>"
									spawn(200)
										if(usr && M && M.Dead == 0 && usr.Dead == 0)
											if(M in range(6,usr))
												var/ProbeMind = 0
												ProbeMind = prob(100 - M.Intelligence)
												if(ProbeMind == 0)
													usr << "<font color = red>[M] blocks you from Probing their mind!<br>"
													M << "<font color = red>([usr.key])[usr] tried to Probe your mind with their powers, but you resist!<br>"
													return
												if(ProbeMind)
													usr << "<font color = red>You manage to Probe [M]'s Mind for information!<br>"
													M << "<font color = red>([usr.key])[usr] manages to Probe your mind for Information!<br>"
													if(usr.Intelligence <= usr.IntCap && usr.Intelligence <= WorldIntCap && usr.Intelligence <= usr.IntelligenceMax)
														usr.Intelligence += usr.IntelligenceMulti / 2
													var/LearnItems = prob(100 - M.Intelligence)
													if(LearnItems)
														usr << "<font color = teal>You learn what [M] is carrying....<p>"
														for(var/obj/Items/I in M)
															usr << "<font color = teal>[M] has [I] [I.suffix]<br>"
													var/LearnName = prob(100 - M.Intelligence)
													if(LearnName)
														usr << "<font color = teal>You learn [M.OriginalName][M]'s name.<br>"
													var/LearnGender = prob(100 - M.Intelligence)
													if(LearnGender)
														usr << "<font color = teal>You learn that [M] is a [M.Gender].<br>"
													var/LearnAge = prob(100 - M.Intelligence)
													if(LearnAge)
														usr << "<font color = teal>You learn that [M] is [M.Age] years old.<br>"
													var/LearnRace = prob(100 - M.Intelligence)
													if(LearnRace)
														usr << "<font color = teal>You learn that [M] is a [M.Race].<br>"
													return
					if(Result == "Observe")
						if(usr.client.eye != usr)
							usr.client.eye = usr
							return
						var/list/menu2 = new()
						var/Mobs = list()
						for(var/mob/M in world)
							menu2 += "[M.name]"
							if(M.OriginalName)
								menu2 += "[M.OriginalName]"
							Mobs += M
						menu2 += "Cancel"
						var/Result2 = input("Choose someone you want to Observe with your mind.", "Choose", null) in menu2
						if (Result2 == "Cancel")
							return
						if(Result2)
							var/mob/Found = null
							for(var/mob/M in Mobs)
								if(M.name == Result2)
									Found = M
								if(M.OriginalName == Result2)
									Found = M
							if(Found)
								if(src in usr.client.screen)
									usr.client:perspective = EYE_PERSPECTIVE
									usr.client:eye = Found
									usr << "<font color = teal>You use your mind powers to Observe [Found]!<br>"
									return
					if(Result == "Locate")
						var/list/menu2 = new()
						var/Mobs = list()
						for(var/mob/M in world)
							if(M.client)
								menu2 += "[M.name]"
								if(M.OriginalName)
									menu2 += "[M.OriginalName]"
								Mobs += M
						menu2 += "Cancel"
						var/Result2 = input("Choose someone you want to Locate.", "Choose", null) in menu2
						if (Result2 == "Cancel")
							return
						if(Result2)
							var/mob/Found = null
							for(var/mob/M in Mobs)
								if(M.name == Result2)
									Found = M
								if(M.OriginalName == Result2)
									Found = M
							if(Found)
								if(src in usr.client.screen)
									var/X = Found.x
									var/Y = Found.y
									var/Z = Found.z
									usr << "<font color = teal>You use your mind powers to locate [Found], they are at [X],[Y],[Z]<br>"
									return
					if(Result == "Telepath")
						if(usr.CurrentLanguage == null)
							usr << "<font color =red>Select a Language to speak first!<br>"
							return
						var/list/menu2 = new()
						var/Mobs = list()
						for(var/mob/M in world)
							if(M.client)
								menu2 += "[M.name]"
								if(M.OriginalName)
									menu2 += "[M.OriginalName]"
								Mobs += M
						menu2 += "Cancel"
						var/Result2 = input("Choose someone you want to Telepath.", "Choose", null) in menu2
						if (Result2 == "Cancel")
							return
						if(Result2)
							var/mob/Found = null
							for(var/mob/M in Mobs)
								if(M.name == Result2)
									Found = M
								if(M.OriginalName == Result2)
									Found = M
							if(Found)
								if(src in usr.client.screen)
									if(usr.Muted)
										usr << "<font color =red>You cant talk, your Muted!<br>"
										return
									var/T = input("Telepath - In Character")as null|text
									if(!T)
										return
									if(usr.invisibility && usr.Admin == 0)
										view(1,usr) << "<font color = teal>[usr] whispers:Wooooo....."
										return
									var/obj/SL = usr.CurrentLanguage
									var/NewText = null
									var/Text = null
									var/TextLength = length(T)
									var/Understands = 0
									if(usr.CurrentLanguage)
										for(var/obj/Misc/Languages/HL in Found.LangKnow)
											if(SL.name == HL.name)
												Understands = HL.SpeakPercent
												if(HL.SpeakPercent <= 100)
													var/NotSpeaker = 1
													if(HL in usr.LangKnow)
														NotSpeaker = 0
													if(NotSpeaker)
														if(SL.SpeakPercent >= HL.SpeakPercent && HL.SpeakPercent <= 97)
															HL.SpeakPercent += Found.Intelligence / 20
															if(Found.Intelligence <= Found.IntCap && Found.Intelligence <= WorldIntCap && Found.Intelligence <= Found.IntelligenceMax)
																Found.Intelligence += Found.IntelligenceMulti / 10
									if(Understands == 0)
										Found.LearnRaceLanguages("[usr.CurrentLanguage]")
									while(TextLength >= 1)
										Text ="[copytext(T,(length(T)-TextLength)+1,(length(T)-TextLength)+2)]"
										var/Change = 0
										Change = prob(100 - Understands)
										if(Change)
											Found.CheckText(Text)
											NewText+="[Found.TextOutput]"
											Found.TextOutput = null
										if(Change == 0)
											NewText+="[copytext(T,(length(T)-TextLength)+1,(length(T)-TextLength)+2)]"
										TextLength--
									Found << "<font color=red>You hear [usr]'s voice in your head (In [SL.name]): [Safe_Guard(NewText)]<br>"
									usr << "<font color=red>[Found] hears your voice (In [SL.name]): [Safe_Guard(NewText)]<br>"
									usr.Log_player("([usr.key])[usr] Telepath to [Found] - [T]")
						return
			GameInfo
				name = "GameInfo-(G)"
				icon_state = "help"
				Type = "Help"
				screen_loc = "15,1"
				layer = 10
				Click()
					var/list/menu = new()
					menu += "Ranks"
					menu += "Story"
					menu += "Help"
					menu += "Updates"
					menu += "Toggle Music"
					menu += "Toggle OOC"
					menu += "Toggle Sparring"
					menu += "Initiate CountDown"
					menu += "Change Language"
					menu += "Players Online"
					menu += "Report Bug"
					menu += "Report Player"
					menu += "Admin Help"
					menu += "Admin Rules"
					menu += "Rules"
					var/obj/O = new
					var/Loc = usr.loc
					var/Z = 0
					if(usr.z == 1)
						O.loc = locate(usr.x,usr.y,2)
						Z = 2
					if(usr.z == 3)
						O.loc = locate(usr.x,usr.y,1)
						Z = 1
					for(var/obj/Misc/Hole/H in range(0,O))
						menu += "Climb Up"
					del(O)
					menu += "Cancel"
					var/Result = input("Choose an option.", "Choose", null) in menu
					if (Result == "Cancel")
						return
					if(Result == "Climb Up")
						if(usr.loc == Loc)
							if(usr.Fainted)
								return
							if(usr.Stunned)
								return
							if(usr.Sleeping)
								return
							if(usr.CantDoTask)
								usr << "<font color = red>Must wait a little while before trying to climb out again!<br>"
								return
							var/Climbs = prob(10 + usr.Agility / 2)
							if(Climbs)
								view(6,usr) << "<font color = yellow>[usr] manages to climb up and out of the Hole above!<br>"
								usr.loc = locate(usr.x,usr.y,Z)
								oview(6,usr) << "<font color = yellow>[usr] manages to climb up and out of the Hole!<br>"
								usr.CantDoTask = 1
								spawn(200)
									if(usr)
										usr.CantDoTask = 0
								return
							else
								view(6,usr) << "<font color = yellow>[usr] tries to climb up and out of the Hole above but fails!<br>"
								usr.CantDoTask = 1
								spawn(200)
									if(usr)
										usr.CantDoTask = 0
								return
					if(Result == "Rules")
						usr<<browse(Rules,"window=Rules")
						return
					if(Result == "Initiate CountDown")
						view(8,usr) << "<font color = teal>([usr.OriginalName])[usr] is Waiting 1 Minute.<br>"
						usr.Log_player("([usr.key])[usr] Initiated a CountDown.")
						spawn(600)
							if(usr)
								view(8,usr) << "<font color = teal>([usr.OriginalName])[usr] has Waited 1 Minute.<br>"
								usr.Log_player("([usr.key])[usr] has waited for the CountDown.")
					if(Result == "Toggle Sparring")
						if(usr.SparMode == 0)
							usr.SparMode = 1
							usr << "<font color = teal><b>You will now only do 1/4 the damage you normally would against players! This does not work for Ranged Weapons.<br>"
							return
						if(usr.SparMode)
							usr.SparMode = 0
							usr << "<font color = teal><b>You will now do full damage to players!<br>"
							return
					if(Result == "Report Player")
						if(usr.Muted)
							usr << "You are Mute and can not do that!<br>"
							return
						var/T = input("Please input the Players Name and Key, what happened, and as much detail as possible. Do not use this for anything but reporting Players or you will be punished.")as null|message
						if(!T)
							return
						if(T)
							usr.Log_reports("([usr.key])[usr] - [usr.OriginalName] used Report Player - [T]<p>")
							usr << "<font color = teal>Player reported!<br>"
							for(var/mob/M in Players)
								if(M.Admin)
									M << "([usr.key])[usr] - [usr.OriginalName] used Report Player - [T]<p>"
							return
					if(Result == "Report Bug")
						if(usr.Muted)
							usr << "You are Mute and can not do that!<br>"
							return
						var/T = input("Please be very detailed with the Bugs you find. Do NOT use this to spam or get the Admins attention, or you will be punished. This is for Bugs only.")as null|message
						if(!T)
							return
						if(T)
							usr.Log_reports("([usr.key])[usr] - [usr.OriginalName] used Report Bug - [T]<p>")
							usr << "<font color = teal>Bug reported!<br>"
							return
					if(Result == "Admin Help")
						if(usr.Muted)
							usr << "You are Mute and can not do that!<br>"
							return
						var/T = input("Type a message to the Admins, please remember that if you Spam this Feature you will be punished.")as null|message
						if(!T)
							return
						var/FindsAdmin = 0
						for(var/mob/M in Players)
							if(M.Admin)
								FindsAdmin = 1
								M << "<b><font color = teal>([usr.key])[usr] - [usr.OriginalName]: [T]<br>"
						if(FindsAdmin)
							usr << "<font color = teal>Your message has been broadcast to the Admins!<br>"
							usr.Log_player("([usr.key])[usr] - [usr.OriginalName] used Admin Help - [T]")
							return
						else
							usr.Log_player("([usr.key])[usr] - [usr.OriginalName] used Admin Help but no Admins were online. - [T]")
							usr << "<font color = teal>There are currently no Admins online right now!<br>"
							return
					if(Result == "Updates")
						var/html_doc="<head><title>Updates</title></head><body bgcolor=#000000 text=#FFFF00><center><b><font color = white><p><u>Pix Version 0.02 Updates</u></p><p>Added a music toggle setting to the Game Info menu (G) that saves with your character savefile.</p><p>Many more changes to internal code structure that should have no effect on game play.</p><br><p><u>Pix Version 0.01 Updates</u></p><br><p>Fur color can now be selected when creating Ratling or Wolfmen characters.</p><p>All players can see log in/out messages again.</p><p>Removed popup spam when logging in.</p><p>Trees no longer block vision like walls.</p><p>Internal structure changes were made to allow servers to start up faster and run slightly better.</p></font><font color = teal><u>Version 0.596 Updates</u><br><p>Fixed a bug where several items could not be pulled or transfered into containers.<p>You can now interact with and apologize to NPC who are in your faction, this will stop them attacking you if you've done something bad, although you must pay a fee of 10 Gold.<p>Tweaked the Illithids TK damage, since its easy to max their Intelligence out and before you could do 26 damage per hit, lowered it to 16 at 80 Intelligence.<p>Fixed a bug where you could drown from not being in water after using stairs.<p><u>Version 0.595 Updates</u><br><p>Fixed a bug with repairing items.<p>NPC Guards will now recognise players who attack same faction NPC, so if you attack a Human Villager as a Human then run away, any guards who see you do this will always attack you on sight, unless you wear a cloak.<p>You can now only be Kicked if you walk near a body of one of your previous characters and you have Pickup or Pull modes activated.<p>Tweaked the starting stats for all races based on exact stat mods and fixed a small bug with Giants Strength mod and Snakeman having a Giants Strength mod.<p>Fixed a bug with the new death system where after making a new char and getting killed then remaking, you could add around +5 to your stats each time, resulting in new chars with more than 5, 10 and even 15+ stats.<p>Fixed a bug where NPC would target you even when your on another z level.<p><u>Version 0.594 Updates</u><br><p>30 second timer on the count down was changed to one minute.<p>Inquisitor now have half as much armour as before, in terms of defence and 10 less Agility than before.<p><b><font color = teal><p><u>Version 0.593 Updates</u><br><p>Anyone who attacks the Inquis Vault doors near an Inquis will get attacked.<p><u>Version 0.592 Updates</u><br><p>Inquis weapons do extra to undead now.<p>May have fixed a bug with being propelled back and slamming into a mob. The mob would get stuck and not be able to move.<p>Changed how potential on an item used for crafting works. Now it will take the Potential number and divide it by 40. Depending on your skill, it will remove 5 from 40 and so on each major skill level. So by about Epic, it becomes 20 and by Legendary, 18. The number left once devided will be added to the damage/defence of the item.<p>Fixed an issue with some mountains not having a second floor and being sky.<p><u>Version 0.591 Updates</u><br><p>Added Gold and Copper doors.<p>Doors were being damaged too easily, tweaked the code a litte.<p>Doors can now be knocked on.<p>The smithing rank now gives a +0.1 to Forging, Smelting and Mining skill mods.<p>Player logs will now display if a player destroys a door/chest/lock or creates a fire near wooden walls or floors.<p>Fixed a bug where stairs built under a hole were never turning the hole into stairs, allowing people to fill the hole in for a secret exit.<p>Version 0.59 Updates</u><br><p>Being stunned no longer allows you to attack.<p>Torches burn out slower than before.<p>Stairs can be built over Holes by Interacting with a Large Brick then the Hole. They can also be destroyed the same way as doors.<p>Player created turf now have a key attached to them so Admins can track those who abuse building.<p>If you fall down a Hole you can now use the ? Button to try and Climb Out, but its a low chance.<p>The chance to swim up was made easier. Instead of taking both the players weight and what they wear, it'll just take what they are carrying instead.<p>Players can now dual wield daggers and swords. Also, using the new hand buttons, you can switch between left and right hands for all weapons. Players could now use their left arm for things if their right is broken.<p>Fixed a bug where Keys would delete.<p>Ratlings now have claws.<p>Illithids Mind Blast was made easier to enter someones mind with slightly.<p>Fixed a bug with doors opening inside a players inventory.<p>Fixed a bug where Skulls from undead could not be used to craft with.<p>Ratling Kings/Queens get Plate armor now and Smiths can create it.<p>Holes can be dug now by using Interact on a shovel or being a Ratling. Double Clicking on turf begins the digging. They can also be filled or climbed down carefully by Interaction.<p>Mining skill goes up slower now because people were having 200+ easily.<p>Giant and Cyclops Kings/Queens/Smiths can now get Plate armor.<p>Ratling no longer start with bone armor but know how to make it instead.<p>Map now saves every year instead of every 6 months.<p>Copper long sword icon was fixed.<p>King rank now gives Defence 10 Plate/Chain, depending on race.<p>Stat gains were way too high, made them adjust better to a players stats, it gets harder to raise as they rise now.<p>Can now repair items with lower than 33 dura instead of lower than 1.<p>Fixed a bug where some Armor could not be repaired.<p>Lowered Kings/Queens weapons from 20 damage to 15.<p>If your unarmed skill is higher than 20, you wont take hand damage when fighting, unless hitting someone in plate/chain/<p>Ammount of Max Weight gained when strength rises was lowered a little.<p>Version 0.58 Updates</u><br><p>Can gain stats from swimming now.<p>Training dummies give a little more weapon skill than before each hit and are twice as endurant than before, but can be improved by repairing.<p>Wolfmen can no longer where shoulder armor. Felt they were already powerful enough.<p>Sligthly Bigger map.<p>Illithid Int Cap is now 80 instead of 100 and Alther Int cap is now 70 instead of 75. Illithid Agility cap is now 40 instead of 60.<p>Tweaked Illithid TK damage a little. Before armor would not give the full defence when being slammed against objects.<p>Version 0.573 Updates</u><br><p>Fixed a bug where Legendary items could not be crafted.<p>Fixed Human hair growth and overlay bugs.<p>Added yearly random events.<p>Illithid mind blast and mind probe are sligthly faster with a shorter cool down.<p>Iron gates can now be crafted.<p>All crafting skills and jobs take twice as less time to do and have had their mininum time lowered.<p>Fixed a bug where anything could be used to skin or butcher.<p>Silver weapons now do extra damage to Undead.<p>NPC Guard now respawn every month.<p>Fixed a bug where players could not learn Ancient.<p>Removed one group of Inquisitors because the maps too small for two groups and players keep getting killed constantly by them.<p>Bandits can roam free now.<p>Small stone bricks now give shards instead of the larger ones.<p>Added Inquisitor inside the Vault.<p>Added an Extra Door to the Inquisitor Vault.<p>Made the Inquisitor Vault Walls Impossible to break due to people Abusing.<p>Fixed a bug where if you had a smithing rank, you could examine weapons that you already knew how to create.<p>Version 0.57 Updates</u><br><p>Fixed a bug with Weapons where if you Examine an iron weapon, you would'nt get the other material types added to your craft list.<p>Added bone crafting.<p>Inventory will now close when a crafting menu opens.<p>Wolfmen can now Skin and Butcher with their claws.<p>Added Silver weapons.<p>Fixed a bug where NPC would smash you on the head and knock you out, even if you had a helmet on.<p>Intelligence is halved now when you get infected and turn into a zombie.<p>Infect chance for zombies is 1% again.<p>Illthid doors can now be attacked.<p>Illthids can no longer use TK + Observe on people.<p>Made NPC guard stronger.<p>Removed the stat boost for newly made players based on old players stats.<p>Fixed an overlay bug regarding Hair and Crowns.<p>Version 0.56 Updates</u><br><p>Wolfmen no longer get their Claws Damage Boost if holding a shield in combat.<p>You can now attack and destroy any walls or floors.<p>Doors are now half as durable as before by default.<p>Town walls can no longer be seen through.<p>Extended the Wolfmans field of vision while in the dark by one tile.<p>Added an Altherian Priest to help Altherian players.<p>Admin reward now takes the number entered by the Admin and Times it by the player race Multi in that stat Area. So for a Alther with an Agility Mod of 0.2, they would get Num X 0.2 added to their stats.<p>Very very sligthly lowered the chance to die depending on Blood loss.<p>Being stunned now sometimes lasts twice as long as before.<p>Zombies now have a 2% chance to infect instead of 1%.<p>NPC will now re-populate the world every two months instead of three.<p>Fixed an icon problem with Stahlites gloves.<p>Zombie NPC and players will no longer rise up from the dead if their brain is damaged badly.<p>Zombie NPC and Players now have a 10% chance per hit to die if they have no limbs.<p>Version 0.55 Updates</u><br><p>The count down on RP's was made seperate from the Emote button.<p>Leather hides can no longer get over 100 Craft Potential.<p>Trees now fall left and right. If they land on the tile your in they will take into account your Wood Cutting Skill, which helps you judge where it'll fall giving a lower chance of being hit.<p>Fixed a bug where if the server rebooted and there was a lit forge, that forge would stay lit forever.<p>Wolves can wear plate pauldrons again.<p>Wolves can no longer use Human style plate helmets. Instead they get their own kind, made by ranked smiths.<p>Wolves can use leather gloves again now, but not plate.<p>Made the new stat system for newly made late joiners divide the best stats by 5 instead of 3.<p>World will now only re-populate withy NPC's every Three months, instead of each month.<p>Wounds now heal twice as quickly as before.<p>Frogmen now have a 1% chance every 2.5 seconds to regenerate a lost limb.<p>Frogmen now get a bonus to swimming skill upon creation.<p>Frogmen no longer drown in water, ever.<p>Frogmen can move faster in water now.<p>Fixed a bug with leather hides not drying out correctly.<p>Fixed a bug where it was impossible to gain Max Weight through non-combat related skills.<p>You can now Examine people for information.<p>Made the System where you gain a portion of the strongest player onlines stats when making a new char differant. Instead it will take the stats of all players online, then add them together and devide by the players, getting the average stats, then dividing by four. It wont do this if theres less than 3 players.<p>Added swimming. You move faster in water depending on your swimming skill and strength. Wearing or Carrying anything increases your chances to sink as well as decreasing your chances to swim up from the water. There is also a Delay on how often you can swim up from underwater now. You can hold your breathe for two minutes, after which you die.<p>You can now wear leggings even if you've a leg missing.<p>Fixed a bug where people could attack a door and force the delay to non-exsistant, resulting in a destroyed door in 1/100 the normal time.<p>Wolfmen and Wolfwomen can no longer wear plate armour on their chest or hands, since this would distrupt their natural movements to the extent of damage to their bodies and realisticly, would cause possible death.<p>Fixed a bug with Stahlites icons.<p>Major Organs now Heal, but slower than other lesser ones.<p>Removed the Lich Npc, can only become un-dead through the Necro book or infection.<p>The game will now track the people with the Highest stats and save that number. When anyone makes a new char, they get that number divided by 3 added to their stats. This is to help lessen the impact upon players when they die after grinding for hours and get killed by a rabid chicken.<p>Moved the Inquisitor tower closer to the Human towns since it made no sense it was miles away. Also added a Vault inside.<p>Limbs and damaged Organs no longer magically heal after a year.<p>Fixed a bug where Transfering an Item would constantly shut your Inventory off each time.<p>You can now Forge Locks and Keys. When you Examine a door, Locks and Keys should be added to your Craft List.<p>You can Damage Doors and Chests using Combat Mode and repair them using certain tools.<p>You can now place Locks into Doors and Chests using Interact.<p>Iron doors can now be crafted.<p>Made it so when one of your legs health drops below 50 you move slower.<p>Made it so when you Target an NPC of your own Race, any other NPC who are friendly to the one you targetted attack you also.<p>There is now a chance to get extra Large and Small Bricks when smashing them with a hammer based on your Masonary Skills.<p>The max ammount of time to build something was lowered from 50 seconds to 30 seconds. This makes building walls and floors quicker but still based on skill as always.<p>There is now a chance based on your Wood Cutting skill to gain an extra Log when chopping a felled tree.<p>Pulling things now makes you slower.<p>Made Stat Gains from crafting slightly higher.<p>Wearing Armour now effects Dodge, Block and Parry when fighting, based on your Strength and Weight of Armour you wear.<p>Wearing Armour will now slow your attacking speed down.<p>There is now a chance based on your wood cutting skill to get extra Blocks or Blanks.<p>Code will now devide your MaxWeight by 1.1 and 1.2 when moving or attacking. If your current Weight is over that number you will Attack and Move slower.<p>There is now stat caps on Races. It starts at 50 for Humans and varies from Race to Race.<p>Lowered default stat gain chance from 33% to 22% per sucessful hit due to a change in stat codes.<p>When you Examine Metal objects, you can now craft them in all Materials, and not just the Material that the object you Examined was made from.<p>Added a Priest Rank.<p>All Humanoid NPC should now act correctly when they turn into a zombie.<p>All Humanoid NPC should now be able to be either infected, or revived, as Zombies.<p>Added a Female Stahlite icon, with hair.<p>Version 0.54 Updates</u><br><p>Added the ability to Mate, simply Click Interact, then click another player. Frogmen and Snakemen lay eggs. The child has a 50/50 chance of either being a player or NPC. If player, the next person to make a new character and pick the same race as the mother, is born to her. If NPC, the mother will give birth, and an NPC child will be created. Later on, if one of the parents die, they will become the child. Both NPC and Player get 1/8 stats from each parent.<p>Fixed the no Dura on Leather items bug.<p>Reverted the map back to the old Version, because its easier to find people and Role Play.<p>Bone armour now has a defence similar to Chain, instead of Leather.<p>Fixed a bug where getting knocked back, slamming into something, and dropping your weapon or shield made them bugged.<p>Fixed a bug that stopped Claws from growing back or healing.<p>Version 0.531 Updates</u><br><p>Was forced to remove the EXP Feature, due to it creating a massive bug.<p>Version 0.53 Updates</u><br><p>Added Bandit Raiders who travel in groups.<p>Fixed a bug where Ranged Combat Skill was not teaching correctly to a Learner when they Dodge,Bat away, Block, or get hit by an Arrow..<p>-May- have fixed a bug with Map Saving, will require alot of testing.<p>Fixed a bug where Large Brick Walls were not showing up in the Build Menu for Construction.<p>Players can now Push other Players who have targetted them, where as before, pushing someone who had targetted you did not work.<p>Players will now gain EXP when they Gain Weapon Skill or Stats, this EXP will then Save when they log out. When the Player dies and makes a new Character, the EXP from the previous Character carries over and adds a small Bonus to the New Characters Stats and Weapon Skills. This was added to lessen the impact of Perm Death. EXP will not go any higher than 100, when a New Character is made, they get EXP devided by 4.5 added to their stats, which is +22 for someone at 100 stats.<p>Version 0.52 Updates</u><br><p>Fixed a bug where Forging would break at 90 skill.<p>Fixed a bug where NPC were talking to players...<p>Mined out tiles that players have created will no longer spawn with hundreds of Rocks scattered about.<p>Hopefully, Plants, Rocks, and other un-wanted objects will now Delete when someone builds a wall/floor over them.<p>Gain chance on Shield Skill was changed to 50% from 33% per successful Block.<p>Base Fail chance on Crafting was lowered to 50% from 60%.<p>Purity of Ores renamed to Craft Potential.<p>Leather now has Craft Potential, like Ore, but depends on the players Skinning Skill.<p>Skin from creatures will now Dry out after a few minutes.<p>Anything with no Blood no longer leaves a blood trail when knocked back.<p>Version 0.51 Updates</u><br><p>Clicking Examine now displays your Cords, this is a Temp feature until I code in a more RP way of locating your position.<p>Added Gold Armour.<p>Months now go slightly faster.<p>Goblins now randomly spawn on the map in groups.<p>Gold and Silver Veins are alot more Rare now.<p>Re-added the dreaded Inquisitors.<p>Skill/Stat Caps now raise when your offline.<p>There is now a universal skill/stat cap that rises each Month.<p>Auto Heals now happen every Month instead of Year.<p>Made the Multi Cap increase by 3 every Month, instead of 10 every Year.<p>Made NPC re-spawn every Month instead of Year.<p>Version 0.50 Updates</u><br><p>May have fixed the Eternal Forge Lit bug.<p>Removed the Heir Rank and added Weapon Master and Diplomat Ranks.<p>All Tools now have a Weight, so they dont attack really fast.<p>Most NPC who dont have a home, such as a Cave or Tomb will now randomly spawn accross the Map every in game Year, this is to avoid them spawning on Player Made houses.<p>Fighting someone with higher Skill now has a 15% chance for you to gain in the Skill Area of the Weapon they use, as long as your Skill is not already higher than theirs. For instance, you wont gain anything from someone if your Skill in Swords is 30 and theirs 50, this is because it Halves their Skill, only allowing you to gain up to 25 of their Skill. This allows you to slowly learn from someone else and their combat Skills, opening up a Teacher-Learner Role Play and at the same time, wont allow you to constantly Gain Skill points from each other Infinitely.<p>Admin Logs will now display Edits, to help prevent abuse.<p>The Map will now save every Six(6) in game Months, instead of Twelve(12).<p>Months and Years now pass Three times as Slower.<p>Day and Night Cycles are now seperate from Months and Years.<p>Crafted items will now display when they were created, their quality, and other information when examined.<p>Fixed a bug with Lit Torches never burning out and giving the player 5 luminosity while not using one.<p>Skeletons die for good when their skulls are smashed during combat.<p>There is now a 15% chance that a sucessful attack to the skull will instantly KO someone. There is also a 33% chance that if your Brain is hurt, you also get instantly KO'ed<p>There is now a chance, based on your strength, that you will knock someone flying back.<p>Stat gain default chance was lowered to 33% from 50% per sucessful hit.<p>Fixed a bug where if your stats were too high, you would never gain, no matter what. Fixed it back to a 2% chance to gain if your stats are very high like it was before.<p>Meat, Limbs, Skulls and Bones now have a much shoter name than before.<p>Admin rewards now raise your stat Multi, where as before they would raise your stats past your multi and possibly bug them.<p>Skill caps will no longer update along with your age when you log in, this means if you dont play for a day, then log in, your skill caps wont go up. You will need to be present each in game year for them to rise now.<p>Fixed a bug where two players could cut down the same tree and get double resources from it.<p>Wolfmen NPC no longer attack Cloaked players.<p>Version 0.491 Updates</u><br><p>May have fixed a bug with Map Saving, but just in case, Maps are backed up every Three IC years.<p>Underground walls can now be dug into.<p>Fixed a bug where the contents of a container would never save.<p>Expanded the map a tiny bit.<p>Frogmen now have a Swamp area.<p>You can now Toggle a Spar mode, this will make you do 1/4 the damage to players. (Not NPC)<p>Fixed a bug related to Quivers, Arrows and Weight.<p>Added a Report Bug and Report Player Option on the Question mark button, if you abuse or spam these features, you will be punished.<p>Added an Admin Help option to the Question Mark button.<p>You can now open stat windows while fighting.<p>Common is now only given to Stahlites, Humans, Snakemen and Altherians.<p>You can now get to 97% instead of 95% with Languages.<p>Version 0.487 Updates</u><br><p>May have fixed the Language bug, needs testing with other players.<p>Due to popular demand, a Common language was added to all races.<p>Fixed a bug where 100 or higher crafting skill would bug up your item creation.<p>Crafts fail chance was lowered again. It was at 70%, it is now 60%, it will now stay at 60%.<p>Wolfmen, Giants and Cyclops Hunger will now go down twice as fast as before. Undead's Hunger will go down Three times as fast.<p>Made forging skill based on your Multi Cap, like with Melee skills and stats.<p>Made smelting skill based on your Multi Cap, like with Melee skills and stats.<p>Training dummies now have alot more dura, but will still need to be repaired. Repairing them makes them stronger than before, based on your Carpentry skills.<p>Butchery Skill Multi's were not active on players, you can now gain Butchery skill,<p>Added Snakemen guards to the Snakeman starting area.<p>Charcoal no longer has a Weight of 5, but 2 instead.<p>Tools placed on the map were given Weight, instead of before where they had 0 Weight and attacked really fast.<p>Added Shoulder Protection for Ratlings.<p>Shield users now have a chance to block arrows based on their Shield Skill and Agility.<p>Added guards to the Wolf Shaman's Cave.<p>Fixed a bug where the Lich NPC would never revive anyone.<p>Money now has no Weight.<p>Attack speed with Heavey weapons is now slower than before.<p>You can pull Arrows out by Interacting on them, depending where it was lodged depends on how much you will bleed.<p>Arrows have a chance to lodge into people when they hit, depending on their armour.<p>Arrows now have a chance to break on some Armours.<p>Worked on the Ranged combat a little, it will now work a lot more like Melee where the enemy can be stunned and faint.<p>Removed the Hell map to help reduce lag until it has a use.<p>Added more Masonary objects in for Masons.<p>Stat gains from Crafting/Building now work like those from fighting, they will increase at a chance based on your current stats.<p>You can now no longer sleep with a Weapon Equipped, Plate Armour, or a Shield Equipped.<p><u>Version 0.47 Updates</u><br><p>Made the language system work better and fixed a bug related to it.<p>You can now create some of the Stone items in game, including the Forge.<p>You can now forge an Anvil.<p>Added different Languages for different Races, the more you hear a Language, the better you become at speaking it, based off your Intelligence.<p>You can now place a lit torch in water to put it out.<p>Meat will now actually cook when you try to. Before it had a chance of the fire going out before finished.<p>You will now no longer have any chance of dieing if you get hungry or tired but you will still get ill.<p>Fixed a bug where you could not create training dummies or armour racks.<p>Stats and Combat skills now have a Cap on them, it starts at 11 and goes up by 10 every year, this means by the time your age 1 you can get your stats to 21, and by age 2, 31, ect ect.<p>Made it so you gain Agility and Endurance when doing crafting skills, where as before it was just strength, which messed up your overall gain chance later on if you decided to fight and become a warrior.<p>Slightly lowered the ammount of Endurance and Strength gained from being a Zombie.<p>Fixed a bug where blunt weapons were able to cut off a limb.<p>You will now only grow a beard if your older than 15.<p>Fixed a bug with the spiders not attacking.<p>Fixed a bug where if you logged out dead and then logged in again, and you were revived just as you go to click load or new game, you would be revived in your old body.<p>Players bodies will now not rot over time.<p>You can now light a forge using two stone shards.<p>Fixed a bug where certain NPC would never respawn.<p>Fixed a bug where targetting a player then killing them would still display the Target icon.<p>Made it so when you become a Zombie you loose your crafting memeory.<br>"
						usr<<browse(html_doc,"window=Updates")
					if(Result == "Admin Rules")
						var/html_doc="<head><title>Admin Rules</title></head><body bgcolor=#000000 text=#FFFF00><center>[AdminRules]"
						usr<<browse(html_doc,"window=Admin Rules")
						return
					if(Result == "Ranks")
						var/html_doc="<head><title>Ranks</title></head><body bgcolor=#000000 text=#FFFF00><center>[Ranks]"
						usr<<browse(html_doc,"window=Ranks")
						return
					if(Result == "Story")
						var/html_doc="<head><title>Story</title></head><body bgcolor=#000000 text=#FFFF00><center>[Story]"
						usr<<browse(html_doc,"window=Story")
						return
					if(Result == "Toggle Music")
						usr.ToggleMusic()
						return
					if(Result == "Toggle OOC")
						usr.OOCToggle()
						return
					if(Result == "Players Online")
						usr.WhoProc()
						return
					if(Result == "Change Language")
						var/list/langmenu = new()
						for(var/obj/Misc/Languages/L in usr.LangKnow)
							langmenu += L
						langmenu += "Cancel"
						var/LangResult = input("What do you need Help on?", "Choose", null) in langmenu
						if(LangResult == "Cancel")
							return
						if(LangResult)
							var/obj/L = LangResult
							usr.CurrentLanguage = L
							usr << "<font color = green>You will now speak [L.name] - You are [L.SpeakPercent]% fluent in this language, and Write [L.WritePercent]% correctly in it.<br>"
					if(Result == "Help")
						var/list/helpmenu = new()
						helpmenu += "Mining"
						helpmenu += "Tree Chopping"
						helpmenu += "Pulling & Pushing"
						helpmenu += "Camp Site Contruction"
						helpmenu += "Pick Up & Dropping Items"
						helpmenu += "Combat"
						helpmenu += "Wounds"
						helpmenu += "Sleeping"
						helpmenu += "Eating"
						helpmenu += "Cooking"
						helpmenu += "Butchery"
						helpmenu += "Skinning"
						helpmenu += "Smelting"
						helpmenu += "Stone Work"
						helpmenu += "Forging"
						helpmenu += "Carpentry"
						helpmenu += "Repair"
						helpmenu += "Cancel"
						var/HelpResult = input("What do you need Help on?", "Choose", null) in helpmenu
						if (HelpResult == "Cancel")
							return
						if(HelpResult == "Mining")
							var/Mining = {"
								<style>
								body{background:#000000}
								</style>
								<font color = teal><font size = 3><u><b>.:Mining:.</u></b> <p>
								In order to Mine you will first need a Pick Axe.
								Once you have one, check its Dura to make sure its not broken.
								Now, walk up to a Solid Stone Wall and Equip your Pick Axe.
								Now all you simply do is Click the Interact button on your screen, then Click a Solid Wall.
								Once finished, a Large Boulder will fall away from the wall.
								In order to cancel Mining, simply Click the Combat button on your screen.
								If you keep Mining a wall, it will eventually turn into an Empty Cave Tile.<br>
								"}
							usr<<browse(Mining,"window=Help")
							return
						if(HelpResult == "Tree Chopping")
							usr << "<font color = teal><font size = 3><u><b>.:Tree Chopping:.</u></b> <p> <font color = teal>In order to Chop a Tree you will first need a Hatchet. Once you have one, check its Dura to make sure its not broken. Now, walk up to a Tree and Equip your Hatchet. Now all you simply do is Click the Interact button on your screen, then Click a Tree. Be careful not to stand to the Right or Left of the Tree, because it will fall and kill you. When you have finished Chopping the Tree you can Chop the fallen Tree into a Log, but only if the Tree was large, small Trees only give Branches. To chop the fallen Tree into a Log, Click Interact, with a Hatchet equipped, then Click the Fallen Tree, this will turn it into a Log. If you want to cancel a job at any time, click the Combat button. Now that you have a Log, you can repeat the Interact process using a Saw, and turn the Log into Wooden Planks, used in house or furniture building.<br>"
							var/Chopping = {"
								<style>
								body{background:#000000}
								</style>
								<font color = teal><font size = 3><u><b>.:Tree Chopping:.</u></b> <p>
								"}
							usr<<browse(Chopping,"window=Help")
							return
						if(HelpResult == "Pulling & Pushing")
							usr << "<font color = teal><font size = 3><u><b>.:Pulling & Pushing:.</u></b> <p> <font color = teal>Alot of Items can be Pulled. Some because they are too big to be carried in your Inventory. In order to pull an object, Click the Pull Button, then Simply Click an object to Pull. You can Click that object again in order to stop Pulling it. While the Pull button is active you can also Push players around if they have no current Target.<br>"
							return
						if(HelpResult == "Camp Site Contruction")
							usr << "<font color = teal><font size = 3><u><b>.:Camp Site Contruction:.</u></b> <p> <font color = teal> Camp sites are useful for cooking food with, but dont stand in them, or you may catch on fire and die. In order to create a Camp Site, you will need Three branches placed down on the ground near you. Once you have Three on the ground, Click the Interact button, then click any of the Three Branches. Remember to have all the Branches in the same tile, and if you need to cancel a Job, Click the Combat Button. There are two ways of lighting a Camp Site on fire. The first is to Mine out a Large Boulder from a Solid Wall, then use a Hammer on the Boulder to get Stone Shards. With Two stone shards in your inventory, Interact with one, then click the other, and this will create sparks and light the camp site. The second way is to get a Torch, Equip it, then Interact with a Wall Torch to light your Torch, then Interact with the Camp Site. Please remember that if you start to spread fire on purpose or have no Role Play Reason to do so, you will be Ban. Admins know when a player start a fire.<br>"
							return
						if(HelpResult == "Pick Up & Dropping Items")
							usr << "<font color = teal><font size = 3><u><b>.:Pick Up & Dropping Items:.</u></b> <p> <font color = teal> In order to pick an Item up, Click the Pick Up button, then click an Item that is near you. Remember that if you carry too much you wont be able to pick anything up. To Drop an Items, Click the Pick Up Button again, then Click an Item in your Inventory, this will Drop the item. Remember that the Pick Up Button Both Picks up & Drops Items.<br>"
							return
						if(HelpResult == "Combat")
							usr << "<font color = teal><font size = 3><u><b>.:Combat:.</u></b> <p> <font color = teal>In order to attack an enemy you need to Click the Combat Mode Button, then simply Click someone. This button also Cancels any Jobs that you may be doing. Please remember that this is a Role Play Game, Admins keep records of players actions, and Non-Role Play kills will result in a ban. Now that you have a target you can Click the Combat button again to loose that target. Combat starts off slow when you first start out, but as your Agility rises, the speed of your attacks become more requent. Also note that some objects in game can be attacked and broken, like Wooden Doors for instance.<br>"
							return
						if(HelpResult == "Wounds")
							usr << "<font color = teal><font size = 3><u><b>.:Wounds:.</u></b> <p> <font color = teal>When you deal damage to an enemy you will hurt certain body parts. You can check the status of your Wounds in the Health Information Button. All Limbs will slowly heal over time, and some organs such as Eyes will Heal up to a point. Sleeping will increase the speed at which you Heal. The best way to Heal a Wound is to use a bandage.<br>"
							return
						if(HelpResult == "Sleeping")
							usr << "<font color = teal><font size = 3><u><b>.:Sleeping:.</u></b> <p> <font color = teal>Eventually your character will become sleepy. But do not worry, you dont need to sleep, but not sleeping will make you quite alot slower in Combat and has a chance to make you Ill. In order to sleep, find a bed and Interact with it. To wake up, Interact with it again.<br>"
							return
						if(HelpResult == "Eating")
							usr << "<font color = teal><font size = 3><u><b>.:Eating:.</u></b> <p> <font color = teal>Eventually your character will become hungry. But do not worry, you dont need to eat, but not eating will make you quite alot slower in Combat and has a chance to make you Ill. In order to eat, simply find some food, open your Inventory and click the Eat button, then click the Food. Some Foods will make you see strange, others will need to be cooked. You can Eat raw meats or limbs, but depending on your race, you may get Ill if the foods not cooked. Small foods, such as berries, will never fill you up past a certain Point, you will be required to find somthing a little bigger. Some races can eat an entire corpse, to do this, Click the Eat button in your inventory, then Click the Corpse.<br>"
							return
						if(HelpResult == "Cooking")
							usr << "<font color = teal><font size = 3><u><b>.:Cooking:.</u></b> <p> <font color = teal>Some races will need to have their food cooked if they want to eat safely. There is currently only one way to cook food. Light up a Camp Fire, then drop the food down next to it. Depending on your cooking skill, the food should cook slowly. If you leave the food near the fire too long you will be alerted that the food will burn.<br>"
							return
						if(HelpResult == "Butchery")
							usr << "<font color = teal><font size = 3><u><b>.:Butchery:.</u></b> <p> <font color = teal>In order to get meat you will need to Butcher a Corpse. In order to do this, Equip a Sword or Axe then Interact with one of them, then simply click a body. A Menu will display asking which part of the body you want to Butcher. Limbs can be removed, cooked and eaten. If you choose the Body option you will get Raw Meat Chuncks.<br>"
							return
						if(HelpResult == "Skinning")
							usr << "<font color = teal><font size = 3><u><b>.:Skinning:.</u></b> <p> <font color = teal>In order to Skin a Corpse you must first Equip a Dagger. After that simply Interact with a Corpse and you will begin to skin it.<br>"
							return
						if(HelpResult == "Smelting")
							usr << "<font color = teal><font size = 3><u><b>.:Smelting:.</u></b> <p> <font color = teal>In order to Smelt Ores that you Mine you will first need to locate a Forge. Next you will need at least one piece of Coal to fuel the forge. You will also need a Torch to light the Forge with. Once you have these things, Interact with the Coal, then Click the Forge. This will place the Coal into the Forge and supply it with Fuel. You can keep adding Coal before and after you light the Forge to make it last longer. Once the Coal is inside the Forge, Light the Torch on a Wall Torch, then Interact with the Forge with the Torch Equipped and Lit. This will light the Forge up. Now that the Forge is lit, Interact on some Ore, then click the Lit Forge. You will begin to create an Ingot out of the Ore. You will fail alot of times before you become really good at it though, so remember to stock up on lots of Coal and Ore.<br>"
							return
						if(HelpResult == "Stone Work")
							usr << "<font color = teal><font size = 3><u><b>.:Stone Work:.</u></b> <p> <font color = teal>Once you try Mining you will notice that you receive a Large Boulder. This Boulder can be turned into large and Small Bricks for use in Building and will also give you Stone Shards for lighting Camp Sites. With a hammer equipped, Interact with a Boulder, this will Hammer the Boulder into a Large brick. If you Interact with the Large Brick you created this will turn it into Three Smaller bricks.<br>"
							return
						if(HelpResult == "Forging")
							usr << "<font color = teal><font size = 3><u><b>.:Forging:.</u></b> <p> <font color = teal>In order to Forge a Metal Ingot into an Item you will first need to make sure you can create the Item you want. using the Examine button you can click Metal objects such as Weapons and Armour and learn how to create them by looking at them, this will add that item to memory for when you begin to Blacksmith. Once you have at least one item in your memory, find a Forge and Anvil. You will now need a Hammer. Once you have a Hammer Interact with an Ingot then click the Hammer. make sure that you are standing between a Lit Forge and an Anvil, or this will not work. A Forging menu should pop up once you Interact with the Ingot then click the hammer. In order to Forge an Item from the list, just simply Click the Item. You will fail alot of times before you become good at it. The higher your Forging skill, the better Quality the item will be. Note that only Iron and Copper can be crafted into items at the present time.<br>"
							return
						if(HelpResult == "Carpentry")
							usr << "<font color = teal><font size = 3><u><b>.:Carpentry:.</u></b> <p> <font color = teal>In order to create wooden items using Planks you will first need to know how to create them. Using the Examine button, Click Wooden items that are close by. This will add the items to your Memory and allow you to craft them any time you wish. To use Carpentry you must first have a Saw. Once you have a Saw, Equip it then Interact with a Wooden Plank, then click the Saw. This will open up the Carpentry menu. From here you simply click which wooden item you want to craft and you will begin doing so. If you create a Wooden Door, you can Place it by Interacting with it in your Inventory.<br>"
							return
						if(HelpResult == "Repair")
							usr << "<font color = teal><font size = 3><u><b>.:Repair:.</u></b> <p> <font color = teal>When your items break you will need to repair them. Use some Coal on a Forge, then use a Lit Torch on the Forge to light it, stand between the Forge and the Anvil, then Equip a Hammer. Now all you have to do is Interact with the broken item, then click the Hammer<br>"
							return
			SkillInfo
				name = "SkillInformation-(A)"
				icon_state = "skills off"
				Type = "Skill"
				screen_loc = "6,1"
				layer = 10
				Click()
					if(usr.Job)
						usr << "<b>You cant open or close this while busy!<br>"
						return
					if(usr.InvenUp)
						usr << "<b>Close your inventory first!<br>"
						return
					if(src.icon_state == "skills off")
						usr.Function = "Skill"
						usr.ResetButtons()
						src.icon_state = "skills on"
						usr.CreateSkillDisplay()
						return
					if(src.icon_state == "skills on")
						usr.ResetButtons()
						usr.Function = null
						src.icon_state = "skills off"
						usr.Delete("SkillDisplay","SkillDisplay")
						return
			HealthInfo
				name = "HealthInformation-(H)"
				icon_state = "health off"
				Type = "Health"
				screen_loc = "7,1"
				layer = 10
				Click()
					if(usr.Job)
						usr << "<b>You cant open or close this while busy!<br>"
						return
					if(usr.InvenUp)
						usr << "<b>Close your inventory first!<br>"
						return
					if(src.icon_state == "health off")
						usr.Function = "Health"
						usr.ResetButtons()
						src.icon_state = "health on"
						usr.CreateHealthDisplay()
						return
					if(src.icon_state == "health on")
						usr.ResetButtons()
						usr.Function = null
						src.icon_state = "health off"
						usr.Delete("HealthDisplay","HealthDisplay")
						return
			CharacterInfo
				name = "CharacterInformation-(C)"
				icon_state = "stats off"
				Type = "Stats"
				screen_loc = "8,1"
				layer = 10
				Click()
					if(usr.Job)
						usr << "<b>You cant open or close this while busy!<br>"
						return
					if(usr.InvenUp)
						usr << "<b>Close your inventory first!<br>"
						return
					if(src.icon_state == "stats off")
						usr.ResetButtons()
						usr.Function = "Stats"
						src.icon_state = "stats on"
						usr.CreateInfoDisplay()
						return
					if(src.icon_state == "stats on")
						usr.ResetButtons()
						usr.Function = null
						src.icon_state = "stats off"
						usr.Delete("InfoDisplay","InfoDisplay")
						return
			Inventory
				name = "Inventory-(I)"
				icon_state = "inv off"
				Type = "Inventory"
				screen_loc = "9,1"
				layer = 10
				Click()
					if(usr.Job)
						usr << "<b>You cant open or close this while busy!<br>"
						return
					if(src.icon_state == "inv off")
						usr.ResetButtons()
						usr.Function = "Inventory"
						src.icon_state = "inv on"
						usr.InvenUp = 1
						usr.CreateInventory()
						return
					if(src.icon_state == "inv on")
						if(usr.Container)
							var/obj/C = usr.Container
							if(C.ClosedState)
								C.icon_state = C.ClosedState
						if(usr.Function != "Eat")
							if(usr.Function != "Interact")
								usr.ResetButtons()
								usr.Function = null
						usr.InvenUp = 0
						src.icon_state = "inv off"
						usr.DeleteInventoryMenu()
						return
			CombatMode
				name = "CombatMode-(D)"
				icon_state = "combat off"
				Type = "Combat"
				screen_loc = "11,1"
				layer = 10
				Click()
					if(usr.Dead)
						return
					if(usr.Job)
						usr.Job = null
						usr << "<font color=green>You stop doing a task and must wait to do another!<br>"
						usr.CantDoTask = 1
						spawn(301)
							if(usr)
								usr.CantDoTask = 0
						usr.MovementCheck()
					if(src.icon_state == "combat off")
						usr.ResetButtons()
						usr.Function = "Combat"
						src.icon_state = "combat on"
						usr << "<b>Combat Mode On, Click an enemy once to start attacking<br>"
						return
					if(src.icon_state == "combat on")
						usr.ResetButtons()
						usr.Function = null
						src.icon_state = "combat off"
						usr << "<b>Combat Mode Off<br>"
						if(usr.Target)
							usr << "Target lost...<br>"
							var/mob/m = usr.Target
							usr.client.images -= m.TargetIcon
							usr.Target = null
						return
			RolePlay
				name = "RolePlay-(R)"
				icon_state = "Emote"
				Type = "RP"
				screen_loc = "3,1"
				layer = 10
				Click()
					var/T = input("Role Play - In Character")as null|message
					if(!T)
						return
					if(usr.OriginalName == null)
						hearers(usr) << "<font color =yellow>[usr] [T]<br>"
					else
						hearers(usr) << "<font color=yellow>([usr.OriginalName])[usr] [T]<br>"
					var/Cant = 0
					if(findtext(T,"(",1,0))
						Cant = 1
					if(findtext(T,")",1,0))
						Cant = 1
					if(findtext(T,"{",1,0))
						Cant = 1
					if(findtext(T,"}",1,0))
						Cant = 1
					if(Cant == 0)
						var/TextLength = length(T)
						while(TextLength)
							TextLength -= 1
							usr.RPpoints += 0.001
					if(usr)
						usr.Log_player("{Year-[Year], Month-[Month], RP-[usr.RPpoints]}([usr.key])[usr] RP - [T]")
			OOC
				name = "OutOfCharacter-(O)"
				icon_state = "OOC"
				Type = "OOC"
				screen_loc = "1,1"
				layer = 10
				Click()
					if(Mute)
						usr << "<font color = red>OOC Disabled!<br>"
						return
					var/T = input("OOC - Out of Character")as null|text
					if(!T)
						return
					if(Mute)
						usr << "<font color = red>OOC Disabled!<br>"
						return
					if(usr.Muted)
						usr << "<font color =red>You cant talk, you're Muted!<br>"
						return
					if(usr)
						for(var/mob/M in Players)
							if(M.client && M.OOC)
								M << "<font color =green>-OOC- [usr.key]: [Safe_Guard(T)]<br>"
						usr.Log_player("([usr.key])[usr] OOC - [T]")
					return
			Say
				name = "InCharacterChat-(S)"
				icon_state = "say"
				Type = "Say"
				screen_loc = "2,1"
				layer = 10
				Click()
					if(usr.Fainted)
						usr << "<font color =red>You cant speak while un-conscious!<br>"
						return
					if(usr.CurrentLanguage == null)
						usr << "<font color =red>Select a Language to speak first!<br>"
						return
					var/T = input("Say - In Character")as null|text
					if(!T)
						return
					if(usr && usr.invisibility && usr.Admin == 0)
						view(1,usr) << "<font color = teal>[usr] whispers:Wooooo....."
						return
					var/obj/SL = usr.CurrentLanguage
					for(var/mob/M in hearers(6,usr))
						var/NewText = null
						var/Text = null
						var/TextLength = length(T)
						var/Understands = 0
						if(usr.CurrentLanguage)
							for(var/obj/Misc/Languages/HL in M.LangKnow)
								if(SL.name == HL.name)
									Understands = HL.SpeakPercent
									if(HL.SpeakPercent <= 100)
										var/NotSpeaker = 1
										if(HL in usr.LangKnow)
											NotSpeaker = 0
										if(NotSpeaker)
											if(SL.SpeakPercent >= HL.SpeakPercent && HL.SpeakPercent <= 97)
												HL.SpeakPercent += M.Intelligence / 20
												if(M.Intelligence <= M.IntCap && M.Intelligence <= WorldIntCap && M.Intelligence <= M.IntelligenceMax)
													M.Intelligence += M.IntelligenceMulti / 10
						if(Understands == 0)
							M.LearnRaceLanguages("[usr.CurrentLanguage]")
						while(TextLength >= 1)
							Text ="[copytext(T,(length(T)-TextLength)+1,(length(T)-TextLength)+2)]"
							var/Change = 0
							Change = prob(100 - Understands)
							if(Change)
								M.CheckText(Text)
								NewText+="[M.TextOutput]"
								M.TextOutput = null
							if(Change == 0)
								NewText+="[copytext(T,(length(T)-TextLength)+1,(length(T)-TextLength)+2)]"
							TextLength--
						if(usr.OriginalName == null)
							M << "<font color=teal>[usr] says in [SL.name]: [Safe_Guard(NewText)]<br>"
						else
							M << "<font color=teal>([usr.OriginalName])[usr] says in [SL.name]: [Safe_Guard(NewText)]<br>"
						var/Cant = 0
						if(findtext(T,"(",1,0))
							Cant = 1
						if(findtext(T,")",1,0))
							Cant = 1
						if(findtext(T,"{",1,0))
							Cant = 1
						if(findtext(T,"}",1,0))
							Cant = 1
						if(Cant == 0)
							var/SayLength = length(T)
							while(SayLength)
								SayLength -= 1
								usr.RPpoints += 0.0005
					usr.Log_player("([usr.key])[usr] IC - [T]")
			LeftHand
				name = "LeftHand"
				icon_state = "left hand"
				Type = "LeftHand"
				screen_loc = "13,2"
				layer = 10
				Click()
					if(usr.LeftArm)
						if(usr.CurrentHand == "Right")
							usr.CurrentHand = "Left"
							src.icon_state = "left hand on"
							for(var/obj/HUD/Buttons/RightHand/R in usr.client.screen)
								R.icon_state = "right hand"
							return
					else
						usr << "<font color = red>Your Left Arm is gone!<br>"
						return
			RightHand
				name = "RightHand"
				icon_state = "right hand"
				Type = "RightHand"
				screen_loc = "14,2"
				layer = 10
				Click()
					if(usr.RightArm)
						if(usr.CurrentHand == "Left")
							usr.CurrentHand = "Right"
							src.icon_state = "right hand on"
							for(var/obj/HUD/Buttons/LeftHand/L in usr.client.screen)
								L.icon_state = "left hand"
							return
					else
						usr << "<font color = red>Your Right Arm is gone!<br>"
						return
			Examine
				name = "Examine-(E)"
				icon_state = "examine off"
				Type = "Examine"
				screen_loc = "12,1"
				layer = 10
				Click()
					if(usr.Job)
						usr << "<b>You cant use this while busy!<br>"
						return
					if(usr.CanSee == 0)
						usr << "<font color=red>You are blind and can not see objects!<br>"
						return
					if(src.icon_state == "examine off")
						usr.ResetButtons()
						usr.Function = "Examine"
						src.icon_state = "examine on"
						usr << "<b>Examine Mode On - (Location - [usr.x],[usr.y],[usr.z]. Temp feature.)<br>"
						usr.client.mouse_pointer_icon = 'IntCursor.dmi'
						return
					if(src.icon_state == "examine on")
						usr.ResetButtons()
						usr.Function = null
						src.icon_state = "examine off"
						usr << "<b>Examine Mode Off - (Location - [usr.x],[usr.y],[usr.z]. Temp feature.)<br>"
						usr.client.mouse_pointer_icon = 'Cursor.dmi'
						return
			PickUp
				name = "PickUp-(U)"
				icon_state = "pick off"
				Type = "PickUp"
				screen_loc = "14,1"
				layer = 10
				Click()
					if(usr.Dead)
						usr << "<b>You cant do that while dead!<br>"
						return
					if(usr.Job)
						usr << "<b>You cant open or close this while busy!<br>"
						return
					if(usr.LeftArm == 0)
						if(usr.RightArm == 0)
							usr << "<font color=red>You have no hands to pick anything up with!<br>"
							return
					if(usr.CanSee == 0)
						usr << "<font color=red>You are blind and can not see objects!<br>"
						return
					if(src.icon_state == "pick off")
						usr.ResetButtons()
						usr.Function = "PickUp"
						src.icon_state = "pick on"
						usr << "<b>Pick Up Mode On<br>"
						usr.client.mouse_pointer_icon = 'IntCursor.dmi'
						return
					if(src.icon_state == "pick on")
						usr.ResetButtons()
						usr.Function = null
						src.icon_state = "pick off"
						usr << "<b>Pick Up Mode Off<br>"
						usr.client.mouse_pointer_icon = 'Cursor.dmi'
						return
			Pull
				name = "Pull-(P)"
				icon_state = "pull off"
				Type = "Pull"
				screen_loc = "10,1"
				layer = 10
				Click()
					if(usr.Job)
						usr << "<b>You cant use this while busy!<br>"
						return
					if(usr.CanSee == 0)
						usr << "<font color=red>You are blind and can not see objects!<br>"
						return
					if(src.icon_state == "pull off")
						usr.ResetButtons()
						usr.Function = "Pull"
						src.icon_state = "pull on"
						usr << "<b>Pull Mode On<br>"
						usr.client.mouse_pointer_icon = 'IntCursor.dmi'
						return
					if(src.icon_state == "pull on")
						usr.ResetButtons()
						usr.Function = null
						if(usr.Pull)
							var/obj/O = usr.Pull
							usr << "<b>You stop pulling [O]!<br>"
							O.Pull = null
						src.icon_state = "pull off"
						usr << "<b>Pull Mode Off<br>"
						usr.client.mouse_pointer_icon = 'Cursor.dmi'
						return
			Build
				name = "Build-(B)"
				icon_state = "build off"
				Type = "Build"
				screen_loc = "5,1"
				layer = 10
				Click()
					if(usr.Job)
						usr << "<b>You cant open or close this while busy!<br>"
						return
					if(usr.CanSee == 0)
						usr << "<font color=red>You are blind and can not see objects!<br>"
						return
					if(src.icon_state == "build off")
						usr.ResetButtons()
						usr.Function = "Build"
						src.icon_state = "build on"
						usr.CreateBuildMenu()
						usr << "<b>Click an icon to build, make sure you have the right materials!<br>"
						return
					if(src.icon_state == "build on")
						usr.ResetButtons()
						usr.Function = null
						src.icon_state = "build off"
						usr << "<b>Build Mode Off<br>"
						usr.DeleteInventoryMenu()
						return
			Interact
				name = "Interact-(Z)"
				icon_state = "int off"
				Type = "Interact"
				screen_loc = "13,1"
				layer = 10
				Click()
					if(usr.Job)
						usr << "<b>You cant use this while busy!<br>"
						return
					if(usr.Dead)
						usr << "<b>You cant do that while dead!<br>"
						return
					if(usr.CanSee == 0)
						usr << "<font color=red>You are blind and can not see objects!<br>"
						return
					if(src.icon_state == "int off")
						usr.ResetButtons()
						usr.Function = "Interact"
						src.icon_state = "int on"
						usr << "<b>Interact Mode On<br>"
						usr.client.mouse_pointer_icon = 'IntCursor.dmi'
						return
					if(src.icon_state == "int on")
						usr.ResetButtons()
						usr.Function = null
						src.icon_state = "int off"
						if(usr.Ref)
							usr << "<font color = teal>Interaction with [usr.Ref] lost.<br>"
						usr.Ref = null
						usr << "<b>Interact Mode Off<br>"
						usr.client.mouse_pointer_icon = 'Cursor.dmi'
						return
		GUI
			icon = 'HUD2.dmi'
			layer = 10
			ScreenOverlay
				name = ""
				icon = 'HUD.dmi'
				icon_state = "blank screen"
				screen_loc = "1,1 to 15,15"
			BloodBar
				icon = 'BloodBar.dmi'
				icon_state = "100"
				screen_loc = "4,1"
			SW
				icon_state = "SW"
				screen_loc = "1,1"
			NW
				icon_state = "NW"
				screen_loc = "1,15"
			NE
				icon_state = "NE"
				screen_loc = "15,15"
			SE
				icon_state = "SE"
				screen_loc = "15,1"
			N
				icon_state = "N"
				screen_loc = "2,15 to 14,15"
			S
				icon_state = "S"
				screen_loc = "2,1 to 14,1"
			E
				icon_state = "E"
				screen_loc = "15,2 to 15,14"
			W
				icon_state = "W"
				screen_loc = "1,2 to 1,14"
		LoadGame
			icon = 'menu.dmi'
			icon_state = "Load"
			Click()
				if(usr in range(8,src))
					if(usr.Ready == 0)
						var/player_sav = "players/[usr.ckey].sav"
						if(length(file(player_sav)))
							usr << sound(null)
							usr.LoggedIn = 1
							usr.Load()
							usr.MusicProc()
							if(usr)
								if(usr.x == 0)
									if(usr.y == 0)
										if(usr.z == 0)
											usr.loc = locate(1,1,1)
											usr << "<font color = teal>Possible Save Error, please report to an Admin.<br>"
						else
							usr << "<b>You have no save!<br>"
							return
					else
						usr << "<font color = teal>Please relog if you wish to load a game now.<br>"
						return
		NewGame
			icon = 'menu.dmi'
			icon_state = "New"
			Click()
				if(usr in range(8,src))
					usr.Ready = 1
					switch(alert("Start a new game?",,"Yes","No"))
						if("No")
							usr.Ready = 0
							return
						if("Yes")
							usr.CreateRaceSelection()
							usr.loc = locate(28,91,1)
							alert("Choose a race by clicking on a face portrait! Once your happy with your selection choose a Gender and click Accept!")
/**
						usr << "<font color = green>You arrive in Holthormus and decide to seek shelter in the Chapel of Order<br>"
*//
