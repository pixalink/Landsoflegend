obj
	proc
		ForgeBurn(var/Time)
			spawn(Time)
				if(src)
					view(src) << "<font color = yellow>The [src] begins to run out of fuel!<br>"
					src.desc = "This Stone Forge seems to be very low on fuel!<br>"
					spawn(500)
						if(src)
							var/Burn = 0
							for(var/obj/Items/Resources/Coal/C in src)
								Burn += 2000
								del(C)
							for(var/obj/Items/Resources/Charcoal/Ch in src)
								Burn += 500
								del(Ch)
							if(Burn >= 1)
								src.ForgeBurn(Burn)
							else
								view(src) << "<font color = red>The [src] burns out!<br>"
								src.desc = "This Stone Forge seems to have been lit recently, but ran out of fuel!<br>"
								src.icon_state = "forge"
								src.Type = "Not Lit"
								return
		SkeletonRaise()
			spawn(rand(300,600))
				if(src)
					var/Rise = 0
					Rise = prob(50)
					if(Rise == 0)
						return
					if(Rise)
						var/HasBones = null
						for(var/obj/Items/Misc/Bones/B in range(0,src))
							if(B.suffix == null)
								HasBones = B
								break
						if(HasBones)
							view(src) << "<font color =purple>[src] begins to shake violently for a moment. Suddenly all the bones around it begin to animate and turn into an undead skeleton!<br>"
							var/mob/NPC/Evil/Undead/Undead_Skeleton/S = new
							S.loc = src.loc
							S.PickUpObjects()
							del(HasBones)
							del(src)
							return

	Items
		Misc
			Skull
				icon = 'corpses.dmi'
				icon_state = "skull"
				Weight = 1
				Fuel = 15
				Material = "Bone"
				Type = "Skull"
				New()
					src.CraftPotential = rand(50,100)
					spawn(10000)
						if(src)
							if(src.suffix == null)
								del(src)
				Click()
					if(usr.Function == "Interact")
						usr.Ref = src
						usr.MovementCheck()
						if(usr.CanMove)
							usr.CreateBoneMenu(src)
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
					if(usr.Function == "Transfer")
						if(usr.Container)
							var/obj/C = usr.Container
							if(src.suffix == "Carried")
								if(src in C)
									if(C in range(1,usr))
										if(usr.Weight <= usr.WeightMax)
											src.loc = usr
											usr.Weight += src.Weight
											C.Weight -= src.Weight
											usr << "You moved [src] from [C] to your inventory!<br>"
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.CreateInventory()
											usr.CreateContainerContents(C)
											return
										else
											usr << "<b>You are carrying enough already!<br>"
											return
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Container)
									var/obj/C = usr.Container
									if(C in range(1,usr))
										if(C.Weight <= C.WeightMax)
											usr.Weight -= src.Weight
											C.Weight += src.Weight
											src.loc = C
											usr << "You moved [src] from your inventory to [C]!<br>"
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.CreateInventory()
											usr.CreateContainerContents(C)
											return
										else
											usr << "<b>[C] is carrying enough already!<br>"
											return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							src.overlays = null
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							for(var/obj/HUD/Text/T in usr.client.screen)
								if(T.Type == "Weight")
									del(T)
							if(usr.InvenUp)
								usr.Text("Weight",usr,4,15,0,10,"Weight - [usr.Weight]/[usr.WeightMax]")
							usr.Delete("ScrollMiddle","BoxDelete")
							return
						if(usr in range(1,src))
							if(src.suffix == null)
								if(usr.Weight <= usr.WeightMax)
									src.loc = usr
									src.suffix = "Carried"
									usr.Weight += src.Weight
									src.overlays+=image(/obj/HUD/C/)
									if(usr.InvenUp)
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
									view() << "<b>[usr] picks up [src]<br>"
									return
								else
									usr << "<b>You cant carry too much weight!<br>"
									return
							else
								usr << "<b>You cant pick that item up!<br>"
								return
					if(usr.Function == "Combat")
						var/CanCrush = 0
						if(usr.Weapon)
							CanCrush = 1
						if(usr.Claws)
							CanCrush = 1
						if(CanCrush)
							if(src in range(1,usr))
								var/obj/W = usr.Weapon
								if(W.suffix)
									if(W.Dura >= 1)
										view(usr) << "<font color = yellow>[usr] smashes their [W] into the [src]!<br>"
										W.Dura -= rand(0.1,0.5)
										usr.CheckWeaponDura(W)
										del(src)
										return
			Fountain
				icon = 'misc.dmi'
				icon_state = "fountain"
				Material = "Stone"
				density = 1
				CanBeCrafted = 1
				suffix = "Stuck"
				Click()
					if(usr.Job == null && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Type != "LargeBrick")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Four Large Bricks in order to create this item!<br>"
								return
							var/BrickNum = 0
							var/Bricks = list()
							for(var/obj/Items/Resources/LargeBrick/B in usr)
								if(BrickNum != 4)
									BrickNum += 1
									Bricks += B
							if(BrickNum != 4)
								usr << "<font color = red>You need Three Large Bricks in order to create this item!<br>"
								return
							if(BrickNum == 4 && O.Type == "LargeBrick")
								var/LOC = usr.loc
								usr.Job = "CreateStoneFountain"
								usr.CanMove = 0
								var/Time = 200 - usr.MasonarySkill * 1.5 - usr.Strength / 2 - usr.Intelligence
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Large Bricks into a [src] !<br>"
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
											if(BrickNum == 4 && O && usr.Job == "CreateStoneFountain")
												var/Fail = prob(50 - usr.MasonarySkill - usr.Strength / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													for(var/obj/I in Bricks)
														if(BrickNum != 0)
															BrickNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.MasonarySkill += usr.MasonarySkillMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.MasonarySkill * 2
												W.suffix = null
												for(var/obj/I in Bricks)
													if(BrickNum != 0)
														BrickNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.MasonarySkill += usr.MasonarySkillMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
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
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in range(1,usr))
							var/Known = 0
							for(var/obj/Items/F in usr.CreateList)
								if(F.type == src.type)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									var/obj/W = new src.type()
									W.layer = 100
									usr.CreateList += W
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
						return
			Oven
				icon = 'tools.dmi'
				icon_state = "oven"
				density = 1
				Type = "Not Active"
				Material = "Stone"
				CanBeCrafted = 1
				New()
					var/obj/Items/Misc/StoneOvenChimney/C = new
					C.pixel_y = 32
					src.overlays += C
				Click()
					if(usr.Job == null && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Type != "SmallBrick")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Twelve Small Bricks in order to create this item!<br>"
								return
							var/BrickNum = 0
							var/Bricks = list()
							for(var/obj/Items/Resources/Brick/B in usr)
								if(BrickNum != 12)
									BrickNum += 1
									Bricks += B
							if(BrickNum != 12)
								usr << "<font color = red>You need Twelve Small Bricks in order to create this item!<br>"
								return
							if(BrickNum == 12 && O.Type == "SmallBrick")
								var/LOC = usr.loc
								usr.Job = "CreateOven"
								usr.CanMove = 0
								var/Time = 200 - usr.MasonarySkill * 1.5 - usr.Strength / 2 - usr.Intelligence
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Small Bricks into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Bricks && usr.loc == LOC)
											BrickNum = 0
											Bricks = null
											Bricks = list()
											for(var/obj/Items/Resources/Brick/B in usr)
												if(BrickNum != 12)
													BrickNum += 1
													Bricks += B
											if(BrickNum == 12 && O && usr.Job == "CreateOven")
												var/Fail = prob(50 - usr.MasonarySkill - usr.Strength / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													for(var/obj/I in Bricks)
														if(BrickNum != 0)
															BrickNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.MasonarySkill += usr.MasonarySkillMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.MasonarySkill * 2
												for(var/obj/I in Bricks)
													if(BrickNum != 0)
														BrickNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.MasonarySkill += usr.MasonarySkillMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Small Bricks could not be found in your inventory, crafting failed!<br>"
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Small Bricks could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.MovementCheck()
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
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in range(1,usr))
							var/Known = 0
							for(var/obj/Items/F in usr.CreateList)
								if(F.type == src.type)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									var/obj/W = new src.type()
									W.layer = 100
									usr.CreateList += W
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
						return
			StoneOvenChimney
				icon = 'tools.dmi'
				icon_state = "oven chimney"
				density = 1
				Type = "Not Lit"
			StoneForge
				icon = 'tools.dmi'
				icon_state = "forge"
				density = 1
				Type = "Not Lit"
				suffix = "Stuck"
				Material = "Stone"
				CanBeCrafted = 1
				Click()
					if(usr.Function == "Interact")
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						if(src.Type == "Lit")
							if(src in range(1,usr))
								if(usr.Ref)
									var/obj/R = usr.Ref
									if(R.Type == "Ore" && R in usr)
										if(usr.Job == null)
											view(usr) << "<font color=yellow>[usr] places the [R] into the [src] and begins to smelt it into an ingot!!<br>"
											usr.Job = "MakeIngot"
											usr.CanMove = 0
											var/Time = 200 - usr.SmeltingSkill * 2
											if(Time <= 50)
												Time = 50
											spawn(Time)
												if(src && usr)
													if(src in range(1,usr))
														if(usr.Job == "MakeIngot")
															usr.Job = null
															R.loc = src
															usr.Weight -= R.Weight
															var/WontFail = prob(usr.SmeltingSkill + 30)
															if(src.Type != "Lit")
																WontFail = 0
															if(WontFail)
																if(usr.SmeltingSkill <= usr.SkillCap && usr.SmeltingSkill <= WorldSkillsCap)
																	usr.SmeltingSkill += usr.SmeltingSkillMulti
																var/obj/Items/Resources/Ingot/I = new
																I.Material = R.Material
																I.icon_state = "[I.Material] ingot"
																I.name = "[I.Material] ingot"
																I.Weight = R.Weight - 2
																I.CraftPotential = R.CraftPotential
																I.loc = usr.loc
																usr << "<font color = yellow>You sucessfully create an [I] !<br>"
															else
																usr << "<font color = red>You fail to create an ingot!<br>"
																if(usr.SmeltingSkill <= usr.SkillCap && usr.SmeltingSkill <= WorldSkillsCap)
																	usr.SmeltingSkill += usr.SmeltingSkillMulti / 2
																var/MakeMess = prob(50)
																if(MakeMess)
																	var/obj/Items/Resources/Scrap/I = new
																	I.Material = R.Material
																	I.icon_state = "[I.Material] scrap"
																	I.name = "[I.Material] scrap"
																	I.Weight = R.Weight
																	I.CraftPotential = R.CraftPotential / 2
																	I.loc = usr.loc
																	usr << "<font color = red>You create a [I] !<br>"
															usr.MovementCheck()
															del(R)
													else
														usr << "<font color = red>The forge was moved, job failed!<br>"
														usr.MovementCheck()
												else
													if(usr)
														usr << "<font color = red>The [src] was moved, job failed!<br>"
														usr.MovementCheck()
					if(usr.Job == null && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Type != "SmallBrick")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Eight Small Bricks in order to create this item!<br>"
								return
							var/BrickNum = 0
							var/Bricks = list()
							for(var/obj/Items/Resources/Brick/B in usr)
								if(BrickNum != 8)
									BrickNum += 1
									Bricks += B
							if(BrickNum != 8)
								usr << "<font color = red>You need Eight Small Bricks in order to create this item!<br>"
								return
							if(BrickNum == 8 && O.Type == "SmallBrick")
								var/LOC = usr.loc
								usr.Job = "CreateForge"
								usr.CanMove = 0
								var/Time = 200 - usr.MasonarySkill * 1.5 - usr.Strength / 2 - usr.Intelligence
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Small Bricks into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Bricks && usr.loc == LOC)
											BrickNum = 0
											Bricks = null
											Bricks = list()
											for(var/obj/Items/Resources/Brick/B in usr)
												if(BrickNum != 8)
													BrickNum += 1
													Bricks += B
											if(BrickNum == 8 && O && usr.Job == "CreateForge")
												var/Fail = prob(50 - usr.MasonarySkill - usr.Strength / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													for(var/obj/I in Bricks)
														if(BrickNum != 0)
															BrickNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.MasonarySkill += usr.MasonarySkillMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.MasonarySkill * 2
												W.suffix = null
												for(var/obj/I in Bricks)
													if(BrickNum != 0)
														BrickNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.MasonarySkill += usr.MasonarySkillMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Small Bricks could not be found in your inventory, crafting failed!<br>"
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Small Bricks could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.MovementCheck()
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
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in range(1,usr))
							var/Known = 0
							for(var/obj/Items/F in usr.CreateList)
								if(F.type == src.type)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									var/obj/W = new src.type()
									W.layer = 100
									usr.CreateList += W
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
						return
					if(usr.Function == "Interact")
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						if(src.Type == "Lit")
							if(usr.Weapon)
								if(src in range(1,usr))
									var/obj/I = usr.Weapon
									if(I.Type == "Torch")
										view(usr) << "<font color = yellow>[usr] lights their [I] in the [src]!<br>"
										usr.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
										I.CarryState = "torch lit"
										I.EquipState = "torch lit equip"
										I.icon_state = I.EquipState
										I.Type = "Torch Lit"
										I.LightProc(usr)
										usr.overlays+=image(I.icon,I.icon_state,I.ItemLayer)
										return
							if(usr.Weapon2)
								if(src in range(1,usr))
									var/obj/I = usr.Weapon2
									if(I.Type == "Torch")
										view(usr) << "<font color = yellow>[usr] lights their [I] in the [src]!<br>"
										usr.overlays-=image(I.icon,"[I.icon_state] left",I.ItemLayer)
										I.CarryState = "torch lit"
										I.EquipState = "torch lit equip left"
										I.icon_state = I.EquipState
										I.Type = "Torch Lit"
										I.LightProc(usr)
										usr.overlays+=image(I.icon,"[I.icon_state]",I.ItemLayer)
										return
						if(src in range(1,usr))
							if(usr.Ref == null)
								if(usr.Weapon)
									var/obj/I = usr.Weapon
									if(I.Type == "Torch Lit")
										if(src.Type != "Lit")
											var/Burn = 0
											for(var/obj/Items/Resources/Coal/C in src)
												Burn += 2000
												del(C)
											for(var/obj/Items/Resources/Charcoal/Ch in src)
												Burn += 500
												del(Ch)
											if(Burn >= 1)
												src.ForgeBurn(Burn)
												src.icon_state = "forge lit"
												src.Type = "Lit"
												src.desc = "This Stone Forge seems to be burning away nicely<br>"
											view(usr) << "<font color = yellow>[usr] places their [I] into the [src]!<br>"
									return
								if(usr.Weapon2)
									var/obj/I = usr.Weapon2
									if(I.Type == "Torch Lit")
										if(src.Type != "Lit")
											var/Burn = 0
											for(var/obj/Items/Resources/Coal/C in src)
												Burn += 2000
												del(C)
											for(var/obj/Items/Resources/Charcoal/Ch in src)
												Burn += 500
												del(Ch)
											if(Burn >= 1)
												src.ForgeBurn(Burn)
												src.icon_state = "forge lit"
												src.Type = "Lit"
												src.desc = "This Stone Forge seems to be burning away nicely<br>"
											view(usr) << "<font color = yellow>[usr] places their [I] into the [src]!<br>"
									return
							if(usr.Ref)
								var/obj/I = usr.Ref
								var/CanBurn = 0
								if(I.icon_state == "charcoal")
									CanBurn = 1
								if(I.icon_state == "Coal")
									CanBurn = 1
								if(CanBurn)
									view(usr) << "<font color = yellow>[usr] throws [I] into the [src]!<br>"
									I.loc = src
									usr.Weight -= I.Weight
									usr.Ref = null
									if(usr.InvenUp)
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
									return
			Lock
				icon = 'tools.dmi'
				icon_state = "lock"
				Weight = 5
				CanBeCrafted = 1
				BaseMaterial = "Metal"
				Type = "Lock"
				Click()
					if(usr.Job == null && src in usr.CreateList )
						var/obj/NearForge = null
						var/obj/NearAnvil = null
						for(var/obj/Items/Misc/StoneForge/F in range(1,usr))
							if(NearForge == null)
								if(F.Type == "Lit")
									NearForge = F
									break
								else
									usr << "<font color = red>The near by Forge is not lit!<br>"
						for(var/obj/Items/Misc/Anvil/A in range(1,usr))
							NearAnvil = A
						if(usr.Ref && NearForge && NearAnvil)
							var/obj/O = usr.Ref
							if(O.Type == "Ingot")
								usr.Job = "Make Lock"
								usr.CanMove = 0
								var/Time = 300 - usr.ForgingSkill * 2 - usr.Strength / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to forge the [O] into a [O.Material] [src] !<br>"
								spawn(Time)
									if(usr)
										if(O && usr.Job == "Make Lock")
											var/Fail = prob(50 - usr.ForgingSkill - usr.Strength / 4 - usr.Agility / 4)
											var/NF = 0
											var/NA = 0
											for(var/obj/Items/Misc/StoneForge/F in range(1,usr))
												if(F.Type == "Lit")
													NF = 1
											for(var/obj/Items/Misc/Anvil/A in range(1,usr))
												NA = 1
											if(NF)
												if(NA)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
														usr.Weight -= O.Weight
														var/MakeMess = prob(50)
														if(MakeMess)
															var/obj/Items/Resources/Scrap/M = new
															M.Material = O.Material
															M.icon_state = "[M.Material] scrap"
															M.name = "[M.Material] scrap"
															M.Weight = O.Weight
															M.CraftPotential = O.CraftPotential / 2
															M.loc = usr.loc
															usr << "<font color = red>You create a [M] !<br>"
															usr.Weight -= O.Weight
															del(O)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti / 2
														usr.GainStats(2)
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
													W.suffix = null
													W.icon_state = "[W.Material] [W.icon_state]"
													W.Dura = usr.ForgingSkill * 2
													usr.Weight -= O.Weight
													del(O)
													if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
														usr.ForgingSkill += usr.ForgingSkillMulti
													usr.GainStats(2)
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													var/K = input("Choose a Key Code for your Lock. It can be either a number or word but both the Lock Hole and Key's Key Code must match in order to Un-Lock anything.")as null|text
													if(!K)
														K = "Default"
													if(K)
														W.KeyCode = K
													return
												else
													usr << "<font color = red>The Anvil was moved, or you moved away from it, forgeing failed!<br>"
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>The Forge was moved, or you moved away from it, or the forge was not lit, forgeing failed!<br>"
												usr.MovementCheck()
												return
										else
											usr.MovementCheck()
											return
					if(usr.Function == "Transfer")
						if(usr.Container)
							var/obj/C = usr.Container
							if(src.suffix == "Carried")
								if(src in C)
									if(C in range(1,usr))
										if(usr.Weight <= usr.WeightMax)
											src.loc = usr
											usr.Weight += src.Weight
											C.Weight -= src.Weight
											usr << "You moved [src] from [C] to your inventory!<br>"
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.CreateInventory()
											usr.CreateContainerContents(C)
											return
										else
											usr << "<b>You are carrying enough already!<br>"
											return
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Container)
									var/obj/C = usr.Container
									if(C in range(1,usr))
										if(C.Weight <= C.WeightMax)
											usr.Weight -= src.Weight
											C.Weight += src.Weight
											src.loc = C
											usr << "You moved [src] from your inventory to [C]!<br>"
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.CreateInventory()
											usr.CreateContainerContents(C)
											return
										else
											usr << "<b>[C] is carrying enough already!<br>"
											return
					if(usr.Function == "Interact" && usr.Ref == null)
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
						return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							src.overlays = null
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							for(var/obj/HUD/Text/T in usr.client.screen)
								if(T.Type == "Weight")
									del(T)
							if(usr.InvenUp)
								usr.Text("Weight",usr,4,15,0,10,"Weight - [usr.Weight]/[usr.WeightMax]")
							usr.Delete("ScrollMiddle","BoxDelete")
							return
						if(usr in range(1,src))
							if(src.suffix == null)
								if(usr.Weight <= usr.WeightMax)
									src.loc = usr
									src.suffix = "Carried"
									usr.Weight += src.Weight
									src.overlays+=image(/obj/HUD/C/)
									if(usr.InvenUp)
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
									view() << "<b>[usr] picks up [src]<br>"
									return
								else
									usr << "<b>You cant carry too much weight!<br>"
									return
							else
								usr << "<b>You cant pick that item up!<br>"
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
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in range(1,usr))
							var/Known = 0
							for(var/obj/Items/F in usr.CreateList)
								if(F.type == src.type)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Copper","Gold")
										for(var/M in Mats)
											var/obj/W = new src.type()
											W.Material = "[M]"
											W.icon_state = "[W.Material] lock"
											W.layer = 100
											usr.CreateList += W
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
						return
			Key
				icon = 'tools.dmi'
				icon_state = "key"
				Weight = 2
				CanBeCrafted = 1
				BaseMaterial = "Metal"
				Type = "Key"
				Click()
					if(usr.Job == null && src in usr.CreateList )
						var/obj/NearForge = null
						var/obj/NearAnvil = null
						for(var/obj/Items/Misc/StoneForge/F in range(1,usr))
							if(NearForge == null)
								if(F.Type == "Lit")
									NearForge = F
									break
								else
									usr << "<font color = red>The near by Forge is not lit!<br>"
						for(var/obj/Items/Misc/Anvil/A in range(1,usr))
							NearAnvil = A
						if(usr.Ref && NearForge && NearAnvil)
							var/obj/O = usr.Ref
							if(O.Type == "Ingot")
								usr.Job = "Make Key"
								usr.CanMove = 0
								var/Time = 300 - usr.ForgingSkill * 2 - usr.Strength / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to forge the [O] into a [O.Material] [src] !<br>"
								spawn(Time)
									if(usr)
										if(O && usr.Job == "Make Key")
											var/Fail = prob(50 - usr.ForgingSkill - usr.Strength / 4 - usr.Agility / 4)
											var/NF = 0
											var/NA = 0
											for(var/obj/Items/Misc/StoneForge/F in range(1,usr))
												if(F.Type == "Lit")
													NF = 1
											for(var/obj/Items/Misc/Anvil/A in range(1,usr))
												NA = 1
											if(NF)
												if(NA)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
														usr.Weight -= O.Weight
														var/MakeMess = prob(50)
														if(MakeMess)
															var/obj/Items/Resources/Scrap/M = new
															M.Material = O.Material
															M.icon_state = "[M.Material] scrap"
															M.name = "[M.Material] scrap"
															M.Weight = O.Weight
															M.CraftPotential = O.CraftPotential / 2
															M.loc = usr.loc
															usr << "<font color = red>You create a [M] !<br>"
															usr.Weight -= O.Weight
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti / 2
														usr.GainStats(2)
														del(O)
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
													W.suffix = null
													W.icon_state = "[W.Material] [W.icon_state]"
													usr.Weight -= O.Weight
													del(O)
													if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
														usr.ForgingSkill += usr.ForgingSkillMulti
													usr.GainStats(2)
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													var/K = input("Choose a Key Code for your Key. It can be either a number or word but both the Lock Hole and Key's Key Code must match in order to Un-Lock anything.")as null|text
													if(!K)
														K = "Default"
													if(K)
														W.KeyCode = K
													return
												else
													usr << "<font color = red>The Anvil was moved, or you moved away from it, forgeing failed!<br>"
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>The Forge was moved, or you moved away from it, or the forge was not lit, forgeing failed!<br>"
												usr.MovementCheck()
												return
										else
											usr.MovementCheck()
											return
					if(usr.Function == "Transfer")
						if(usr.Container)
							var/obj/C = usr.Container
							if(src.suffix == "Carried")
								if(src in C)
									if(C in range(1,usr))
										if(usr.Weight <= usr.WeightMax)
											src.loc = usr
											usr.Weight += src.Weight
											C.Weight -= src.Weight
											usr << "You moved [src] from [C] to your inventory!<br>"
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.CreateInventory()
											usr.CreateContainerContents(C)
											return
										else
											usr << "<b>You are carrying enough already!<br>"
											return
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Container)
									var/obj/C = usr.Container
									if(C in range(1,usr))
										if(C.Weight <= C.WeightMax)
											usr.Weight -= src.Weight
											C.Weight += src.Weight
											src.loc = C
											usr << "You moved [src] from your inventory to [C]!<br>"
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.CreateInventory()
											usr.CreateContainerContents(C)
											return
										else
											usr << "<b>[C] is carrying enough already!<br>"
											return
					if(usr.Function == "Interact" && usr.Ref == null)
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
						return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							src.overlays = null
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							for(var/obj/HUD/Text/T in usr.client.screen)
								if(T.Type == "Weight")
									del(T)
							if(usr.InvenUp)
								usr.Text("Weight",usr,4,15,0,10,"Weight - [usr.Weight]/[usr.WeightMax]")
							usr.Delete("ScrollMiddle","BoxDelete")
							return
						if(usr in range(1,src))
							if(src.suffix == null)
								if(usr.Weight <= usr.WeightMax)
									src.loc = usr
									src.suffix = "Carried"
									usr.Weight += src.Weight
									src.overlays+=image(/obj/HUD/C/)
									if(usr.InvenUp)
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
									view() << "<b>[usr] picks up [src]<br>"
									return
								else
									usr << "<b>You cant carry too much weight!<br>"
									return
							else
								usr << "<b>You cant pick that item up!<br>"
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
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in range(1,usr))
							var/Known = 0
							for(var/obj/Items/F in usr.CreateList)
								if(F.type == src.type)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Copper","Gold")
										for(var/M in Mats)
											var/obj/W = new src.type()
											W.Material = "[M]"
											W.icon_state = "[W.Material] key"
											W.layer = 100
											usr.CreateList += W
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
						return
			Anvil
				icon = 'tools.dmi'
				icon_state = "anvil"
				Weight = 50
				density = 1
				suffix = "Stuck"
				CanBeCrafted = 1
				Material = "Iron"
				Click()
					if(usr.Job == null && src in usr.CreateList )
						var/obj/NearForge = null
						var/obj/NearAnvil = null
						for(var/obj/Items/Misc/StoneForge/F in range(1,usr))
							if(NearForge == null)
								if(F.Type == "Lit")
									NearForge = F
									break
								else
									usr << "<font color = red>The near by Forge is not lit!<br>"
						for(var/obj/Items/Misc/Anvil/A in range(1,usr))
							NearAnvil = A
						if(usr.Ref && NearForge && NearAnvil)
							var/obj/O = usr.Ref
							if(O.Type == "Ingot")
								var/Ingots = list()
								Ingots += O
								for(var/obj/Items/Resources/Ingot/I in usr)
									if(I != O && I.Material == O.Material)
										Ingots += I
								var/IngotNum = 0
								for(var/obj/I in Ingots)
									IngotNum += 1
									if(IngotNum == 5)
										break
								if(IngotNum != 5)
									usr << "<font color = red>You need five Ingots of the same Material to forge this item!<br>"
									return
								IngotNum = 0
								usr.Job = "Anvil"
								usr.CanMove = 0
								var/Time = 200 - usr.ForgingSkill * 2 - usr.Strength / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to forge the [O] into a [O.Material] [src] !<br>"
								spawn(Time)
									if(usr)
										if(Ingots)
											for(var/obj/I in Ingots)
												if(I in usr)
													IngotNum += 1
													if(IngotNum == 5)
														break
										if(IngotNum == 5 && usr.Job == "Anvil")
											var/Fail = prob(50 - usr.ForgingSkill - usr.Strength / 4 - usr.Agility / 4)
											var/NF = 0
											var/NA = 0
											for(var/obj/Items/Misc/StoneForge/F in range(1,usr))
												if(F.Type == "Lit")
													NF = 1
											for(var/obj/Items/Misc/Anvil/A in range(1,usr))
												NA = 1
											if(NF)
												if(NA)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
														usr.Weight -= O.Weight
														IngotNum = 0
														var/MakeMess = prob(50)
														if(MakeMess)
															for(var/obj/I in Ingots)
																var/obj/Items/Resources/Scrap/M = new
																M.Material = I.Material
																M.icon_state = "[M.Material] scrap"
																M.name = "[M.Material] scrap"
																M.Weight = I.Weight
																M.CraftPotential = I.CraftPotential / 2
																M.loc = usr.loc
																usr << "<font color = red>You create a [M] !<br>"
																break
														for(var/obj/I in Ingots)
															if(IngotNum != 5)
																IngotNum += 1
																usr.Weight -= I.Weight
																del(I)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti / 2
														usr.GainStats(2)
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
													W.suffix = null
													IngotNum = 0
													for(var/obj/I in Ingots)
														if(IngotNum != 5)
															IngotNum += 1
															usr.Weight -= I.Weight
															del(I)
													if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
														usr.ForgingSkill += usr.ForgingSkillMulti
													usr.GainStats(2)
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													return
												else
													usr << "<font color = red>The Anvil was moved, or you moved away from it, forgeing failed!<br>"
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>The Forge was moved, or you moved away from it, or the forge was not lit, forgeing failed!<br>"
												usr.MovementCheck()
												return
										else
											usr.MovementCheck()
											return
					if(usr.Function == "Transfer")
						if(usr.Container)
							var/obj/C = usr.Container
							if(src.suffix == "Carried")
								if(src in C)
									if(C in range(1,usr))
										if(usr.Weight <= usr.WeightMax)
											src.loc = usr
											usr.Weight += src.Weight
											C.Weight -= src.Weight
											usr << "You moved [src] from [C] to your inventory!<br>"
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.CreateInventory()
											usr.CreateContainerContents(C)
											return
										else
											usr << "<b>You are carrying enough already!<br>"
											return
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Container)
									var/obj/C = usr.Container
									if(C in range(1,usr))
										if(C.Weight <= C.WeightMax)
											usr.Weight -= src.Weight
											C.Weight += src.Weight
											src.loc = C
											usr << "You moved [src] from your inventory to [C]!<br>"
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.CreateInventory()
											usr.CreateContainerContents(C)
											return
										else
											usr << "<b>[C] is carrying enough already!<br>"
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
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in range(1,usr))
							var/Known = 0
							for(var/obj/Items/F in usr.CreateList)
								if(F.type == src.type)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									var/obj/W = new src.type()
									W.layer = 100
									usr.CreateList += W
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
						return
			Bones
				icon = 'corpses.dmi'
				icon_state = "bones"
				Weight = 1
				Fuel = 15
				Material = "Bone"
				New()
					src.CraftPotential = rand(50,100)
					spawn(10000)
						if(src)
							if(src.suffix == null)
								del(src)
				Click()
					if(usr.Function == "Interact")
						usr.Ref = src
						usr.MovementCheck()
						if(usr.CanMove)
							usr.CreateBoneMenu(src)
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
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							src.overlays = null
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							for(var/obj/HUD/Text/T in usr.client.screen)
								if(T.Type == "Weight")
									del(T)
							if(usr.InvenUp)
								usr.Text("Weight",usr,4,15,0,10,"Weight - [usr.Weight]/[usr.WeightMax]")
							usr.Delete("ScrollMiddle","BoxDelete")
							return
						if(usr in range(1,src))
							if(src.suffix == null)
								if(usr.Weight <= usr.WeightMax)
									src.loc = usr
									src.suffix = "Carried"
									usr.Weight += src.Weight
									src.overlays+=image(/obj/HUD/C/)
									if(usr.InvenUp)
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
									view() << "<b>[usr] picks up [src]<br>"
									return
								else
									usr << "<b>You cant carry too much weight!<br>"
									return
							else
								usr << "<b>You cant pick that item up!<br>"
								return
			GraveStone
				icon = 'misc.dmi'
				icon_state = "grave1"
				suffix = "Stuck"
				New()
					var/I = rand(1,4)
					src.icon_state = "grave[I]"
			Bandage
				icon = 'misc.dmi'
				icon_state = "bandage"
				Fuel = 15
				Weight = 1
				Click()
					if(usr.Function == "Transfer")
						if(usr.Container)
							var/obj/C = usr.Container
							if(src.suffix == "Carried")
								if(src in C)
									if(C in range(1,usr))
										if(usr.Weight <= usr.WeightMax)
											src.loc = usr
											usr.Weight += src.Weight
											C.Weight -= src.Weight
											usr << "You moved [src] from [C] to your inventory!<br>"
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.CreateInventory()
											usr.CreateContainerContents(C)
											return
										else
											usr << "<b>You are carrying enough already!<br>"
											return
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Container)
									var/obj/C = usr.Container
									if(C in range(1,usr))
										if(C.Weight <= C.WeightMax)
											usr.Weight -= src.Weight
											C.Weight += src.Weight
											src.loc = C
											usr << "You moved [src] from your inventory to [C]!<br>"
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.CreateInventory()
											usr.CreateContainerContents(C)
											return
										else
											usr << "<b>[C] is carrying enough already!<br>"
											return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							src.overlays = null
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							for(var/obj/HUD/Text/T in usr.client.screen)
								if(T.Type == "Weight")
									del(T)
							if(usr.InvenUp)
								usr.Text("Weight",usr,4,15,0,10,"Weight - [usr.Weight]/[usr.WeightMax]")
							usr.Delete("ScrollMiddle","BoxDelete")
							return
						if(usr in range(1,src))
							if(src.suffix == null)
								if(usr.Weight <= usr.WeightMax)
									src.loc = usr
									src.suffix = "Carried"
									usr.Weight += src.Weight
									src.overlays+=image(/obj/HUD/C/)
									if(usr.InvenUp)
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
									view() << "<b>[usr] picks up [src]<br>"
									return
								else
									usr << "<b>You cant carry too much weight!<br>"
									return
							else
								usr << "<b>You cant pick that item up!<br>"
								return
					if(src in usr)
						if(src.suffix == "Carried" && usr.Dead == 0 && usr.Job == null && usr.Fainted == 0 && usr.Stunned == 0 && usr.Sleeping == 0 && usr.Function == "Interact")
							if(usr.Target)
								usr << "<font color = red>You have a target, you are busy fighting!<br>"
								return
							var/Cant = 0
							for(var/mob/Z in range(1,usr))
								if(Z.Target == usr)
									Cant = 1
							if(Cant)
								usr << "<font color = red>You are in combat and can not do that!<br>"
								return
							var/Arms = 1
							if(usr.RightArm == 0)
								if(usr.LeftArm == 0)
									Arms = 0
							if(Arms == 0)
								usr << "<font color=red>You have no arms, you can not use this item!<br>"
								return
							var/Heal = rand(2,5)
							Heal += usr.FirstAidSkill
							var/list/menu = new()
							for(var/mob/M in range(1,usr))
								menu += M
							menu += "Cancel"
							var/Result = input("Who do you wish to apply this bandage on?", "Choose", null) in menu
							if (Result == "Cancel")
								return
							if(Result)
								for(var/mob/M in range(1,usr))
									if(M == Result)
										if(M.Target)
											usr << "<font color = red>[M] has a target, they are busy fighting!<br>"
											return
										view(usr) << "<b>[usr] uses a [src] on [M]!<br>"
										var/EXPHeal = 0
										if(M.MortalWound)
											var/HealWound = prob(10)
											if(HealWound)
												M.MortalWound = 0
										if(M.RightArm)
											if(M.RightArm < 100)
												EXPHeal = 1
											M.RightArm += Heal
											if(src.WoundRightArm)
												var/RemoveWound = prob(25)
												if(RemoveWound)
													src.overlays -= src.WoundRightArm
													src.WoundRightArm = null
											if(M.RightArm >= 100)
												M.RightArm = 100
										if(M.LeftArm)
											if(M.LeftArm < 100)
												EXPHeal = 1
											M.LeftArm += Heal
											if(src.WoundLeftArm)
												var/RemoveWound = prob(25)
												if(RemoveWound)
													src.overlays -= src.WoundLeftArm
													src.WoundLeftArm = null
											if(M.LeftArm >= 100)
												M.LeftArm = 100
										if(M.RightLeg)
											if(M.RightLeg < 100)
												EXPHeal = 1
											M.RightLeg += Heal
											if(src.WoundRightLeg)
												var/RemoveWound = prob(25)
												if(RemoveWound)
													src.overlays -= src.WoundRightLeg
													src.WoundRightLeg = null
											if(M.RightLeg >= 100)
												M.RightLeg = 100
										if(M.LeftLeg)
											if(M.LeftLeg < 100)
												EXPHeal = 1
											M.LeftLeg += Heal
											if(src.WoundLeftLeg)
												var/RemoveWound = prob(25)
												if(RemoveWound)
													src.overlays -= src.WoundLeftLeg
													src.WoundLeftLeg = null
											if(M.LeftLeg >= 100)
												M.LeftLeg = 100
										if(M.Nose)
											if(M.Nose < 100)
												EXPHeal = 1
											M.Nose += Heal
											if(M.Nose >= 100)
												M.Nose = 100
										if(M.LeftEar)
											if(M.LeftEar < 100)
												EXPHeal = 1
											M.LeftEar += Heal
											if(M.LeftEar >= 100)
												M.LeftEar = 100
										if(M.RightEar)
											if(M.RightEar < 100)
												EXPHeal = 1
											M.RightEar += Heal
											if(M.RightEar >= 100)
												M.RightEar = 100
										if(M.Throat)
											if(M.Throat < 100)
												EXPHeal = 1
											M.Throat += Heal / 2
											if(M.Throat >= 100)
												M.Throat = 100
										if(M.Skull)
											if(M.Skull < 100)
												EXPHeal = 1
											M.Skull += Heal / 2
											if(M.Skull >= 100)
												M.Skull = 100
										if(src.WoundTorso)
											var/RemoveWound = prob(25)
											if(RemoveWound)
												src.overlays -= src.WoundTorso
												src.WoundTorso = null
										if(src.WoundHead)
											var/RemoveWound = prob(25)
											if(RemoveWound)
												src.overlays -= src.WoundHead
												src.WoundHead = null
										if(M.Blood < M.BloodMax)
											EXPHeal = 1
										M.Blood += rand(10,20)
										M.Blood += Heal / 2
										M.Pain -= Heal
										M.Pain -= rand(5,10)
										if(M.Pain <= 0)
											M.Pain = 0
										if(M.Blood >= M.BloodMax)
											M.Blood = M.BloodMax
										M.Bleed()
										if(EXPHeal)
											usr.FirstAidSkill += usr.FirstAidSkillMulti
										usr.Weight -= src.Weight
										del(src)
										return
			InquisitionSeal
				icon = 'misc.dmi'
				icon_state = "eagle sign"
				suffix = "Stuck"
				New()
					if(src.dir == NORTH)
						src.pixel_y = 32
					if(src.dir == SOUTH)
						src.pixel_y = -32
					if(src.dir == EAST)
						src.pixel_x = 32
					if(src.dir == WEST)
						src.pixel_x = -32
			Rock
				icon = 'plants.dmi'
				icon_state = "rock1"
				New()
					var/I = rand(1,4)
					src.icon_state = "rock[I]"
					spawn(1)
						for(var/turf/T in range(0,src))
							if(T in Tiles)
								del(src)
				Click()
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
			Stalagmite
				icon = 'terrain.dmi'
				icon_state = "stal1"
				Click()
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						return
				New()
					var/I = rand(1,3)
					src.icon_state = "stal[I]"
