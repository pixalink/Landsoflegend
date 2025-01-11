atom
	MouseDrag(var/obj/Over_Object,var/turf/Turf_Start,var/obj/Over_Loc)
		if(ismob(src))
			var/mob/M = src
			if(usr.CanUseTK && usr.Function == "Interact" && usr.client.eye == usr && M.Sleeping == 0 && usr.Sleeping == 0 && usr.Sleep >= 0 && usr.Dead == 0 && usr.Fainted == 0)
				M.LastLoc = M.loc
				var/CanLift = 0
				var/CanResist = 0
				CanLift = prob(100 - M.Weight / 3)
				CanResist = prob(10 + M.Intelligence)
				usr.Sleep -= 0.1
				usr.Intelligence += 0.001
				if(CanLift && CanResist == 0)
					if(Over_Loc in range(1,M.LastLoc))
						M.UnderTK = usr
						M.overlays += /obj/Misc/SpellEffects/Dispel
						usr.overlays += /obj/Misc/SpellEffects/Dispel
						spawn(10)
							if(usr)
								usr.overlays -= /obj/Misc/SpellEffects/Dispel
							if(M)
								M.overlays -= /obj/Misc/SpellEffects/Dispel
						M.Move(Over_Loc,SOUTH)
						if(M)
							M.UnderTK = null
					else
						M.loc = M.LastLoc
		if(isobj(src))
			var/obj/O = src
			if(usr.CanUseTK && usr.Function == "Interact" && O.Type != "Sleep" && usr.Sleeping == 0 && usr.Sleep >= 0 && O.suffix == null && usr.Dead == 0 && usr.Fainted == 0)
				if(Over_Loc)
					if(Over_Loc.density == 0)
						O.LastLoc = O.loc
						var/CanLift = 0
						CanLift = prob(100 - O.Weight / 3)
						usr.Sleep -= 0.05
						usr.Intelligence += 0.001
						if(usr.client.eye != usr)
							usr.Sleep -= 0.05
						if(CanLift)
							if(Over_Loc in range(1,O.LastLoc))
								O.overlays += /obj/Misc/SpellEffects/Dispel
								usr.overlays += /obj/Misc/SpellEffects/Dispel
								spawn(10)
									if(usr)
										usr.overlays -= /obj/Misc/SpellEffects/Dispel
									if(O)
										O.overlays -= /obj/Misc/SpellEffects/Dispel
								O.Move(Over_Loc)
								for(var/atom/a in range(0,O))
									if(a.density)
										O.loc = O.LastLoc
									if(isobj(a))
										var/obj/Z = a
										if(Z.Type == "Hole" && Z.GoesTo)
											view(6,O) << "<font color = yellow>[O] falls down the Hole!<br>"
											O.loc = Z.GoesTo
							else
								O.loc = O.LastLoc
obj
	var
		EquipState = null
		CarryState = null
		ItemLayer = 0

		ObjectType = null
		ObjectTag = null

		OpenState = null
		ClosedState = null

		Locked = 0
		KeyCode = null

		CantRaces = null
		Heals = null

		tmp/GoesTo = null

		Value = 0

		CraftPotential = 0

		Skinned = 0
		Butchered = 0

		CookedState = null //Icon state of the meat when cooked
		CookingFood = 0 // 1 means it needs to be cook, and 2 means it is cooked.

		Delete = 0 //Add this to items that should delete when the person holding them dies.

		TwoHander = 0 //Weapons that can used two hands to do damage with.

		SpeakPercent = 0 //How well you can speak that Language
		WritePercent = 0 //How well you can write that Language

		WeaponDamageMax = 0
		WeaponDamageMin = 0

	proc
		RandomItem()
			var/MadeItem = 1
			if(src.Type == "RandomResource")
				var/R = rand(1,3)
				var/Num = rand(15,33)
				if(R == 1)
					while(Num)
						Num -= 1
						var/obj/Items/Resources/Plank/P = new
						P.loc = src.loc
				if(R == 2)
					while(Num)
						Num -= 1
						var/obj/Items/Resources/LargeBrick/B = new
						B.loc = src.loc
				if(R == 3)
					var/Mat = rand(1,4)
					if(Mat == 1)
						Mat = "Iron"
					if(Mat == 2)
						Mat = "Copper"
					if(Mat == 3)
						Mat = "Gold"
					if(Mat == 4)
						Mat = "Silver"
					while(Num)
						Num -= 1
						var/obj/Items/Resources/Ingot/I = new
						I.Material = Mat
						I.icon_state = "[I.Material] ingot"
						I.name = "[I.Material] ingot"
						I.Weight = 10
						I.CraftPotential = rand(1,100)
						I.loc = src.loc
			if(src.Type == "RandomBone")
				var/obj/Items/Armour/UpperBody/BoneChestPlate/U = new
				U.icon_state = U.CarryState
				U.pixel_y = 12
				U.loc = src.loc
				U.Defence += rand(3,10)
				var/obj/Items/Armour/Shoulders/SkullPauldrons/PS = new
				PS.icon_state = PS.CarryState
				PS.pixel_y = 12
				PS.loc = src.loc
				PS.Defence += rand(3,10)
				var/obj/Items/Armour/Head/SkullHelmet/H = new
				H.icon_state = H.CarryState
				H.pixel_y = 12
				H.loc = src.loc
				H.Defence += rand(3,10)
				var/obj/Items/Armour/LeftArm/BoneLeftGauntlet/PGL = new
				PGL.icon_state = PGL.CarryState
				PGL.pixel_y = 12
				PGL.loc = src.loc
				PGL.Defence += rand(3,10)
				var/obj/Items/Armour/RightArm/BoneRightGauntlet/PGR = new
				PGR.icon_state = PGR.CarryState
				PGR.pixel_y = 12
				PGR.loc = src.loc
				PGR.Defence += rand(3,10)
				var/obj/Items/Armour/LeftFoot/BoneBootLeft/PBL = new
				PBL.icon_state = PBL.CarryState
				PBL.pixel_y = 12
				PBL.loc = src.loc
				PBL.Defence += rand(3,10)
				var/obj/Items/Armour/RightFoot/BoneBootRight/PBR = new
				PBR.icon_state = PBR.CarryState
				PBR.pixel_y = 12
				PBR.loc = src.loc
				PBR.Defence += rand(3,10)
			if(src.Type == "RandomPlateStahlite")
				var/Mat = rand(1,3)
				if(Mat == 1)
					Mat = "Iron"
				if(Mat == 2)
					Mat = "Copper"
				if(Mat == 3)
					Mat = "Gold"
				var/obj/Items/Armour/Chest/SmallChainShirt/C = new
				C.Material = Mat
				C.RandomItemQuality()
				C.name = "[C.Material] [C]"
				C.icon_state = C.CarryState
				C.pixel_y = 12
				C.loc = src.loc
				if(Mat == "Iron")
					C.Defence += rand(3,5)
				if(Mat == "Copper")
					C.Defence += rand(2,4)
				if(Mat == "Gold")
					C.Defence += rand(1,2)
				var/obj/Items/Armour/UpperBody/SmallChestPlate/U = new
				U.Material = Mat
				U.RandomItemQuality()
				U.name = "[U.Material] [U]"
				U.icon_state = U.CarryState
				U.pixel_y = 12
				U.loc = src.loc
				if(Mat == "Iron")
					U.Defence += rand(3,5)
				if(Mat == "Copper")
					U.Defence += rand(2,4)
				if(Mat == "Gold")
					U.Defence += rand(1,2)
				var/obj/Items/Armour/Shoulders/SmallPlatePauldrons/PS = new
				PS.Material = Mat
				PS.RandomItemQuality()
				PS.name = "[PS.Material] [PS]"
				PS.icon_state = PS.CarryState
				PS.pixel_y = 12
				PS.loc = src.loc
				if(Mat == "Iron")
					PS.Defence += rand(3,5)
				if(Mat == "Copper")
					PS.Defence += rand(2,4)
				if(Mat == "Gold")
					PS.Defence += rand(1,2)
				var/obj/Items/Armour/Head/SmallDwarvenHelmet/H = new
				var/HelmNum = rand(1,3)
				H.icon_state = "small stahlite helm[HelmNum]"
				H.EquipState = "small stahlite helm[HelmNum]"
				H.CarryState = "small stahlite helm[HelmNum]"
				H.Material = Mat
				H.RandomItemQuality()
				H.name = "[H.Material] [H]"
				H.icon_state = H.CarryState
				H.pixel_y = 12
				H.loc = src.loc
				if(Mat == "Iron")
					H.Defence += rand(3,5)
				if(Mat == "Copper")
					H.Defence += rand(2,4)
				if(Mat == "Gold")
					H.Defence += rand(1,2)
				var/obj/Items/Armour/LeftArm/SmallPlateGauntletLeft/PGL = new
				PGL.Material = Mat
				PGL.RandomItemQuality()
				PGL.name = "[PGL.Material] [PGL]"
				PGL.icon_state = PGL.CarryState
				PGL.pixel_y = 12
				PGL.loc = src.loc
				if(Mat == "Iron")
					PGL.Defence += rand(3,5)
				if(Mat == "Copper")
					PGL.Defence += rand(2,4)
				if(Mat == "Gold")
					PGL.Defence += rand(1,2)
				var/obj/Items/Armour/RightArm/SmallPlateGauntletRight/PGR = new
				PGR.Material = Mat
				PGR.RandomItemQuality()
				PGR.name = "[PGR.Material] [PGR]"
				PGR.icon_state = PGR.CarryState
				PGR.pixel_y = 12
				PGR.loc = src.loc
				if(Mat == "Iron")
					PGR.Defence += rand(3,5)
				if(Mat == "Copper")
					PGR.Defence += rand(2,4)
				if(Mat == "Gold")
					PGR.Defence += rand(1,2)
				var/obj/Items/Armour/Legs/SmallChainLeggings/CL = new
				CL.Material = Mat
				CL.RandomItemQuality()
				CL.name = "[CL.Material] [CL]"
				CL.icon_state = CL.CarryState
				CL.pixel_y = 12
				CL.loc = src.loc
				if(Mat == "Iron")
					CL.Defence += rand(3,5)
				if(Mat == "Copper")
					CL.Defence += rand(2,4)
				if(Mat == "Gold")
					CL.Defence += rand(1,2)
				var/obj/Items/Armour/Shields/Shield/S = new
				S.Material = Mat
				S.RandomItemQuality()
				S.name = "[S.Material] [S]"
				S.icon_state = S.CarryState
				S.pixel_y = 12
				S.loc = src.loc
				if(Mat == "Iron")
					S.Defence += rand(3,5)
				if(Mat == "Copper")
					S.Defence += rand(2,4)
				if(Mat == "Gold")
					S.Defence += rand(1,2)
				var/obj/Items/Armour/LeftFoot/SmallPlateBootLeft/PBL = new
				PBL.Material = Mat
				PBL.RandomItemQuality()
				PBL.name = "[PBL.Material] [PBL]"
				PBL.icon_state = PBL.CarryState
				PBL.pixel_y = 12
				PBL.loc = src.loc
				if(Mat == "Iron")
					PBL.Defence += rand(3,5)
				if(Mat == "Copper")
					PBL.Defence += rand(2,4)
				if(Mat == "Gold")
					PBL.Defence += rand(1,2)

				var/obj/Items/Armour/RightFoot/SmallPlateBootRight/PBR = new
				PBR.Material = Mat
				PBR.RandomItemQuality()
				PBR.name = "[PBR.Material] [PBR]"
				PBR.icon_state = PBR.CarryState
				PBR.pixel_y = 12
				PBR.loc = src.loc
				if(Mat == "Iron")
					PBR.Defence += rand(3,5)
				if(Mat == "Copper")
					PBR.Defence += rand(2,4)
				if(Mat == "Gold")
					PBR.Defence += rand(1,2)
			if(src.Type == "RandomPlate")
				var/Mat = rand(1,3)
				if(Mat == 1)
					Mat = "Iron"
				if(Mat == 2)
					Mat = "Copper"
				if(Mat == 3)
					Mat = "Gold"
				var/obj/Items/Armour/Chest/ChainShirt/C = new
				C.Material = Mat
				C.RandomItemQuality()
				C.name = "[C.Material] [C]"
				C.icon_state = C.CarryState
				C.pixel_y = 12
				C.loc = src.loc
				if(Mat == "Iron")
					C.Defence += rand(3,5)
				if(Mat == "Copper")
					C.Defence += rand(2,4)
				if(Mat == "Gold")
					C.Defence += rand(1,2)
				var/obj/Items/Armour/UpperBody/ChestPlate/U = new
				U.Material = Mat
				U.RandomItemQuality()
				U.name = "[U.Material] [U]"
				U.icon_state = U.CarryState
				U.pixel_y = 12
				U.loc = src.loc
				if(Mat == "Iron")
					U.Defence += rand(3,5)
				if(Mat == "Copper")
					U.Defence += rand(2,4)
				if(Mat == "Gold")
					U.Defence += rand(1,2)
				var/obj/Items/Armour/Shoulders/PlatePauldrons/PS = new
				PS.Material = Mat
				PS.RandomItemQuality()
				PS.name = "[PS.Material] [PS]"
				PS.icon_state = PS.CarryState
				PS.pixel_y = 12
				PS.loc = src.loc
				if(Mat == "Iron")
					PS.Defence += rand(3,5)
				if(Mat == "Copper")
					PS.Defence += rand(2,4)
				if(Mat == "Gold")
					PS.Defence += rand(1,2)
				var/obj/Items/Armour/Head/PlateHelmet/H = new
				var/HelmNum = rand(1,5)
				H.icon_state = "plate helm[HelmNum]"
				H.EquipState = "plate helm[HelmNum]"
				H.CarryState = "plate helm[HelmNum]"
				H.Material = Mat
				H.RandomItemQuality()
				H.name = "[H.Material] [H]"
				H.icon_state = H.CarryState
				H.pixel_y = 12
				H.loc = src.loc
				if(Mat == "Iron")
					H.Defence += rand(3,5)
				if(Mat == "Copper")
					H.Defence += rand(2,4)
				if(Mat == "Gold")
					H.Defence += rand(1,2)
				var/obj/Items/Armour/LeftArm/PlateGauntletLeft/PGL = new
				PGL.Material = Mat
				PGL.RandomItemQuality()
				PGL.name = "[PGL.Material] [PGL]"
				PGL.icon_state = PGL.CarryState
				PGL.pixel_y = 12
				PGL.loc = src.loc
				if(Mat == "Iron")
					PGL.Defence += rand(3,5)
				if(Mat == "Copper")
					PGL.Defence += rand(2,4)
				if(Mat == "Gold")
					PGL.Defence += rand(1,2)
				var/obj/Items/Armour/RightArm/PlateGauntletRight/PGR = new
				PGR.Material = Mat
				PGR.RandomItemQuality()
				PGR.name = "[PGR.Material] [PGR]"
				PGR.icon_state = PGR.CarryState
				PGR.pixel_y = 12
				PGR.loc = src.loc
				if(Mat == "Iron")
					PGR.Defence += rand(3,5)
				if(Mat == "Copper")
					PGR.Defence += rand(2,4)
				if(Mat == "Gold")
					PGR.Defence += rand(1,2)
				var/obj/Items/Armour/Legs/ChainLeggings/CL = new
				CL.Material = Mat
				CL.RandomItemQuality()
				CL.name = "[CL.Material] [CL]"
				CL.icon_state = CL.CarryState
				CL.pixel_y = 12
				CL.loc = src.loc
				if(Mat == "Iron")
					CL.Defence += rand(3,5)
				if(Mat == "Copper")
					CL.Defence += rand(2,4)
				if(Mat == "Gold")
					CL.Defence += rand(1,2)
				var/obj/Items/Armour/Shields/Shield/S = new
				S.Material = Mat
				S.RandomItemQuality()
				S.name = "[S.Material] [S]"
				S.icon_state = S.CarryState
				S.pixel_y = 12
				S.loc = src.loc
				if(Mat == "Iron")
					S.Defence += rand(3,5)
				if(Mat == "Copper")
					S.Defence += rand(2,4)
				if(Mat == "Gold")
					S.Defence += rand(1,2)
				var/obj/Items/Armour/LeftFoot/PlateBootLeft/PBL = new
				PBL.Material = Mat
				PBL.RandomItemQuality()
				PBL.name = "[PBL.Material] [PBL]"
				PBL.icon_state = PBL.CarryState
				PBL.pixel_y = 12
				PBL.loc = src.loc
				if(Mat == "Iron")
					PBL.Defence += rand(3,5)
				if(Mat == "Copper")
					PBL.Defence += rand(2,4)
				if(Mat == "Gold")
					PBL.Defence += rand(1,2)

				var/obj/Items/Armour/RightFoot/PlateBootRight/PBR = new
				PBR.Material = Mat
				PBR.RandomItemQuality()
				PBR.name = "[PBR.Material] [PBR]"
				PBR.icon_state = PBR.CarryState
				PBR.pixel_y = 12
				PBR.loc = src.loc
				if(Mat == "Iron")
					PBR.Defence += rand(3,5)
				if(Mat == "Copper")
					PBR.Defence += rand(2,4)
				if(Mat == "Gold")
					PBR.Defence += rand(1,2)
			if(src.Type == "RandomWeapon")
				MadeItem = 0
				var/ItemType = 0
				ItemType = rand(1,6)
				if(ItemType == 1)
					var/Swords = list()
					Swords += typesof(/obj/Items/Weapons/Swords/)
					for(var/O in Swords)
						var/obj/I = new O()
						if(I.CanBeCrafted)
							var/Choose = prob(25)
							if(Choose)
								var/obj/A = new I.type()
								var/Make = rand(1,3)
								var/Mat = null
								if(Make == 1)
									Mat = "Iron"
									A.Quality += rand(4,7)
								if(Make == 2)
									Mat = "Copper"
									A.Quality += rand(3,5)
								if(Make == 3)
									Mat = "Silver"
									A.Quality += rand(3,5)
								A.Material = Mat
								A.RandomItemQuality()
								A.name = "[A.Material] [A]"
								A.icon_state = A.CarryState
								A.pixel_y = 12
								A.loc = src.loc
								A.CanBeCrafted = 0
								MadeItem = 1
								break
							else
								del(I)
						else
							del(I)
				if(ItemType == 2)
					var/Axes = list()
					Axes += typesof(/obj/Items/Weapons/Axes/)
					for(var/O in Axes)
						var/obj/I = new O()
						if(I.CanBeCrafted)
							var/Choose = prob(33)
							if(Choose)
								var/obj/A = new I.type()
								var/Make = rand(1,3)
								var/Mat = null
								if(Make == 1)
									Mat = "Iron"
									A.Quality += rand(4,7)
								if(Make == 2)
									Mat = "Copper"
									A.Quality += rand(3,5)
								if(Make == 3)
									Mat = "Silver"
									A.Quality += rand(3,5)
								A.Material = Mat
								A.RandomItemQuality()
								A.name = "[A.Material] [A]"
								A.icon_state = A.CarryState
								A.pixel_y = 12
								A.loc = src.loc
								A.CanBeCrafted = 0
								MadeItem = 1
								break
							else
								del(I)
						else
							del(I)
				if(ItemType == 3)
					var/Blunts = list()
					Blunts += typesof(/obj/Items/Weapons/Blunts/)
					for(var/O in Blunts)
						var/obj/I = new O()
						if(I.CanBeCrafted)
							var/Choose = prob(25)
							if(Choose)
								var/obj/A = new I.type()
								var/Make = rand(1,3)
								var/Mat = null
								if(Make == 1)
									Mat = "Iron"
									A.Quality += rand(4,7)
								if(Make == 2)
									Mat = "Copper"
									A.Quality += rand(3,5)
								if(Make == 3)
									Mat = "Silver"
									A.Quality += rand(3,5)
								A.Material = Mat
								A.RandomItemQuality()
								A.name = "[A.Material] [A]"
								A.icon_state = A.CarryState
								A.pixel_y = 12
								A.loc = src.loc
								A.CanBeCrafted = 0
								MadeItem = 1
								break
							else
								del(I)
						else
							del(I)
				if(ItemType == 4)
					var/Spears = list()
					Spears += typesof(/obj/Items/Weapons/Spears/)
					for(var/O in Spears)
						var/obj/I = new O()
						if(I.CanBeCrafted)
							var/Choose = prob(100)
							if(Choose)
								var/obj/A = new I.type()
								var/Make = rand(1,3)
								var/Mat = null
								if(Make == 1)
									Mat = "Iron"
									A.Quality += rand(4,7)
								if(Make == 2)
									Mat = "Copper"
									A.Quality += rand(3,5)
								if(Make == 3)
									Mat = "Silver"
									A.Quality += rand(3,5)
								A.Material = Mat
								A.RandomItemQuality()
								A.name = "[A.Material] [A]"
								A.icon_state = A.CarryState
								A.pixel_y = 12
								A.loc = src.loc
								A.CanBeCrafted = 0
								MadeItem = 1
								break
							else
								del(I)
						else
							del(I)
				if(ItemType == 5)
					var/Daggers = list()
					Daggers += typesof(/obj/Items/Weapons/Daggers/)
					for(var/O in Daggers)
						var/obj/I = new O()
						if(I.CanBeCrafted)
							var/Choose = prob(50)
							if(Choose)
								var/obj/A = new I.type()
								var/Make = rand(1,3)
								var/Mat = null
								if(Make == 1)
									Mat = "Iron"
									A.Quality += rand(4,7)
								if(Make == 2)
									Mat = "Copper"
									A.Quality += rand(3,5)
								if(Make == 3)
									Mat = "Silver"
									A.Quality += rand(3,5)
								A.Material = Mat
								A.RandomItemQuality()
								A.name = "[A.Material] [A]"
								A.icon_state = A.CarryState
								A.pixel_y = 12
								A.loc = src.loc
								A.CanBeCrafted = 0
								MadeItem = 1
								break
							else
								del(I)
						else
							del(I)
				if(ItemType == 6)
					var/Bows = list()
					Bows += typesof(/obj/Items/Weapons/Ranged/)
					for(var/O in Bows)
						var/obj/I = new O()
						if(I.CanBeCrafted)
							var/Choose = prob(50)
							if(Choose)
								var/obj/A = new I.type()
								var/Make = rand(1,3)
								var/Mat = null
								if(Make == 1)
									Mat = "Iron"
									A.Quality += rand(4,7)
								if(Make == 2)
									Mat = "Copper"
									A.Quality += rand(3,5)
								if(Make == 3)
									Mat = "Silver"
									A.Quality += rand(3,5)
								A.Material = Mat
								A.RandomItemQuality()
								A.name = "[A.Material] [A]"
								A.icon_state = A.CarryState
								A.pixel_y = 12
								A.loc = src.loc
								A.CanBeCrafted = 0
								MadeItem = 1
								break
							else
								del(I)
						else
							del(I)
			if(MadeItem == 0)
				src.RandomItem()
			else
				del(src)
			return
		Cook(var/Loc,var/obj/Fire,var/mob/DroppedBy,var/Cooked,var/WillBurn,)
			if(src.icon == 'Skeleton.dmi')
				return
			spawn(rand(100,300))
				if(Fire && src)
					if(Fire in range(1,src))
						if(src && src.suffix == null && src.loc == Loc && Fire.OnFire)
							if(WillBurn)
								view(2,src.loc) << "<font color = yellow>The [src] burns to ash!<br>"
								var/obj/Items/Resources/Ash/A = new
								A.loc = src.loc
								del(src)
								return
							if(src.CookingFood != 2)
								if(Cooked == 2)
									view(2,src.loc) << "<font color = yellow>The [src] seems to be done cooking!<br>"
									src.CookingFood = 2
									if(src.icon != 'food.dmi')
										src.icon = 'food.dmi'
									if(src.tag == "Limb")
										src.CookedState = "cooked meat2"
									src.icon_state = src.CookedState
									if(DroppedBy)
										if(DroppedBy in view(4,src))
											DroppedBy.CookingSkill += DroppedBy.CookingSkillMulti
									src.Cook(Loc,Fire,DroppedBy,Cooked,WillBurn)
									return
								else
									view(2,src.loc) << "<font color = yellow>The [src] seems to be cooking nicely!<br>"
									Cooked += 1
									if(DroppedBy)
										if(DroppedBy in view(4,src))
											DroppedBy.CookingSkill += DroppedBy.CookingSkillMulti / 4
											src.Type += DroppedBy.CookingSkill / 4
									src.Cook(Loc,Fire,DroppedBy,Cooked,WillBurn)
									return
							if(Cooked == 3)
								view(2,src.loc) << "<font color = yellow>The [src] seems to be burning!<br>"
								src.Cook(Loc,Fire,DroppedBy,Cooked,1)
								return

		LightProc(var/mob/M)
			if(src && src.Type == "Torch Lit")
				src.Dura -= 0.5
				if(M && src in M)
					M.luminosity = 5
					if(M.InWater)
						M.luminosity = 0
						M.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
						M.overlays-=image(src.icon,"[src.icon_state] left",src.ItemLayer)
						src.Type = "Torch"
						src.CarryState = "torch"
						src.EquipState = "torch equip"
						src.icon_state = src.EquipState
						if(src == M.Weapon)
							M.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
						if(src == M.Weapon2)
							M.overlays+=image(src.icon,"[src.icon_state] left",src.ItemLayer)
				else
					if(M)
						M.luminosity = 0
						src.luminosity = 5
						M = null
				if(src.Dura <= 1)
					view(2,src.loc) << "<font color = yellow>[src] burns out!<br>"
					if(M && src in M)
						M.Weight -= src.Weight
						M.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
						M.overlays-=image(src.icon,"[src.icon_state] left",src.ItemLayer)
						M.luminosity = 1
					del(src)
					return
			else
				if(M)
					M.luminosity = 0
				return
			spawn(10) LightProc(M)
		ChaosGate()
			spawn(rand(5000,10000))
				if(src)
					var/mob/NPC/Evil/Chaos/Chaos_Entity/C = new
					C.loc = src.loc
					view(src) << "<font color = purple>The [src] swirls and crackles with chaotic energy, suddenly the [src] flares violently and expells a strange dark mist of pure energy!<br>"
					ChaosGate()
		CreateChaos()
			if(src)
				var/num = rand(5,8)
				while(num)
					num -= 1
					var/obj/Misc/OtherWorldly/ChaosEnergy/E = new
					E.loc = locate(src.x,src.y,src.z)
					E.dir = rand(1,12)
			else
				return
			spawn(9)
				CreateChaos()
		MoveRand()
			step_rand(src)
			spawn(5) MoveRand()
	Misc
		Night
			icon = 'fx.dmi'
			icon_state = "night"
			layer = 99
		ContainerOverlays
			icon = 'containers.dmi'
			BowlOverlay
				icon_state = "bowl liquid"
		Layer
		MetalLadderUp
			name = "Metal Ladder"
			icon = 'terrain.dmi'
			icon_state = "metal ladder"
			suffix = "Stuck"
			New()
				spawn(1)
					if(src.z == 1)
						src.GoesTo = locate(src.x,src.y,src.z + 1)
					if(src.z == 3)
						src.GoesTo = locate(src.x,src.y,src.z - 2)
			Click()
				if(usr.Dead)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
				if(usr.Function == "Interact" && usr.Fainted == 0)
					if(src in range(1,usr))
						view(usr) << "<font color = yellow>[usr] climbs up [src]!<br>"
						usr.loc = src.GoesTo
		SandStoneStairsUp
			name = "Stairs"
			icon = 'terrain.dmi'
			icon_state = "sand stairs up"
			suffix = "Stuck"
			New()
				spawn(1)
					if(src.z == 1)
						src.GoesTo = locate(src.x,src.y,src.z + 1)
					if(src.z == 3)
						src.GoesTo = locate(src.x,src.y,src.z - 2)
			Click()
				if(usr.Dead)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
				if(usr.Function == "Interact" && usr.Fainted == 0)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
						usr.overlays -= /obj/Misc/Bubbles/
						usr.overlays -= /obj/Misc/Swim/
						usr.InWater = 0
				if(usr.Function == "Combat" && src.suffix == "Stuck" && usr.Job == null)
					if(usr in range(1,src))
						if(usr.CantDoTask)
							usr << "<font color = red>Cant attack that for a while!<br>"
							return
						view(usr) << "<font color = red>[usr] begins an attempt at breaking the [src]!<br>"
						usr.Job = "SmashStair"
						usr.CanMove = 0
						usr.CantDoTask = 1
						spawn(150)
							if(usr)
								usr.CantDoTask = 0
						var/LOC = usr.loc
						var/Time = 300 - usr.Agility / 2
						if(Time <= 50)
							Time = 50
						spawn(Time)
							if(usr && src && usr.loc == LOC && usr.Job == "SmashStair" && src.suffix == "Stuck")
								var/DMG = usr.Strength
								var/Holding = 0
								if(usr.Weapon)
									Holding += 1
									var/obj/W = usr.Weapon
									if(W.ObjectTag == "Weapon")
										DMG += W.Weight / 2
										DMG += rand(W.Dura / 2,W.Dura)
										W.Dura -= rand(0.1,2)
										if(W.ObjectType == "Blunt")
											DMG += 10
										if(W.TwoHander && usr.Weapon2 == null)
											DMG += W.Weight / 2
										usr.CheckWeaponDura(W)
								if(usr.Weapon2)
									Holding += 2
									var/obj/W = usr.Weapon2
									if(W.ObjectTag == "Weapon")
										DMG += W.Weight / 2
										DMG += rand(W.Dura / 2,W.Dura)
										W.Dura -= rand(0.1,2)
										if(W.ObjectType == "Blunt")
											DMG += 10
										if(W.TwoHander && usr.Weapon == null)
											DMG += W.Weight / 2
										usr.CheckWeaponDura(W)
								if(Holding == 2)
									DMG = DMG / 1.5
								usr.DetermineWeaponSkill()
								if(usr.CurrentSkillLevel)
									DMG = DMG + usr.CurrentSkillLevel / 4
								usr.Job = null
								usr.MovementCheck()
								var/WontDamage = 75 - DMG
								var/CantDamage = prob(WontDamage)
								if(DMG >= 0 && CantDamage != 1)
									src.Dura -= DMG
									if(src.Dura <= 0)
										range(src) << "<font color = red>[src] begins to crumble and fall away as [usr] smashes it!<br>"
										var/obj/Z = new
										if(src.z == 1)
											Z.loc = locate(src.x,src.y,2)
										if(src.z == 3)
											Z.loc = locate(src.x,src.y,1)
										for(var/obj/Misc/StairsDown/S in range(0,Z))
											var/obj/Misc/Hole/H = new
											H.loc = S.loc
											del(S)
										del(Z)
										del(src)
									else
										range(src) << "<font color = red>[src] makes a loud noise as [usr] damages it!<br>"
									return
								else
									range(src) << "<font color = red>[src] makes a loud noise as [usr] tried to damage it!<br>"
									return
							else
								if(usr)
									usr.MovementCheck()
						return
		StairsUp
			name = "Stairs"
			icon = 'terrain.dmi'
			icon_state = "stairs up"
			suffix = "Stuck"
			Dura = 300
			New()
				spawn(1)
					if(src.z == 1)
						src.GoesTo = locate(src.x,src.y,src.z + 1)
					if(src.z == 3)
						src.GoesTo = locate(src.x,src.y,src.z - 2)
			Click()
				if(usr.Dead)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
				if(usr.Function == "Interact" && usr.Fainted == 0)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
						usr.overlays -= /obj/Misc/Bubbles/
						usr.overlays -= /obj/Misc/Swim/
						usr.InWater = 0
				if(usr.Function == "Combat" && src.suffix == "Stuck" && usr.Job == null)
					if(usr in range(1,src))
						if(usr.CantDoTask)
							usr << "<font color = red>Cant attack that for a while!<br>"
							return
						view(usr) << "<font color = red>[usr] begins an attempt at breaking the [src]!<br>"
						usr.Job = "SmashStair"
						usr.CanMove = 0
						usr.CantDoTask = 1
						spawn(150)
							if(usr)
								usr.CantDoTask = 0
						var/LOC = usr.loc
						var/Time = 300 - usr.Agility / 2
						if(Time <= 50)
							Time = 50
						spawn(Time)
							if(usr && src && usr.loc == LOC && usr.Job == "SmashStair" && src.suffix == "Stuck")
								var/DMG = usr.Strength
								var/Holding = 0
								if(usr.Weapon)
									Holding += 1
									var/obj/W = usr.Weapon
									if(W.ObjectTag == "Weapon")
										DMG += W.Weight / 2
										DMG += rand(W.Dura / 2,W.Dura)
										W.Dura -= rand(0.1,2)
										if(W.ObjectType == "Blunt")
											DMG += 10
										if(W.TwoHander && usr.Weapon2 == null)
											DMG += W.Weight / 2
										usr.CheckWeaponDura(W)
								if(usr.Weapon2)
									Holding += 2
									var/obj/W = usr.Weapon2
									if(W.ObjectTag == "Weapon")
										DMG += W.Weight / 2
										DMG += rand(W.Dura / 2,W.Dura)
										W.Dura -= rand(0.1,2)
										if(W.ObjectType == "Blunt")
											DMG += 10
										if(W.TwoHander && usr.Weapon == null)
											DMG += W.Weight / 2
										usr.CheckWeaponDura(W)
								if(Holding == 2)
									DMG = DMG / 1.5
								usr.DetermineWeaponSkill()
								if(usr.CurrentSkillLevel)
									DMG = DMG + usr.CurrentSkillLevel / 4
								usr.Job = null
								usr.MovementCheck()
								var/WontDamage = 75 - DMG
								var/CantDamage = prob(WontDamage)
								if(DMG >= 0 && CantDamage != 1)
									src.Dura -= DMG
									if(src.Dura <= 0)
										range(src) << "<font color = red>[src] begins to crumble and fall away as [usr] smashes it!<br>"
										var/obj/Z = new
										if(src.z == 1)
											Z.loc = locate(src.x,src.y,2)
										if(src.z == 3)
											Z.loc = locate(src.x,src.y,1)
										for(var/obj/Misc/StairsDown/S in range(0,Z))
											var/obj/Misc/Hole/H = new
											H.loc = S.loc
											del(S)
										del(Z)
										del(src)
									else
										range(src) << "<font color = red>[src] makes a loud noise as [usr] damages it!<br>"
									return
								else
									range(src) << "<font color = red>[src] makes a loud noise as [usr] tried to damage it!<br>"
									return
							else
								if(usr)
									usr.MovementCheck()
						return
		SewerGrate
			name = "Sewer Grate"
			icon = 'terrain.dmi'
			icon_state = "sewer entrance"
			Type = "Sewer"
			suffix = "Stuck"
			New()
				spawn(1)
					if(src.z == 2)
						src.GoesTo = locate(src.x,src.y,src.z - 1)
					if(src.z == 1)
						src.GoesTo = locate(src.x,src.y,src.z + 2)
			Click()
				if(usr.Dead)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
				if(usr.Function == "Interact" && usr.Fainted == 0)
					if(src in range(1,usr))
						view(usr) << "<font color = yellow>[usr] lifts up the [src] and climbs down!<br>"
						usr.loc = src.GoesTo
						usr.overlays -= /obj/Misc/Bubbles/
						usr.overlays -= /obj/Misc/Swim/
						usr.InWater = 0
		RailTracks
			icon = 'tools.dmi'
			icon_state = "tracks"
			suffix = "Stuck"
		HoleUp
			name = "Hole"
			icon = 'terrain.dmi'
			icon_state = "hole2"
			suffix = "Stuck"
			New()
				spawn(1)
					if(src.z == 1)
						src.GoesTo = locate(src.x,src.y,src.z + 1)
					if(src.z == 3)
						src.GoesTo = locate(src.x,src.y,src.z - 2)
			Click()
				if(usr.Dead)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
						usr.overlays -= /obj/Misc/Bubbles/
						usr.overlays -= /obj/Misc/Swim/
						usr.InWater = 0
				if(usr.Function == "Interact" && usr.Fainted == 0)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
		HoleDown
			name = "Hole"
			icon = 'terrain.dmi'
			icon_state = "hole"
			suffix = "Stuck"
			New()
				spawn(1)
					if(src.z == 2)
						src.GoesTo = locate(src.x,src.y,src.z - 1)
					if(src.z == 1)
						src.GoesTo = locate(src.x,src.y,src.z + 2)
			Click()
				if(usr.Dead)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
						usr.overlays -= /obj/Misc/Bubbles/
						usr.overlays -= /obj/Misc/Swim/
						usr.InWater = 0
				if(usr.Function == "Interact" && usr.Fainted == 0)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
						usr.overlays -= /obj/Misc/Bubbles/
						usr.overlays -= /obj/Misc/Swim/
						usr.InWater = 0
		Marker
			icon = 'misc.dmi'
			icon_state = "marker"
			New()
				spawn(9)
					src.RandomItem()
		Hole
			name = "Hole"
			icon = 'Hole.dmi'
			icon_state = "hole"
			suffix = "Stuck"
			density = 1
			Type = "Hole"
			New()
				spawn(1)
					if(src.z == 2)
						src.GoesTo = locate(src.x,src.y,src.z - 1)
					if(src.z == 1)
						src.GoesTo = locate(src.x,src.y,src.z + 2)
			Click()
				if(src in range(1,usr))
					if(usr.Dead)
						if(src in range(1,usr))
							usr.loc = src.GoesTo
					if(usr.Function == "Interact" && usr.Job == null)
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Type != "Shovel")
								if(O.Type != "LargeBrick")
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									usr << "<font color = red>You need Four Large Bricks in order to create stone stairs!<br>"
									return
								var/BrickNum = 0
								var/Bricks = list()
								for(var/obj/Items/Resources/LargeBrick/B in usr)
									if(BrickNum != 4)
										BrickNum += 1
										Bricks += B
								if(BrickNum != 4)
									usr << "<font color = red>You need Four Large Bricks in order to create stone stairs!<br>"
									return
								if(BrickNum == 4 && O.Type == "LargeBrick")
									var/LOC = usr.loc
									usr.Job = "CreateStoneStair"
									usr.CanMove = 0
									var/Time = 300 - usr.MasonarySkill * 1.5 - usr.Strength / 2 - usr.Intelligence
									if(Time <= 50)
										Time = 50
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									for(var/obj/HUD/B in usr.client.screen)
										if(B.Type == "Inventory")
											B.icon_state = "inv off"
									view(usr) << "<font color = yellow>[usr] begins to contruct the Large Bricks into a stone stairs!<br>"
									spawn(Time)
										if(usr)
											if(Bricks && usr.loc == LOC)
												BrickNum = 0
												Bricks = null
												Bricks = list()
												for(var/obj/Items/Resources/LargeBrick/B in usr)
													if(BrickNum != 4)
														BrickNum += 1
														Bricks += B
												if(BrickNum == 4 && O && usr.Job == "CreateStoneStair")
													var/Fail = prob(50 - usr.MasonarySkill - usr.Strength / 4 - usr.Intelligence / 2)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a stone stairs!<br>"
														for(var/obj/I in Bricks)
															if(BrickNum != 0)
																BrickNum -= 1
																usr.Weight -= I.Weight
																del(I)
														usr.MasonarySkill += usr.MasonarySkillMulti / 2
														usr.BuildingSkill += usr.BuildingSkillMulti / 2
														usr.GainStats(3,"Yes")
														return
													var/obj/Misc/StairsDown/S = new
													S.loc = src.loc
													S.Dura += usr.BuildingSkill
													S.Dura += usr.MasonarySkill
													var/obj/X = new
													if(S.z == 1)
														X.loc = locate(S.x,S.y,3)
													if(S.z == 2)
														X.loc = locate(S.x,S.y,1)
													var/CanPlace = 1
													for(var/obj/Q in X.loc)
														if(Q.GoesTo)
															CanPlace = 0
													if(CanPlace)
														var/obj/Misc/StairsUp/D = new
														D.loc = X.loc
													del(X)
													for(var/obj/I in Bricks)
														if(BrickNum != 0)
															BrickNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.MasonarySkill += usr.MasonarySkillMulti
													usr.BuildingSkill += usr.BuildingSkillMulti
													usr.GainStats(2,"Yes")
													view(usr) << "<font color = yellow>[usr] finishes creating a stone stairs!<br>"
													del(src)
													return
												else
													usr << "<font color = red>Large Bricks could not be found in your inventory, crafting failed!<br>"
													usr.Job = null
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>Large Bricks could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
									return
					if(usr.Function == "Interact")
						switch(alert("Climb down Hole or Fill in?",,"Cancel","Climb Down","Fill"))
							if("Climb Down")
								if(src in range(1,usr))
									if(usr.Fainted == 0 && usr.Stunned == 0)
										view(6,usr) << "<font color = yellow>[usr] climbs down the Hole carefully.<br>"
										usr.loc = src.GoesTo
									return
							if("Fill")
								if(usr.Job == "Fill")
									return
								var/obj/O = null
								if(usr.Ref)
									O = usr.Ref
								var/Dig = 0
								if(O)
									if(O.Type == "Shovel")
										Dig = 1
								if(usr.Race == "Ratling")
									Dig = 1
								if(Dig)
									if(src in range(1,usr))
										view() << "<font color=yellow>[usr] begins to fill in the Hole!<br>"
										usr.Job = "Fill"
										usr.CanMove = 0
										var/Time = 300 - usr.MiningSkill * 2
										if(Time <= 50)
											Time = 50
										spawn(Time)
											if(usr)
												if(src in range(1,usr))
													if(usr.Job == "Fill" && usr.CantDoTask == 0)
														usr.Job = null
														usr.MiningSkill += usr.MiningSkillMulti / 2
														usr.GainStats(3)
														view() << "<font color=yellow>[usr] finishes filling in the Hole!<br>"
														usr.MovementCheck()
														if(O)
															O.Dura -= rand(0.5,1)
															usr.CheckWeaponDura(O)
														usr.CheckHole(src,"Fill")
														del(src)
								else
									usr << "<font color = red>You'll need to Interact with a Shovel to fill this Hole in!<br>"
									return
		SandStoneStairsDown
			name = "Stairs"
			icon = 'terrain.dmi'
			icon_state = "sand stairs down"
			suffix = "Stuck"
			New()
				spawn(1)
					if(src.z == 2)
						src.GoesTo = locate(src.x,src.y,src.z - 1)
					if(src.z == 1)
						src.GoesTo = locate(src.x,src.y,src.z + 2)
			Click()
				if(usr.Dead)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
				if(usr.Function == "Interact" && usr.Fainted == 0)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
						usr.overlays -= /obj/Misc/Bubbles/
						usr.overlays -= /obj/Misc/Swim/
						usr.InWater = 0
				if(usr.Function == "Combat" && src.suffix == "Stuck" && usr.Job == null)
					if(usr in range(1,src))
						if(usr.CantDoTask)
							usr << "<font color = red>Cant attack that for a while!<br>"
							return
						view(usr) << "<font color = red>[usr] begins an attempt at breaking the [src]!<br>"
						usr.Job = "SmashStair"
						usr.CanMove = 0
						usr.CantDoTask = 1
						spawn(150)
							if(usr)
								usr.CantDoTask = 0
						var/LOC = usr.loc
						var/Time = 300 - usr.Agility / 2
						if(Time <= 50)
							Time = 50
						spawn(Time)
							if(usr && src && usr.loc == LOC && usr.Job == "SmashStair" && src.suffix == "Stuck")
								var/DMG = usr.Strength
								var/Holding = 0
								if(usr.Weapon)
									Holding += 1
									var/obj/W = usr.Weapon
									if(W.ObjectTag == "Weapon")
										DMG += W.Weight / 2
										DMG += rand(W.Dura / 2,W.Dura)
										W.Dura -= rand(0.1,2)
										if(W.ObjectType == "Blunt")
											DMG += 10
										if(W.TwoHander && usr.Weapon2 == null)
											DMG += W.Weight / 2
										usr.CheckWeaponDura(W)
								if(usr.Weapon2)
									Holding += 2
									var/obj/W = usr.Weapon2
									if(W.ObjectTag == "Weapon")
										DMG += W.Weight / 2
										DMG += rand(W.Dura / 2,W.Dura)
										W.Dura -= rand(0.1,2)
										if(W.ObjectType == "Blunt")
											DMG += 10
										if(W.TwoHander && usr.Weapon == null)
											DMG += W.Weight / 2
										usr.CheckWeaponDura(W)
								if(Holding == 2)
									DMG = DMG / 1.5
								usr.DetermineWeaponSkill()
								if(usr.CurrentSkillLevel)
									DMG = DMG + usr.CurrentSkillLevel / 4
								usr.Job = null
								usr.MovementCheck()
								var/WontDamage = 75 - DMG
								var/CantDamage = prob(WontDamage)
								if(DMG >= 0 && CantDamage != 1)
									src.Dura -= DMG
									if(src.Dura <= 0)
										range(src) << "<font color = red>[src] begins to crumble and fall away as [usr] smashes it!<br>"
										var/obj/Z = new
										if(src.z == 1)
											Z.loc = locate(src.x,src.y,2)
										if(src.z == 3)
											Z.loc = locate(src.x,src.y,1)
										for(var/obj/Misc/StairsDown/S in range(0,Z))
											var/obj/Misc/Hole/H = new
											H.loc = S.loc
											del(S)
										del(Z)
										del(src)
									else
										range(src) << "<font color = red>[src] makes a loud noise as [usr] damages it!<br>"
									return
								else
									range(src) << "<font color = red>[src] makes a loud noise as [usr] tried to damage it!<br>"
									return
							else
								if(usr)
									usr.MovementCheck()
						return
		StairsDown
			name = "Stairs"
			icon = 'terrain.dmi'
			icon_state = "stairs down"
			suffix = "Stuck"
			Dura = 300
			New()
				spawn(1)
					if(src.z == 2)
						src.GoesTo = locate(src.x,src.y,src.z - 1)
					if(src.z == 1)
						src.GoesTo = locate(src.x,src.y,src.z + 2)
			Click()
				if(usr.Dead)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
				if(usr.Function == "Interact" && usr.Fainted == 0)
					if(src in range(1,usr))
						usr.loc = src.GoesTo
						usr.overlays -= /obj/Misc/Bubbles/
						usr.overlays -= /obj/Misc/Swim/
						usr.InWater = 0
				if(usr.Function == "Combat" && src.suffix == "Stuck" && usr.Job == null)
					if(usr in range(1,src))
						if(usr.CantDoTask)
							usr << "<font color = red>Cant attack that for a while!<br>"
							return
						view(usr) << "<font color = red>[usr] begins an attempt at breaking the [src]!<br>"
						usr.Job = "SmashStair"
						usr.CanMove = 0
						usr.CantDoTask = 1
						spawn(150)
							if(usr)
								usr.CantDoTask = 0
						var/LOC = usr.loc
						var/Time = 300 - usr.Agility / 2
						if(Time <= 50)
							Time = 50
						spawn(Time)
							if(usr && src && usr.loc == LOC && usr.Job == "SmashStair" && src.suffix == "Stuck")
								var/DMG = usr.Strength
								var/Holding = 0
								if(usr.Weapon)
									Holding += 1
									var/obj/W = usr.Weapon
									if(W.ObjectTag == "Weapon")
										DMG += W.Weight / 2
										DMG += rand(W.Dura / 2,W.Dura)
										W.Dura -= rand(0.1,2)
										if(W.ObjectType == "Blunt")
											DMG += 10
										if(W.TwoHander && usr.Weapon2 == null)
											DMG += W.Weight / 2
										usr.CheckWeaponDura(W)
								if(usr.Weapon2)
									Holding += 2
									var/obj/W = usr.Weapon2
									if(W.ObjectTag == "Weapon")
										DMG += W.Weight / 2
										DMG += rand(W.Dura / 2,W.Dura)
										W.Dura -= rand(0.1,2)
										if(W.ObjectType == "Blunt")
											DMG += 10
										if(W.TwoHander && usr.Weapon == null)
											DMG += W.Weight / 2
										usr.CheckWeaponDura(W)
								if(Holding == 2)
									DMG = DMG / 1.5
								usr.DetermineWeaponSkill()
								if(usr.CurrentSkillLevel)
									DMG = DMG + usr.CurrentSkillLevel / 4
								usr.Job = null
								usr.MovementCheck()
								var/WontDamage = 75 - DMG
								var/CantDamage = prob(WontDamage)
								if(DMG >= 0 && CantDamage != 1)
									src.Dura -= DMG
									if(src.Dura <= 0)
										range(src) << "<font color = red>[src] begins to crumble and fall away as [usr] smashes it!<br>"
										var/obj/Z = new
										if(src.z == 1)
											Z.loc = locate(src.x,src.y,3)
										if(src.z == 3)
											Z.loc = locate(src.x,src.y,2)
										for(var/obj/Misc/StairsUp/S in range(0,Z))
											del(S)
										var/obj/Misc/Hole/H = new
										H.loc = src.loc
										del(Z)
										del(src)
									else
										range(src) << "<font color = red>[src] makes a loud noise as [usr] damages it!<br>"
									return
								else
									range(src) << "<font color = red>[src] makes a loud noise as [usr] tried to damage it!<br>"
									return
							else
								if(usr)
									usr.MovementCheck()
						return
		SpellEffects
			icon = 'fx.dmi'
			AstralShield
				icon_state = "astral shield"
				layer = 7
			Dispel
				icon_state = "dispel"
			Evil
				icon_state = "evil"
		OtherWorldly
			AstralStrand
				icon = 'terrain.dmi'
				icon_state = "astral strand"
				New()
					var/D = rand(1,4)
					if(D == 1)
						src.dir = NORTH
					if(D == 2)
						src.dir = SOUTH
					if(D == 3)
						src.dir = EAST
					if(D == 4)
						src.dir = WEST
			AstralStrands
				icon = 'terrain.dmi'
				icon_state = "astral strands"
				New()
					var/D = rand(1,8)
					if(D == 1)
						src.dir = NORTH
					if(D == 2)
						src.dir = SOUTH
					if(D == 3)
						src.dir = EAST
					if(D == 4)
						src.dir = WEST
					if(D == 5)
						src.dir = NORTHWEST
					if(D == 6)
						src.dir = NORTHEAST
					if(D == 7)
						src.dir = SOUTHWEST
					if(D == 8)
						src.dir = SOUTHEAST
			ChaosEnergy
				icon = 'fx.dmi'
				icon_state = "chaos energy"
				layer = 5
				New()
					MoveRand()
					spawn(30)
						if(src)
							del(src)
		Smoke
			icon = 'fx.dmi'
			icon_state = "smoke"
			layer = 7
			New()
				src.dir = NORTH
				MoveRand()
				spawn(30)
					if(src)
						del(src)
		Gates
			AstralGate
				icon = 'fx.dmi'
				icon_state = "astral gate"
				luminosity = 3
				suffix = "Stuck"
				New()
					spawn(300)
						if(src)
							view(6,src) << "<font color = yellow>[src] slams shut and vanishes!<br>"
							del(src)
				Click()
					if(usr.Function == "Interact")
						if(src.GoesTo && usr.Fainted == 0)
							view(6,usr) << "<font color = yellow>[usr] enters the [src]!<br>"
							usr.loc = src.GoesTo
							view(6,usr) << "<font color = yellow>[usr] appears from the [src]!<br>"
							usr.overlays -= /obj/Misc/Bubbles/
							usr.overlays -= /obj/Misc/Swim/
							usr.InWater = 0
							return
			ChaosGate
				icon = 'fx.dmi'
				icon_state = "chaos gate"
				suffix = "Stuck"
				New()
					spawn(1)
						src.ChaosGate()
						src.CreateChaos()
			BloodGate
				icon = 'fx.dmi'
				icon_state = "blood portal"
				suffix = "Stuck"
		Target
			icon = 'Target.dmi'
			pixel_y = 32
			layer = 10
		Target
			icon = 'target.dmi'
			layer = 10
		Swim
			icon = 'terrain.dmi'
			icon_state = "swim"
			layer = 10
		Bubbles
			icon = 'terrain.dmi'
			icon_state = "bubbles"
			layer = 10
			pixel_y = 32
		Fire
			icon = 'fx.dmi'
			icon_state = "burning"
			layer = 5
		FireLarge
			icon = 'fx.dmi'
			icon_state = "fire"
			layer = 4
		LiquidSplatter
			icon = 'ingredients.dmi'
			icon_state = "liquid splatter"
			layer = 4
			New()
				spawn(3000)
					if(src)
						del(src)
		Sleeping
			icon = 'misc.dmi'
			icon_state = "sleep"
			layer = 5
		Gore
			icon = 'gore.dmi'
			FleshBeastCorpse
				icon = 'corpses.dmi'
				icon_state = "flesh beast corpse right"
				pixel_x = 32
			DrakeCorpse
				icon = 'corpses.dmi'
				icon_state = "drake corpse right"
				pixel_x = 32
			TrollCorpse
				icon = 'corpses.dmi'
				icon_state = "troll corpse right"
				pixel_x = 32
			YetiCorpse
				icon = 'corpses.dmi'
				icon_state = "yeti corpse right"
				pixel_x = 32
			GiantSnakeCorpse
				icon = 'corpses.dmi'
				icon_state = "giant snake corpse right"
				pixel_x = 32
			HeadWound
				icon_state = "damage head"
				layer = 4
			TorsoWound
				icon_state = "damage torso"
				layer = 4
			RightArmWound
				icon_state = "damage rarm"
				layer = 4
			LeftArmWound
				icon_state = "damage larm"
				layer = 4
			RightLegWound
				icon_state = "damage rleg"
				layer = 4
			LeftLegWound
				icon_state = "damage lleg"
				layer = 4
			BloodSplat
				icon_state = "floor small1"
				suffix = "Stuck"
				Click()
					if(src in range(1,usr))
						if(usr.Function == "Interact")
							view(usr) << "<b>[usr] wipes away some blood!<br>"
							del(src)
							return
				New()
					var/I = rand(1,5)
					src.icon_state = "floor small[I]"
					spawn(10000)
						if(src)
							del(src)
			GreenBloodSplat
				icon_state = "green floor1"
				suffix = "Stuck"
				Click()
					if(src in range(1,usr))
						if(usr.Function == "Interact")
							view(usr) << "<b>[usr] wipes away some blood!<br>"
							del(src)
							return
				New()
					var/I = rand(1,5)
					src.icon_state = "green floor[I]"
					spawn(10000)
						if(src)
							del(src)
			BloodTrail
				icon_state = "blood trail"
				suffix = "Stuck"
				Click()
					if(src in range(1,usr))
						if(usr.Function == "Interact")
							view(usr) << "<b>[usr] wipes away some blood!<br>"
							del(src)
							return
				New()
					spawn(2000)
						if(src)
							del(src)
			BloodPuddle
				icon_state = "floor puddle"
				suffix = "Stuck"
				Click()
					if(src in range(1,usr))
						if(usr.Function == "Interact")
							view(usr) << "<b>[usr] wipes away some blood!<br>"
							del(src)
							return
				New()
					spawn(10000)
						if(src)
							del(src)
			Puke
				icon_state = "Puke"
				suffix = "Stuck"
				New()
					spawn(10000)
						if(src)
							del(src)
				Click()
					if(src in range(1,usr))
						if(usr.Function == "Interact")
							view(usr) << "<b>[usr] wipes away some sick!<br>"
							del(src)
							return
			GreenWallBloodSplat
				icon_state = "green wall1"
				suffix = "Stuck"
				Click()
					if(src in range(1,usr))
						if(usr.Function == "Interact")
							view(usr) << "<b>[usr] wipes away some blood!<br>"
							del(src)
							return
				New()
					var/I = rand(1,5)
					src.icon_state = "green wall[I]"
					spawn(10000)
						if(src)
							del(src)
			WallBloodSplat
				icon_state = "wall small1"
				suffix = "Stuck"
				Click()
					if(src in range(1,usr))
						if(usr.Function == "Interact")
							view(usr) << "<b>[usr] wipes away some blood!<br>"
							del(src)
							return
				New()
					var/I = rand(1,5)
					src.icon_state = "wall small[I]"
					spawn(10000)
						if(src)
							del(src)
			WallBloodSplatLarge
				suffix = "Stuck"
				icon_state = "wall"
		Weather
			icon = 'fx.dmi'
			Night
				layer = 10
				icon_state = "night"
			Rain
				layer = 10
				icon_state = "rain"
			Snow
				layer = 10
				icon_state = "snow"
			LighteningBolt
				layer = 10
				icon_state = "lighteningbolt"
			LighteningHit
				layer = 10
				icon_state = "lighteninghit"
				luminosity = 5
				New()
					var/obj/Misc/Weather/LighteningBolt/LB = new
					LB.pixel_y = 32
					src.overlays += LB

					var/obj/Misc/Weather/LighteningBolt/LB2 = new
					LB2.pixel_y = 64
					src.overlays += LB2
					spawn(10)
						if(src)
							del(src)
		Admins
		Languages
			Common
				name = "Common"
			Ancient
				name = "Ancient"
			Demonic
				name = "Demonic"
			DarkTongue
				name = "DarkTongue"
			Human
				name = "Human"
			Altherian
				name = "Altherian"
			Stahliteian
				name = "Stahliteian"
			Slithus
				name = "Slithus"
			Wolfen
				name = "Wolfen"
			Scutter
				name = "Scutter"
			Ribbitus
				name = "Ribbitus"
		Beards
			icon = 'hair.dmi'
			layer = 4.9
			StahliteBeard
				icon_state = "dwarf beard 1"
			HumanoidBeard
				icon_state = "beard 1"
		Hairs
			icon = 'hair.dmi'
			layer = 4.8
			HairLeft
				icon_state = "side L 1"
			HairRight
				icon_state = "side R 1"
			Middle
				icon_state = "middle 1"
			PotHead
				icon_state = "pot head 1"
			Long
				icon_state = "long hair 1"
			GiantHairMale
				icon_state = "giant hair male 1"
			GiantHairFemale
				icon_state = "giant hair female 1"
			SmallHairFemale
				icon_state = "small hair female 1"
		CombatOverlays
			icon = 'fx.dmi'
			pixel_y = 32
			Hit
				icon_state = "Hit"
				layer = 8
			Block
				icon_state = "Block"
				layer = 8
			Dodge
				icon_state = "Dodge"
				layer = 8
			Head
				icon_state = "Head"
				layer = 8
			Torso
				icon_state = "Torso"
				layer = 8
			LeftLeg
				icon_state = "L Leg"
				layer = 8
			RightLeg
				icon_state = "R Leg"
				layer = 8
			RightArm
				icon_state = "R Arm"
				layer = 8
			LeftArm
				icon_state = "L Arm"
				layer = 8
