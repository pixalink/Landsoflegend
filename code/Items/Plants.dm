obj
	proc
		Rot()
			spawn(2000)
				if(src)
					view(src) << "<font color = yellow>The stump rots and falls apart!<br>"
					src.icon = null
					src.Fuel = 0

	Items
		Plants
			icon = 'plants.dmi'
			suffix = "Stuck"
			DeadTree2
				name = "Tree"
				icon_state = "trunk2"
				density = 1
				Type = "Tree"
				Fuel = 100
				opacity = 0
				desc = "This is a small tree, it can be cut down or stripped of leaves using various tools.<br>"
				Click()
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						return
					if(usr.Function == "Interact")
						if(src in range(1,usr))
							if(src.density)
								if(usr.Weapon)
									var/obj/W = usr.Weapon
									if(W.Type == "Hatchet")
										if(usr.Job == null)
											if(src.icon_state == "small stump")
												view(usr) << "<font color = yellow>[usr] hacks a large notch in the side of the stump!<br>"
												src.density = 0
												src.Rot()
												usr.WoodCuttingSkill += usr.WoodCuttingSkillMulti / 3
												usr.GainStats(2.5)
												return
							if(src.opacity == 0)
								return
							if(usr.Weapon)
								var/obj/W = null
								var/CanDo = 0
								if(usr.Weapon)
									W = usr.Weapon
									if(W.Type == "Hatchet")
										CanDo = 1
									else
										W = null
								if(usr.Weapon2 && W == null)
									W = usr.Weapon2
									if(W.Type == "Hatchet")
										CanDo = 1
									else
										W = null
								if(CanDo && W)
									if(usr.Job == null)
										if(W.Dura <= 1)
											usr << "<font color = red>The [W] is Broken, you can not do this job!<br>"
											return
										view(usr) << "<font color=yellow>[usr] begins to chop away at the tree!<br>"
										W.Dura -= rand(0.5,1)
										usr.CheckWeaponDura(W)
										usr.Job = "CutTree"
										usr.CanMove = 0
										var/Time = 300 - usr.WoodCuttingSkill * 2
										if(Time <= 50)
											Time = 50
										spawn(Time)
											if(src)
												if(usr)
													if(src in range(1,usr))
														if(usr.Job == "CutTree" && src.opacity)
															usr.Job = null
															src.icon_state = "small stump"
															src.overlays = null
															src.opacity = 0
															for(var/turf/T in range(0,src))
																Tiles += T
															usr.WoodCuttingSkill += usr.WoodCuttingSkillMulti
															usr.GainStats(3)
															var/obj/Items/Resources/FelledTree2/T = new
															var/DIR = rand(1,2)
															if(DIR == 1)
																T.loc = locate(src.x+1,src.y,src.z)
															if(DIR == 2)
																T.loc = locate(src.x-1,src.y,src.z)
															for(var/mob/M in range(0,T))
																var/WontHit = 0
																WontHit += M.Agility * 2
																if(M == usr)
																	WontHit += usr.WoodCuttingSkill
																var/Misses = prob(WontHit)
																if(Misses)
																	view(M) << "<font color = red>[M] dodges the falling Tree!<br>"
																else
																	view(M) << "<font color = red>The tree falls on [M]!<br>"
																	M.Skull -= 20
																	M.Blood -= 30
																	M.Bleed()
															usr.MovementCheck()
				New()
					spawn(10)
						if(src.icon_state == "trunk2")
							src.overlays += /obj/Items/Plants/Branches/Tree2Branch1/
						for(var/turf/T in locate(src.x,src.y,src.z))
							if(T in Tiles)
								del(src)
			Tree2
				name = "Tree"
				icon_state = "trunk2"
				density = 1
				Type = "Tree"
				Fuel = 100
				opacity = 0
				desc = "This is a small tree, it can be cut down or stripped of leaves using various tools.<br>"
				Click()
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						return
					if(usr.Function == "Interact")
						if(src in range(1,usr))
							if(src.density)
								if(usr.Weapon)
									var/obj/W = usr.Weapon
									if(W.Type == "Hatchet")
										if(usr.Job == null)
											if(src.icon_state == "small stump")
												view(usr) << "<font color = yellow>[usr] hacks a large notch in the side of the stump!<br>"
												src.density = 0
												src.Rot()
												usr.WoodCuttingSkill += usr.WoodCuttingSkillMulti / 3
												usr.GainStats(2.5)
												return
							if(src.opacity == 0)
								return
							var/obj/W = null
							var/CanDo = 0
							if(usr.Weapon)
								W = usr.Weapon
								if(W.Type == "Hatchet")
									CanDo = 1
								else
									W = null
							if(usr.Weapon2 && W == null)
								W = usr.Weapon2
								if(W.Type == "Hatchet")
									CanDo = 1
								else
									W = null
							if(CanDo && W)
								if(usr.Job == null)
									if(W.Dura <= 1)
										usr << "<font color = red>The [W] is Broken, you can not do this job!<br>"
										return
									view(usr) << "<font color=yellow>[usr] begins to chop away at the tree!<br>"
									W.Dura -= rand(0.5,1)
									usr.CheckWeaponDura(W)
									usr.Job = "CutTree"
									usr.CanMove = 0
									var/Time = 300 - usr.WoodCuttingSkill * 2
									if(Time <= 50)
										Time = 50
									spawn(Time)
										if(src && usr)
											if(src in range(1,usr))
												if(usr.Job == "CutTree" && src.opacity)
													usr.Job = null
													src.icon_state = "small stump"
													src.overlays = null
													src.opacity = 0
													for(var/turf/T in range(0,src))
														Tiles += T
													usr.WoodCuttingSkill += usr.WoodCuttingSkillMulti
													usr.GainStats(3)
													var/obj/Items/Resources/FelledTree2/T = new
													var/DIR = rand(1,2)
													if(DIR == 1)
														T.loc = locate(src.x+1,src.y,src.z)
													if(DIR == 2)
														T.loc = locate(src.x-1,src.y,src.z)
													for(var/mob/M in range(0,T))
														var/WontHit = 0
														WontHit += M.Agility * 2
														if(M == usr)
															WontHit += usr.WoodCuttingSkill
														var/Misses = prob(WontHit)
														if(Misses)
															view(M) << "<font color = red>[M] dodges the falling Tree!<br>"
														else
															view(M) << "<font color = red>The tree falls on [M]!<br>"
															M.Skull -= 20
															M.Blood -= 30
															M.Bleed()
													usr.MovementCheck()
				New()
					spawn(10)
						if(src.icon_state == "trunk2")
							src.overlays += /obj/Items/Plants/Branches/Tree2Branch1/
							src.overlays += /obj/Items/Plants/Branches/Tree2Leaves1/
							src.overlays += /obj/Items/Plants/Branches/Tree2Leaves2/
						for(var/turf/T in locate(src.x,src.y,src.z))
							if(T in Tiles)
								del(src)
			BurntTree2
				name = "Tree"
				icon_state = "burnt2"
				density = 1
				Type = "Tree"
				Fuel = 0
				opacity = 0
				New()
					spawn(10)
						if(src.icon_state == "burnt2")
							src.overlays += /obj/Items/Plants/Branches/BurntTree2Branch1/
						for(var/turf/T in locate(src.x,src.y,src.z))
							if(T in Tiles)
								del(src)
			BurntTree1
				name = "Tree"
				icon_state = "burnt1"
				density = 1
				opacity = 0
				Type = "Tree"
				Fuel = 0
				New()
					spawn(10)
						if(src.icon_state == "burnt1")
							src.overlays += /obj/Items/Plants/Branches/BurntTree1Branch1/
							src.overlays += /obj/Items/Plants/Branches/BurntTree1Branch2/
							src.overlays += /obj/Items/Plants/Branches/BurntTree1Branch3/
						for(var/turf/T in locate(src.x,src.y,src.z))
							if(T in Tiles)
								del(src)
			DeadTree1
				name = "Tree"
				icon_state = "trunk1"
				density = 1
				opacity = 0
				Type = "Tree"
				Fuel = 100
				desc = "This is a tree, it can be cut down or stripped of leaves using various tools.<br>"
				Click()
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						return
					if(usr.Function == "Interact")
						if(src in range(1,usr))
							if(src.density)
								if(usr.Weapon)
									var/obj/W = usr.Weapon
									if(W.Type == "Hatchet")
										if(usr.Job == null)
											if(src.icon_state == "big stump")
												view(usr) << "<font color = yellow>[usr] hacks a large notch in the side of the stump, soon it will rot and fall apart.<br>"
												src.density = 0
												src.Rot()
												usr.WoodCuttingSkill += usr.WoodCuttingSkillMulti / 3
												usr.GainStats(2.5)
												return
							if(src.opacity == 0)
								return
							if(usr.Weapon)
								var/obj/W = null
								var/CanDo = 0
								if(usr.Weapon)
									W = usr.Weapon
									if(W.Type == "Hatchet")
										CanDo = 1
									else
										W = null
								if(usr.Weapon2 && W == null)
									W = usr.Weapon2
									if(W.Type == "Hatchet")
										CanDo = 1
									else
										W = null
								if(CanDo && W)
									if(usr.Job == null)
										if(W.Dura <= 1)
											usr << "<font color = red>The [W] is Broken, you can not do this job!<br>"
											return
										view(usr) << "<font color=yellow>[usr] begins to chop away at the tree!<br>"
										W.Dura -= rand(0.5,1)
										usr.CheckWeaponDura(W)
										usr.Job = "CutTree"
										usr.CanMove = 0
										var/Time = 300 - usr.WoodCuttingSkill * 2
										if(Time <= 50)
											Time = 50
										spawn(Time)
											if(src && usr)
												if(src in range(1,usr))
													if(usr.Job == "CutTree" && src.opacity)
														usr.Job = null
														src.icon_state = "big stump"
														src.overlays = null
														for(var/turf/T in range(0,src))
															Tiles += T
														src.opacity = 0
														usr.WoodCuttingSkill += usr.WoodCuttingSkillMulti
														usr.GainStats(3)
														var/obj/Items/Resources/FelledTree/T = new
														var/DIR = rand(1,2)
														if(DIR == 1)
															T.loc = locate(src.x+1,src.y,src.z)
														if(DIR == 2)
															T.loc = locate(src.x-1,src.y,src.z)
														for(var/mob/M in range(0,T))
															var/WontHit = 0
															WontHit += M.Agility * 2
															if(M == usr)
																WontHit += usr.WoodCuttingSkill
															var/Misses = prob(WontHit)
															if(Misses)
																view(M) << "<font color = red>[M] dodges the falling Tree!<br>"
															else
																view(M) << "<font color = red>The tree falls on [M]!<br>"
																M.Skull -= 30
																M.Blood -= 40
																M.Bleed()
														usr.MovementCheck()
				New()
					spawn(10)
						if(src.icon_state == "trunk1")
							src.overlays += /obj/Items/Plants/Branches/Tree1Branch1/
							src.overlays += /obj/Items/Plants/Branches/Tree1Branch2/
							src.overlays += /obj/Items/Plants/Branches/Tree1Branch3/
						for(var/turf/T in locate(src.x,src.y,src.z))
							if(T in Tiles)
								del(src)
			Tree1
				name = "Tree"
				icon_state = "trunk1"
				density = 1
				opacity = 0
				Type = "Tree"
				Fuel = 100
				desc = "This is a tree, it can be cut down or stripped of leaves using various tools.<br>"
				Click()
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						return
					if(usr.Function == "Interact")
						if(src in range(1,usr))
							if(src.density)
								if(usr.Weapon)
									var/obj/W = usr.Weapon
									if(W.Type == "Hatchet")
										if(usr.Job == null)
											if(src.icon_state == "big stump")
												view(usr) << "<font color = yellow>[usr] hacks a large notch in the side of the stump, soon it will rot and fall apart.<br>"
												src.density = 0
												src.Rot()
												usr.WoodCuttingSkill += usr.WoodCuttingSkillMulti / 3
												usr.GainStats(2.5)
												return
							if(src.opacity == 0)
								return
							var/obj/W = null
							var/CanDo = 0
							if(usr.Weapon)
								W = usr.Weapon
								if(W.Type == "Hatchet")
									CanDo = 1
								else
									W = null
							if(usr.Weapon2 && W == null)
								W = usr.Weapon2
								if(W.Type == "Hatchet")
									CanDo = 1
								else
									W = null
							if(CanDo && W)
								if(usr.Job == null)
									if(W.Dura <= 1)
										usr << "<font color = red>The [W] is Broken, you can not do this job!<br>"
										return
									view(usr) << "<font color=yellow>[usr] begins to chop away at the tree!<br>"
									W.Dura -= rand(0.5,1)
									usr.CheckWeaponDura(W)
									usr.Job = "CutTree"
									usr.CanMove = 0
									var/Time = 300 - usr.WoodCuttingSkill * 2
									if(Time <= 50)
										Time = 50
									spawn(Time)
										if(src && usr)
											if(src in range(1,usr))
												if(usr.Job == "CutTree" && src.opacity)
													usr.Job = null
													src.icon_state = "big stump"
													src.overlays = null
													src.opacity = 0
													for(var/turf/T in range(0,src))
														Tiles += T
													usr.WoodCuttingSkill += usr.WoodCuttingSkillMulti
													usr.GainStats(3)
													var/obj/Items/Resources/FelledTree/T = new
													var/DIR = rand(1,2)
													if(DIR == 1)
														T.loc = locate(src.x+1,src.y,src.z)
													if(DIR == 2)
														T.loc = locate(src.x-1,src.y,src.z)
													for(var/mob/M in range(0,T))
														var/WontHit = 0
														WontHit += M.Agility * 2
														if(M == usr)
															WontHit += usr.WoodCuttingSkill
														var/Misses = prob(WontHit)
														if(Misses)
															view(M) << "<font color = red>[M] dodges the falling Tree!<br>"
														else
															view(M) << "<font color = red>The tree falls on [M]!<br>"
															M.Skull -= 40
															M.Blood -= 50
															M.Bleed()
													usr.MovementCheck()

				New()
					spawn(10)
						if(src.icon_state == "trunk1")
							src.overlays += /obj/Items/Plants/Branches/Tree1Branch1/
							src.overlays += /obj/Items/Plants/Branches/Tree1Branch2/
							src.overlays += /obj/Items/Plants/Branches/Tree1Branch3/
							src.overlays += /obj/Items/Plants/Branches/Tree1Leaves1/
							src.overlays += /obj/Items/Plants/Branches/Tree1Leaves2/
							src.overlays += /obj/Items/Plants/Branches/Tree1Leaves3/
							src.overlays += /obj/Items/Plants/Branches/Tree1Leaves4/
							src.overlays += /obj/Items/Plants/Branches/Tree1Leaves5/
							src.overlays += /obj/Items/Plants/Branches/Tree1Leaves6/
						for(var/turf/T in locate(src.x,src.y,src.z))
							if(T in Tiles)
								del(src)
			Bamboo
				icon_state = "bamboo1"
				Fuel = 30
				desc = "This is bamboo.<br>"
				density = 1
				opacity = 0
				New()
					var/I = rand(1,2)
					src.icon_state = "bamboo[I]"
					spawn(10)
						for(var/turf/T in locate(src.x,src.y,src.z))
							if(T.icon_state != "grass")
								if(T.icon_state != "ash floor")
									if(T.icon_state != "dirt")
										if(T.icon_state != "dirt road")
											del(src)
			Plant
				icon_state = "plant1"
				Fuel = 15
				desc = "This is a plant, depending on what type, it might be useful.<br>"
				New()
					spawn(10)
						var/I = rand(1,7)
						src.icon_state = "plant[I]"
						for(var/turf/T in locate(src.x,src.y,src.z))
							if(T in Tiles)
								del(src)
			Bush
				icon_state = "bush1"
				Fuel = 30
				desc = "This is a bush, you might find berries in them.<br>"
				Click()
					if(src in range(1,usr))
						if(usr.Function == "Examine")
							usr << "<font color=teal>[src.desc]"
							return
						if(usr.Function == "Combat")
							if(usr.Dead == 0 && usr.Fainted == 0 && usr.Stunned == 0 && usr.Job == null && usr.CanMove)
								var/HasArms = 1
								if(usr.LeftArm <= 20)
									if(usr.RightArm <= 20)
										HasArms = 0
								if(HasArms)
									view(usr) << "<font color = yellow>[usr] rips up the [src]!<br>"
									del(src)
									return
								else
									usr << "<font color = red>You cant do that with hurt arms!<br>"
									return
						if(usr.Function == "Interact")
							if(usr.Dead == 0)
								if(usr.Job == null)
									var/Loc = usr.loc
									if(usr.Fainted == 0)
										if(usr.Stunned == 0)
											if(src.Type)
												view(usr) << "<font color=yellow>[usr] begins to pick berries from the [src]!<br>"
												usr.Job = "PickBerries"
												usr.CanMove = 0
												var/Time = 150
												Time -= usr.FarmingSkill * 2
												if(Time <= 25)
													Time = 25
												spawn(Time)
													if(src && usr)
														if(usr.loc == Loc)
															if(usr.Job == "PickBerries")
																usr.Job = null
																usr.FarmingSkill += usr.FarmingSkillMulti
																if(src.Type == "RedBerries")
																	var/obj/Items/Foods/RedBerries/R = new
																	R.loc = usr.loc
																if(src.Type == "BlueBerries")
																	var/obj/Items/Foods/BlueBerries/B = new
																	B.loc = usr.loc
																src.Type = null
																src.overlays = null
																usr << "<font color =green>You finish picking berries from the [src]!<br>"
																usr.MovementCheck()
														else
															usr << "<font color=red>You moved from the position you were picking berries at, you failed to get any!<br>"
															usr.MovementCheck()
															return

				New()
					var/I = rand(1,3)
					src.icon_state = "bush[I]"
					var/HasBerries = prob(75)
					if(HasBerries)
						var/Colour = rand(1,2)
						if(Colour == 1)
							src.overlays += /obj/Items/Plants/Berries/RedBerries/
							src.Type = "RedBerries"
						if(Colour == 2)
							src.overlays += /obj/Items/Plants/Berries/BlueBerries/
							src.Type = "BlueBerries"
					spawn(10)
						for(var/turf/T in locate(src.x,src.y,src.z))
							if(T in Tiles)
								del(src)
			Berries
				RedBerries
					layer = 4
					icon_state = "berries1"
				BlueBerries
					layer = 4
					icon_state = "berries3"
			Branches
				BurntTree1Branch1
					layer = 7
					icon_state = "burnt tree 1x2"
					pixel_x = -32
					pixel_y = 32
				BurntTree1Branch2
					layer = 7
					icon_state = "burnt tree 2x2"
					pixel_y = 32
				BurntTree1Branch3
					layer = 7
					icon_state = "burnt tree 3x2"
					pixel_y = 32
					pixel_x = 32
				BurntTree2Branch1
					layer = 7
					icon_state = "burnt tree2 1x2"
					pixel_y = 32
				Tree1Branch1
					layer = 7
					icon_state = "tree 1x2"
					pixel_x = -32
					pixel_y = 32
				Tree1Branch2
					layer = 7
					icon_state = "tree 2x2"
					pixel_y = 32
				Tree1Branch3
					layer = 7
					icon_state = "tree 3x2"
					pixel_y = 32
					pixel_x = 32
				Tree2Branch1
					layer = 7
					icon_state = "tree2 1x2"
					pixel_y = 32
				Tree1Leaves1
					layer = 8
					icon_state = "leaves 1x2"
					pixel_x = -32
					pixel_y = 32
				Tree1Leaves2
					layer = 8
					icon_state = "leaves 2x2"
					pixel_y = 32
				Tree1Leaves3
					layer = 8
					icon_state = "leaves 3x2"
					pixel_y = 32
					pixel_x = 32
				Tree1Leaves4
					layer = 8
					icon_state = "leaves 1x1"
					pixel_x = -32
				Tree1Leaves5
					layer = 8
					icon_state = "leaves 2x1"
				Tree1Leaves6
					layer = 8
					icon_state = "leaves 3x1"
					pixel_x = 32
				Tree2Leaves1
					layer = 8
					icon_state = "leaves2 1x1"
				Tree2Leaves2
					layer = 8
					icon_state = "leaves2 1x2"
					pixel_y = 32
