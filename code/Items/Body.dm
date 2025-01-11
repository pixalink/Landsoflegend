obj
	Items
		Body
			Fuel = 90
			New()
				spawn(30000)
					if(src && src.Owner == null)
						var/obj/Items/Misc/Bones/B = new
						B.loc = src.loc
						B.name = "[src]'s Bones"
						var/obj/Items/Misc/Skull/S = new
						S.loc = src.loc
						S.name = "[src]'s Bones"
						del(src)
			Click()
				if(usr.Function == "Interact")
					if(src in range(1,usr))
						var/obj/R = null
						if(usr.Ref)
							R = usr.Ref
						if(R == null && usr.Claws <= 1)
							usr << "<font color = red>You'll need to Interact with a weapon before butchering.<br>"
							return
						var/CanSkin = 0
						if(usr.Claws)
							CanSkin = 1
						if(R)
							if(R.ObjectType == "Dagger")
								if(src.icon == 'Skeleton.dmi')
									usr << "<font color = red>Theres no skin on this corpse!<br>"
									return
								if(R.suffix != "Equip")
									usr << "<font color = red>Equip the dagger first before trying to skin anything!<br>"
									return
								if(R.Dura <= 1)
									usr << "<font color = red>This dagger is broken, you cant use it for skinning!!<br>"
									return
								CanSkin = 1
							else
								CanSkin = 0
						if(CanSkin)
							if(src.Skinned == 0)
								if(usr.Dead == 0 && usr.Job == null)
									var/Loc = usr.loc
									if(usr.Fainted == 0 && usr.Stunned == 0)
										if(R)
											view(usr) << "<font color=yellow>[usr] begins to skin [src] using a [R]!<br>"
										else
											view(usr) << "<font color=yellow>[usr] begins to skin [src] using their claws!<br>"
										usr.Job = "Skin"
										usr.CanMove = 0
										var/Time = 250
										Time -= usr.SkinningSkill * 2
										if(Time <= 25)
											Time = 25
										spawn(Time)
											if(usr)
												usr.MovementCheck()
												if(src)
													if(usr.loc == Loc)
														if(usr.Job == "Skin")
															usr.Job = null
															usr.SkinningSkill += usr.SkinningSkillMulti
															src.icon += rgb(200,0,0)
															src.Skinned = 1
															var/obj/Items/Resources/Skin/S = new
															if(src.Humanoid && src.Race)
																S.icon_state = "[src.Race] skin"
															else
																S.icon_state = "Leather Hide"
															S.name = "[src.Race] Hide"
															S.loc = src.loc
															S.CraftPotential += rand(1,10)
															S.CraftPotential += usr.SkinningSkill / 2
															if(S.CraftPotential >= 100)
																S.CraftPotential = 100
															S.CreateLeather()
															view(6,usr) << "<font color =yellow>[usr] finishes skinning [src]!<br>"
															return
													else
														usr << "<font color=red>You moved from the position you were skinning at, you failed the job!<br>"
														usr.MovementCheck()
														return
						var/CanButcher = 0
						if(usr.Claws)
							CanButcher = 1
						if(R)
							if(R.Type == "PickAxe")
								CanButcher = 0
							if(R.ObjectType == "Axe")
								CanButcher = 1
							if(R.ObjectType == "Sword")
								CanButcher = 1
						if(CanButcher && usr.Job != "Skin")
							if(src.icon == 'Skeleton.dmi')
								usr << "<font color = red>Theres no meat on this corpse!<br>"
								return
							if(R)
								if(R.suffix != "Equip")
									usr << "<font color = red>Equip a weapon first before trying to butcher anything!<br>"
									return
								if(R.Dura <= 1)
									usr << "<font color = red>This weapon is broken, you cant use it for butchery!!<br>"
									return
							if(usr.Dead == 0 && usr.Job == null)
								var/Loc = usr.loc
								if(usr.Fainted == 0 && usr.Stunned == 0)
									var/Result
									if(src.Humanoid)
										var/list/menu = new()
										if(src.RightArm)
											menu += "Right Arm"
										if(src.LeftArm)
											menu += "Left Arm"
										if(src.LeftLeg && src.Race != "Snakeman")
											menu += "Left Leg"
										if(src.RightLeg && src.Race != "Snakeman")
											menu += "Right Leg"
										if(src.Butchered == 0)
											menu += "Body"
										menu += "None"
										Result = input("Which part of the corpse do you want to butcher?", "Choose", null) in menu
									else
										Result = "Body"
									if(Result != "None")
										if(src in range(1,usr))
											if(R)
												view(usr) << "<font color=yellow>[usr] begins to butcher [src]'s [Result] using a [R]!<br>"
											else
												view(usr) << "<font color=yellow>[usr] begins to butcher [src]'s [Result] using their claws!<br>"
											usr.Job = "Butcher"
											usr.CanMove = 0
											var/Time = 250
											Time -= usr.ButcherySkill * 2
											if(Time <= 25)
												Time = 25
											spawn(Time)
												if(usr)
													usr.MovementCheck()
													if(src)
														if(usr.loc == Loc)
															if(usr.Job == "Butcher")
																usr.Job = null
																usr.ButcherySkill += usr.ButcherySkillMulti
																if(Result == "Right Arm" && src.RightArm)
																	var/obj/Items/Limb/L = new
																	L.icon = src.icon
																	L.icon_state = "limb"
																	L.name = "[src.Race]'s RightArm"
																	L.loc = src.loc
																	src.RightArm = 0
																if(Result == "Left Arm" && src.LeftArm)
																	var/obj/Items/Limb/L = new
																	L.icon = src.icon
																	L.icon_state = "limb"
																	L.name = "[src.Race]'s LeftArm"
																	L.loc = src.loc
																	src.LeftArm = 0
																if(Result == "Left Leg" && src.LeftLeg)
																	var/obj/Items/Limb/L = new
																	L.icon = src.icon
																	L.icon_state = "limb"
																	L.name = "[src.Race]'s LeftLeg"
																	L.loc = src.loc
																	src.LeftLeg = 0
																if(Result == "Right Leg" && src.RightLeg)
																	var/obj/Items/Limb/L = new
																	L.icon = src.icon
																	L.icon_state = "limb"
																	L.name = "[src.Race]'s RightLeg"
																	L.loc = src.loc
																	src.RightLeg = 0
																if(src.BloodColour == /obj/Misc/Gore/BloodSplat/)
																	var/obj/Misc/Gore/BloodPuddle/P = new
																	P.loc = src.loc
																if(src.BloodColour == /obj/Misc/Gore/GreenBloodSplat/)
																	var/obj/Misc/Gore/GreenBloodSplat/G = new
																	G.loc = src.loc
																src.LimbLoss()
																view(6,usr) << "<font color =yellow>[usr] finishes butchering [src]!<br>"
																if(Result == "Body" && src.Butchered == 0)
																	var/obj/Items/Misc/Bones/B = new
																	B.name = "[src.Race] Bones"
																	B.loc = src.loc
																	var/obj/Items/Misc/Skull/S = new
																	S.name = "[src.Race] Skull"
																	S.loc = src.loc
																	if(src.Brain)
																		var/obj/Items/Foods/Brain/Br = new
																		Br.loc = src.loc
																		Br.name = "[src.Race]'s Brain"
																	if(src.Spleen)
																		var/obj/Items/Foods/Spleen/Sp = new
																		Sp.loc = src.loc
																		Sp.name = "[src.Race]'s Spleen"
																	if(src.Intestine)
																		var/obj/Items/Foods/Intestines/I = new
																		I.loc = src.loc
																		I.name = "[src.Race]'s Intestines"
																	if(src.LeftKidney)
																		var/obj/Items/Foods/Kidney/LK = new
																		LK.loc = src.loc
																		LK.name = "[src.Race]'s LeftKidney"
																	if(src.RightKidney)
																		var/obj/Items/Foods/Kidney/RK = new
																		RK.loc = src.loc
																		RK.name = "[src.Race]'s RightKidney"
																	if(src.Heart)
																		var/obj/Items/Foods/Heart/H = new
																		H.loc = src.loc
																		H.name = "[src.Race]'s Heart"
																	var/Meat = rand(2,4)
																	while(Meat)
																		Meat -= 1
																		var/obj/Items/Foods/RawMeatChunck/M = new
																		M.loc = src.loc
																		M.name = "[src.Race] Chunk"
																	del(src)
														else
															usr << "<font color=red>You moved from the position you were butchering at, you failed the job!<br>"
															usr.MovementCheck()
															return
				if(usr.Function == "Eat")
					if(usr.Dead)
						return
					if(src in range(1,usr))
						if(usr.CanEatBodies)
							if(usr.Hunger <= 33)
								view(usr) << "<font color = purple>[usr] grabs hold of [src] and begins to pull bits off, they then start to eat the pieces until all that remains are bones...<br>"
								if(src.BloodColour == /obj/Misc/Gore/BloodSplat/)
									var/obj/Misc/Gore/BloodPuddle/P = new
									P.loc = src.loc
								if(src.BloodColour == /obj/Misc/Gore/GreenBloodSplat/)
									var/obj/Misc/Gore/GreenBloodSplat/G = new
									G.loc = src.loc
								var/obj/Items/Misc/Bones/B = new
								B.name = "[src] Bones"
								B.loc = src.loc
								var/obj/Items/Misc/Skull/S = new
								S.name = "[src] Skull"
								S.loc = src.loc
								if(usr.Faction == "Undead")
									if(src.Humanoid)
										S.SkeletonRaise()
								usr.Hunger += 47
								usr.GainStats(2)
								if(usr.Hunger >= 100)
									usr.Hunger = 100
								del(src)
								return
							else
								usr << "<font color = red>You dont feel quite hungry enough to eat an entire corpse! (33 Hunger needed.)<br>"
								return
				if(usr.Function == "Pull")
					if(src in range(1,usr))
						if(usr.Pull == src)
							usr.Pull = null
							if(src.Pull == usr)
								src.Pull = null
							view(usr) << "<b>[usr] stops pulling [src]<br>"
							return
						if(src.suffix == null)
							if(usr.Pull == null)
								usr.Pull = src
								src.Pull = usr
								usr.Pull()
								if(usr.Dead == 0)
									view(usr) << "<b>[usr] starts pulling [src]<br>"
								return
