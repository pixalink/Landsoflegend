obj
	Items
		Furniture
			Doors
				icon = 'terrain.dmi'
				IronGate
					icon_state = "gate"
					density = 1
					suffix = "Stuck"
					Weight = 30
					Dura = 300
					Fuel = 0
					CanBeCrafted = 1
					Material = "Iron"
					Click()
						if(usr.Function == "Interact" && usr.Ref)
							if(usr in range(1,src))
								if(isobj(usr.Ref))
									var/obj/O = usr.Ref
									if(O.Type == "Hammer")
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged!<br>"
											return
										if(src.density == 0)
											usr << "<font color = red>You need to shut the gate first before trying to Repair it!<br>"
											return
										if(O != usr.Weapon)
											usr << "<font color = red>Equip the Hammer first!<br>"
											return
										var/list/menu = new()
										menu += "Repair Gate"
										menu += "Cancel"
										var/Result = input(usr,"Choose an Area of the Gate to repair.", "Choose", null) in menu
										if (Result == "Cancel")
											return
										if(Result == "Repair Gate")
											var/HasIngot = 0
											for(var/obj/Items/Resources/Ingot/I in usr)
												if(I.Material == "Iron")
													HasIngot = 1
													break
											var/CanRepair = 1
											for(var/mob/M in range(1,src))
												if(M != usr)
													CanRepair = 0
											if(HasIngot == 0)
												usr << "<font color = red>You will need one Iron Ingot to Repair this gate!<br>"
												return
											if(CanRepair == 0)
												usr << "<font color = red>Cant Repair with others near!<br>"
												return
											if(src.Dura >= usr.ForgingSkill * 2 + 300)
												usr << "<font color = red>This gate is beyond your skill to repair!<br>"
												return
											var/LOC = usr.loc
											usr.Job = "Repair Gate"
											usr.Ref = null
											usr.CanMove = 0
											var/Time = 600 - usr.Agility - usr.Intelligence
											if(Time <= 50)
												Time = 50
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.InvenUp = 0
											usr.ResetButtons()
											for(var/obj/HUD/B in usr.client.screen)
												if(B.Type == "Inventory")
													B.icon_state = "inv off"
											range(src) << "<font color = yellow>[usr] begins to Repair [src]!<br>"
											spawn(Time)
												if(usr)
													if(src && O && usr.loc == LOC)
														if(usr.Job == "Repair Gate" && usr.CantDoTask == 0)
															HasIngot = 0
															for(var/obj/Items/Resources/Ingot/I in usr)
																usr.Weight -= I.Weight
																del(I)
																HasIngot = 1
																break
															var/Fail = prob(50 - usr.Agility / 2 - usr.Intelligence / 2)
															usr.Job = null
															usr.MovementCheck()
															if(HasIngot == 0)
																usr << "<font color = red>Iron Ingot was moved, crafting stopped!<br>"
																return
															if(Fail)
																range(src) << "<font color = yellow>[usr] fails at Repairing the [src]!<br>"
																return
															if(src.Dura <= usr.ForgingSkill * 2 + 301)
																src.Dura = usr.ForgingSkill * 2 + 301
															range(src) << "<font color = yellow>[usr] finishes Repairing the [src]!<br>"
															return
											return
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
										if(IngotNum == 4)
											break
									if(IngotNum != 4)
										usr << "<font color = red>You need five Ingots of the same Material to forge this item!<br>"
										return
									IngotNum = 0
									usr.Job = "Metal Gate"
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
									view(usr) << "<font color = yellow>[usr] begins to forge the [O] into a [src] !<br>"
									spawn(Time)
										if(usr)
											if(Ingots)
												for(var/obj/I in Ingots)
													if(I in usr)
														IngotNum += 1
														if(IngotNum == 4)
															break
											if(IngotNum == 4 && usr.Job == "Metal Gate")
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
																if(IngotNum != 4)
																	IngotNum += 1
																	usr.Weight -= I.Weight
																	del(I)
															if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
																usr.ForgingSkill += usr.ForgingSkillMulti / 2
															usr.GainStats(2)
															return
														var/obj/W = new src.type(usr.loc)
														W.Material = O.Material
														W.suffix = null
														IngotNum = 0
														for(var/obj/I in Ingots)
															if(IngotNum != 4)
																IngotNum += 1
																usr.Weight -= I.Weight
																del(I)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti
														usr.GainStats(2)
														view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
														usr << "<font color = teal>The gate is now laying flat on the floor, in order to make it dense, you must Click Interact then Click the gate while its in your Inventory.<br>"
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
						if(usr.Function == "Interact" && src.suffix == "Carried")
							var/CanPlace = 1
							for(var/obj/Items/Furniture/Doors/IronGate/G in range(0,usr))
								CanPlace = 1
							if(CanPlace)
								usr << "<font color = green>You place the [src] down and secure it!<br>"
								src.suffix = "Stuck"
								src.density = 1
								src.loc = usr.loc
								usr.Weight -= src.Weight
								src.overlays = null
								if(usr.InvenUp)
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
								return
						if(usr.Function == "Combat" && src.suffix == "Stuck" && usr.Job == null && src.density)
							if(usr in range(1,src))
								var/list/menu = new()
								menu += "Attack Gate"
								menu += "Cancel"
								var/Result = input(usr,"Choose an Area of the gate to attack.", "Choose", null) in menu
								if (Result == "Cancel")
									return
								if (Result == "Attack Gate")
									if(usr.CantDoTask)
										usr << "<font color = red>Cant attack that for a while!<br>"
										return
									view(usr) << "<font color = red>[usr] begins an attempt at breaking the [src] down!<br>"
									usr.Job = "SmashGate"
									usr.CanMove = 0
									usr.CantDoTask = 1
									spawn(150)
										if(usr)
											usr.CantDoTask = 0
									var/LOC = usr.loc
									var/Time = 150 - usr.Agility / 2
									if(Time <= 10)
										Time = 10
									spawn(Time)
										if(usr && src && usr.loc == LOC && usr.Job == "SmashGate" && src.density && src.suffix == "Stuck")
											var/DMG = usr.Strength
											var/Holding = 0
											if(usr.Weapon)
												Holding += 1
												var/obj/W = usr.Weapon
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
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
											var/WontDamage = 75 - usr.Strength
											var/CantDamage = prob(WontDamage)
											if(DMG >= 0 && CantDamage != 1)
												src.Dura -= DMG
												if(src.Dura <= 0)
													usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [src] open<br>")
													range(src) << "<font color = red>[src] makes a thunderous noise as it bends and crinkles as [usr] attacks it!<br>"
													del(src)
												else
													range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] damages it!<br>"
												return
											else
												range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] tried to damage it!<br>"
												return
										else
											if(usr)
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
							usr << "<font color=teal>[src.desc]<br>"
							if(src in range(1,usr))
								var/Known = 0
								for(var/obj/Items/F in usr.CreateList)
									if(F.type == src.type)
										Known = 1
								if(Known == 0)
									if(src.CanBeCrafted)
										var/obj/W = new src.type()
										W.layer = 100
										W.suffix = "None"
										usr.CreateList += W
										usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
									else
										usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
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
						if(usr.Function == "Interact")
							var/CanOpen = 0
							if(usr in range(1,src))
								CanOpen = 1
							if(usr.CanUseTK)
								CanOpen = 1
							if(CanOpen)
								if(src.Locked == 0)
									if(src.density)
										if(src.Type != "Busy")
											src.GateFunctions("Open")
											view(5) << 'MetalGate.wav'
											if(usr.CanUseTK)
												var/obj/Misc/SpellEffects/Dispel/D = new
												src.overlays += D
												var/obj/Misc/SpellEffects/Dispel/D2 = new
												usr.overlays += D2
												spawn(10)
													if(usr)
														usr.overlays -= D2
														del(D2)
													if(src)
														src.overlays -= D
														del(D)
										return
									if(src.density == 0)
										if(src.Type != "Busy")
											src.GateFunctions("Close")
											view(5) << 'MetalGate.wav'
											if(usr.CanUseTK)
												var/obj/Misc/SpellEffects/Dispel/D = new
												src.overlays += D
												var/obj/Misc/SpellEffects/Dispel/D2 = new
												usr.overlays += D2
												spawn(10)
													if(usr)
														usr.overlays -= D2
														del(D2)
													if(src)
														src.overlays -= D
														del(D)
										return
								else
									usr << "<font color = red>This gate is locked!<br>"
									return

				WoodenGate
					icon = 'tools.dmi'
					icon_state = "gate"
					density = 1
					suffix = "Stuck"
					Weight = 10
					Fuel = 50
					Material = "Wood"
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
						if(usr.Function == "Interact")
							if(usr in range(1,src))
								if(usr.Dead)
									return
								if(src.density)
									src.density = 0
									src.icon_state = "gate open"
									view(5) << 'WoodDoor.wav'
									return
								if(src.density == 0)
									src.density = 1
									src.icon_state = "gate"
									view(5) << 'WoodDoor.wav'
									return
				StoneDoor
					icon_state = "Stone door"
					density = 1
					opacity = 1
					suffix = "Stuck"
					Weight = 50
					Fuel = 0
					Dura = 400
					CanBeCrafted = 1
					Material = "Stone"
					Click()
						if(usr.Function == "Interact" && usr.Ref)
							if(usr in range(1,src))
								if(isobj(usr.Ref))
									var/obj/O = usr.Ref
									if(O.Type == "Hammer")
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged!<br>"
											return
										if(src.density == 0)
											usr << "<font color = red>You need to shut the door first before trying to Repair it!<br>"
											return
										if(O != usr.Weapon)
											usr << "<font color = red>Equip the Hammer first!<br>"
											return
										var/list/menu = new()
										menu += "Repair Door"
										if(src.KeyCode)
											menu += "Repair Lock"
										menu += "Cancel"
										var/Result = input(usr,"Choose an Area of the door to repair.", "Choose", null) in menu
										if (Result == "Cancel")
											return
										if(Result == "Repair Door")
											var/HasBrick = 0
											for(var/obj/Items/Resources/Brick/B in usr)
												HasBrick = 1
												break
											var/CanRepair = 1
											for(var/mob/M in range(1,src))
												if(M != usr)
													CanRepair = 0
											if(HasBrick == 0)
												usr << "<font color = red>You will need one Small Brick to Repair this door!<br>"
												return
											if(CanRepair == 0)
												usr << "<font color = red>Cant Repair with others near!<br>"
												return
											if(src.Dura >= usr.MasonarySkill * 2 + 400)
												usr << "<font color = red>This door is beyond your skill to repair!<br>"
												return
											var/LOC = usr.loc
											usr.Job = "Repair Door"
											usr.Ref = null
											usr.CanMove = 0
											var/Time = 600 - usr.Agility - usr.Intelligence
											if(Time <= 50)
												Time = 50
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.InvenUp = 0
											usr.ResetButtons()
											for(var/obj/HUD/B in usr.client.screen)
												if(B.Type == "Inventory")
													B.icon_state = "inv off"
											range(src) << "<font color = yellow>[usr] begins to Repair [src]!<br>"
											spawn(Time)
												if(usr)
													if(src && O && usr.loc == LOC)
														if(usr.Job == "Repair Door" && usr.CantDoTask == 0)
															HasBrick = 0
															for(var/obj/Items/Resources/Brick/B in usr)
																usr.Weight -= B.Weight
																del(B)
																HasBrick = 1
																break
															var/Fail = prob(50 - usr.Agility / 2 - usr.Intelligence / 2)
															usr.Job = null
															usr.MovementCheck()
															if(HasBrick == 0)
																usr << "<font color = red>Small Brick was moved, crafting stopped!<br>"
																return
															if(Fail)
																range(src) << "<font color = yellow>[usr] fails at Repairing the [src]!<br>"
																return
															if(src.Dura <= usr.MasonarySkill * 2 + 401)
																src.Dura = usr.MasonarySkill * 2 + 401
															range(src) << "<font color = yellow>[usr] finishes Repairing the [src]!<br>"
															return
											return
										if(Result == "Repair Lock")
											var/obj/Lock = null
											for(var/obj/Items/Misc/Lock/L in src)
												Lock = L
											var/CanRepair = 1
											for(var/mob/M in range(1,src))
												if(M != usr)
													CanRepair = 0
											if(CanRepair == 0)
												usr << "<font color = red>Cant Repair with others near!<br>"
												return
											if(Lock.Dura >= usr.ForgingSkill * 2)
												usr << "<font color = red>This lock is beyond your skill to repair!<br>"
												return
											var/LOC = usr.loc
											usr.Job = "Repair Lock"
											usr.Ref = null
											usr.CanMove = 0
											var/Time = 600 - usr.Agility - usr.Intelligence
											if(Time <= 50)
												Time = 50
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.InvenUp = 0
											usr.ResetButtons()
											for(var/obj/HUD/B in usr.client.screen)
												if(B.Type == "Inventory")
													B.icon_state = "inv off"
											range(src) << "<font color = yellow>[usr] begins to Repair the [Lock] inside [src]!<br>"
											spawn(Time)
												if(usr)
													if(src && O && usr.loc == LOC)
														if(usr.Job == "Repair Lock" && usr.CantDoTask == 0)
															var/Fail = prob(50 - usr.Agility / 2 - usr.Intelligence / 2)
															usr.Job = null
															usr.MovementCheck()
															if(Fail)
																range(src) << "<font color = yellow>[usr] fails at Repairing the [Lock] inside [src]!<br>"
																return
															if(Lock.Dura <= usr.ForgingSkill * 2 + 1)
																Lock.Dura = usr.ForgingSkill * 2 + 1
															range(src) << "<font color = yellow>[usr] finishes Repairing the [Lock] inside [src]!<br>"
															return
											return
									if(O.Type == "Key")
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged!<br>"
											return
										if(src.density == 0)
											usr << "<font color = red>You need to shut the door first before trying to Lock or Un-Lock it!<br>"
											return
										if(O.KeyCode == src.KeyCode)
											if(src.Locked == 0)
												view() << "<font color = yellow>[usr] Locks [src] using their [O]!<br>"
												src.Locked = 1
												usr.Ref = null
												return
											if(src.Locked)
												view() << "<font color = yellow>[usr] Un-Locks [src] using their [O]!<br>"
												src.Locked = 0
												usr.Ref = null
												return
										else
											usr << "<font color = red>That is the wrong key for this door!<br>"
											return
									if(O.Type == "Lock" && O.suffix)
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged to do that!<br>"
											return
										if(src.KeyCode)
											usr << "<font color = red>This door appears to already have a Lock Fitted.<br>"
											return
										var/CanFit = 0
										if(src.density && src.opacity)
											CanFit = 1
										if(CanFit == 0)
											usr << "<font color = red>The door must be closed in order to continue!<br>"
											return
										if(usr.Weapon)
											var/obj/T = usr.Weapon
											if(T.Type == "Hammer")
												var/LOC = usr.loc
												usr.Job = "Fit Lock"
												usr.Ref = null
												usr.CanMove = 0
												var/Time = 300 - usr.MasonarySkill * 1.5 - usr.Agility / 2 - usr.Intelligence
												if(Time <= 50)
													Time = 50
												usr.DeleteInventoryMenu()
												if(usr.InvenUp)
													usr.InvenUp = 0
												usr.ResetButtons()
												for(var/obj/HUD/B in usr.client.screen)
													if(B.Type == "Inventory")
														B.icon_state = "inv off"
												view(usr) << "<font color = yellow>[usr] begins to fit the [O] into [src]!<br>"
												spawn(Time)
													if(usr)
														if(src && O && usr.loc == LOC)
															if(usr.Job == "Fit Lock" && usr.CantDoTask == 0)
																var/Fail = prob(50 - usr.MasonarySkill - usr.Agility / 4 - usr.Intelligence / 2)
																usr.Job = null
																usr.MovementCheck()
																if(Fail)
																	view(usr) << "<font color = yellow>[usr] fails at fitting a [O] into [src]!<br>"
																	usr.MasonarySkill += usr.MasonarySkillMulti / 2
																	usr.GainStats(3,"Yes")
																	return
																usr.Weight -= O.Weight
																O.loc = src
																O.overlays = null
																O.suffix = "Fitted"
																O.icon_state = "[O.icon_state] fitted door"
																O.pixel_x = -3
																O.pixel_y = 2
																src.KeyCode = O.KeyCode
																src.overlays += O
																usr.MasonarySkill += usr.MasonarySkillMulti
																usr.GainStats(2,"Yes")
																view(usr) << "<font color = yellow>[usr] finishes fitting the [O] into [src]!<br>"
																return
												return
											else
												usr << "<font color = red>You need a Hammer in order to fit Locks!<br>"
												return
										else
											usr << "<font color = red>You need a Hammer in order to fit Locks!<br>"
											return
						if(usr.Function == "Interact" && src.suffix == "Carried")
							var/CanPlace = 1
							for(var/obj/O in range(0,usr))
								if(O.suffix == "Stuck")
									CanPlace = 0
							if(CanPlace)
								usr << "<font color = green>You place the [src] down and secure it!<br>"
								src.suffix = "Stuck"
								src.opacity = 1
								src.density = 1
								src.loc = usr.loc
								usr.Weight -= src.Weight
								src.overlays = null
								if(usr.InvenUp)
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
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
									usr << "<font color = red>You need Four Large Bricks in order to create this item!<br>"
									return
								if(BrickNum == 4 && O.Type == "LargeBrick")
									var/LOC = usr.loc
									usr.Job = "CreateStoneDoor"
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
												if(BrickNum == 4 && O && usr.Job == "CreateStoneDoor")
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
													W.Dura += usr.MasonarySkill * 3
													W.suffix = null
													W.density = 0
													W.opacity = 0
													for(var/obj/I in Bricks)
														if(BrickNum != 0)
															BrickNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.MasonarySkill += usr.MasonarySkillMulti
													usr.GainStats(2,"Yes")
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													usr << "<font color = teal>The door is now laying flat on the floor, in order to make it dense, you must Click Interact then Click the door while its in your Inventory.<br>"
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
							usr << "<font color=teal>[src.desc]<br>"
							if(src in range(1,usr))
								for(var/obj/Items/Misc/Lock/L in src)
									usr << "<font color=teal>[src] appears to have an [L] inside it.<br>"
								var/Known = 0
								for(var/obj/Items/F in usr.CreateList)
									if(F.type == src.type)
										Known = 1
								if(Known == 0)
									if(src.CanBeCrafted)
										var/obj/W = new src.type()
										W.layer = 100
										W.suffix = "None"
										usr.CreateList += W
										var/KnowsKey = 0
										for(var/obj/I in usr.CreateList)
											if(I.type == /obj/Items/Misc/Key/)
												KnowsKey = 1
										if(KnowsKey == 0)
											var/Mats = list("Iron","Copper","Gold")
											for(var/M in Mats)
												var/obj/Items/Misc/Key/K = new
												K.layer = 100
												K.Material = "[M]"
												K.icon_state = "[M] key"
												usr.CreateList += K
										var/KnowsLock = 0
										for(var/obj/I in usr.CreateList)
											if(I.type == /obj/Items/Misc/Lock/)
												KnowsLock = 1
										if(KnowsLock == 0)
											var/Mats = list("Iron","Copper","Gold")
											for(var/M in Mats)
												var/obj/Items/Misc/Lock/L = new
												L.layer = 100
												L.Material = "[M]"
												L.icon_state = "[M] lock"
												usr.CreateList += L
										usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
									else
										usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
							return
						if(usr.Function == "Combat" && src.suffix == "Stuck" && usr.Job == null && src.density)
							if(usr in range(1,src))
								var/list/menu = new()
								menu += "Attack Door"
								if(src.KeyCode)
									menu += "Attack Lock"
								menu += "Cancel"
								var/Result = input(usr,"Choose an Area of the door to attack.", "Choose", null) in menu
								if (Result == "Cancel")
									return
								if (Result == "Attack Lock")
									if(usr.CantDoTask)
										usr << "<font color = red>Cant attack that for a while!<br>"
										return
									for(var/obj/Items/Misc/Lock/L in src)
										view(usr) << "<font color = red>[usr] begins an attempt at breaking [src]'s [L]!<br>"
										usr.Job = "SmashLock"
										usr.CanMove = 0
										usr.CantDoTask = 1
										spawn(150)
											if(usr)
												usr.CantDoTask = 0
										var/LOC = usr.loc
										var/Time = 150 - usr.Agility / 2
										if(Time <= 10)
											Time = 10
										spawn(Time)
											if(L && usr && src && usr.loc == LOC && usr.Job == "SmashLock" && src.density && src.suffix == "Stuck")
												var/DMG = usr.Strength
												var/Holding = 0
												if(usr.Weapon)
													Holding += 1
													var/obj/W = usr.Weapon
													if(W.ObjectTag == "Weapon")
														DMG += W.Weight / 2
														W.Dura -= rand(0.1,2)
														if(W.ObjectType == "Blunt")
															DMG += 10
														if(W.TwoHander && usr.Weapon2 == null)
															DMG += W.Weight / 2
														usr.CheckWeaponDura(W)
												if(usr.Weapon2)
													Holding += 1
													var/obj/W = usr.Weapon2
													if(W.ObjectTag == "Weapon")
														DMG += W.Weight / 2
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
												var/WontDamage = 50 - usr.Strength
												var/CantDamage = prob(WontDamage)
												if(DMG >= 0 && CantDamage != 1)
													L.Dura -= DMG
													if(L.Dura <= 0)
														usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [L] open<br>")
														range(src) << "<font color = red>[src] makes a loud rumbling noise as the [L] inside it breaks away after [usr] attacks it!<br>"
														src.KeyCode = null
														src.overlays = null
														var/Jam = prob(50)
														if(Jam)
															range(src) << "<font color = red>[src] appears to have become Jammed!<br>"
														else
															src.Locked = 0
														del(L)
													else
														range(src) << "<font color = red>[src] makes a loud rumbling noise as [usr] damages the [L] inside!<br>"
													return
												else
													range(src) << "<font color = red>[src] makes a loud rumbling noise as [usr] tries to damage the [L]!<br>"
													return
											else
												if(usr)
													usr.MovementCheck()
										return
								if (Result == "Attack Door")
									if(usr.CantDoTask)
										usr << "<font color = red>Cant attack that for a while!<br>"
										return
									view(usr) << "<font color = red>[usr] begins an attempt at breaking the [src] down!<br>"
									usr.Job = "SmashDoor"
									usr.CanMove = 0
									usr.CantDoTask = 1
									spawn(150)
										if(usr)
											usr.CantDoTask = 0
									var/LOC = usr.loc
									var/Time = 150 - usr.Agility / 2
									if(Time <= 10)
										Time = 10
									spawn(Time)
										if(usr && src && usr.loc == LOC && usr.Job == "SmashDoor" && src.density && src.suffix == "Stuck")
											var/DMG = usr.Strength
											var/Holding = 0
											if(usr.Weapon)
												Holding += 1
												var/obj/W = usr.Weapon
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
													W.Dura -= rand(0.1,2)
													if(W.ObjectType == "Blunt")
														DMG += 10
													if(W.TwoHander && usr.Weapon2 == null)
														DMG += W.Weight / 2
													usr.CheckWeaponDura(W)
											if(usr.Weapon2)
												Holding += 1
												var/obj/W = usr.Weapon2
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
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
											var/WontDamage = 50 - usr.Strength
											var/CantDamage = prob(WontDamage)
											if(DMG >= 0 && CantDamage != 1)
												src.Dura -= DMG
												if(src.Dura <= 0)
													usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [src] open<br>")
													range(src) << "<font color = red>[src] makes a thunderous rumbling noise as it shatter when [usr] attacks it!<br>"
													del(src)
												else
													range(src) << "<font color = red>[src] makes a loud rumbling noise as [usr] damages it!<br>"
												return
											else
												range(src) << "<font color = red>[src] makes a loud rumbling noise as [usr] tried to damage it!<br>"
												return
										else
											if(usr)
												usr.MovementCheck()
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
						if(usr.Function == "Interact" && src.suffix == "Stuck")
							switch(alert("Knock on the door, or open/close it?",,"Cancel","Knock","Open/Close"))
								if("Knock")
									var/CanOpen = 0
									if(usr in range(1,src))
										CanOpen = 1
									if(usr.CanUseTK)
										CanOpen = 1
									if(CanOpen)
										if(usr.Dead)
											return
										if(src.density)
											range(6,src) << "<font color = yellow>A knocking noise can be heard from the [src]!<br>"
											return
								if("Open/Close")
									var/CanOpen = 0
									if(usr in range(1,src))
										CanOpen = 1
									if(usr.CanUseTK)
										CanOpen = 1
									if(CanOpen)
										if(usr.Dead)
											return
										if(src.Locked)
											usr << "<font color = red>This door is Locked tight!<br>"
											return
										if(src.density)
											src.density = 0
											src.opacity = 0
											src.icon_state = "Stone door open"
											src.overlays = null
											view(5) << 'WoodDoor.wav'
											if(usr.CanUseTK)
												var/obj/Misc/SpellEffects/Dispel/D = new
												src.overlays += D
												var/obj/Misc/SpellEffects/Dispel/D2 = new
												usr.overlays += D2
												spawn(10)
													if(usr)
														usr.overlays -= D2
														del(D2)
													if(src)
														src.overlays -= D
														del(D)
											return
										if(src.density == 0)
											src.density = 1
											src.opacity = 1
											src.icon_state = "Stone door"
											if(src.KeyCode)
												for(var/obj/I in src)
													src.overlays += I
											view(5) << 'WoodDoor2.wav'
											if(usr.CanUseTK)
												var/obj/Misc/SpellEffects/Dispel/D = new
												src.overlays += D
												var/obj/Misc/SpellEffects/Dispel/D2 = new
												usr.overlays += D2
												spawn(10)
													if(usr)
														usr.overlays -= D2
														del(D2)
													if(src)
														src.overlays -= D
														del(D)
											return
				StrangeCrystalDoor
					icon_state = "strange crystal door"
					density = 1
					opacity = 1
					suffix = "Stuck"
					Weight = 100
					Fuel = 0
					Dura = 1000
					CanBeCrafted = 1
					Material = "Stone"
					Click()
						if(usr.Function == "Examine")
							usr << "<font color=teal>[src.desc]"
						if(usr.Function == "Interact" && src.suffix == "Stuck")
							switch(alert("Knock on the door, or open/close it?",,"Cancel","Knock","Open/Close"))
								if("Knock")
									var/CanOpen = 0
									if(usr in range(1,src))
										CanOpen = 1
									if(usr.CanUseTK)
										CanOpen = 1
									if(CanOpen)
										if(usr.Dead)
											return
										if(src.density)
											range(6,src) << "<font color = yellow>A knocking noise can be heard from the [src]!<br>"
											return
								if("Open/Close")
									if(usr in range(1,src))
										if(usr.Dead)
											return
										if(src.density)
											if(usr.AstralMagic >= 20)
												src.density = 0
												src.opacity = 0
												src.icon_state = "strange crystal door open"
												view(6,src) << "<font color = purple>[src] reacts to [usr]'s touch!<br>"
												return
											else
												usr << "<font color = red>You try to open the door but it appears stuck! Upon touching it, you feel a strange sensation.<br>"
												return
										else
											if(usr.AstralMagic >= 20)
												src.density = 1
												src.opacity = 1
												src.icon_state = "strange crystal door"
												view(6,src) << "<font color = purple>[src] reacts to [usr]'s touch!<br>"
												return
											else
												usr << "<font color = red>You try to open the door but it appears stuck! Upon touching it, you feel a strange sensation.<br>"
												return
						if(usr.Function == "Combat" && src.suffix == "Stuck" && usr.Job == null && src.density)
							if(usr in range(1,src))
								var/list/menu = new()
								menu += "Attack Door"
								menu += "Cancel"
								var/Result = input(usr,"Choose an Area of the door to attack.", "Choose", null) in menu
								if (Result == "Cancel")
									return
								if (Result == "Attack Door")
									if(usr.CantDoTask)
										usr << "<font color = red>Cant attack that for a while!<br>"
										return
									view(usr) << "<font color = red>[usr] begins an attempt at breaking the [src] down!<br>"
									usr.Job = "SmashDoor"
									usr.CanMove = 0
									usr.CantDoTask = 1
									spawn(150)
										if(usr)
											usr.CantDoTask = 0
									var/LOC = usr.loc
									var/Time = 150 - usr.Agility / 2
									if(Time <= 10)
										Time = 10
									spawn(Time)
										if(usr && src && usr.loc == LOC && usr.Job == "SmashDoor" && src.density && src.suffix == "Stuck")
											var/DMG = usr.Strength
											var/Holding = 0
											if(usr.Weapon)
												Holding += 1
												var/obj/W = usr.Weapon
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
													W.Dura -= rand(0.1,2)
													if(W.ObjectType == "Blunt")
														DMG += 10
													if(W.TwoHander && usr.Weapon2 == null)
														DMG += W.Weight / 2
													usr.CheckWeaponDura(W)
											if(usr.Weapon2)
												Holding += 1
												var/obj/W = usr.Weapon2
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
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
											var/WontDamage = 75 - usr.Strength
											var/CantDamage = prob(WontDamage)
											if(DMG >= 0 && CantDamage != 1)
												src.Dura -= DMG
												if(src.Dura <= 0)
													usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [src] open<br>")
													range(src) << "<font color = red>[src] makes a thunderous noise as it bends and crinkles as [usr] attacks it!<br>"
													del(src)
												else
													range(src) << "<font color = red>[src] makes a loud humm as [usr] damages it!<br>"
												return
											else
												range(src) << "<font color = red>[src] makes a loud humm as [usr] tried to damage it!<br>"
												return
										else
											if(usr)
												usr.MovementCheck()
									return
				IronPrisonDoor
					icon_state = "Iron prison door"
					density = 1
					suffix = "Stuck"
					Weight = 35
					Fuel = 0
					Dura = 400
					CanBeCrafted = 1
					Material = "Iron"
					Click()
						if(usr.Function == "Interact" && usr.Ref)
							if(usr in range(1,src))
								if(isobj(usr.Ref))
									var/obj/O = usr.Ref
									if(O.Type == "Hammer")
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged!<br>"
											return
										if(src.density == 0)
											usr << "<font color = red>You need to shut the door first before trying to Repair it!<br>"
											return
										if(O != usr.Weapon)
											usr << "<font color = red>Equip the Hammer first!<br>"
											return
										var/list/menu = new()
										menu += "Repair Door"
										if(src.KeyCode)
											menu += "Repair Lock"
										menu += "Cancel"
										var/Result = input(usr,"Choose an Area of the door to repair.", "Choose", null) in menu
										if (Result == "Cancel")
											return
										if(Result == "Repair Door")
											var/HasIngot = 0
											for(var/obj/Items/Resources/Ingot/I in usr)
												if(I.Material == "Iron")
													HasIngot = 1
													break
											var/CanRepair = 1
											for(var/mob/M in range(1,src))
												if(M != usr)
													CanRepair = 0
											if(HasIngot == 0)
												usr << "<font color = red>You will need one Iron Ingot to Repair this door!<br>"
												return
											if(CanRepair == 0)
												usr << "<font color = red>Cant Repair with others near!<br>"
												return
											if(src.Dura >= usr.ForgingSkill * 2 + 400)
												usr << "<font color = red>This door is beyond your skill to repair!<br>"
												return
											var/LOC = usr.loc
											usr.Job = "Repair Door"
											usr.Ref = null
											usr.CanMove = 0
											var/Time = 600 - usr.Agility - usr.Intelligence
											if(Time <= 50)
												Time = 50
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.InvenUp = 0
											usr.ResetButtons()
											for(var/obj/HUD/B in usr.client.screen)
												if(B.Type == "Inventory")
													B.icon_state = "inv off"
											range(src) << "<font color = yellow>[usr] begins to Repair [src]!<br>"
											spawn(Time)
												if(usr)
													if(src && O && usr.loc == LOC)
														if(usr.Job == "Repair Door" && usr.CantDoTask == 0)
															HasIngot = 0
															for(var/obj/Items/Resources/Ingot/I in usr)
																usr.Weight -= I.Weight
																del(I)
																HasIngot = 1
																break
															var/Fail = prob(50 - usr.Agility / 2 - usr.Intelligence / 2)
															usr.Job = null
															usr.MovementCheck()
															if(HasIngot == 0)
																usr << "<font color = red>Iron Ingot was moved, crafting stopped!<br>"
																return
															if(Fail)
																range(src) << "<font color = yellow>[usr] fails at Repairing the [src]!<br>"
																return
															if(src.Dura <= usr.ForgingSkill * 2 + 401)
																src.Dura = usr.ForgingSkill * 2 + 401
															range(src) << "<font color = yellow>[usr] finishes Repairing the [src]!<br>"
															return
											return
										if(Result == "Repair Lock")
											var/obj/Lock = null
											for(var/obj/Items/Misc/Lock/L in src)
												Lock = L
											var/CanRepair = 1
											for(var/mob/M in range(1,src))
												if(M != usr)
													CanRepair = 0
											if(CanRepair == 0)
												usr << "<font color = red>Cant Repair with others near!<br>"
												return
											if(Lock.Dura >= usr.ForgingSkill * 2)
												usr << "<font color = red>This lock is beyond your skill to repair!<br>"
												return
											var/LOC = usr.loc
											usr.Job = "Repair Lock"
											usr.Ref = null
											usr.CanMove = 0
											var/Time = 600 - usr.Agility - usr.Intelligence
											if(Time <= 50)
												Time = 50
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.InvenUp = 0
											usr.ResetButtons()
											for(var/obj/HUD/B in usr.client.screen)
												if(B.Type == "Inventory")
													B.icon_state = "inv off"
											range(src) << "<font color = yellow>[usr] begins to Repair the [Lock] inside [src]!<br>"
											spawn(Time)
												if(usr)
													if(src && O && usr.loc == LOC)
														if(usr.Job == "Repair Lock" && usr.CantDoTask == 0)
															var/Fail = prob(50 - usr.Agility / 2 - usr.Intelligence / 2)
															usr.Job = null
															usr.MovementCheck()
															if(Fail)
																range(src) << "<font color = yellow>[usr] fails at Repairing the [Lock] inside [src]!<br>"
																return
															if(Lock.Dura <= usr.ForgingSkill * 2 + 1)
																Lock.Dura = usr.ForgingSkill * 2 + 1
															range(src) << "<font color = yellow>[usr] finishes Repairing the [Lock] inside [src]!<br>"
															return
											return
									if(O.Type == "Key")
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged!<br>"
											return
										if(src.density == 0)
											usr << "<font color = red>You need to shut the door first before trying to Lock or Un-Lock it!<br>"
											return
										if(O.KeyCode == src.KeyCode)
											if(src.Locked == 0)
												view() << "<font color = yellow>[usr] Locks [src] using their [O]!<br>"
												src.Locked = 1
												usr.Ref = null
												return
											if(src.Locked)
												view() << "<font color = yellow>[usr] Un-Locks [src] using their [O]!<br>"
												src.Locked = 0
												usr.Ref = null
												return
										else
											usr << "<font color = red>That is the wrong key for this door!<br>"
											return
									if(O.Type == "Lock")
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged to do that!<br>"
											return
										if(src.KeyCode)
											usr << "<font color = red>This door appears to already have a Lock Fitted.<br>"
											return
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
										if(IngotNum == 4)
											break
									if(IngotNum != 4)
										usr << "<font color = red>You need five Ingots of the same Material to forge this item!<br>"
										return
									IngotNum = 0
									usr.Job = "Metal Door"
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
									view(usr) << "<font color = yellow>[usr] begins to forge the [O] into a [src] !<br>"
									spawn(Time)
										if(usr)
											if(Ingots)
												for(var/obj/I in Ingots)
													if(I in usr)
														IngotNum += 1
														if(IngotNum == 4)
															break
											if(IngotNum == 4 && usr.Job == "Metal Door")
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
																if(IngotNum != 4)
																	IngotNum += 1
																	usr.Weight -= I.Weight
																	del(I)
															if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
																usr.ForgingSkill += usr.ForgingSkillMulti / 2
															usr.GainStats(2)
															return
														var/obj/W = new src.type(usr.loc)
														W.Material = O.Material
														W.suffix = null
														var/K = input("Choose a Key Code for your Prison Door. It can be either a number or word but both the Lock Hole and Key's Key Code must match in order to Un-Lock anything.")as null|text
														if(!K)
															K = "Default"
														if(K)
															W.KeyCode = K
														var/obj/Items/Misc/Lock/L = new
														L.Material = "Iron"
														L.icon_state = "Iron lock fitted door"
														L.loc = W
														L.KeyCode = K
														L.Dura = usr.ForgingSkill * 2
														IngotNum = 0
														for(var/obj/I in Ingots)
															if(IngotNum != 4)
																IngotNum += 1
																usr.Weight -= I.Weight
																del(I)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti
														usr.GainStats(2)
														view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
														usr << "<font color = teal>The door is now laying flat on the floor, in order to make it dense, you must Click Interact then Click the door while its in your Inventory.<br>"
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
						if(usr.Function == "Interact" && src.suffix == "Carried")
							var/CanPlace = 1
							for(var/obj/O in range(0,usr))
								if(O.suffix == "Stuck")
									CanPlace = 0
							if(CanPlace)
								usr << "<font color = green>You place the [src] down and secure it!<br>"
								src.suffix = "Stuck"
								src.density = 1
								src.loc = usr.loc
								usr.Weight -= src.Weight
								src.overlays = null
								if(usr.InvenUp)
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
								return
						if(usr.Function == "Combat" && src.suffix == "Stuck" && usr.Job == null && src.density)
							if(usr in range(1,src))
								var/list/menu = new()
								menu += "Attack Door"
								if(src.KeyCode)
									menu += "Attack Lock"
								menu += "Cancel"
								var/Result = input(usr,"Choose an Area of the door to attack.", "Choose", null) in menu
								if (Result == "Cancel")
									return
								if (Result == "Attack Lock")
									if(usr.CantDoTask)
										usr << "<font color = red>Cant attack that for a while!<br>"
										return
									for(var/obj/Items/Misc/Lock/L in src)
										view(usr) << "<font color = red>[usr] begins an attempt at breaking [src]'s [L]!<br>"
										usr.Job = "SmashLock"
										usr.CanMove = 0
										usr.CantDoTask = 1
										spawn(150)
											if(usr)
												usr.CantDoTask = 0
										var/LOC = usr.loc
										var/Time = 150 - usr.Agility / 2
										if(Time <= 10)
											Time = 10
										spawn(Time)
											if(L && usr && src && usr.loc == LOC && usr.Job == "SmashLock" && src.density && src.suffix == "Stuck")
												var/DMG = usr.Strength
												var/Holding = 0
												if(usr.Weapon)
													Holding += 1
													var/obj/W = usr.Weapon
													if(W.ObjectTag == "Weapon")
														DMG += W.Weight / 2
														W.Dura -= rand(0.1,2)
														if(W.ObjectType == "Blunt")
															DMG += 10
														if(W.TwoHander && usr.Weapon2 == null)
															DMG += W.Weight / 2
														usr.CheckWeaponDura(W)
												if(usr.Weapon2)
													Holding += 1
													var/obj/W = usr.Weapon2
													if(W.ObjectTag == "Weapon")
														DMG += W.Weight / 2
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
												var/WontDamage = 50 - usr.Strength
												var/CantDamage = prob(WontDamage)
												if(DMG >= 0 && CantDamage != 1)
													L.Dura -= DMG
													if(L.Dura <= 0)
														usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [L] open<br>")
														range(src) << "<font color = red>[src] makes a loud metallic noise as the [L] inside it breaks away after [usr] attacks it!<br>"
														src.KeyCode = null
														src.overlays = null
														var/Jam = prob(50)
														if(Jam)
															range(src) << "<font color = red>[src] appears to have become Jammed!<br>"
														else
															src.Locked = 0
														del(L)
													else
														range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] damages the [L] inside!<br>"
													return
												else
													range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] tries to damage the [L]!<br>"
													return
											else
												if(usr)
													usr.MovementCheck()
										return
								if (Result == "Attack Door")
									if(usr.CantDoTask)
										usr << "<font color = red>Cant attack that for a while!<br>"
										return
									view(usr) << "<font color = red>[usr] begins an attempt at breaking the [src] down!<br>"
									usr.Job = "SmashDoor"
									usr.CanMove = 0
									usr.CantDoTask = 1
									spawn(150)
										if(usr)
											usr.CantDoTask = 0
									var/LOC = usr.loc
									var/Time = 150 - usr.Agility / 2
									if(Time <= 10)
										Time = 10
									spawn(Time)
										if(usr && src && usr.loc == LOC && usr.Job == "SmashDoor" && src.density && src.suffix == "Stuck")
											var/DMG = usr.Strength
											var/Holding = 0
											if(usr.Weapon)
												Holding += 1
												var/obj/W = usr.Weapon
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
													W.Dura -= rand(0.1,2)
													if(W.ObjectType == "Blunt")
														DMG += 10
													if(W.TwoHander && usr.Weapon2 == null)
														DMG += W.Weight / 2
													usr.CheckWeaponDura(W)
											if(usr.Weapon2)
												Holding += 1
												var/obj/W = usr.Weapon2
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
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
											var/WontDamage = 75 - usr.Strength
											var/CantDamage = prob(WontDamage)
											if(DMG >= 0 && CantDamage != 1)
												src.Dura -= DMG
												if(src.Dura <= 0)
													usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [src] open<br>")
													range(src) << "<font color = red>[src] makes a thunderous noise as it bends and crinkles as [usr] attacks it!<br>"
													del(src)
												else
													range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] damages it!<br>"
												return
											else
												range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] tried to damage it!<br>"
												return
										else
											if(usr)
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
							usr << "<font color=teal>[src.desc]<br>"
							if(src in range(1,usr))
								for(var/obj/Items/Misc/Lock/L in src)
									usr << "<font color=teal>[src] appears to have an [L] inside it.<br>"
								var/Known = 0
								for(var/obj/Items/F in usr.CreateList)
									if(F.type == src.type)
										Known = 1
								if(Known == 0)
									if(src.CanBeCrafted)
										var/obj/W = new src.type()
										W.layer = 100
										W.suffix = "None"
										usr.CreateList += W
										var/KnowsKey = 0
										for(var/obj/I in usr.CreateList)
											if(I.type == /obj/Items/Misc/Key/)
												KnowsKey = 1
										if(KnowsKey == 0)
											var/Mats = list("Iron","Copper","Gold")
											for(var/M in Mats)
												var/obj/Items/Misc/Key/K = new
												K.layer = 100
												K.Material = "[M]"
												K.icon_state = "[M] key"
												usr.CreateList += K
										var/KnowsLock = 0
										for(var/obj/I in usr.CreateList)
											if(I.type == /obj/Items/Misc/Lock/)
												KnowsLock = 1
										if(KnowsLock == 0)
											var/Mats = list("Iron","Copper","Gold")
											for(var/M in Mats)
												var/obj/Items/Misc/Lock/L = new
												L.layer = 100
												L.Material = "[M]"
												L.icon_state = "[M] lock"
												usr.CreateList += L
										usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
									else
										usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
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
						if(usr.Function == "Interact" && src.suffix == "Stuck")
							var/CanOpen = 0
							if(usr in range(1,src))
								CanOpen = 1
							if(usr.CanUseTK)
								CanOpen = 1
							if(CanOpen)
								if(usr.Dead)
									return
								if(src.Locked)
									usr << "<font color = red>This door is Locked tight!<br>"
									return
								if(src.density)
									src.density = 0
									src.icon_state = "Iron prison door open"
									src.overlays = null
									view(5) << 'WoodDoor.wav'
									if(usr.CanUseTK)
										var/obj/Misc/SpellEffects/Dispel/D = new
										src.overlays += D
										var/obj/Misc/SpellEffects/Dispel/D2 = new
										usr.overlays += D2
										spawn(10)
											if(usr)
												usr.overlays -= D2
												del(D2)
											if(src)
												src.overlays -= D
												del(D)
									return
								if(src.density == 0)
									src.density = 1
									src.icon_state = "Iron prison door"
									view(5) << 'WoodDoor2.wav'
									if(usr.CanUseTK)
										var/obj/Misc/SpellEffects/Dispel/D = new
										src.overlays += D
										var/obj/Misc/SpellEffects/Dispel/D2 = new
										usr.overlays += D2
										spawn(10)
											if(usr)
												usr.overlays -= D2
												del(D2)
											if(src)
												src.overlays -= D
												del(D)
									return
				InquisitorIronDoor
					icon_state = "Inquisitor Iron door"
					density = 1
					opacity = 1
					suffix = "Stuck"
					Weight = 45
					Fuel = 0
					Dura = 4000
					Locked = 1
					Material = "Iron"
					New()
						var/obj/Items/Misc/Lock/L = new
						L.loc = src
						L.suffix = "Fitted"
						L.KeyCode = rand(1000,10000)
						L.Dura = 3000
						src.KeyCode = L.KeyCode
					Click()
						if(usr.Function == "Interact" && usr.Ref)
							if(usr in range(1,src))
								if(isobj(usr.Ref))
									var/obj/O = usr.Ref
									if(O.Type == "Hammer" && src.suffix == "Stuck")
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged!<br>"
											return
										if(src.density == 0)
											usr << "<font color = red>You need to shut the door first before trying to Repair it!<br>"
											return
										if(O != usr.Weapon)
											usr << "<font color = red>Equip the Hammer first!<br>"
											return
										var/list/menu = new()
										menu += "Repair Door"
										if(src.KeyCode)
											menu += "Repair Lock"
										menu += "Cancel"
										var/Result = input(usr,"Choose an Area of the door to repair.", "Choose", null) in menu
										if (Result == "Cancel")
											return
										if(Result == "Repair Door")
											var/HasIngot = 0
											for(var/obj/Items/Resources/Ingot/I in usr)
												if(I.Material == "Iron")
													HasIngot = 1
													break
											var/CanRepair = 1
											for(var/mob/M in range(1,src))
												if(M != usr)
													CanRepair = 0
											if(HasIngot == 0)
												usr << "<font color = red>You will need one Iron Ingot to Repair this door!<br>"
												return
											if(CanRepair == 0)
												usr << "<font color = red>Cant Repair with others near!<br>"
												return
											if(src.Dura >= usr.ForgingSkill * 2 + 4000)
												usr << "<font color = red>This door is beyond your skill to repair!<br>"
												return
											var/LOC = usr.loc
											usr.Job = "Repair Door"
											usr.Ref = null
											usr.CanMove = 0
											var/Time = 600 - usr.Agility - usr.Intelligence
											if(Time <= 50)
												Time = 50
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.InvenUp = 0
											usr.ResetButtons()
											for(var/obj/HUD/B in usr.client.screen)
												if(B.Type == "Inventory")
													B.icon_state = "inv off"
											range(src) << "<font color = yellow>[usr] begins to Repair [src]!<br>"
											spawn(Time)
												if(usr)
													if(src && O && usr.loc == LOC)
														if(usr.Job == "Repair Door" && usr.CantDoTask == 0)
															HasIngot = 0
															for(var/obj/Items/Resources/Ingot/I in usr)
																usr.Weight -= I.Weight
																del(I)
																HasIngot = 1
																break
															var/Fail = prob(50 - usr.Agility / 2 - usr.Intelligence / 2)
															usr.Job = null
															usr.MovementCheck()
															if(HasIngot == 0)
																usr << "<font color = red>Iron Ingot was moved, crafting stopped!<br>"
																return
															if(Fail)
																range(src) << "<font color = yellow>[usr] fails at Repairing the [src]!<br>"
																return
															if(src.Dura <= usr.ForgingSkill * 2 + 4001)
																src.Dura = usr.ForgingSkill * 2 + 4001
															range(src) << "<font color = yellow>[usr] finishes Repairing the [src]!<br>"
															return
											return
										if(Result == "Repair Lock")
											var/obj/Lock = null
											for(var/obj/Items/Misc/Lock/L in src)
												Lock = L
											var/CanRepair = 1
											for(var/mob/M in range(1,src))
												if(M != usr)
													CanRepair = 0
											if(CanRepair == 0)
												usr << "<font color = red>Cant Repair with others near!<br>"
												return
											if(Lock.Dura >= usr.ForgingSkill * 2)
												usr << "<font color = red>This lock is beyond your skill to repair!<br>"
												return
											var/LOC = usr.loc
											usr.Job = "Repair Lock"
											usr.Ref = null
											usr.CanMove = 0
											var/Time = 600 - usr.Agility - usr.Intelligence
											if(Time <= 50)
												Time = 50
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.InvenUp = 0
											usr.ResetButtons()
											for(var/obj/HUD/B in usr.client.screen)
												if(B.Type == "Inventory")
													B.icon_state = "inv off"
											range(src) << "<font color = yellow>[usr] begins to Repair the [Lock] inside [src]!<br>"
											spawn(Time)
												if(usr)
													if(src && O && usr.loc == LOC)
														if(usr.Job == "Repair Lock" && usr.CantDoTask == 0)
															var/Fail = prob(50 - usr.Agility / 2 - usr.Intelligence / 2)
															usr.Job = null
															usr.MovementCheck()
															if(Fail)
																range(src) << "<font color = yellow>[usr] fails at Repairing the [Lock] inside [src]!<br>"
																return
															if(Lock.Dura <= usr.ForgingSkill * 2 + 1)
																Lock.Dura = usr.ForgingSkill * 2 + 1
															range(src) << "<font color = yellow>[usr] finishes Repairing the [Lock] inside [src]!<br>"
															return
											return
									if(O.Type == "Key")
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged!<br>"
											return
										if(src.density == 0)
											usr << "<font color = red>You need to shut the door first before trying to Lock or Un-Lock it!<br>"
											return
										if(O.tag == "Inquisitor Vault Key")
											O.KeyCode = src.KeyCode
										if(O.KeyCode == src.KeyCode)
											if(src.Locked == 0)
												view() << "<font color = yellow>[usr] Locks [src] using their [O]!<br>"
												src.Locked = 1
												for(var/mob/M in Players)
													if(M.Admin)
														M << "<font color = teal>([usr.key])[usr] Locks the Inquisitor Vault Door!<br>"
												usr.Ref = null
												return
											if(src.Locked)
												view() << "<font color = yellow>[usr] Un-Locks [src] using their [O]!<br>"
												src.Locked = 0
												for(var/mob/M in Players)
													if(M.Admin)
														M << "<font color = teal>([usr.key])[usr] Un-Locks the Inquisitor Vault Door!<br>"
												usr.Ref = null
												return
										else
											usr << "<font color = red>That is the wrong key for this door!<br>"
											return
									if(O.Type == "Lock" && O.suffix)
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged to do that!<br>"
											return
										if(src.KeyCode)
											usr << "<font color = red>This door appears to already have a Lock Fitted.<br>"
											return
										var/CanFit = 0
										if(src.density && src.opacity)
											CanFit = 1
										if(CanFit == 0)
											usr << "<font color = red>The door must be closed in order to continue!<br>"
											return
										if(usr.Weapon)
											var/obj/T = usr.Weapon
											if(T.Type == "Hammer")
												var/LOC = usr.loc
												usr.Job = "Fit Lock"
												usr.Ref = null
												usr.CanMove = 0
												var/Time = 300 - usr.ForgingSkill * 1.5 - usr.Agility / 2 - usr.Intelligence
												if(Time <= 50)
													Time = 50
												usr.DeleteInventoryMenu()
												if(usr.InvenUp)
													usr.InvenUp = 0
												usr.ResetButtons()
												for(var/obj/HUD/B in usr.client.screen)
													if(B.Type == "Inventory")
														B.icon_state = "inv off"
												view(usr) << "<font color = yellow>[usr] begins to fit the [O] into [src]!<br>"
												spawn(Time)
													if(usr)
														if(src && O && usr.loc == LOC)
															if(usr.Job == "Fit Lock" && usr.CantDoTask == 0)
																var/Fail = prob(50 - usr.ForgingSkill - usr.Agility / 4 - usr.Intelligence / 2)
																usr.Job = null
																usr.MovementCheck()
																if(Fail)
																	view(usr) << "<font color = yellow>[usr] fails at fitting a [O] into [src]!<br>"
																	usr.ForgingSkill += usr.ForgingSkillMulti / 2
																	usr.GainStats(3,"Yes")
																	return
																usr.Weight -= O.Weight
																O.loc = src
																O.overlays = null
																O.suffix = "Fitted"
																O.icon_state = "[O.icon_state] fitted door"
																O.pixel_x = -3
																O.pixel_y = 2
																src.KeyCode = O.KeyCode
																src.overlays += O
																usr.ForgingSkill += usr.ForgingSkillMulti
																usr.GainStats(2,"Yes")
																view(usr) << "<font color = yellow>[usr] finishes fitting the [O] into [src]!<br>"
																return
												return
											else
												usr << "<font color = red>You need a Hammer in order to fit Locks!<br>"
												return
										else
											usr << "<font color = red>You need a Hammer in order to fit Locks!<br>"
											return
						if(usr.Function == "Combat" && src.suffix == "Stuck" && usr.Job == null && src.density)
							if(usr in range(1,src))
								for(var/mob/NPC/Good/G in range(6,usr))
									if(G.Target == null)
										G.Target = usr
										view(6,G) << "<font color = teal>[G] notices you try to attack the [src] and so attacks you!<br>"
								var/list/menu = new()
								menu += "Attack Door"
								if(src.KeyCode)
									menu += "Attack Lock"
								menu += "Cancel"
								var/Result = input(usr,"Choose an Area of the door to attack.", "Choose", null) in menu
								if (Result == "Cancel")
									return
								if (Result == "Attack Lock")
									if(usr.CantDoTask)
										usr << "<font color = red>Cant attack that for a while!<br>"
										return
									for(var/obj/Items/Misc/Lock/L in src)
										view(usr) << "<font color = red>[usr] begins an attempt at breaking [src]'s [L]!<br>"
										usr.Job = "SmashLock"
										usr.CanMove = 0
										usr.CantDoTask = 1
										spawn(150)
											if(usr)
												usr.CantDoTask = 0
										var/LOC = usr.loc
										var/Time = 150 - usr.Agility / 2
										if(Time <= 10)
											Time = 10
										spawn(Time)
											if(L && usr && src && usr.loc == LOC && usr.Job == "SmashLock" && src.density && src.suffix == "Stuck")
												var/DMG = usr.Strength
												var/Holding = 0
												if(usr.Weapon)
													Holding += 1
													var/obj/W = usr.Weapon
													if(W.ObjectTag == "Weapon")
														DMG += W.Weight / 2
														W.Dura -= rand(0.1,2)
														if(W.ObjectType == "Blunt")
															DMG += 10
														if(W.TwoHander && usr.Weapon2 == null)
															DMG += W.Weight / 2
														usr.CheckWeaponDura(W)
												if(usr.Weapon2)
													Holding += 1
													var/obj/W = usr.Weapon2
													if(W.ObjectTag == "Weapon")
														DMG += W.Weight / 2
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
												var/WontDamage = 50 - usr.Strength
												var/CantDamage = prob(WontDamage)
												if(DMG >= 0 && CantDamage != 1)
													L.Dura -= DMG
													if(L.Dura <= 0)
														usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [L] open<br>")
														range(src) << "<font color = red>[src] makes a loud metallic noise as the [L] inside it breaks away after [usr] attacks it!<br>"
														src.KeyCode = null
														src.overlays = null
														var/Jam = prob(50)
														if(Jam)
															range(src) << "<font color = red>[src] appears to have become Jammed!<br>"
														else
															src.Locked = 0
														del(L)
													else
														range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] damages the [L] inside!<br>"
													return
												else
													range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] tries to damage the [L]!<br>"
													return
											else
												if(usr)
													usr.MovementCheck()
										return
								if (Result == "Attack Door")
									if(usr.CantDoTask)
										usr << "<font color = red>Cant attack that for a while!<br>"
										return
									view(usr) << "<font color = red>[usr] begins an attempt at breaking the [src] down!<br>"
									usr.Job = "SmashDoor"
									usr.CanMove = 0
									usr.CantDoTask = 1
									spawn(150)
										if(usr)
											usr.CantDoTask = 0
									var/LOC = usr.loc
									var/Time = 150 - usr.Agility / 2
									if(Time <= 10)
										Time = 10
									spawn(Time)
										if(usr && src && usr.loc == LOC && usr.Job == "SmashDoor" && src.density && src.suffix == "Stuck")
											var/DMG = usr.Strength
											var/Holding = 0
											if(usr.Weapon)
												Holding += 1
												var/obj/W = usr.Weapon
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
													W.Dura -= rand(0.1,2)
													if(W.ObjectType == "Blunt")
														DMG += 10
													if(W.TwoHander && usr.Weapon2 == null)
														DMG += W.Weight / 2
													usr.CheckWeaponDura(W)
											if(usr.Weapon2)
												Holding += 1
												var/obj/W = usr.Weapon2
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
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
											var/WontDamage = 75 - usr.Strength
											var/CantDamage = prob(WontDamage)
											if(DMG >= 0 && CantDamage != 1)
												src.Dura -= DMG
												if(src.Dura <= 0)
													usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [src] open<br>")
													range(src) << "<font color = red>[src] makes a thunderous noise as it bends and crinkles as [usr] attacks it!<br>"
													del(src)
												else
													range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] damages it!<br>"
												return
											else
												range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] tried to damage it!<br>"
												return
										else
											if(usr)
												usr.MovementCheck()
									return
						if(usr.Function == "Examine")
							usr << "<font color=teal>[src.desc]<br>"
							if(src in range(1,usr))
								for(var/obj/Items/Misc/Lock/L in src)
									usr << "<font color=teal>[src] appears to have an [L] inside it.<br>"
								var/Known = 0
								for(var/obj/Items/F in usr.CreateList)
									if(F.type == src.type)
										Known = 1
								if(Known == 0)
									if(src.CanBeCrafted)
										var/obj/W = new src.type()
										W.layer = 100
										W.suffix = "None"
										usr.CreateList += W
										var/KnowsKey = 0
										for(var/obj/I in usr.CreateList)
											if(I.type == /obj/Items/Misc/Key/)
												KnowsKey = 1
										if(KnowsKey == 0)
											var/Mats = list("Iron","Copper","Gold")
											for(var/M in Mats)
												var/obj/Items/Misc/Key/K = new
												K.layer = 100
												K.Material = "[M]"
												K.icon_state = "[M] key"
												usr.CreateList += K
										var/KnowsLock = 0
										for(var/obj/I in usr.CreateList)
											if(I.type == /obj/Items/Misc/Lock/)
												KnowsLock = 1
										if(KnowsLock == 0)
											var/Mats = list("Iron","Copper","Gold")
											for(var/M in Mats)
												var/obj/Items/Misc/Lock/L = new
												L.layer = 100
												L.Material = "[M]"
												L.icon_state = "[M] lock"
												usr.CreateList += L
										usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
									else
										usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
							return
						if(usr.Function == "Interact" && src.suffix == "Stuck")
							switch(alert("Knock on the door, or open/close it?",,"Cancel","Knock","Open/Close"))
								if("Knock")
									var/CanOpen = 0
									if(usr in range(1,src))
										CanOpen = 1
									if(usr.CanUseTK)
										CanOpen = 1
									if(CanOpen)
										if(usr.Dead)
											return
										if(src.density)
											range(6,src) << "<font color = yellow>A knocking noise can be heard from the [src]!<br>"
											return
								if("Open/Close")
									var/CanOpen = 0
									if(usr in range(1,src))
										CanOpen = 1
									if(usr.CanUseTK)
										CanOpen = 1
									if(CanOpen)
										if(usr.Dead)
											return
										if(src.Locked)
											usr << "<font color = red>This door is Locked tight!<br>"
											return
										if(src.density)
											src.density = 0
											src.opacity = 0
											src.icon_state = "Inquisitor Iron door open"
											view(5) << 'WoodDoor.wav'
											if(usr.CanUseTK)
												var/obj/Misc/SpellEffects/Dispel/D = new
												src.overlays += D
												var/obj/Misc/SpellEffects/Dispel/D2 = new
												usr.overlays += D2
												spawn(10)
													if(usr)
														usr.overlays -= D2
														del(D2)
													if(src)
														src.overlays -= D
														del(D)
											return
										if(src.density == 0)
											src.density = 1
											src.opacity = 1
											src.icon_state = "Inquisitor Iron door"
											view(5) << 'WoodDoor2.wav'
											if(usr.CanUseTK)
												var/obj/Misc/SpellEffects/Dispel/D = new
												src.overlays += D
												var/obj/Misc/SpellEffects/Dispel/D2 = new
												usr.overlays += D2
												spawn(10)
													if(usr)
														usr.overlays -= D2
														del(D2)
													if(src)
														src.overlays -= D
														del(D)
											return
				Door
					icon_state = "Iron door"
					name = "Iron Door"
					density = 1
					opacity = 1
					suffix = "Stuck"
					Weight = 40
					Fuel = 0
					Dura = 450
					CanBeCrafted = 1
					Material = "Iron"
					Click()
						if(usr.Function == "Interact" && usr.Ref)
							if(usr in range(1,src))
								if(isobj(usr.Ref))
									var/obj/O = usr.Ref
									if(O.Type == "Hammer")
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged!<br>"
											return
										if(src.density == 0)
											usr << "<font color = red>You need to shut the door first before trying to Repair it!<br>"
											return
										if(O != usr.Weapon)
											usr << "<font color = red>Equip the Hammer first!<br>"
											return
										var/list/menu = new()
										menu += "Repair Door"
										if(src.KeyCode)
											menu += "Repair Lock"
										menu += "Cancel"
										var/Result = input(usr,"Choose an Area of the door to repair.", "Choose", null) in menu
										if (Result == "Cancel")
											return
										if(Result == "Repair Door")
											var/HasIngot = 0
											for(var/obj/Items/Resources/Ingot/I in usr)
												if(I.Material == "Iron")
													HasIngot = 1
													break
											var/CanRepair = 1
											for(var/mob/M in range(1,src))
												if(M != usr)
													CanRepair = 0
											if(HasIngot == 0)
												usr << "<font color = red>You will need one Iron Ingot to Repair this door!<br>"
												return
											if(CanRepair == 0)
												usr << "<font color = red>Cant Repair with others near!<br>"
												return
											if(src.Dura >= usr.ForgingSkill * 2 + 450)
												usr << "<font color = red>This door is beyond your skill to repair!<br>"
												return
											var/LOC = usr.loc
											usr.Job = "Repair Door"
											usr.Ref = null
											usr.CanMove = 0
											var/Time = 600 - usr.Agility - usr.Intelligence
											if(Time <= 50)
												Time = 50
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.InvenUp = 0
											usr.ResetButtons()
											for(var/obj/HUD/B in usr.client.screen)
												if(B.Type == "Inventory")
													B.icon_state = "inv off"
											range(src) << "<font color = yellow>[usr] begins to Repair [src]!<br>"
											spawn(Time)
												if(usr)
													if(src && O && usr.loc == LOC)
														if(usr.Job == "Repair Door" && usr.CantDoTask == 0)
															HasIngot = 0
															for(var/obj/Items/Resources/Ingot/I in usr)
																usr.Weight -= I.Weight
																del(I)
																HasIngot = 1
																break
															var/Fail = prob(50 - usr.Agility / 2 - usr.Intelligence / 2)
															usr.Job = null
															usr.MovementCheck()
															if(HasIngot == 0)
																usr << "<font color = red>Iron Ingot was moved, crafting stopped!<br>"
																return
															if(Fail)
																range(src) << "<font color = yellow>[usr] fails at Repairing the [src]!<br>"
																return
															if(src.Dura <= usr.ForgingSkill * 2 + 451)
																src.Dura = usr.ForgingSkill * 2 + 451
															range(src) << "<font color = yellow>[usr] finishes Repairing the [src]!<br>"
															return
											return
										if(Result == "Repair Lock")
											var/obj/Lock = null
											for(var/obj/Items/Misc/Lock/L in src)
												Lock = L
											var/CanRepair = 1
											for(var/mob/M in range(1,src))
												if(M != usr)
													CanRepair = 0
											if(CanRepair == 0)
												usr << "<font color = red>Cant Repair with others near!<br>"
												return
											if(Lock.Dura >= usr.ForgingSkill * 2)
												usr << "<font color = red>This lock is beyond your skill to repair!<br>"
												return
											var/LOC = usr.loc
											usr.Job = "Repair Lock"
											usr.Ref = null
											usr.CanMove = 0
											var/Time = 600 - usr.Agility - usr.Intelligence
											if(Time <= 50)
												Time = 50
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.InvenUp = 0
											usr.ResetButtons()
											for(var/obj/HUD/B in usr.client.screen)
												if(B.Type == "Inventory")
													B.icon_state = "inv off"
											range(src) << "<font color = yellow>[usr] begins to Repair the [Lock] inside [src]!<br>"
											spawn(Time)
												if(usr)
													if(src && O && usr.loc == LOC)
														if(usr.Job == "Repair Lock" && usr.CantDoTask == 0)
															var/Fail = prob(50 - usr.Agility / 2 - usr.Intelligence / 2)
															usr.Job = null
															usr.MovementCheck()
															if(Fail)
																range(src) << "<font color = yellow>[usr] fails at Repairing the [Lock] inside [src]!<br>"
																return
															if(Lock.Dura <= usr.ForgingSkill * 2 + 1)
																Lock.Dura = usr.ForgingSkill * 2 + 1
															range(src) << "<font color = yellow>[usr] finishes Repairing the [Lock] inside [src]!<br>"
															return
											return
									if(O.Type == "Key")
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged!<br>"
											return
										if(src.density == 0)
											usr << "<font color = red>You need to shut the door first before trying to Lock or Un-Lock it!<br>"
											return
										if(O.KeyCode == src.KeyCode)
											if(src.Locked == 0)
												view() << "<font color = yellow>[usr] Locks [src] using their [O]!<br>"
												src.Locked = 1
												usr.Ref = null
												return
											if(src.Locked)
												view() << "<font color = yellow>[usr] Un-Locks [src] using their [O]!<br>"
												src.Locked = 0
												usr.Ref = null
												return
										else
											usr << "<font color = red>That is the wrong key for this door!<br>"
											return
									if(O.Type == "Lock" && O.suffix)
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged to do that!<br>"
											return
										if(src.KeyCode)
											usr << "<font color = red>This door appears to already have a Lock Fitted.<br>"
											return
										var/CanFit = 0
										if(src.density && src.opacity)
											CanFit = 1
										if(CanFit == 0)
											usr << "<font color = red>The door must be closed in order to continue!<br>"
											return
										if(usr.Weapon)
											var/obj/T = usr.Weapon
											if(T.Type == "Hammer")
												var/LOC = usr.loc
												usr.Job = "Fit Lock"
												usr.Ref = null
												usr.CanMove = 0
												var/Time = 300 - usr.ForgingSkill * 1.5 - usr.Agility / 2 - usr.Intelligence
												if(Time <= 50)
													Time = 50
												usr.DeleteInventoryMenu()
												if(usr.InvenUp)
													usr.InvenUp = 0
												usr.ResetButtons()
												for(var/obj/HUD/B in usr.client.screen)
													if(B.Type == "Inventory")
														B.icon_state = "inv off"
												view(usr) << "<font color = yellow>[usr] begins to fit the [O] into [src]!<br>"
												spawn(Time)
													if(usr)
														if(src && O && usr.loc == LOC)
															if(usr.Job == "Fit Lock" && usr.CantDoTask == 0)
																var/Fail = prob(50 - usr.ForgingSkill - usr.Agility / 4 - usr.Intelligence / 2)
																usr.Job = null
																usr.MovementCheck()
																if(Fail)
																	view(usr) << "<font color = yellow>[usr] fails at fitting a [O] into [src]!<br>"
																	usr.ForgingSkill += usr.ForgingSkillMulti / 2
																	usr.GainStats(3,"Yes")
																	return
																usr.Weight -= O.Weight
																O.loc = src
																O.overlays = null
																O.suffix = "Fitted"
																O.icon_state = "[O.icon_state] fitted door"
																O.pixel_x = -3
																O.pixel_y = 2
																src.KeyCode = O.KeyCode
																src.overlays += O
																usr.ForgingSkill += usr.ForgingSkillMulti
																usr.GainStats(2,"Yes")
																view(usr) << "<font color = yellow>[usr] finishes fitting the [O] into [src]!<br>"
																return
												return
											else
												usr << "<font color = red>You need a Hammer in order to fit Locks!<br>"
												return
										else
											usr << "<font color = red>You need a Hammer in order to fit Locks!<br>"
											return
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
									usr.Job = "Metal Door"
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
									view(usr) << "<font color = yellow>[usr] begins to forge the [O] into a [src] !<br>"
									spawn(Time)
										if(usr)
											if(Ingots)
												for(var/obj/I in Ingots)
													if(I in usr)
														IngotNum += 1
														if(IngotNum == 5)
															break
											if(IngotNum == 5 && usr.Job == "Metal Door")
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
														W.icon_state = "[W.Material] door"
														W.name = "[W.Material] Door"
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
														usr << "<font color = teal>The door is now laying flat on the floor, in order to make it dense, you must Click Interact then Click the door while its in your Inventory.<br>"
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
						if(usr.Function == "Interact" && src.suffix == "Carried")
							var/CanPlace = 1
							for(var/obj/O in range(0,usr))
								if(O.suffix == "Stuck")
									CanPlace = 0
							if(CanPlace)
								usr << "<font color = green>You place the [src] down and secure it!<br>"
								src.suffix = "Stuck"
								src.opacity = 1
								src.density = 1
								src.loc = usr.loc
								usr.Weight -= src.Weight
								src.overlays = null
								if(usr.InvenUp)
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
								return
						if(usr.Function == "Combat" && src.suffix == "Stuck" && usr.Job == null && src.density)
							if(usr in range(1,src))
								var/list/menu = new()
								menu += "Attack Door"
								if(src.KeyCode)
									menu += "Attack Lock"
								menu += "Cancel"
								var/Result = input(usr,"Choose an Area of the door to attack.", "Choose", null) in menu
								if (Result == "Cancel")
									return
								if (Result == "Attack Lock")
									if(usr.CantDoTask)
										usr << "<font color = red>Cant attack that for a while!<br>"
										return
									for(var/obj/Items/Misc/Lock/L in src)
										view(usr) << "<font color = red>[usr] begins an attempt at breaking [src]'s [L]!<br>"
										usr.Job = "SmashLock"
										usr.CanMove = 0
										usr.CantDoTask = 1
										spawn(150)
											if(usr)
												usr.CantDoTask = 0
										var/LOC = usr.loc
										var/Time = 150 - usr.Agility / 2
										if(Time <= 10)
											Time = 10
										spawn(Time)
											if(L && usr && src && usr.loc == LOC && usr.Job == "SmashLock" && src.density && src.suffix == "Stuck")
												var/DMG = usr.Strength
												var/Holding = 0
												if(usr.Weapon)
													Holding += 1
													var/obj/W = usr.Weapon
													if(W.ObjectTag == "Weapon")
														DMG += W.Weight / 2
														W.Dura -= rand(0.1,2)
														if(W.ObjectType == "Blunt")
															DMG += 10
														if(W.TwoHander && usr.Weapon2 == null)
															DMG += W.Weight / 2
														usr.CheckWeaponDura(W)
												if(usr.Weapon2)
													Holding += 1
													var/obj/W = usr.Weapon2
													if(W.ObjectTag == "Weapon")
														DMG += W.Weight / 2
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
												var/WontDamage = 50 - usr.Strength
												var/CantDamage = prob(WontDamage)
												if(DMG >= 0 && CantDamage != 1)
													L.Dura -= DMG
													if(L.Dura <= 0)
														range(src) << "<font color = red>[src] makes a loud metallic noise as the [L] inside it breaks away after [usr] attacks it!<br>"
														usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [L] open<br>")
														src.KeyCode = null
														src.overlays = null
														var/Jam = prob(50)
														if(Jam)
															range(src) << "<font color = red>[src] appears to have become Jammed!<br>"
														else
															src.Locked = 0
														del(L)
													else
														range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] damages the [L] inside!<br>"
													return
												else
													range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] tries to damage the [L]!<br>"
													return
											else
												if(usr)
													usr.MovementCheck()
										return
								if (Result == "Attack Door")
									if(usr.CantDoTask)
										usr << "<font color = red>Cant attack that for a while!<br>"
										return
									view(usr) << "<font color = red>[usr] begins an attempt at breaking the [src] down!<br>"
									usr.Job = "SmashDoor"
									usr.CanMove = 0
									usr.CantDoTask = 1
									spawn(150)
										if(usr)
											usr.CantDoTask = 0
									var/LOC = usr.loc
									var/Time = 150 - usr.Agility / 2
									if(Time <= 10)
										Time = 10
									spawn(Time)
										if(usr && src && usr.loc == LOC && usr.Job == "SmashDoor" && src.density && src.suffix == "Stuck")
											var/DMG = usr.Strength
											var/Holding = 0
											if(usr.Weapon)
												Holding += 1
												var/obj/W = usr.Weapon
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
													W.Dura -= rand(0.1,2)
													if(W.ObjectType == "Blunt")
														DMG += 10
													if(W.TwoHander && usr.Weapon2 == null)
														DMG += W.Weight / 2
													usr.CheckWeaponDura(W)
											if(usr.Weapon2)
												Holding += 1
												var/obj/W = usr.Weapon2
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
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
											var/WontDamage = 75 - usr.Strength
											var/CantDamage = prob(WontDamage)
											if(DMG >= 0 && CantDamage != 1)
												src.Dura -= DMG
												if(src.Dura <= 0)
													usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [src] open<br>")
													range(src) << "<font color = red>[src] makes a thunderous noise as it bends and crinkles as [usr] attacks it!<br>"
													del(src)
												else
													range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] damages it!<br>"
												return
											else
												range(src) << "<font color = red>[src] makes a loud metallic noise as [usr] tried to damage it!<br>"
												return
										else
											if(usr)
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
							usr << "<font color=teal>[src.desc]<br>"
							if(src in range(1,usr))
								for(var/obj/Items/Misc/Lock/L in src)
									usr << "<font color=teal>[src] appears to have an [L] inside it.<br>"
								var/Known = 0
								for(var/obj/Items/F in usr.CreateList)
									if(F.type == src.type)
										Known = 1
								if(Known == 0)
									if(src.CanBeCrafted)
										var/DoorMats = list("Iron","Copper","Gold")
										for(var/M in DoorMats)
											var/obj/W = new src.type()
											W.layer = 100
											W.Material = "[M]"
											W.icon_state = "[M] door"
											W.name = "[M] Door"
											W.suffix = "None"
											usr.CreateList += W
										var/KnowsKey = 0
										for(var/obj/I in usr.CreateList)
											if(I.type == /obj/Items/Misc/Key/)
												KnowsKey = 1
										if(KnowsKey == 0)
											var/Mats = list("Iron","Copper","Gold")
											for(var/M in Mats)
												var/obj/Items/Misc/Key/K = new
												K.layer = 100
												K.Material = "[M]"
												K.icon_state = "[M] key"
												usr.CreateList += K
										var/KnowsLock = 0
										for(var/obj/I in usr.CreateList)
											if(I.type == /obj/Items/Misc/Lock/)
												KnowsLock = 1
										if(KnowsLock == 0)
											var/Mats = list("Iron","Copper","Gold")
											for(var/M in Mats)
												var/obj/Items/Misc/Lock/L = new
												L.layer = 100
												L.Material = "[M]"
												L.icon_state = "[M] lock"
												usr.CreateList += L
										usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
									else
										usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
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
						if(usr.Function == "Interact" && src.suffix == "Stuck")
							switch(alert("Knock on the door, or open/close it?",,"Cancel","Knock","Open/Close"))
								if("Knock")
									var/CanOpen = 0
									if(usr in range(1,src))
										CanOpen = 1
									if(usr.CanUseTK)
										CanOpen = 1
									if(CanOpen)
										if(usr.Dead)
											return
										if(src.density)
											range(6,src) << "<font color = yellow>A knocking noise can be heard from the [src]!<br>"
											return
								if("Open/Close")
									var/CanOpen = 0
									if(usr in range(1,src))
										CanOpen = 1
									if(usr.CanUseTK)
										CanOpen = 1
									if(CanOpen)
										if(usr.Dead)
											return
										if(src.Locked)
											usr << "<font color = red>This door is Locked tight!<br>"
											return
										if(src.density)
											src.density = 0
											src.opacity = 0
											src.icon_state = "[src.Material] door open"
											src.overlays = null
											view(5) << 'WoodDoor.wav'
											if(usr.CanUseTK)
												var/obj/Misc/SpellEffects/Dispel/D = new
												src.overlays += D
												var/obj/Misc/SpellEffects/Dispel/D2 = new
												usr.overlays += D2
												spawn(10)
													if(usr)
														usr.overlays -= D2
														del(D2)
													if(src)
														src.overlays -= D
														del(D)
											return
										if(src.density == 0)
											src.density = 1
											src.opacity = 1
											src.icon_state = "[src.Material] door"
											if(src.KeyCode)
												for(var/obj/I in src)
													src.overlays += I
											view(5) << 'WoodDoor2.wav'
											if(usr.CanUseTK)
												var/obj/Misc/SpellEffects/Dispel/D = new
												src.overlays += D
												var/obj/Misc/SpellEffects/Dispel/D2 = new
												usr.overlays += D2
												spawn(10)
													if(usr)
														usr.overlays -= D2
														del(D2)
													if(src)
														src.overlays -= D
														del(D)
											return
				WoodenDoor
					icon_state = "Wood door"
					density = 1
					opacity = 1
					suffix = "Stuck"
					Weight = 20
					Fuel = 100
					Dura = 150
					CanBeCrafted = 1
					Material = "Wood"
					Click()
						if(usr.Function == "Interact" && usr.Ref)
							if(usr in range(1,src))
								if(isobj(usr.Ref))
									var/obj/O = usr.Ref
									if(O.Type == "Saw")
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged!<br>"
											return
										if(src.density == 0)
											usr << "<font color = red>You need to shut the door first before trying to Repair it!<br>"
											return
										if(O != usr.Weapon)
											usr << "<font color = red>Equip the Saw first!<br>"
											return
										var/list/menu = new()
										menu += "Repair Door"
										if(src.KeyCode)
											menu += "Repair Lock"
										menu += "Cancel"
										var/Result = input(usr,"Choose an Area of the door to repair.", "Choose", null) in menu
										if (Result == "Cancel")
											return
										if(Result == "Repair Door")
											var/HasPlank = 0
											for(var/obj/Items/Resources/Plank/P in usr)
												HasPlank = 1
												break
											var/CanRepair = 1
											for(var/mob/M in range(1,src))
												if(M != usr)
													CanRepair = 0
											if(HasPlank == 0)
												usr << "<font color = red>You will need one Wooden Plank to Repair this door!<br>"
												return
											if(CanRepair == 0)
												usr << "<font color = red>Cant Repair with others near!<br>"
												return
											if(src.Dura >= usr.CarpentrySkill * 2 + 150)
												usr << "<font color = red>This door is beyond your skill to repair!<br>"
												return
											var/LOC = usr.loc
											usr.Job = "Repair Door"
											usr.Ref = null
											usr.CanMove = 0
											var/Time = 600 - usr.Agility - usr.Intelligence
											if(Time <= 50)
												Time = 50
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.InvenUp = 0
											usr.ResetButtons()
											for(var/obj/HUD/B in usr.client.screen)
												if(B.Type == "Inventory")
													B.icon_state = "inv off"
											range(src) << "<font color = yellow>[usr] begins to Repair [src]!<br>"
											spawn(Time)
												if(usr)
													if(src && O && usr.loc == LOC)
														if(usr.Job == "Repair Door" && usr.CantDoTask == 0)
															HasPlank = 0
															for(var/obj/Items/Resources/Plank/P in usr)
																usr.Weight -= P.Weight
																del(P)
																HasPlank = 1
																break
															var/Fail = prob(50 - usr.Agility / 2 - usr.Intelligence / 2)
															usr.Job = null
															usr.MovementCheck()
															if(HasPlank == 0)
																usr << "<font color = red>Wooden Plank was moved, crafting stopped!<br>"
																return
															if(Fail)
																range(src) << "<font color = yellow>[usr] fails at Repairing the [src]!<br>"
																return
															if(src.Dura <= usr.CarpentrySkill * 2 + 151)
																src.Dura = usr.CarpentrySkill * 2 + 151
															range(src) << "<font color = yellow>[usr] finishes Repairing the [src]!<br>"
															return
											return
										if(Result == "Repair Lock")
											var/obj/Lock = null
											for(var/obj/Items/Misc/Lock/L in src)
												Lock = L
											var/CanRepair = 1
											for(var/mob/M in range(1,src))
												if(M != usr)
													CanRepair = 0
											if(CanRepair == 0)
												usr << "<font color = red>Cant Repair with others near!<br>"
												return
											if(Lock.Dura >= usr.ForgingSkill * 2)
												usr << "<font color = red>This lock is beyond your skill to repair!<br>"
												return
											var/LOC = usr.loc
											usr.Job = "Repair Lock"
											usr.Ref = null
											usr.CanMove = 0
											var/Time = 600 - usr.Agility - usr.Intelligence
											if(Time <= 50)
												Time = 50
											usr.DeleteInventoryMenu()
											if(usr.InvenUp)
												usr.InvenUp = 0
											usr.ResetButtons()
											for(var/obj/HUD/B in usr.client.screen)
												if(B.Type == "Inventory")
													B.icon_state = "inv off"
											range(src) << "<font color = yellow>[usr] begins to Repair the [Lock] inside [src]!<br>"
											spawn(Time)
												if(usr)
													if(src && O && usr.loc == LOC)
														if(usr.Job == "Repair Lock" && usr.CantDoTask == 0)
															var/Fail = prob(50 - usr.Agility / 2 - usr.Intelligence / 2)
															usr.Job = null
															usr.MovementCheck()
															if(Fail)
																range(src) << "<font color = yellow>[usr] fails at Repairing the [Lock] inside [src]!<br>"
																return
															if(Lock.Dura <= usr.ForgingSkill * 2 + 1)
																Lock.Dura = usr.ForgingSkill * 2 + 1
															range(src) << "<font color = yellow>[usr] finishes Repairing the [Lock] inside [src]!<br>"
															return
											return
									if(O.Type == "Key")
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged!<br>"
											return
										if(src.density == 0)
											usr << "<font color = red>You need to shut the door first before trying to Lock or Un-Lock it!<br>"
											return
										if(O.KeyCode == src.KeyCode)
											if(src.Locked == 0)
												view() << "<font color = yellow>[usr] Locks [src] using their [O]!<br>"
												src.Locked = 1
												usr.Ref = null
												return
											if(src.Locked)
												view() << "<font color = yellow>[usr] Un-Locks [src] using their [O]!<br>"
												src.Locked = 0
												usr.Ref = null
												return
										else
											usr << "<font color = red>That is the wrong key for this door!<br>"
											return
									if(O.Type == "Lock" && O.suffix)
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms == 0)
											usr << "<font color = red>Your Arms are far too damaged to do that!<br>"
											return
										if(src.KeyCode)
											usr << "<font color = red>This door appears to already have a Lock Fitted.<br>"
											return
										var/CanFit = 0
										if(src.density && src.opacity)
											CanFit = 1
										if(CanFit == 0)
											usr << "<font color = red>The door must be closed in order to continue!<br>"
											return
										if(usr.Weapon)
											var/obj/T = usr.Weapon
											if(T.Type == "Saw")
												var/LOC = usr.loc
												usr.Job = "Fit Lock"
												usr.Ref = null
												usr.CanMove = 0
												var/Time = 300 - usr.CarpentrySkill * 1.5 - usr.Agility / 2 - usr.Intelligence
												if(Time <= 50)
													Time = 50
												usr.DeleteInventoryMenu()
												if(usr.InvenUp)
													usr.InvenUp = 0
												usr.ResetButtons()
												for(var/obj/HUD/B in usr.client.screen)
													if(B.Type == "Inventory")
														B.icon_state = "inv off"
												view(usr) << "<font color = yellow>[usr] begins to fit the [O] into [src]!<br>"
												spawn(Time)
													if(usr)
														if(src && O && usr.loc == LOC)
															if(usr.Job == "Fit Lock" && usr.CantDoTask == 0)
																var/Fail = prob(50 - usr.CarpentrySkill - usr.Agility / 4 - usr.Intelligence / 2)
																usr.Job = null
																usr.MovementCheck()
																if(Fail)
																	view(usr) << "<font color = yellow>[usr] fails at fitting a [O] into [src]!<br>"
																	usr.CarpentrySkill += usr.CarpentrySkillMulti / 2
																	usr.GainStats(3,"Yes")
																	return
																usr.Weight -= O.Weight
																O.loc = src
																O.overlays = null
																O.suffix = "Fitted"
																O.icon_state = "[O.icon_state] fitted door"
																src.KeyCode = O.KeyCode
																src.overlays += O
																usr.CarpentrySkill += usr.CarpentrySkillMulti
																usr.GainStats(2,"Yes")
																view(usr) << "<font color = yellow>[usr] finishes fitting the [O] into [src]!<br>"
																return
												return
											else
												usr << "<font color = red>You need a Saw in order to fit Locks!<br>"
												return
										else
											usr << "<font color = red>You need a Saw in order to fit Locks!<br>"
											return
						if(usr.Function == "Combat" && src.suffix == "Stuck" && usr.Job == null && src.density)
							if(usr in range(1,src))
								var/list/menu = new()
								menu += "Attack Door"
								if(src.KeyCode)
									menu += "Attack Lock"
								menu += "Cancel"
								var/Result = input(usr,"Choose an Area of the door to attack.", "Choose", null) in menu
								if (Result == "Cancel")
									return
								if (Result == "Attack Lock")
									if(usr.CantDoTask)
										usr << "<font color = red>Cant attack that for a while!<br>"
										return
									for(var/obj/Items/Misc/Lock/L in src)
										view(usr) << "<font color = red>[usr] begins an attempt at breaking [src]'s [L]!<br>"
										usr.Job = "SmashLock"
										usr.CanMove = 0
										usr.CantDoTask = 1
										spawn(150)
											if(usr)
												usr.CantDoTask = 0
										var/LOC = usr.loc
										var/Time = 150 - usr.Agility / 2
										if(Time <= 10)
											Time = 10
										spawn(Time)
											if(L && usr && src && usr.loc == LOC && usr.Job == "SmashLock" && src.density && src.suffix == "Stuck")
												var/DMG = usr.Strength
												var/Holding = 0
												if(usr.Weapon)
													Holding += 1
													var/obj/W = usr.Weapon
													if(W.ObjectTag == "Weapon")
														DMG += W.Weight / 2
														W.Dura -= rand(0.1,2)
														if(W.ObjectType == "Blunt")
															DMG += 10
														if(W.TwoHander && usr.Weapon2 == null)
															DMG += W.Weight / 2
														usr.CheckWeaponDura(W)
												if(usr.Weapon2)
													Holding += 1
													var/obj/W = usr.Weapon2
													if(W.ObjectTag == "Weapon")
														DMG += W.Weight / 2
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
												var/WontDamage = 50 - usr.Strength
												var/CantDamage = prob(WontDamage)
												if(DMG >= 0 && CantDamage != 1)
													L.Dura -= DMG
													if(L.Dura <= 0)
														usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [L] open<br>")
														range(src) << "<font color = red>[src] makes a loud creaking noise as the [L] inside it breaks away after [usr] attacks it!<br>"
														src.KeyCode = null
														src.overlays = null
														var/Jam = prob(50)
														if(Jam)
															range(src) << "<font color = red>[src] appears to have become Jammed!<br>"
														else
															src.Locked = 0
														del(L)
													else
														range(src) << "<font color = red>[src] makes a loud creaking noise as [usr] damages the [L] inside!<br>"
													return
												else
													range(src) << "<font color = red>[src] makes a loud creaking noise as [usr] tries to damage the [L]!<br>"
													return
											else
												if(usr)
													usr.MovementCheck()
										return
								if (Result == "Attack Door")
									if(usr.CantDoTask)
										usr << "<font color = red>Cant attack that for a while!<br>"
										return
									view(usr) << "<font color = red>[usr] begins an attempt at breaking the [src] down!<br>"
									usr.Job = "SmashDoor"
									usr.CanMove = 0
									usr.CantDoTask = 1
									spawn(150)
										if(usr)
											usr.CantDoTask = 0
									var/LOC = usr.loc
									var/Time = 150 - usr.Agility / 2
									if(Time <= 10)
										Time = 10
									spawn(Time)
										if(usr && src && usr.loc == LOC && usr.Job == "SmashDoor" && src.density && src.suffix == "Stuck")
											var/DMG = usr.Strength
											var/Holding = 0
											if(usr.Weapon)
												Holding += 1
												var/obj/W = usr.Weapon
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
													W.Dura -= rand(0.1,2)
													if(W.ObjectType == "Axe")
														DMG += 15
													if(W.ObjectType == "Blunt")
														DMG += 10
													if(W.TwoHander && usr.Weapon2 == null)
														DMG += W.Weight / 2
													usr.CheckWeaponDura(W)
											if(usr.Weapon2)
												Holding += 1
												var/obj/W = usr.Weapon2
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
													W.Dura -= rand(0.1,2)
													if(W.ObjectType == "Axe")
														DMG += 15
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
											var/WontDamage = 50 - usr.Strength
											var/CantDamage = prob(WontDamage)
											if(DMG >= 0 && CantDamage != 1)
												src.Dura -= DMG
												if(src.Dura <= 0)
													usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [src] open<br>")
													range(src) << "<font color = red>[src] makes a loud creaking noise as it splinters into pieces after [usr] attacks it!<br>"
													del(src)
												else
													range(src) << "<font color = red>[src] makes a loud creaking noise as [usr] damages it!<br>"
												return
											else
												range(src) << "<font color = red>[src] makes a loud creaking noise as [usr] tried to damage it!<br>"
												return
										else
											if(usr)
												usr.MovementCheck()
									return
						if(usr.Job == null && src in usr.CreateList )
							if(usr.Ref)
								var/obj/O = usr.Ref
								if(O.Type != "Plank")
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									usr << "<font color = red>You need Four wooden Planks in order to create this item!<br>"
									return
								var/PlankNum = 0
								var/Planks = list()
								for(var/obj/Items/Resources/Plank/P in usr)
									if(PlankNum != 4)
										PlankNum += 1
										Planks += P
								if(PlankNum != 4)
									usr << "<font color = red>You need Four wooden Planks in order to create this item!<br>"
									return
								if(PlankNum == 4 && O.Type == "Plank")
									var/LOC = usr.loc
									usr.Job = "CreateDoor"
									usr.CanMove = 0
									var/Time = 200 - usr.CarpentrySkill * 1.5 - usr.Agility / 2 - usr.Intelligence
									if(Time <= 50)
										Time = 50
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									for(var/obj/HUD/B in usr.client.screen)
										if(B.Type == "Inventory")
											B.icon_state = "inv off"
									view(usr) << "<font color = yellow>[usr] begins to contruct the Planks into a [src] !<br>"
									spawn(Time)
										if(usr)
											if(Planks && usr.loc == LOC)
												PlankNum = 0
												Planks = null
												Planks = list()
												for(var/obj/Items/Resources/Plank/P in usr)
													if(PlankNum != 4)
														PlankNum += 1
														Planks += P
												if(PlankNum == 4 && O && usr.Job == "CreateDoor")
													var/Fail = prob(50 - usr.CarpentrySkill - usr.Agility / 4 - usr.Intelligence / 2)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
														for(var/obj/I in Planks)
															if(PlankNum != 0)
																PlankNum -= 1
																usr.Weight -= I.Weight
																del(I)
														usr.CarpentrySkill += usr.CarpentrySkillMulti / 2
														usr.GainStats(3,"Yes")
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.Dura += usr.CarpentrySkill * 2
													W.suffix = null
													W.density = 0
													W.opacity = 0
													for(var/obj/I in Planks)
														if(PlankNum != 0)
															PlankNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.CarpentrySkill += usr.CarpentrySkillMulti
													usr.GainStats(2,"Yes")
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													usr << "<font color = teal>The door is now laying flat on the floor, in order to make it dense, you must Click Interact then Click the door while its in your Inventory.<br>"
													return
												else
													usr << "<font color = red>Planks could not be found in your inventory, crafting failed!<br>"
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>Planks could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
												usr.MovementCheck()
												return
						if(usr.Function == "Interact" && src.suffix == "Carried")
							var/CanPlace = 1
							for(var/obj/O in range(0,usr))
								if(O.suffix == "Stuck")
									CanPlace = 0
							if(CanPlace)
								usr << "<font color = green>You place the [src] down and secure it!<br>"
								src.suffix = "Stuck"
								src.opacity = 1
								src.density = 1
								src.loc = usr.loc
								usr.Weight -= src.Weight
								src.overlays = null
								if(usr.InvenUp)
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
								var/InTiles = 0
								for(var/turf/T in range(0,usr))
									if(T in Tiles)
										InTiles = 1
									if(InTiles == 0)
										Tiles += T
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
							usr << "<font color=teal>[src.desc]<br>"
							if(src in range(1,usr))
								for(var/obj/Items/Misc/Lock/L in src)
									usr << "<font color=teal>[src] appears to have an [L] inside it.<br>"
								var/Known = 0
								for(var/obj/Items/F in usr.CreateList)
									if(F.type == src.type)
										Known = 1
								if(Known == 0)
									if(src.CanBeCrafted)
										var/obj/W = new src.type()
										W.layer = 100
										W.suffix = "None"
										usr.CreateList += W
										var/KnowsKey = 0
										for(var/obj/I in usr.CreateList)
											if(I.type == /obj/Items/Misc/Key/)
												KnowsKey = 1
										if(KnowsKey == 0)
											var/Mats = list("Iron","Copper","Gold")
											for(var/M in Mats)
												var/obj/Items/Misc/Key/K = new
												K.layer = 100
												K.Material = "[M]"
												K.icon_state = "[M] key"
												usr.CreateList += K
										var/KnowsLock = 0
										for(var/obj/I in usr.CreateList)
											if(I.type == /obj/Items/Misc/Lock/)
												KnowsLock = 1
										if(KnowsLock == 0)
											var/Mats = list("Iron","Copper","Gold")
											for(var/M in Mats)
												var/obj/Items/Misc/Lock/L = new
												L.layer = 100
												L.Material = "[M]"
												L.icon_state = "[M] lock"
												usr.CreateList += L
										usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
									else
										usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
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
						if(usr.Function == "Interact" && src.suffix == "Stuck")
							switch(alert("Knock on the door, or open/close it?",,"Cancel","Knock","Open/Close"))
								if("Knock")
									var/CanOpen = 0
									if(usr in range(1,src))
										CanOpen = 1
									if(usr.CanUseTK)
										CanOpen = 1
									if(CanOpen)
										if(usr.Dead)
											return
										if(src.density)
											range(6,src) << "<font color = yellow>A knocking noise can be heard from the [src]!<br>"
											return
								if("Open/Close")
									var/CanOpen = 0
									if(usr in range(1,src))
										CanOpen = 1
									if(usr.CanUseTK)
										CanOpen = 1
									if(CanOpen)
										if(usr.Dead)
											return
										if(src.Locked)
											usr << "<font color = red>This door is Locked tight!<br>"
											return
										if(src.density)
											src.density = 0
											src.opacity = 0
											src.icon_state = "Wood door open"
											src.overlays = null
											view(5) << 'WoodDoor.wav'
											if(usr.CanUseTK)
												var/obj/Misc/SpellEffects/Dispel/D = new
												src.overlays += D
												var/obj/Misc/SpellEffects/Dispel/D2 = new
												usr.overlays += D2
												spawn(10)
													if(usr)
														usr.overlays -= D2
														del(D2)
													if(src)
														src.overlays -= D
														del(D)
											return
										if(src.density == 0)
											src.density = 1
											src.opacity = 1
											src.icon_state = "Wood door"
											if(src.KeyCode)
												for(var/obj/I in src)
													src.overlays += I
											view(5) << 'WoodDoor2.wav'
											if(usr.CanUseTK)
												var/obj/Misc/SpellEffects/Dispel/D = new
												src.overlays += D
												var/obj/Misc/SpellEffects/Dispel/D2 = new
												usr.overlays += D2
												spawn(10)
													if(usr)
														usr.overlays -= D2
														del(D2)
													if(src)
														src.overlays -= D
														del(D)
											return
			Misc
				Fence
					icon = 'tools.dmi'
					icon_state = "front"
					density = 1
					Fuel = 50
					suffix = "Stuck"
					Click()
						if(src in range(1,usr))
							if(usr.Function == "Interact" && usr.Dead == 0)
								view(usr) << "<font color = yellow>[usr] climbs up onto the [src]!<br>"
								usr.loc = src.loc
								return
				BedRoll
					icon = 'tools.dmi'
					icon_state = "bed roll"
					Weight = 5
					Fuel = 25
					Type = "Sleep"
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
						if(usr.Function == "Interact")
							if(src.suffix)
								usr << "<font color = red>Drop this item first before using it!<br>"
								return
							if(src in range(1,usr))
								if(usr.Sleeping == 0)
									if(usr.Dead)
										return
									if(usr.Fainted)
										return
									if(usr.Stunned)
										return
									if(usr.Weapon)
										usr << "<font color = red>You wont be able to sleep with a [usr.Weapon] on!!<br>"
										return
									if(usr.Weapon2)
										usr << "<font color = red>You wont be able to sleep with a [usr.Weapon2] on!!<br>"
									for(var/obj/Items/Armour/A in usr)
										if(A.suffix == "Equip" && A.DefenceType == "Plate")
											usr << "<font color = red>You wont be able to sleep with Plate Armour on!<br>"
											return
									usr.ResetButtons()
									usr.Function = null
									usr.loc = src.loc
									usr.dir = SOUTH
									usr.CanMove = 0
									usr.Sleeping = 1
									usr.Pain = 0
									usr.overlays += /obj/Misc/Sleeping/
									usr.Sleeping()
									usr << "<font color=green>You climb into bed and fall fast asleep!<br>"
									return
								if(usr.Sleeping)
									if(usr.Fainted)
										return
									if(usr.Stunned)
										return
									var/Legs = 1
									if(usr.RightLeg == 0)
										if(usr.LeftLeg == 0)
											Legs = 0
									if(Legs)
										if(usr.Job == null)
											usr.CanMove = 1
									usr.Sleeping = 0
									usr.overlays -= /obj/Misc/Sleeping/
									usr << "<font color=green>You wake up and climb out of bed!<br>"
									return

						if(usr.Function == "Pull")
							if(src in range(1,usr))
								for(var/mob/M in range(0,src))
									if(M.Sleeping)
										usr << "<font color = red>Cant move a bed while someone is sleeping on it!<br>"
										return
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
							return
						if(usr.Function == "PickUp")
							if(src.suffix == "Carried" && src in usr)
								src.loc = usr.loc
								src.suffix = null
								src.layer = 4
								src.overlays = null
								src.icon_state = "bed roll"
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
								for(var/mob/M in range(0,src))
									if(M.Sleeping)
										usr << "<font color = red>Cant move a bed while someone is sleeping on it!<br>"
										return
								if(src.suffix == null)
									if(usr.Weight <= usr.WeightMax)
										src.loc = usr
										src.icon_state = "bed rolled"
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
				Bed
					icon = 'furniture.dmi'
					icon_state = "bed"
					Weight = 12
					Fuel = 50
					Material = "Wood"
					CanBeCrafted = 1
					Type = "Sleep"
					Click()
						if(usr.Job == null && src in usr.CreateList )
							if(usr.Ref)
								var/obj/O = usr.Ref
								if(O.Type != "Plank")
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									usr << "<font color = red>You need Three wooden Planks in order to create this item!<br>"
									return
								var/PlankNum = 0
								var/Planks = list()
								for(var/obj/Items/Resources/Plank/P in usr)
									if(PlankNum != 3)
										PlankNum += 1
										Planks += P
								if(PlankNum != 3)
									usr << "<font color = red>You need Three wooden Planks in order to create this item!<br>"
									return
								if(PlankNum == 3 && O.Type == "Plank")
									var/LOC = usr.loc
									usr.Job = "CreateBed"
									usr.CanMove = 0
									var/Time = 200 - usr.CarpentrySkill * 1.5 - usr.Agility / 2 - usr.Intelligence
									if(Time <= 50)
										Time = 50
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									for(var/obj/HUD/B in usr.client.screen)
										if(B.Type == "Inventory")
											B.icon_state = "inv off"
									view(usr) << "<font color = yellow>[usr] begins to contruct the Planks into a [src] !<br>"
									spawn(Time)
										if(usr)
											if(Planks && usr.loc == LOC)
												PlankNum = 0
												Planks = null
												Planks = list()
												for(var/obj/Items/Resources/Plank/P in usr)
													if(PlankNum != 3)
														PlankNum += 1
														Planks += P
												if(PlankNum == 3 && O && usr.Job == "CreateBed")
													var/Fail = prob(50 - usr.CarpentrySkill - usr.Agility / 4 - usr.Intelligence / 2)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
														for(var/obj/I in Planks)
															if(PlankNum != 0)
																PlankNum -= 1
																usr.Weight -= I.Weight
																del(I)
														usr.CarpentrySkill += usr.CarpentrySkillMulti / 2
														usr.GainStats(3,"Yes")
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.Dura += usr.CarpentrySkill * 2
													W.suffix = null
													for(var/obj/I in Planks)
														if(PlankNum != 0)
															PlankNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.CarpentrySkill += usr.CarpentrySkillMulti
													usr.GainStats(2,"Yes")
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													return
												else
													usr << "<font color = red>Planks could not be found in your inventory, crafting failed!<br>"
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>Planks could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
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
						if(usr.Function == "Interact")
							if(src in range(1,usr))
								if(usr.Sleeping == 0)
									if(usr.Dead)
										return
									if(usr.Fainted)
										return
									if(usr.Stunned)
										return
									if(usr.Weapon)
										usr << "<font color = red>You wont be able to sleep with a [usr.Weapon] on!!<br>"
										return
									if(usr.Weapon2)
										usr << "<font color = red>You wont be able to sleep with a [usr.Weapon2] on!!<br>"
									for(var/obj/Items/Armour/A in usr)
										if(A.suffix == "Equip" && A.DefenceType == "Plate")
											usr << "<font color = red>You wont be able to sleep with Plate Armour on!<br>"
											return
									usr.ResetButtons()
									usr.Function = null
									usr.loc = src.loc
									usr.dir = SOUTH
									usr.CanMove = 0
									usr.Sleeping = 1
									usr.Pain = 0
									usr.overlays += /obj/Misc/Sleeping/
									usr.Sleeping()
									usr << "<font color=green>You climb into bed and fall fast asleep!<br>"
									return
								if(usr.Sleeping)
									if(usr.Fainted)
										return
									if(usr.Stunned)
										return
									var/Legs = 1
									if(usr.RightLeg == 0)
										if(usr.LeftLeg == 0)
											Legs = 0
									if(Legs)
										if(usr.Job == null)
											usr.CanMove = 1
									usr.Sleeping = 0
									usr.overlays -= /obj/Misc/Sleeping/
									usr << "<font color=green>You wake up and climb out of bed!<br>"
									return

						if(usr.Function == "Pull")
							for(var/mob/M in range(0,src))
								if(M.Sleeping)
									usr << "<font color = red>Cant move a bed while someone is sleeping on it!<br>"
									return
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
				Benches
					name = "Wooden Bench"
					Click()
						if(usr.Function == "Interact")
							if(usr in range(1,src))
								usr.loc = src.loc
								usr.dir = SOUTH
								usr << "<b>You take a seat!<br>"
								return
					Bench1
						icon = 'misc.dmi'
						icon_state = "bench1"
						Weight = 7
						Fuel = 35
					Bench2
						icon = 'misc.dmi'
						icon_state = "bench2"
						Weight = 7
						Fuel = 35
				BookStand
					icon = 'furniture.dmi'
					icon_state = "bookstand"
					Fuel = 25
				StoneStand
					icon = 'furniture.dmi'
					icon_state = "stone stand"
				Statues
					StatueBase
						icon = 'misc.dmi'
						icon_state = "statue base"
						Weight = 70
						density = 1
						suffix = "Stuck"
					StatueKing
						icon = 'misc.dmi'
						icon_state = "statue king"
						Weight = 70
						density = 1
						suffix = "Stuck"
					StatueHero
						icon = 'misc.dmi'
						icon_state = "statue hero"
						Weight = 70
						density = 1
						suffix = "Stuck"
				TrainingDummy
					icon = 'tools.dmi'
					icon_state = "training doll"
					Weight = 6
					Fuel = 40
					density = 1
					Material = "Wood"
					CanBeCrafted = 1
					Dura = 200
					Type = "CanHit"
					Click()
						if(usr.Job == null && src in usr.CreateList )
							if(usr.Ref)
								var/obj/O = usr.Ref
								if(O.Type != "Block")
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									usr << "<font color = red>You need Two wooden Blocks in order to create this item!<br>"
									return
								var/BlockNum = 0
								var/Blocks = list()
								for(var/obj/Items/Resources/Block/P in usr)
									if(BlockNum != 2)
										BlockNum += 1
										Blocks += P
								if(BlockNum != 2)
									usr << "<font color = red>You need Two wooden Blocks in order to create this item!<br>"
									return
								if(BlockNum == 2 && O.Type == "Block")
									var/LOC = usr.loc
									usr.Job = "CreateDummy"
									usr.CanMove = 0
									var/Time = 200 - usr.CarpentrySkill * 1.5 - usr.Agility / 2 - usr.Intelligence
									if(Time <= 50)
										Time = 50
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									for(var/obj/HUD/B in usr.client.screen)
										if(B.Type == "Inventory")
											B.icon_state = "inv off"
									view(usr) << "<font color = yellow>[usr] begins to contruct the Blocks into a [src] !<br>"
									spawn(Time)
										if(usr)
											if(Blocks && usr.loc == LOC)
												BlockNum = 0
												Blocks = null
												Blocks = list()
												for(var/obj/Items/Resources/Block/P in usr)
													if(BlockNum != 2)
														BlockNum += 1
														Blocks += P
												if(BlockNum == 2 && O && usr.Job == "CreateDummy")
													var/Fail = prob(50 - usr.CarpentrySkill - usr.Agility / 4 - usr.Intelligence / 2)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
														for(var/obj/I in Blocks)
															if(BlockNum != 0)
																BlockNum -= 1
																usr.Weight -= I.Weight
																del(I)
														usr.CarpentrySkill += usr.CarpentrySkillMulti / 2
														usr.GainStats(3,"Yes")
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.Dura += usr.CarpentrySkill * 4
													W.suffix = null
													for(var/obj/I in Blocks)
														if(BlockNum != 0)
															BlockNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.CarpentrySkill += usr.CarpentrySkillMulti
													usr.GainStats(2,"Yes")
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													return
												else
													usr << "<font color = red>Blocks could not be found in your inventory, crafting failed!<br>"
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>Blocks could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
												usr.MovementCheck()
												return
						if(src in range(1,usr))
							if(usr.Function == "Interact" && usr.Ref && usr.Job == null && usr.Fainted == 0 && usr.Stunned == 0)
								var/obj/O = usr.Ref
								if(O.Type == "Saw" && O.Dura >= 1)
									if(O.suffix != "Equip")
										usr << "<font color = red>Equip the Saw first!<br>"
										return
									usr.Job = "Fix"
									var/Loc = usr.loc
									var/Time = 300 - usr.CarpentrySkill * 2
									if(Time <= 25)
										Time = 25
									view(usr) << "<font color = yellow>[usr] begins to fix [src] using their [O]!<br>"
									spawn(Time)
										if(usr && src && usr.loc == Loc && usr.Job == "Fix" && src.Dura <= 1 && usr.Dead == 0)
											view(usr) << "<font color = yellow>[usr] finishes fixing [src] with their [O]!<br>"
											if(usr.CarpentrySkill == 0)
												usr.CarpentrySkill = 0.1
											src.Dura += usr.CarpentrySkill * 4 + 2
											src.icon_state = "training doll"
											src.Type = "CanHit"
											usr.Job = null
											usr.CarpentrySkill += usr.CarpentrySkillMulti
											O.Dura -= rand(1,2)
											usr.CheckWeaponDura(O)
											return
										else
											usr << "<font color = red>You failed to fix [src]!<br>"
											usr.Job = null
											usr.CarpentrySkill += usr.CarpentrySkillMulti / 2
											return
							if(usr.Function == "Combat" && src.Type == "CanHit" && usr.Dead == 0 && usr.Fainted == 0 && usr.Job == null && usr.Stunned == 0)
								if(src.Dura >= 1)
									usr.DetermineWeaponSkill()
									view(usr) << "<font color = yellow>[usr] hits the [src]!<br>"
									var/DMG = usr.Strength / 2 + usr.CurrentSkillLevel
									src.Dura -= DMG
									if(usr.CurrentSkillLevel <= 20)
										if(usr.CurrentSkill == "Sword")
											usr.SwordSkill += usr.SwordSkillMulti / 2
										if(usr.CurrentSkill == "Axe")
											usr.AxeSkill += usr.AxeSkillMulti / 2
										if(usr.CurrentSkill == "Spear")
											usr.SpearSkill += usr.SpearSkillMulti / 2
										if(usr.CurrentSkill == "Blunt")
											usr.BluntSkill += usr.BluntSkillMulti / 2
										if(usr.CurrentSkill == "Dagger")
											usr.DaggerSkill += usr.DaggerSkillMulti / 2
										if(usr.CurrentSkill == "Unarmed")
											usr.UnarmedSkill += usr.UnarmedSkillMulti / 2
									else
										usr << "<font color = red>You will not gain from training off this, your skills are too high!<br>"
									src.Type = "CantHit"
									if(src.Dura <= 1)
										src.icon_state = "broken training doll"
										src.Dura = 0
									spawn(100)
										if(src && src.Dura >= 1)
											src.Type = "CanHit"
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
				ArmourRack
					icon = 'misc.dmi'
					icon_state = "armour rack"
					Weight = 7
					Fuel = 35
					Material = "Wood"
					CanBeCrafted = 1
					Click()
						if(usr.Job == null && src in usr.CreateList )
							if(usr.Ref)
								var/obj/O = usr.Ref
								if(O.Type != "Block")
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr << "<font color = red>You need Two wooden Blocks in order to create this item!<br>"
									usr.ResetButtons()
									return
								var/BlockNum = 0
								var/Blocks = list()
								for(var/obj/Items/Resources/Block/P in usr)
									if(BlockNum != 2)
										BlockNum += 1
										Blocks += P
								if(BlockNum != 2)
									usr << "<font color = red>You need Two wooden Blocks in order to create this item!<br>"
									return
								if(BlockNum == 2 && O.Type == "Block")
									var/LOC = usr.loc
									usr.Job = "CreateRack"
									usr.CanMove = 0
									var/Time = 200 - usr.CarpentrySkill * 1.5 - usr.Agility / 2 - usr.Intelligence
									if(Time <= 50)
										Time = 50
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									for(var/obj/HUD/B in usr.client.screen)
										if(B.Type == "Inventory")
											B.icon_state = "inv off"
									view(usr) << "<font color = yellow>[usr] begins to contruct the Blocks into a [src] !<br>"
									spawn(Time)
										if(usr)
											if(Blocks && usr.loc == LOC)
												BlockNum = 0
												Blocks = null
												Blocks = list()
												for(var/obj/Items/Resources/Block/P in usr)
													if(BlockNum != 2)
														BlockNum += 1
														Blocks += P
												if(BlockNum == 2 && O && usr.Job == "CreateRack")
													var/Fail = prob(50 - usr.CarpentrySkill - usr.Agility / 4 - usr.Intelligence / 2)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
														for(var/obj/I in Blocks)
															if(BlockNum != 0)
																BlockNum -= 1
																usr.Weight -= I.Weight
																del(I)
														usr.CarpentrySkill += usr.CarpentrySkillMulti / 2
														usr.GainStats(3,"Yes")
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.Dura += usr.CarpentrySkill * 2
													W.suffix = null
													for(var/obj/I in Blocks)
														if(BlockNum != 0)
															BlockNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.CarpentrySkill += usr.CarpentrySkillMulti
													usr.GainStats(2,"Yes")
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													return
												else
													usr << "<font color = red>Blocks could not be found in your inventory, crafting failed!<br>"
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>Blocks could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
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
				WeaponRack
					icon = 'misc.dmi'
					icon_state = "weapon rack"
					Weight = 5
					Fuel = 35
					Material = "Wood"
					CanBeCrafted = 1
					Click()
						if(usr.Job == null && src in usr.CreateList )
							if(usr.Ref)
								var/obj/O = usr.Ref
								if(O.Type != "Plank")
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									usr << "<font color = red>You need Two wooden Planks in order to create this item!<br>"
									return
								var/PlankNum = 0
								var/Planks = list()
								for(var/obj/Items/Resources/Plank/P in usr)
									if(PlankNum != 2)
										PlankNum += 1
										Planks += P
								if(PlankNum != 2)
									usr << "<font color = red>You need Two wooden Planks in order to create this item!<br>"
									return
								if(PlankNum == 2 && O.Type == "Plank")
									var/LOC = usr.loc
									usr.Job = "CreateRack"
									usr.CanMove = 0
									var/Time = 200 - usr.CarpentrySkill * 1.5 - usr.Agility / 2 - usr.Intelligence
									if(Time <= 50)
										Time = 50
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									for(var/obj/HUD/B in usr.client.screen)
										if(B.Type == "Inventory")
											B.icon_state = "inv off"
									view(usr) << "<font color = yellow>[usr] begins to contruct the Planks into a [src] !<br>"
									spawn(Time)
										if(usr)
											if(Planks && usr.loc == LOC)
												PlankNum = 0
												Planks = null
												Planks = list()
												for(var/obj/Items/Resources/Plank/P in usr)
													if(PlankNum != 2)
														PlankNum += 1
														Planks += P
												if(PlankNum == 2 && O && usr.Job == "CreateRack")
													var/Fail = prob(50 - usr.CarpentrySkill - usr.Agility / 4 - usr.Intelligence / 2)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
														for(var/obj/I in Planks)
															if(PlankNum != 0)
																PlankNum -= 1
																usr.Weight -= I.Weight
																del(I)
														usr.CarpentrySkill += usr.CarpentrySkillMulti / 2
														usr.GainStats(3,"Yes")
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.Dura += usr.CarpentrySkill * 2
													W.suffix = null
													for(var/obj/I in Planks)
														if(PlankNum != 0)
															PlankNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.CarpentrySkill += usr.CarpentrySkillMulti
													usr.GainStats(2,"Yes")
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													return
												else
													usr << "<font color = red>Planks could not be found in your inventory, crafting failed!<br>"
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>Planks could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
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
				WoodenCounter
					icon = 'furniture.dmi'
					icon_state = "counter"
					Weight = 7
					Fuel = 30
					density = 1
					CanBeCrafted = 1
					Material = "Wood"
					Click()
						if(usr.Function == "Interact")
							if(src in range(1,usr))
								view(usr) << "<font color = yellow>[usr] climbs on top of the [src]!<br>"
								usr.loc = src.loc
								return
						if(usr.Job == null && src in usr.CreateList )
							if(usr.Ref)
								var/obj/O = usr.Ref
								if(O.Type != "Plank")
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									usr << "<font color = red>You need Three wooden Planks in order to create this item!<br>"
									return
								var/PlankNum = 0
								var/Planks = list()
								for(var/obj/Items/Resources/Plank/P in usr)
									if(PlankNum != 3)
										PlankNum += 1
										Planks += P
								if(PlankNum != 3)
									usr << "<font color = red>You need Three wooden Planks in order to create this item!<br>"
									return
								if(PlankNum == 3 && O.Type == "Plank")
									var/LOC = usr.loc
									usr.Job = "CreateCounter"
									usr.CanMove = 0
									var/Time = 200 - usr.CarpentrySkill * 1.5 - usr.Agility / 2 - usr.Intelligence
									if(Time <= 50)
										Time = 50
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									for(var/obj/HUD/B in usr.client.screen)
										if(B.Type == "Inventory")
											B.icon_state = "inv off"
									view(usr) << "<font color = yellow>[usr] begins to contruct the Planks into a [src] !<br>"
									spawn(Time)
										if(usr)
											if(Planks && usr.loc == LOC)
												PlankNum = 0
												Planks = null
												Planks = list()
												for(var/obj/Items/Resources/Plank/P in usr)
													if(PlankNum != 3)
														PlankNum += 1
														Planks += P
												if(PlankNum == 3 && O && usr.Job == "CreateCounter")
													var/Fail = prob(50 - usr.CarpentrySkill - usr.Agility / 4 - usr.Intelligence / 2)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
														for(var/obj/I in Planks)
															if(PlankNum != 0)
																PlankNum -= 1
																usr.Weight -= I.Weight
																del(I)
														usr.CarpentrySkill += usr.CarpentrySkillMulti / 2
														usr.GainStats(3,"Yes")
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.Dura += usr.CarpentrySkill * 2
													W.suffix = null
													for(var/obj/I in Planks)
														if(PlankNum != 0)
															PlankNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.CarpentrySkill += usr.CarpentrySkillMulti
													usr.GainStats(2,"Yes")
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													return
												else
													usr << "<font color = red>Planks could not be found in your inventory, crafting failed!<br>"
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>Planks could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
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
				WoodenTable
					icon = 'furniture.dmi'
					icon_state = "table"
					Weight = 7
					Fuel = 30
					density = 1
					CanBeCrafted = 1
					Material = "Wood"
					Click()
						if(usr.Job == null && src in usr.CreateList )
							if(usr.Ref)
								var/obj/O = usr.Ref
								if(O.Type != "Plank")
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									usr << "<font color = red>You need Three wooden Planks in order to create this item!<br>"
									return
								var/PlankNum = 0
								var/Planks = list()
								for(var/obj/Items/Resources/Plank/P in usr)
									if(PlankNum != 3)
										PlankNum += 1
										Planks += P
								if(PlankNum != 3)
									usr << "<font color = red>You need Three wooden Planks in order to create this item!<br>"
									return
								if(PlankNum == 3 && O.Type == "Plank")
									var/LOC = usr.loc
									usr.Job = "CreateTable"
									usr.CanMove = 0
									var/Time = 200 - usr.CarpentrySkill * 1.5 - usr.Agility / 2 - usr.Intelligence
									if(Time <= 50)
										Time = 50
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									for(var/obj/HUD/B in usr.client.screen)
										if(B.Type == "Inventory")
											B.icon_state = "inv off"
									view(usr) << "<font color = yellow>[usr] begins to contruct the Planks into a [src] !<br>"
									spawn(Time)
										if(usr)
											if(Planks && usr.loc == LOC)
												PlankNum = 0
												Planks = null
												Planks = list()
												for(var/obj/Items/Resources/Plank/P in usr)
													if(PlankNum != 3)
														PlankNum += 1
														Planks += P
												if(PlankNum == 3 && O && usr.Job == "CreateTable")
													var/Fail = prob(50 - usr.CarpentrySkill - usr.Agility / 4 - usr.Intelligence / 2)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
														for(var/obj/I in Planks)
															if(PlankNum != 0)
																PlankNum -= 1
																usr.Weight -= I.Weight
																del(I)
														usr.CarpentrySkill += usr.CarpentrySkillMulti / 2
														usr.GainStats(3,"Yes")
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.Dura += usr.CarpentrySkill * 2
													W.suffix = null
													for(var/obj/I in Planks)
														if(PlankNum != 0)
															PlankNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.CarpentrySkill += usr.CarpentrySkillMulti
													usr.GainStats(2,"Yes")
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													return
												else
													usr << "<font color = red>Planks could not be found in your inventory, crafting failed!<br>"
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>Planks could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
												usr.MovementCheck()
												return
						if(usr.Function == "Interact")
							if(src in range(1,usr))
								view(usr) << "<font color = yellow>[usr] climbs on top of the [src]!<br>"
								usr.loc = src.loc
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
				SignPost
					icon = 'tools.dmi'
					icon_state = "sign2"
					Weight = 5
					Fuel = 25
					density = 1
					Material = "Wood"
					CanBeCrafted = 1
					Type = "Stuck"
					suffix = "Stuck"
					Click()
						if(usr.Job == null && src in usr.CreateList )
							if(usr.Ref)
								var/obj/O = usr.Ref
								if(O.Type != "Plank")
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									usr << "<font color = red>You need Three wooden Planks in order to create this item!<br>"
									return
								var/PlankNum = 0
								var/Planks = list()
								for(var/obj/Items/Resources/Plank/P in usr)
									if(PlankNum != 3)
										PlankNum += 1
										Planks += P
								if(PlankNum != 3)
									usr << "<font color = red>You need Three wooden Planks in order to create this item!<br>"
									return
								if(PlankNum == 3 && O.Type == "Plank")
									var/LOC = usr.loc
									usr.Job = "CreateSign"
									usr.CanMove = 0
									var/Time = 200 - usr.CarpentrySkill * 1.5 - usr.Agility / 2 - usr.Intelligence
									if(Time <= 50)
										Time = 50
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									for(var/obj/HUD/B in usr.client.screen)
										if(B.Type == "Inventory")
											B.icon_state = "inv off"
									view(usr) << "<font color = yellow>[usr] begins to contruct the Planks into a [src] !<br>"
									spawn(Time)
										if(usr)
											if(Planks && usr.loc == LOC)
												PlankNum = 0
												Planks = null
												Planks = list()
												for(var/obj/Items/Resources/Plank/P in usr)
													if(PlankNum != 3)
														PlankNum += 1
														Planks += P
												if(PlankNum == 3 && O && usr.Job == "CreateSign")
													var/Fail = prob(50 - usr.CarpentrySkill - usr.Agility / 4 - usr.Intelligence / 2)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
														for(var/obj/I in Planks)
															if(PlankNum != 0)
																PlankNum -= 1
																usr.Weight -= I.Weight
																del(I)
														usr.CarpentrySkill += usr.CarpentrySkillMulti / 2
														usr.GainStats(3,"Yes")
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.Dura += usr.CarpentrySkill * 2
													W.suffix = null
													W.Type = "NotStuck"
													for(var/obj/I in Planks)
														if(PlankNum != 0)
															PlankNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.CarpentrySkill += usr.CarpentrySkillMulti
													usr.GainStats(2,"Yes")
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													return
												else
													usr << "<font color = red>Planks could not be found in your inventory, crafting failed!<br>"
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>Planks could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
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
						if(usr.Function == "Interact")
							if(src in range(1,usr))
								if(src.Type == "Stuck")
									if(usr.Dead == 0 && usr.Fainted == 0 && usr.Stunned == 0 && usr.Job == null && usr.CanMove)
										var/HasArms = 1
										if(usr.LeftArm <= 20)
											if(usr.RightArm <= 20)
												HasArms = 0
										if(HasArms)
											view(usr) << "<font color = yellow>[usr] pull the sign post loose!<br>"
											src.Type = "NotStuck"
											src.suffix = null
											return
										else
											usr << "<font color = red>You cant do that with hurt arms!<br>"
											return
							if(src.Type == "NotStuck" && src in usr)
								var/N=input("What do you want written on this sign?")as text
								if(N == null)
									return
								else
									src.desc = N
									src.name = N
								return
							if(src.Type == "NotStuck" && src.suffix == null)
								if(usr.Dead == 0 && usr.Fainted == 0 && usr.Stunned == 0 && usr.Job == null && usr.CanMove)
									var/HasArms = 1
									if(usr.LeftArm <= 20)
										if(usr.RightArm <= 20)
											HasArms = 0
									if(HasArms)
										view(usr) << "<font color = yellow>[usr] pushes the sign post into the ground firmly!<br>"
										src.Type = "Stuck"
										src.suffix = "Stuck"
										return
									else
										usr << "<font color = red>You cant do that with hurt arms!<br>"
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
				BookCase
					icon = 'furniture.dmi'
					icon_state = "bookcase"
					Weight = 10
					Fuel = 45
					density = 1
					Material = "Wood"
					CanBeCrafted = 1
					Click()
						if(usr.Job == null && src in usr.CreateList )
							if(usr.Ref)
								var/obj/O = usr.Ref
								if(O.Type != "Plank")
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									usr << "<font color = red>You need Three wooden Planks in order to create this item!<br>"
									return
								var/PlankNum = 0
								var/Planks = list()
								for(var/obj/Items/Resources/Plank/P in usr)
									if(PlankNum != 3)
										PlankNum += 1
										Planks += P
								if(PlankNum != 3)
									usr << "<font color = red>You need Three wooden Planks in order to create this item!<br>"
									return
								if(PlankNum == 3 && O.Type == "Plank")
									var/LOC = usr.loc
									usr.Job = "CreateBookCase"
									usr.CanMove = 0
									var/Time = 200 - usr.CarpentrySkill * 1.5 - usr.Agility / 2 - usr.Intelligence
									if(Time <= 50)
										Time = 50
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									for(var/obj/HUD/B in usr.client.screen)
										if(B.Type == "Inventory")
											B.icon_state = "inv off"
									view(usr) << "<font color = yellow>[usr] begins to contruct the Planks into a [src] !<br>"
									spawn(Time)
										if(usr)
											if(Planks && usr.loc == LOC)
												PlankNum = 0
												Planks = null
												Planks = list()
												for(var/obj/Items/Resources/Plank/P in usr)
													if(PlankNum != 3)
														PlankNum += 1
														Planks += P
												if(PlankNum == 3 && O && usr.Job == "CreateBookCase")
													var/Fail = prob(50 - usr.CarpentrySkill - usr.Agility / 4 - usr.Intelligence / 2)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
														for(var/obj/I in Planks)
															if(PlankNum != 0)
																PlankNum -= 1
																usr.Weight -= I.Weight
																del(I)
														usr.CarpentrySkill += usr.CarpentrySkillMulti / 2
														usr.GainStats(3,"Yes")
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.Dura += usr.CarpentrySkill * 2
													W.suffix = null
													for(var/obj/I in Planks)
														if(PlankNum != 0)
															PlankNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.CarpentrySkill += usr.CarpentrySkillMulti
													usr.GainStats(2,"Yes")
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													return
												else
													usr << "<font color = red>Planks could not be found in your inventory, crafting failed!<br>"
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>Planks could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
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
				Picture
					icon = 'misc.dmi'
					icon_state = "pic 1"
					name = "Picture"
					suffix = "Stuck"
					Weight = 4
					Fuel = 35
					New()
						var/PicNum = rand(1,12)
						src.icon_state = "pic [PicNum]"
						if(src.dir == NORTH)
							src.pixel_y = 32
						if(src.dir == SOUTH)
							src.pixel_y = -32
						if(src.dir == EAST)
							src.pixel_x = 32
						if(src.dir == WEST)
							src.pixel_x = -32
				GlowingCrystal
					icon = 'misc.dmi'
					icon_state = "glowing crystal"
					name = "Glowing Crystal"
					suffix = "Stuck"
					Weight = 4
					luminosity = 5
					Fuel = 35
					New()
						if(src.dir == NORTH)
							src.pixel_y = 32
						if(src.dir == SOUTH)
							src.pixel_y = -32
						if(src.dir == EAST)
							src.pixel_x = 32
						if(src.dir == WEST)
							src.pixel_x = -32
				TorchStand
					icon = 'tools.dmi'
					icon_state = "torch stand"
					name = "Torch Stand"
					Weight = 8
					BaseMaterial = "Metal"
					New()
						if(src.dir == NORTH)
							src.pixel_y = 32
						if(src.dir == SOUTH)
							src.pixel_y = -32
						if(src.dir == EAST)
							src.pixel_x = 32
						if(src.dir == WEST)
							src.pixel_x = -32
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
									usr.Job = "Forge"
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
											if(O && usr.Job == "Forge")
												if(O in usr)
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
																del(O)
																if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
																	usr.ForgingSkill += usr.ForgingSkillMulti / 2
																usr.GainStats(2)
																return
															var/obj/W = new src.type(usr.loc)
															W.icon = src.icon
															W.Material = O.Material
															W.name = "[W.Material] [W.name]"
															W.icon_state = "[W.Material] [W.icon_state]"
															usr.Weight -= O.Weight
															del(O)
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
											else
												usr.MovementCheck()
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
						if(usr.Function == "Examine")
							usr << "<font color=teal>[src.desc]"
							var/Known = 0
							for(var/obj/Items/W in usr.CreateList)
								if(W.type == src.type)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Copper","Gold","Silver")
										for(var/M in Mats)
											var/obj/Items/Furniture/Misc/TorchStand/S = new
											S.Material = "[M]"
											S.icon_state = "[M] [S.icon_state]"
											S.layer = 100
											usr.CreateList += S
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
							return
				WallTorch
					icon = 'tools.dmi'
					icon_state = "torch stand lit"
					name = "Wall Torch"
					suffix = "Stuck"
					Weight = 4
					luminosity = 5
					BaseMaterial = "Metal"
					Material = "Iron"
					Fuel = 35
					New()
						if(src.dir == NORTH)
							src.pixel_y = 32
						if(src.dir == SOUTH)
							src.pixel_y = -32
						if(src.dir == EAST)
							src.pixel_x = 32
						if(src.dir == WEST)
							src.pixel_x = -32
					Click()
						if(usr.Function == "Interact")
							if(usr.Fainted)
								usr << "<font color =red>You have fainted and cant do that!<br>"
								return
							if(usr.Stunned)
								usr << "<font color =red>You are stunned and cant do that!<br>"
								return
							if(usr.Weapon)
								if(src in range(1,usr))
									var/obj/I = usr.Weapon
									if(I.Type == "Torch")
										view(usr) << "<font color = yellow>[usr] lights their [I] on the [src]!<br>"
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
										view(usr) << "<font color = yellow>[usr] lights their [I] on the [src]!<br>"
										usr.overlays-=image(I.icon,"[I.icon_state] left",I.ItemLayer)
										usr.overlays-=image(I.icon,"[I.icon_state]",I.ItemLayer)
										I.CarryState = "torch lit"
										I.EquipState = "torch lit equip left"
										I.icon_state = I.EquipState
										I.Type = "Torch Lit"
										I.LightProc(usr)
										usr.overlays+=image(I.icon,"[I.icon_state]",I.ItemLayer)
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
							var/Known = 0
							for(var/obj/Items/Furniture/Misc/TorchStand/W in usr.CreateList)
								Known = 1
							if(Known == 0)
								var/Mats = list("Iron","Copper","Gold","Silver")
								for(var/M in Mats)
									var/obj/Items/Furniture/Misc/TorchStand/S = new
									S.Material = "[M]"
									S.icon_state = "[M] torch stand"
									S.layer = 100
									usr.CreateList += S
								usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
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
				TempleCandle
					icon = 'misc.dmi'
					icon_state = "temple candle lit"
					Weight = 5
					luminosity = 3
					Click()
						if(usr.Function == "Interact")
							if(usr.Fainted)
								usr << "<font color =red>You have fainted and cant do that!<br>"
								return
							if(usr.Stunned)
								usr << "<font color =red>You are stunned and cant do that!<br>"
								return
							if(usr.Weapon)
								if(src in range(1,usr))
									var/obj/I = usr.Weapon
									if(I.Type == "Torch")
										view(usr) << "<font color = yellow>[usr] lights their [I] on the [src]!<br>"
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
										view(usr) << "<font color = yellow>[usr] lights their [I] on the [src]!<br>"
										usr.overlays-=image(I.icon,"[I.icon_state] left",I.ItemLayer)
										I.CarryState = "torch lit"
										I.EquipState = "torch lit equip left"
										I.icon_state = I.EquipState
										I.Type = "Torch Lit"
										I.LightProc(usr)
										usr.overlays+=image(I.icon,"[I.icon_state]",I.ItemLayer)
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
			Chairs
				WoodenChair
					icon = 'furniture.dmi'
					icon_state = "chair"
					suffix = "Stuck"
					Weight = 5
					Fuel = 25
					Material = "Wood"
					CanBeCrafted = 1
					Click()
						if(usr.Job == null && src in usr.CreateList )
							if(usr.Ref)
								var/obj/O = usr.Ref
								if(O.Type != "Plank")
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									usr << "<font color = red>You need Two wooden Planks in order to create this item!<br>"
									return
								var/PlankNum = 0
								var/Planks = list()
								for(var/obj/Items/Resources/Plank/P in usr)
									if(PlankNum != 2)
										PlankNum += 1
										Planks += P
								if(PlankNum != 2)
									usr << "<font color = red>You need Two wooden Planks in order to create this item!<br>"
									return
								if(PlankNum == 2 && O.Type == "Plank")
									var/LOC = usr.loc
									usr.Job = "CreateChair"
									usr.CanMove = 0
									var/Time = 200 - usr.CarpentrySkill * 1.5 - usr.Agility / 2 - usr.Intelligence
									if(Time <= 50)
										Time = 50
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									for(var/obj/HUD/B in usr.client.screen)
										if(B.Type == "Inventory")
											B.icon_state = "inv off"
									view(usr) << "<font color = yellow>[usr] begins to contruct the Planks into a [src] !<br>"
									spawn(Time)
										if(usr)
											if(Planks && usr.loc == LOC)
												PlankNum = 0
												Planks = null
												Planks = list()
												for(var/obj/Items/Resources/Plank/P in usr)
													if(PlankNum != 2)
														PlankNum += 1
														Planks += P
												if(PlankNum == 2 && O && usr.Job == "CreateChair")
													var/Fail = prob(50 - usr.CarpentrySkill - usr.Agility / 4 - usr.Intelligence / 2)
													usr.Job = null
													usr.MovementCheck()
													if(Fail)
														view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
														for(var/obj/I in Planks)
															if(PlankNum != 0)
																PlankNum -= 1
																usr.Weight -= I.Weight
																del(I)
														usr.CarpentrySkill += usr.CarpentrySkillMulti / 2
														usr.GainStats(3,"Yes")
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.Dura += usr.CarpentrySkill * 2
													W.suffix = null
													for(var/obj/I in Planks)
														if(PlankNum != 0)
															PlankNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.CarpentrySkill += usr.CarpentrySkillMulti
													usr.GainStats(2,"Yes")
													view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
													return
												else
													usr << "<font color = red>Planks could not be found in your inventory, crafting failed!<br>"
													usr.MovementCheck()
													return
											else
												usr << "<font color = red>Planks could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
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
						if(usr.Function == "Interact")
							if(usr in range(1,src))
								usr.loc = src.loc
								usr.dir = src.dir
								usr << "<b>You take a seat!<br>"
								return
				Throne
					icon = 'misc.dmi'
					icon_state = "Throne"
					suffix = "Stuck"
					Weight = 10
					Fuel = 50
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
						if(usr.Function == "Interact")
							if(usr in range(1,src))
								usr.loc = src.loc
								usr.dir = SOUTH
								usr << "<b>You take a seat!<br>"
								return
			Pillars
				suffix = "Stuck"
				SmallPillar1
					name = "Pillar"
					icon = 'misc.dmi'
					icon_state = "p small1"
					Material = "Stone"
					CanBeCrafted = 1
					opacity = 1
					Click()
						if(usr.Job == null && src in usr.CreateList )
							if(usr.Ref)
								var/obj/O = usr.Ref
								if(O.Type != "LargeBrick")
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									usr << "<font color = red>You need Three Large Bricks in order to create this item!<br>"
									return
								var/BrickNum = 0
								var/Bricks = list()
								for(var/obj/Items/Resources/LargeBrick/B in usr)
									if(BrickNum != 3)
										BrickNum += 1
										Bricks += B
								if(BrickNum != 3)
									usr << "<font color = red>You need Three Large Bricks in order to create this item!<br>"
									return
								if(BrickNum == 5 && O.Type == "LargeBrick")
									var/LOC = usr.loc
									usr.Job = "CreateStonePillar"
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
													if(BrickNum != 3)
														BrickNum += 1
														Bricks += B
												if(BrickNum == 3 && O && usr.Job == "CreateStonePillar")
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
				SmallPillar2
					name = "Pillar"
					icon = 'misc.dmi'
					icon_state = "p small2"
					Material = "Stone"
					CanBeCrafted = 1
					opacity = 1
					Click()
						if(usr.Job == null && src in usr.CreateList )
							if(usr.Ref)
								var/obj/O = usr.Ref
								if(O.Type != "LargeBrick")
									usr.DeleteInventoryMenu()
									if(usr.InvenUp)
										usr.InvenUp = 0
									usr.ResetButtons()
									usr << "<font color = red>You need Three Large Bricks in order to create this item!<br>"
									return
								var/BrickNum = 0
								var/Bricks = list()
								for(var/obj/Items/Resources/LargeBrick/B in usr)
									if(BrickNum != 3)
										BrickNum += 1
										Bricks += B
								if(BrickNum != 3)
									usr << "<font color = red>You need Three Large Bricks in order to create this item!<br>"
									return
								if(BrickNum == 5 && O.Type == "LargeBrick")
									var/LOC = usr.loc
									usr.Job = "CreateStonePillar"
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
													if(BrickNum != 3)
														BrickNum += 1
														Bricks += B
												if(BrickNum == 3 && O && usr.Job == "CreateStonePillar")
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
				LargePillar
					suffix = "Stuck"
					LargePillarBottom
						name = "Stone Pillar"
						icon = 'misc.dmi'
						icon_state = "P Bottom"
						Material = "Stone"
						CanBeCrafted = 1
						density = 1
						opacity = 1
						New()
							src.overlays += /obj/Items/Furniture/Pillars/LargePillar/LPM/
							src.overlays += /obj/Items/Furniture/Pillars/LargePillar/LPT/
						Click()
							if(usr.Job == null && src in usr.CreateList )
								if(usr.Ref)
									var/obj/O = usr.Ref
									if(O.Type != "LargeBrick")
										usr.DeleteInventoryMenu()
										if(usr.InvenUp)
											usr.InvenUp = 0
										usr.ResetButtons()
										usr << "<font color = red>You need Five Large Bricks in order to create this item!<br>"
										return
									var/BrickNum = 0
									var/Bricks = list()
									for(var/obj/Items/Resources/LargeBrick/B in usr)
										if(BrickNum != 5)
											BrickNum += 1
											Bricks += B
									if(BrickNum != 5)
										usr << "<font color = red>You need Five Large Bricks in order to create this item!<br>"
										return
									if(BrickNum == 5 && O.Type == "LargeBrick")
										var/LOC = usr.loc
										usr.Job = "CreateStoneCoffin"
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
														if(BrickNum != 5)
															BrickNum += 1
															Bricks += B
													if(BrickNum == 5 && O && usr.Job == "CreateStoneCoffin")
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
					LPM
						name = "Stone Pillar"
						icon = 'misc.dmi'
						icon_state = "P Middle"
						layer = 8
						pixel_y = 32
					LargePillarBroken
						name = "Stone Pillar"
						icon = 'misc.dmi'
						icon_state = "P broken"
						layer = 8
					LargePillarBroken2
						name = "Stone Pillar"
						icon = 'misc.dmi'
						icon_state = "P ground"
						density = 1
					LPT
						name = "Stone Pillar"
						icon = 'misc.dmi'
						icon_state = "P Top"
						layer = 8
						pixel_y = 64
