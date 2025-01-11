obj
	Items
		Armour
			ObjectTag = "Armour"
			Legs
				Click()
					if(usr.Job == null && src.Material == "Leather" && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Material != "Leather")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Four Dry Leather Hides in order to create this item!<br>"
								return
							var/LeatherNum = 0
							var/Leathers = list()
							for(var/obj/Items/Resources/Skin/S in usr)
								if(S.Type == "Dry" && LeatherNum != 4)
									LeatherNum += 1
									Leathers += S
							if(LeatherNum != 4)
								usr << "<font color = red>You need Four Dry Leather Hides in order to create this item!<br>"
								return
							if(LeatherNum == 4 && O.Material == "Leather")
								var/LOC = usr.loc
								usr.Job = "MakeLeatherItem"
								usr.CanMove = 0
								var/Time = 200 - usr.LeatherCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Dry Leather Hides into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Leathers && usr.loc == LOC)
											if(LeatherNum == 4 && O && usr.Job == "MakeLeatherItem")
												var/Fail = prob(50 - usr.LeatherCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													var/Scraps = rand(1,2)
													while(Scraps)
														Scraps -= 1
														var/obj/Items/Resources/Skin/S = new
														S.icon_state = "Dry Leather Scrap"
														S.name = "[O.name] Scrap"
														S.CraftPotential = O.CraftPotential / 2
														S.Weight = S.Weight / 2
														S.loc = usr.loc
														S.Type = "Dry"
													for(var/obj/I in Leathers)
														if(LeatherNum != 0)
															LeatherNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti / 2
													usr.GainStats(2,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.LeatherCraftSkill * 2
												W.Defence += usr.LeatherCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftLeatherArmour(O,W)
												for(var/obj/I in Leathers)
													if(LeatherNum != 0)
														LeatherNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Dry Leather Hides could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Dry Leather Hides could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
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
									if(IngotNum == 2)
										break
								if(IngotNum != 2)
									usr << "<font color = red>You need two Ingot of the same Material to forge this item!<br>"
									return
								IngotNum = 0
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
										if(Ingots)
											for(var/obj/I in Ingots)
												if(I in usr)
													IngotNum += 1
													if(IngotNum == 2)
														break
										if(IngotNum == 2 && usr.Job == "Forge")
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
															if(IngotNum != 2)
																IngotNum += 1
																usr.Weight -= I.Weight
																del(I)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti / 2
														usr.GainStats(2)
														return
													var/obj/W = new src.type(usr.loc)
													W.icon = src.icon
													W.EquipState = src.EquipState
													W.CarryState = src.CarryState
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
													if(W.ObjectTag == "Armour")
														usr.CraftArmour(O,W)
													W.icon_state = W.CarryState
													IngotNum = 0
													for(var/obj/I in Ingots)
														if(IngotNum != 2)
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
					if(usr.Function == "Interact" && usr.Ref == null)
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Race in src.CantRaces)
									usr << "<font color = red>Your race cant wear that item!<br>"
									return
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								var/HasLeg = 0
								if(usr.LeftLeg)
									HasLeg = 1
								if(usr.RightLeg)
									HasLeg = 1
								if(HasLeg)
									if(usr.WLegs == null)
										src.layer = src.ItemLayer
										src.suffix = "Equip"
										src.overlays += image(/obj/HUD/E/)
										src.icon_state = src.EquipState
										usr.WLegs = src
										usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
										src.layer = 20
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
										return
								else
									usr << "<font color=red>You have no Legs!"
									return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.WLegs == src)
									src.layer = src.ItemLayer
									usr.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
									usr.WLegs = null
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in usr)
							var/Known = 0
							for(var/obj/Items/A in usr.CreateList)
								if(A.EquipState == src.EquipState && A.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Gold","Copper")
										for(var/M in Mats)
											var/obj/A = new src.type()
											A.Material = "[M]"
											A.CarryState = "[M] [A.icon_state]"
											A.EquipState = "[M] [A.EquipState] equip"
											A.icon_state = A.CarryState
											A.layer = 100
											usr.CreateList += A
									else
										var/obj/A = new src.type()
										A.Material = src.Material
										A.icon_state = src.CarryState
										A.EquipState = src.EquipState
										A.CarryState = src.CarryState
										A.layer = 100
										usr.CreateList += A
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
							return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							usr.DeleteInventoryMenu()
							usr.CreateInventory()
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
				GiantLeatherLeggings
					icon = 'equipment.dmi'
					icon_state = "giant leather pants equip"
					EquipState = "giant leather pants equip"
					CarryState = "giant leather pants"
					DefenceType = "Leather"
					Material = "Leather"
					ItemLayer = 4.3
					CantRaces = list("Human","Ratling","Alther","Frogman","Stahlite","Wolfman","Snakeman","Illithid")
					CanBeCrafted = 1
					Dura = 100
					Fuel = 75
					Weight = 2
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				LeatherLeggings
					icon = 'equipment.dmi'
					icon_state = "leather pants equip"
					EquipState = "leather pants equip"
					CarryState = "leather pants"
					DefenceType = "Leather"
					Material = "Leather"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Snakeman")
					ItemLayer = 4.3
					Defence = 3
					CanBeCrafted = 1
					Dura = 100
					Weight = 1
					Fuel = 75
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				RatChainLeggings
					icon = 'equipment.dmi'
					icon_state = "rat chainlegs"
					EquipState = "rat chainlegs"
					CarryState = "folded chain"
					DefenceType = "Chain"
					CantRaces = list("Giant","Cyclops","Stahlite","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.3
					CanBeCrafted = 1
					Weight = 4
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				ChainLeggings
					icon = 'equipment.dmi'
					icon_state = "chainlegs"
					EquipState = "chainlegs"
					CarryState = "folded chain"
					DefenceType = "Chain"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Snakeman")
					ItemLayer = 4.3
					CanBeCrafted = 1
					Weight = 7
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				GiantChainLeggings
					icon = 'equipment.dmi'
					icon_state = "giant chainlegs"
					EquipState = "giant chainlegs"
					CarryState = "folded chain"
					DefenceType = "Chain"
					CantRaces = list("Human","Alther","Ratling","Frogman","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.3
					CanBeCrafted = 1
					Weight = 10
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SmallChainLeggings
					icon = 'equipment.dmi'
					icon_state = "small chainlegs"
					EquipState = "small chainlegs"
					CarryState = "folded chain"
					DefenceType = "Chain"
					CantRaces = list("Giant","Cyclops","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.3
					CanBeCrafted = 1
					Weight = 5
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			Waist
				Click()
					if(usr.Function == "Interact" && usr.Ref == null)
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(usr.Race in src.CantRaces)
								usr << "<font color = red>Your race cant wear that item!<br>"
								return
							if(src.Dura <= 0)
								usr << "<font color = red>[src] is broken, you cant use that!<br>"
								return
							if(src in usr)
								if(usr.WWaist == null)
									src.layer = src.ItemLayer
									src.suffix = "Equip"
									src.overlays += image(/obj/HUD/E/)
									src.icon_state = src.EquipState
									usr.WWaist = src
									usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.WWaist == src)
									src.layer = src.ItemLayer
									usr.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
									usr.WWaist = null
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						return
					if(usr.Function == "Interact")
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
						return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							usr.DeleteInventoryMenu()
							usr.CreateInventory()
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
				SmallPlateBelt
					icon = 'equipment.dmi'
					icon_state = "small platebelt"
					EquipState = "small platebelt"
					CarryState = "small platebelt"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Human","Alther","Frogman","Wolfman","Illithid")
					ItemLayer = 4.4
					Weight = 3
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PriestBelt
					icon = 'equipment.dmi'
					icon_state = "priest belt"
					EquipState = "priest belt"
					CarryState = "inquisitor priest belt"
					Weight = 3
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Snakeman","Illithid")
					DefenceType = "Plate"
					Dura = 100
					ItemLayer = 4.6
					Defence = 3
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			Shoulders
				Click()
					if(usr.Job == null && src.Material == "Bone" && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							var/Close = 0
							if(O.Material != "Bone")
								Close = 1
							if(O.Type != "Skull")
								Close = 1
							if(Close)
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Two Skulls in order to create this item!<br>"
								return
							var/BoneNum = 0
							var/Bones = list()
							for(var/obj/Items/Misc/Skull/S in usr)
								if(BoneNum != 2)
									BoneNum += 1
									Bones += S
							if(BoneNum != 2)
								usr << "<font color = red>You need Two Skulls in order to create this item!<br>"
								return
							if(BoneNum == 2 && O.Material == "Bone")
								var/LOC = usr.loc
								usr.Job = "MakeBoneItem"
								usr.CanMove = 0
								var/Time = 200 - usr.BoneCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Skulls into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Bones && usr.loc == LOC)
											if(BoneNum == 2 && O && usr.Job == "MakeBoneItem")
												var/Fail = prob(50 - usr.BoneCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													for(var/obj/I in Bones)
														if(BoneNum != 0)
															BoneNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.BoneCraftSkill += usr.BoneCraftMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.BoneCraftSkill * 2
												W.Defence += usr.BoneCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftBoneArmour(O,W)
												for(var/obj/I in Bones)
													if(BoneNum != 0)
														BoneNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.BoneCraftSkill += usr.BoneCraftMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Skulls could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Skulls could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
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
									if(IngotNum == 2)
										break
								if(IngotNum != 2)
									usr << "<font color = red>You need two Ingots of the same Material to forge this item!<br>"
									return
								IngotNum = 0
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
										if(Ingots)
											for(var/obj/I in Ingots)
												if(I in usr)
													IngotNum += 1
													if(IngotNum == 2)
														break
										if(IngotNum == 2 && usr.Job == "Forge")
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
															if(IngotNum != 2)
																IngotNum += 1
																usr.Weight -= I.Weight
																del(I)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti / 2
														usr.GainStats(2)
														return
													var/obj/W = new src.type(usr.loc)
													W.icon = src.icon
													W.EquipState = src.EquipState
													W.CarryState = src.CarryState
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
													if(W.ObjectTag == "Armour")
														usr.CraftArmour(O,W)
													W.icon_state = W.CarryState
													IngotNum = 0
													for(var/obj/I in Ingots)
														if(IngotNum != 2)
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(usr.Race in src.CantRaces)
								usr << "<font color = red>Your race cant wear that item!<br>"
								return
							if(src.Dura <= 0)
								usr << "<font color = red>[src] is broken, you cant use that!<br>"
								return
							if(src in usr)
								if(usr.WShoulders == null)
									src.layer = src.ItemLayer
									src.suffix = "Equip"
									src.overlays += image(/obj/HUD/E/)
									src.icon_state = src.EquipState
									usr.WShoulders = src
									usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.WShoulders == src)
									src.layer = src.ItemLayer
									usr.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
									usr.WShoulders = null
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in usr)
							var/Known = 0
							for(var/obj/Items/A in usr.CreateList)
								if(A.EquipState == src.EquipState && A.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Gold","Copper")
										for(var/M in Mats)
											var/obj/A = new src.type()
											A.Material = "[M]"
											A.CarryState = "[M] [A.icon_state]"
											A.EquipState = "[M] [A.EquipState] equip"
											A.icon_state = A.CarryState
											A.layer = 100
											usr.CreateList += A
									else
										var/obj/A = new src.type()
										A.Material = src.Material
										A.icon_state = src.CarryState
										A.EquipState = src.EquipState
										A.CarryState = src.CarryState
										A.layer = 100
										usr.CreateList += A
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
							return
					if(usr.Function == "Interact")
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
						return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							usr.DeleteInventoryMenu()
							usr.CreateInventory()
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
				PriestsPauldrons
					icon = 'equipment.dmi'
					icon_state = "priest shoulders"
					EquipState = "priest shoulders"
					CarryState = "inquisitor priest pauldrons"
					Weight = 15
					DefenceType = "Plate"
					Dura = 100
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					ItemLayer = 4.7
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SkullPauldrons
					icon = 'equipment.dmi'
					icon_state = "skull shoulders equip"
					EquipState = "skull shoulders equip"
					CarryState = "skull shoulders"
					Weight = 5
					DefenceType = "Chain"
					Dura = 100
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 5
					Defence = 4
					Material = "Bone"
					CanBeCrafted = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				InquisitorsPauldrons
					icon = 'equipment.dmi'
					icon_state = "inquisitor shoulders"
					EquipState = "inquisitor shoulders"
					CarryState = "inquisitor pauldrons"
					Weight = 20
					DefenceType = "Plate"
					Dura = 100
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					ItemLayer = 4.6
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SmallPlatePauldrons
					icon = 'equipment.dmi'
					icon_state = "small shoulders"
					EquipState = "small shoulders"
					CarryState = "small shoulders"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Human","Alther","Frogman","Wolfman","Illithid")
					ItemLayer = 4.7
					CanBeCrafted = 1
					Weight = 7
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				RatPlatePauldrons
					icon = 'equipment.dmi'
					icon_state = "rat shoulders"
					EquipState = "rat shoulders"
					CarryState = "rat shoulders"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 5
					CanBeCrafted = 1
					Weight = 6
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PlatePauldrons
					icon = 'equipment.dmi'
					icon_state = "shoulders"
					EquipState = "shoulders"
					CarryState = "shoulders"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman")
					ItemLayer = 4.7
					Weight = 10
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			LeftArm
				Click()
					if(usr.Job == null && src.Material == "Bone" && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Material != "Bone")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Two piles of Bones in order to create this item!<br>"
								return
							var/BoneNum = 0
							var/Bones = list()
							for(var/obj/Items/Misc/Bones/B in usr)
								if(BoneNum != 2)
									BoneNum += 1
									Bones += B
							if(BoneNum != 2)
								usr << "<font color = red>You need Two piles of Bones in order to create this item!<br>"
								return
							if(BoneNum == 2 && O.Material == "Bone")
								var/LOC = usr.loc
								usr.Job = "MakeBoneItem"
								usr.CanMove = 0
								var/Time = 200 - usr.BoneCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Bone piles into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Bones && usr.loc == LOC)
											if(BoneNum == 2 && O && usr.Job == "MakeBoneItem")
												var/Fail = prob(50 - usr.BoneCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													for(var/obj/I in Bones)
														if(BoneNum != 0)
															BoneNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.BoneCraftSkill += usr.BoneCraftMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.BoneCraftSkill * 2
												W.Defence += usr.BoneCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftBoneArmour(O,W)
												for(var/obj/I in Bones)
													if(BoneNum != 0)
														BoneNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.BoneCraftSkill += usr.BoneCraftMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Bone piles could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Bone piles could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
											return
					if(usr.Job == null && src.Material == "Leather" && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Material != "Leather")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Two Dry Leather Hides in order to create this item!<br>"
								return
							var/LeatherNum = 0
							var/Leathers = list()
							for(var/obj/Items/Resources/Skin/S in usr)
								if(S.Type == "Dry" && LeatherNum != 2)
									LeatherNum += 1
									Leathers += S
							if(LeatherNum != 2)
								usr << "<font color = red>You need Two Dry Leather Hides in order to create this item!<br>"
								return
							if(LeatherNum == 2 && O.Material == "Leather")
								var/LOC = usr.loc
								usr.Job = "MakeLeatherItem"
								usr.CanMove = 0
								var/Time = 200 - usr.LeatherCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Dry Leather Hides into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Leathers && usr.loc == LOC)
											if(LeatherNum == 2 && O && usr.Job == "MakeLeatherItem")
												var/Fail = prob(50 - usr.LeatherCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													var/obj/Items/Resources/Skin/S = new
													S.icon_state = "Dry Leather Scrap"
													S.name = "[O.name] Scrap"
													S.CraftPotential = O.CraftPotential / 2
													S.Weight = S.Weight / 2
													S.loc = usr.loc
													S.Type = "Dry"
													for(var/obj/I in Leathers)
														if(LeatherNum != 0)
															LeatherNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.LeatherCraftSkill * 2
												W.Defence += usr.LeatherCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftLeatherArmour(O,W)
												for(var/obj/I in Leathers)
													if(LeatherNum != 0)
														LeatherNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Dry Leather Hides could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Dry Leather Hides could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
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
									if(IngotNum == 1)
										break
								if(IngotNum != 1)
									usr << "<font color = red>You need one Ingot of the same Material to forge this item!<br>"
									return
								IngotNum = 0
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
										if(Ingots)
											for(var/obj/I in Ingots)
												if(I in usr)
													IngotNum += 1
													if(IngotNum == 1)
														break
										if(IngotNum == 1 && usr.Job == "Forge")
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
															if(IngotNum != 1)
																IngotNum += 1
																usr.Weight -= I.Weight
																del(I)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti / 2
														usr.GainStats(3)
														return
													var/obj/W = new src.type(usr.loc)
													W.icon = src.icon
													W.EquipState = src.EquipState
													W.CarryState = src.CarryState
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
													if(W.ObjectTag == "Armour")
														usr.CraftArmour(O,W)
													W.icon_state = W.CarryState
													IngotNum = 0
													for(var/obj/I in Ingots)
														if(IngotNum != 1)
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Race in src.CantRaces)
									usr << "<font color = red>Your race cant wear that item!<br>"
									return
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								if(usr.LeftArm)
									if(usr.WLeftHand == null)
										src.layer = src.ItemLayer
										src.suffix = "Equip"
										src.overlays += image(/obj/HUD/E/)
										src.icon_state = src.EquipState
										usr.WLeftHand = src
										usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
										src.layer = 20
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
										return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.WLeftHand == src)
									src.layer = src.ItemLayer
									usr.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
									usr.WLeftHand = null
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in usr)
							var/Known = 0
							for(var/obj/Items/A in usr.CreateList)
								if(A.EquipState == src.EquipState && A.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Gold","Copper")
										for(var/M in Mats)
											var/obj/A = new src.type()
											A.Material = "[M]"
											A.CarryState = "[M] [A.icon_state]"
											A.EquipState = "[M] [A.EquipState] equip"
											A.icon_state = A.CarryState
											A.layer = 100
											usr.CreateList += A
									else
										var/obj/A = new src.type()
										A.Material = src.Material
										A.icon_state = src.CarryState
										A.EquipState = src.EquipState
										A.CarryState = src.CarryState
										A.layer = 100
										usr.CreateList += A
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
							return
					if(usr.Function == "Interact")
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
						return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							usr.DeleteInventoryMenu()
							usr.CreateInventory()
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
				BoneLeftGauntlet
					icon = 'equipment.dmi'
					icon_state = "left bone equip"
					EquipState = "left bone equip"
					CarryState = "left bone gauntlet"
					DefenceType = "Chain"
					Weight = 1
					Dura = 100
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					Defence = 3
					Material = "Bone"
					CanBeCrafted = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				LeatherGloveLeft
					icon = 'equipment.dmi'
					icon_state = "leather glove left2"
					EquipState = "leather glove left2"
					CarryState = "leather glove left"
					DefenceType = "Leather"
					Material = "Leather"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite")
					ItemLayer = 4.5
					CanBeCrafted = 1
					Defence = 3
					Dura = 100
					Fuel = 75
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PriestsLeftGauntlet
					icon = 'equipment.dmi'
					icon_state = "priest glove L"
					EquipState = "priest glove L"
					CarryState = "priest gauntlet L"
					DefenceType = "Plate"
					Weight = 8
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					Dura = 100
					ItemLayer = 4.5
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				InquisitorsLeftGauntlet
					icon = 'equipment.dmi'
					icon_state = "inquisitor left glove"
					EquipState = "inquisitor left glove"
					CarryState = "inqusitor gauntlets left"
					DefenceType = "Plate"
					Weight = 8
					Dura = 100
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					ItemLayer = 4.5
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				RatPlateGauntletLeft
					icon = 'equipment.dmi'
					icon_state = "rat plateglove left"
					EquipState = "rat plateglove left"
					CarryState = "rat plateglove left"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 3
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SmallPlateGauntletLeft
					icon = 'equipment.dmi'
					icon_state = "small plateglove left"
					EquipState = "small plateglove left"
					CarryState = "small plateglove left"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 3
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PlateGauntletLeft
					icon = 'equipment.dmi'
					icon_state = "plateglove left"
					EquipState = "plateglove left"
					CarryState = "plateglove left"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 5
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				GiantChainGloveLeft
					icon = 'equipment.dmi'
					icon_state = "giant chainleft glove"
					EquipState = "giant chainleft glove"
					CarryState = "folded chain"
					DefenceType = "Chain"
					CantRaces = list("Stahlite","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 6
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				GiantPlateGloveLeft
					icon = 'equipment.dmi'
					icon_state = "giant plateglove left"
					EquipState = "giant plateglove left"
					CarryState = "giant plateglove left"
					DefenceType = "Plate"
					CantRaces = list("Stahlite","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 7
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			RightArm
				Click()
					if(usr.Job == null && src.Material == "Bone" && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Material != "Bone")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Two piles of Bones in order to create this item!<br>"
								return
							var/BoneNum = 0
							var/Bones = list()
							for(var/obj/Items/Misc/Bones/B in usr)
								if(BoneNum != 2)
									BoneNum += 1
									Bones += B
							if(BoneNum != 2)
								usr << "<font color = red>You need Two piles of Bones in order to create this item!<br>"
								return
							if(BoneNum == 2 && O.Material == "Bone")
								var/LOC = usr.loc
								usr.Job = "MakeBoneItem"
								usr.CanMove = 0
								var/Time = 200 - usr.BoneCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Bone piles into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Bones && usr.loc == LOC)
											if(BoneNum == 2 && O && usr.Job == "MakeBoneItem")
												var/Fail = prob(50 - usr.BoneCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													for(var/obj/I in Bones)
														if(BoneNum != 0)
															BoneNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.BoneCraftSkill += usr.BoneCraftMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.BoneCraftSkill * 2
												W.Defence += usr.BoneCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftBoneArmour(O,W)
												for(var/obj/I in Bones)
													if(BoneNum != 0)
														BoneNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.BoneCraftSkill += usr.BoneCraftMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Bone piles could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Bone piles could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
											return
					if(usr.Job == null && src.Material == "Leather" && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Material != "Leather")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Two Dry Leather Hides in order to create this item!<br>"
								return
							var/LeatherNum = 0
							var/Leathers = list()
							for(var/obj/Items/Resources/Skin/S in usr)
								if(S.Type == "Dry" && LeatherNum != 2)
									LeatherNum += 1
									Leathers += S
							if(LeatherNum != 2)
								usr << "<font color = red>You need Two Dry Leather Hides in order to create this item!<br>"
								return
							if(LeatherNum == 2 && O.Material == "Leather")
								var/LOC = usr.loc
								usr.Job = "MakeLeatherItem"
								usr.CanMove = 0
								var/Time = 200 - usr.LeatherCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Dry Leather Hides into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Leathers && usr.loc == LOC)
											if(LeatherNum == 2 && O && usr.Job == "MakeLeatherItem")
												var/Fail = prob(50 - usr.LeatherCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													var/obj/Items/Resources/Skin/S = new
													S.icon_state = "Dry Leather Scrap"
													S.name = "[O.name] Scrap"
													S.CraftPotential = O.CraftPotential / 2
													S.Weight = S.Weight / 2
													S.loc = usr.loc
													S.Type = "Dry"
													for(var/obj/I in Leathers)
														if(LeatherNum != 0)
															LeatherNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.LeatherCraftSkill * 2
												W.Defence += usr.LeatherCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftLeatherArmour(O,W)
												for(var/obj/I in Leathers)
													if(LeatherNum != 0)
														LeatherNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Dry Leather Hides could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Dry Leather Hides could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
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
									if(IngotNum == 1)
										break
								if(IngotNum != 1)
									usr << "<font color = red>You need one Ingot of the same Material to forge this item!<br>"
									return
								IngotNum = 0
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
										if(Ingots)
											for(var/obj/I in Ingots)
												if(I in usr)
													IngotNum += 1
													if(IngotNum == 1)
														break
										if(IngotNum == 1 && usr.Job == "Forge")
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
															if(IngotNum != 1)
																IngotNum += 1
																usr.Weight -= I.Weight
																del(I)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti / 2
														usr.GainStats(2,"Yes")
														return
													var/obj/W = new src.type(usr.loc)
													W.icon = src.icon
													W.EquipState = src.EquipState
													W.CarryState = src.CarryState
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
													if(W.ObjectTag == "Armour")
														usr.CraftArmour(O,W)
													W.icon_state = W.CarryState
													IngotNum = 0
													for(var/obj/I in Ingots)
														if(IngotNum != 1)
															IngotNum += 1
															usr.Weight -= I.Weight
															del(I)
													if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
														usr.ForgingSkill += usr.ForgingSkillMulti
													usr.GainStats(2,"Yes")
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Race in src.CantRaces)
									usr << "<font color = red>Your race cant wear that item!<br>"
									return
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								if(usr.RightArm)
									if(usr.WRightHand == null)
										src.layer = src.ItemLayer
										src.suffix = "Equip"
										src.overlays += image(/obj/HUD/E/)
										src.icon_state = src.EquipState
										usr.WRightHand = src
										usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
										src.layer = 20
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
										if(src.Type == "Corruption")
											src.suffix = "Fused"
											usr.Afflictions += "Right Hand Corruption"
											usr << "<font color = red>You place the [src] over your right hand, as you do you feel a sharp pain run up your arm. Suddenly your hand fills with agony as the [src] begins to fuse itself to your body!<br>"
											usr.Endurance += 2
											usr.Strength += 2
											usr.Corruption()
										return
						if(src.suffix == "Fused")
							usr << "<font color = red>You try to pull the [src] off, but its no use, its fused to your body and wont budge!<br>"
							return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.WRightHand == src)
									src.layer = src.ItemLayer
									usr.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
									usr.WRightHand = null
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in usr)
							var/Known = 0
							for(var/obj/Items/A in usr.CreateList)
								if(A.EquipState == src.EquipState && A.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Gold","Copper")
										for(var/M in Mats)
											var/obj/A = new src.type()
											A.Material = "[M]"
											A.CarryState = "[M] [A.icon_state]"
											A.EquipState = "[M] [A.EquipState] equip"
											A.icon_state = A.CarryState
											A.layer = 100
											usr.CreateList += A
									else
										var/obj/A = new src.type()
										A.Material = src.Material
										A.icon_state = src.CarryState
										A.EquipState = src.EquipState
										A.CarryState = src.CarryState
										A.layer = 100
										usr.CreateList += A
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
							return
					if(usr.Function == "Interact")
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
						return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							usr.DeleteInventoryMenu()
							usr.CreateInventory()
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
				BoneRightGauntlet
					icon = 'equipment.dmi'
					icon_state = "right bone equip"
					EquipState = "right bone equip"
					CarryState = "right bone gauntlet"
					DefenceType = "Chain"
					Weight = 1
					Dura = 100
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					Defence = 3
					Material = "Bone"
					CanBeCrafted = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				LeatherGloveRight
					icon = 'equipment.dmi'
					icon_state = "leather glove right2"
					EquipState = "leather glove right2"
					CarryState = "leather glove right"
					DefenceType = "Leather"
					Material = "Leather"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite")
					ItemLayer = 4.5
					CanBeCrafted = 1
					Defence = 3
					Dura = 100
					Fuel = 75
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PriestsRightGauntlet
					icon = 'equipment.dmi'
					icon_state = "priest glove R"
					EquipState = "priest glove R"
					CarryState = "priest gauntlet R"
					DefenceType = "Plate"
					Weight = 1
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					Dura = 100
					ItemLayer = 4.5
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Glove_of_Corruption
					icon = 'equipment.dmi'
					icon_state = "Corruption1"
					EquipState = "Corruption1"
					CarryState = "Corruption1 Floor"
					DefenceType = "Plate"
					Type = "Corruption"
					Weight = 10
					Dura = 100
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Snakeman")
					ItemLayer = 4.5
					Defence = 1
					BaseMaterial = "Metal"
					Delete = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				InquisitorsRightGauntlet
					icon = 'equipment.dmi'
					icon_state = "inquisitor right glove"
					EquipState = "inquisitor right glove"
					CarryState = "inqusitor gauntlets right"
					DefenceType = "Plate"
					Weight = 2
					Dura = 100
					ItemLayer = 4.5
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				GiantChainGloveRight
					icon = 'equipment.dmi'
					icon_state = "giant chainright glove"
					EquipState = "giant chainright glove"
					CarryState = "folded chain"
					DefenceType = "Chain"
					CantRaces = list("Stahlite","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 6
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				GiantPlateGloveRight
					icon = 'equipment.dmi'
					icon_state = "giant plateglove right"
					EquipState = "giant plateglove right"
					CarryState = "giant plateglove right"
					DefenceType = "Plate"
					CantRaces = list("Stahlite","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 7
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SmallPlateGauntletRight
					icon = 'equipment.dmi'
					icon_state = "small plateglove right"
					EquipState = "small plateglove right"
					CarryState = "small plateglove right"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 3
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				RatPlateGauntletRight
					icon = 'equipment.dmi'
					icon_state = "rat plateglove right"
					EquipState = "rat plateglove right"
					CarryState = "rat plateglove right"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 3
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PlateGauntletRight
					icon = 'equipment.dmi'
					icon_state = "plateglove right"
					EquipState = "plateglove right"
					CarryState = "plateglove right"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 5
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			RightFoot
				Click()
					if(usr.Job == null && src.Material == "Bone" && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Material != "Bone")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Two piles of Bones in order to create this item!<br>"
								return
							var/BoneNum = 0
							var/Bones = list()
							for(var/obj/Items/Misc/Bones/B in usr)
								if(BoneNum != 2)
									BoneNum += 1
									Bones += B
							if(BoneNum != 2)
								usr << "<font color = red>You need Two piles of Bones in order to create this item!<br>"
								return
							if(BoneNum == 2 && O.Material == "Bone")
								var/LOC = usr.loc
								usr.Job = "MakeBoneItem"
								usr.CanMove = 0
								var/Time = 200 - usr.BoneCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Bone piles into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Bones && usr.loc == LOC)
											if(BoneNum == 2 && O && usr.Job == "MakeBoneItem")
												var/Fail = prob(50 - usr.BoneCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													for(var/obj/I in Bones)
														if(BoneNum != 0)
															BoneNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.BoneCraftSkill += usr.BoneCraftMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.BoneCraftSkill * 2
												W.Defence += usr.BoneCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftBoneArmour(O,W)
												for(var/obj/I in Bones)
													if(BoneNum != 0)
														BoneNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.BoneCraftSkill += usr.BoneCraftMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Bone piles could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Bone piles could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
											return
					if(usr.Job == null && src.Material == "Leather" && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Material != "Leather")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Two Dry Leather Hides in order to create this item!<br>"
								return
							var/LeatherNum = 0
							var/Leathers = list()
							for(var/obj/Items/Resources/Skin/S in usr)
								if(S.Type == "Dry" && LeatherNum != 2)
									LeatherNum += 1
									Leathers += S
							if(LeatherNum != 2)
								usr << "<font color = red>You need Two Dry Leather Hides in order to create this item!<br>"
								return
							if(LeatherNum == 2 && O.Material == "Leather")
								var/LOC = usr.loc
								usr.Job = "MakeLeatherItem"
								usr.CanMove = 0
								var/Time = 200 - usr.LeatherCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Dry Leather Hides into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Leathers && usr.loc == LOC)
											if(LeatherNum == 2 && O && usr.Job == "MakeLeatherItem")
												var/Fail = prob(50 - usr.LeatherCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													var/obj/Items/Resources/Skin/S = new
													S.icon_state = "Dry Leather Scrap"
													S.name = "[O.name] Scrap"
													S.CraftPotential = O.CraftPotential / 2
													S.Weight = S.Weight / 2
													S.loc = usr.loc
													S.Type = "Dry"
													for(var/obj/I in Leathers)
														if(LeatherNum != 0)
															LeatherNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.LeatherCraftSkill * 2
												W.Defence += usr.LeatherCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftLeatherArmour(O,W)
												for(var/obj/I in Leathers)
													if(LeatherNum != 0)
														LeatherNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Dry Leather Hides could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Dry Leather Hides could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
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
									if(IngotNum == 1)
										break
								if(IngotNum != 1)
									usr << "<font color = red>You need one Ingot of the same Material to forge this item!<br>"
									return
								IngotNum = 0
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
										if(Ingots)
											for(var/obj/I in Ingots)
												if(I in usr)
													IngotNum += 1
													if(IngotNum == 1)
														break
										if(IngotNum == 1 && usr.Job == "Forge")
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
															if(IngotNum != 1)
																IngotNum += 1
																usr.Weight -= I.Weight
																del(I)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti / 2
														usr.GainStats(2)
														return
													var/obj/W = new src.type(usr.loc)
													W.icon = src.icon
													W.EquipState = src.EquipState
													W.CarryState = src.CarryState
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
													if(W.ObjectTag == "Armour")
														usr.CraftArmour(O,W)
													W.icon_state = W.CarryState
													IngotNum = 0
													for(var/obj/I in Ingots)
														if(IngotNum != 1)
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Race in src.CantRaces)
									usr << "<font color = red>Your race cant wear that item!<br>"
									return
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								if(usr.RightLeg)
									if(usr.WRightFoot == null)
										src.layer = src.ItemLayer
										src.suffix = "Equip"
										src.overlays += image(/obj/HUD/E/)
										src.icon_state = src.EquipState
										usr.WRightFoot = src
										usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
										src.layer = 20
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
										return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.WRightFoot == src)
									src.layer = src.ItemLayer
									usr.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
									usr.WRightFoot = null
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in usr)
							var/Known = 0
							for(var/obj/Items/A in usr.CreateList)
								if(A.EquipState == src.EquipState && A.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Gold","Copper")
										for(var/M in Mats)
											var/obj/A = new src.type()
											A.Material = "[M]"
											A.CarryState = "[M] [A.icon_state]"
											A.EquipState = "[M] [A.EquipState] equip"
											A.icon_state = A.CarryState
											A.layer = 100
											usr.CreateList += A
									else
										var/obj/A = new src.type()
										A.Material = src.Material
										A.icon_state = src.CarryState
										A.EquipState = src.EquipState
										A.CarryState = src.CarryState
										A.layer = 100
										usr.CreateList += A
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
							return
					if(usr.Function == "Interact")
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
						return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							usr.DeleteInventoryMenu()
							usr.CreateInventory()
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
				BoneBootRight
					icon = 'equipment.dmi'
					icon_state = "right bone boot"
					EquipState = "right bone boot"
					CarryState = "right bone boot"
					DefenceType = "Chain"
					Weight = 1
					Dura = 100
					ItemLayer = 4.6
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					Defence = 3
					Dura = 100
					Material = "Bone"
					CanBeCrafted = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				LeatherBootRight
					icon = 'equipment.dmi'
					icon_state = "leather boot right2"
					EquipState = "leather boot right2"
					CarryState = "leather boot right"
					DefenceType = "Leather"
					Material = "Leather"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Snakeman")
					ItemLayer = 4.6
					Defence = 3
					CanBeCrafted = 1
					Dura = 100
					Fuel = 75
					Weight = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PriestsRightBoot
					icon = 'equipment.dmi'
					icon_state = "priest boot R"
					EquipState = "priest boot R"
					CarryState = "inquisitor priest boot R"
					DefenceType = "Plate"
					Weight = 8
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Snakeman","Illithid")
					Dura = 100
					ItemLayer = 4.6
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
						src.RandomItemQuality()
				InquisitorsRightBoot
					icon = 'equipment.dmi'
					icon_state = "inquisitor right boot"
					EquipState = "inquisitor right boot"
					CarryState = "inquisitor boots right"
					DefenceType = "Plate"
					Weight = 8
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Snakeman","Illithid")
					Dura = 100
					ItemLayer = 4.6
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
						src.RandomItemQuality()
				GiantChainBootRight
					icon = 'equipment.dmi'
					icon_state = "giant chainright boot"
					EquipState = "giant chainright boot"
					CarryState = "folded chain"
					DefenceType = "Chain"
					CantRaces = list("Stahlite","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.6
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 6
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				GiantPlateBootRight
					icon = 'equipment.dmi'
					icon_state = "giant plateboot right"
					EquipState = "giant plateboot right"
					CarryState = "giant plateboot right"
					DefenceType = "Plate"
					CantRaces = list("Stahlite","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.6
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 7
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SmallPlateBootRight
					icon = 'equipment.dmi'
					icon_state = "small plateboot right"
					EquipState = "small plateboot right"
					CarryState = "small plateboot right"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.6
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 3
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				RatPlateBootRight
					icon = 'equipment.dmi'
					icon_state = "rat plateboot right"
					EquipState = "rat plateboot right"
					CarryState = "rat plateboot right"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.6
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 3
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PlateBootRight
					icon = 'equipment.dmi'
					icon_state = "plateboot right"
					EquipState = "plateboot right"
					CarryState = "plateboot right"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Snakeman","Illithid")
					ItemLayer = 4.6
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 5
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			LeftFoot
				Click()
					if(usr.Job == null && src.Material == "Bone" && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Material != "Bone")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Two piles of Bones in order to create this item!<br>"
								return
							var/BoneNum = 0
							var/Bones = list()
							for(var/obj/Items/Misc/Bones/B in usr)
								if(BoneNum != 2)
									BoneNum += 1
									Bones += B
							if(BoneNum != 2)
								usr << "<font color = red>You need Two piles of Bones in order to create this item!<br>"
								return
							if(BoneNum == 2 && O.Material == "Bone")
								var/LOC = usr.loc
								usr.Job = "MakeBoneItem"
								usr.CanMove = 0
								var/Time = 200 - usr.BoneCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Bone piles into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Bones && usr.loc == LOC)
											if(BoneNum == 2 && O && usr.Job == "MakeBoneItem")
												var/Fail = prob(50 - usr.BoneCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													for(var/obj/I in Bones)
														if(BoneNum != 0)
															BoneNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.BoneCraftSkill += usr.BoneCraftMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.BoneCraftSkill * 2
												W.Defence += usr.BoneCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftBoneArmour(O,W)
												for(var/obj/I in Bones)
													if(BoneNum != 0)
														BoneNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.BoneCraftSkill += usr.BoneCraftMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Bone piles could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Bone piles could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
											return
					if(usr.Job == null && src.Material == "Leather" && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Material != "Leather")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Two Dry Leather Hides in order to create this item!<br>"
								return
							var/LeatherNum = 0
							var/Leathers = list()
							for(var/obj/Items/Resources/Skin/S in usr)
								if(S.Type == "Dry" && LeatherNum != 2)
									LeatherNum += 1
									Leathers += S
							if(LeatherNum != 2)
								usr << "<font color = red>You need Two Dry Leather Hides in order to create this item!<br>"
								return
							if(LeatherNum == 2 && O.Material == "Leather")
								var/LOC = usr.loc
								usr.Job = "MakeLeatherItem"
								usr.CanMove = 0
								var/Time = 200 - usr.LeatherCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Dry Leather Hides into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Leathers && usr.loc == LOC)
											if(LeatherNum == 2 && O && usr.Job == "MakeLeatherItem")
												var/Fail = prob(50 - usr.LeatherCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													var/obj/Items/Resources/Skin/S = new
													S.icon_state = "Dry Leather Scrap"
													S.name = "[O.name] Scrap"
													S.CraftPotential = O.CraftPotential / 2
													S.Weight = S.Weight / 2
													S.loc = usr.loc
													S.Type = "Dry"
													for(var/obj/I in Leathers)
														if(LeatherNum != 0)
															LeatherNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.LeatherCraftSkill * 2
												W.Defence += usr.LeatherCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftLeatherArmour(O,W)
												for(var/obj/I in Leathers)
													if(LeatherNum != 0)
														LeatherNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Dry Leather Hides could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Dry Leather Hides could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
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
									if(IngotNum == 1)
										break
								if(IngotNum != 1)
									usr << "<font color = red>You need one Ingot of the same Material to forge this item!<br>"
									return
								IngotNum = 0
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
										if(Ingots)
											for(var/obj/I in Ingots)
												if(I in usr)
													IngotNum += 1
													if(IngotNum == 1)
														break
										if(IngotNum == 1 && usr.Job == "Forge")
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
															if(IngotNum != 1)
																IngotNum += 1
																usr.Weight -= I.Weight
																del(I)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti / 2
														usr.GainStats(2)
														return
													var/obj/W = new src.type(usr.loc)
													W.icon = src.icon
													W.EquipState = src.EquipState
													W.CarryState = src.CarryState
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
													if(W.ObjectTag == "Armour")
														usr.CraftArmour(O,W)
													W.icon_state = W.CarryState
													IngotNum = 0
													for(var/obj/I in Ingots)
														if(IngotNum != 1)
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Race in src.CantRaces)
									usr << "<font color = red>Your race cant wear that item!<br>"
									return
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								if(usr.LeftLeg)
									if(usr.WLeftFoot == null)
										src.layer = src.ItemLayer
										src.suffix = "Equip"
										src.overlays += image(/obj/HUD/E/)
										src.icon_state = src.EquipState
										usr.WLeftFoot = src
										usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
										src.layer = 20
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
										return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.WLeftFoot == src)
									src.layer = src.ItemLayer
									usr.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
									usr.WLeftFoot = null
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in usr)
							var/Known = 0
							for(var/obj/Items/A in usr.CreateList)
								if(A.EquipState == src.EquipState && A.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Gold","Copper")
										for(var/M in Mats)
											var/obj/A = new src.type()
											A.Material = "[M]"
											A.CarryState = "[M] [A.icon_state]"
											A.EquipState = "[M] [A.EquipState] equip"
											A.icon_state = A.CarryState
											A.layer = 100
											usr.CreateList += A
									else
										var/obj/A = new src.type()
										A.Material = src.Material
										A.icon_state = src.CarryState
										A.EquipState = src.EquipState
										A.CarryState = src.CarryState
										A.layer = 100
										usr.CreateList += A
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
							return
					if(usr.Function == "Interact")
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
						return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							usr.DeleteInventoryMenu()
							usr.CreateInventory()
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
				BoneBootLeft
					icon = 'equipment.dmi'
					icon_state = "left bone boot"
					EquipState = "left bone boot"
					CarryState = "left bone boot"
					DefenceType = "Chain"
					Weight = 1
					Dura = 100
					ItemLayer = 4.6
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					Defence = 3
					Material = "Bone"
					CanBeCrafted = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				LeatherBootLeft
					icon = 'equipment.dmi'
					icon_state = "leather boot left2"
					EquipState = "leather boot left2"
					CarryState = "leather boot left"
					DefenceType = "Leather"
					Material = "Leather"
					ItemLayer = 4.6
					CanBeCrafted = 1
					Defence = 3
					Dura = 100
					Fuel = 75
					Weight = 1
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Snakeman")
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PriestsLeftBoot
					icon = 'equipment.dmi'
					icon_state = "priest boot L"
					EquipState = "priest boot L"
					CarryState = "inquisitor priest boot L"
					DefenceType = "Plate"
					Weight = 8
					Dura = 100
					ItemLayer = 4.6
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Snakeman","Illithid")
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				InquisitorsLeftBoot
					icon = 'equipment.dmi'
					icon_state = "inquisitor left boot"
					EquipState = "inquisitor left boot"
					CarryState = "inquisitor boots left"
					DefenceType = "Plate"
					Weight = 8
					Dura = 100
					ItemLayer = 4.6
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Snakeman","Illithid")
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				GiantChainBootLeft
					icon = 'equipment.dmi'
					icon_state = "giant chainleft boot"
					EquipState = "giant chainleft boot"
					CarryState = "folded chain"
					DefenceType = "Chain"
					CantRaces = list("Stahlite","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.6
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 6
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				GiantPlateBootLeft
					icon = 'equipment.dmi'
					icon_state = "giant plateboot left"
					EquipState = "giant plateboot left"
					CarryState = "giant plateboot left"
					DefenceType = "Plate"
					CantRaces = list("Stahlite","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.6
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 7
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				RatPlateBootLeft
					icon = 'equipment.dmi'
					icon_state = "rat plateboot left"
					EquipState = "rat plateboot left"
					CarryState = "rat plateboot left"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.6
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 3
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SmallPlateBootLeft
					icon = 'equipment.dmi'
					icon_state = "small plateboot left"
					EquipState = "small plateboot left"
					CarryState = "small plateboot left"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.6
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 3
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PlateBootLeft
					icon = 'equipment.dmi'
					icon_state = "plateboot left"
					EquipState = "plateboot left"
					CarryState = "plateboot left"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Snakeman","Illithid")
					ItemLayer = 4.6
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 5
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			Shields
				Type = "Shield"
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
									if(IngotNum == 1)
										break
								if(IngotNum != 1)
									usr << "<font color = red>You need one Ingot of the same Material to forge this item!<br>"
									return
								IngotNum = 0
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
										if(Ingots)
											for(var/obj/I in Ingots)
												if(I in usr)
													IngotNum += 1
													if(IngotNum == 1)
														break
										if(IngotNum == 1 && usr.Job == "Forge")
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
															if(IngotNum != 1)
																IngotNum += 1
																usr.Weight -= I.Weight
																del(I)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti / 2
														usr.GainStats(2)
														return
													var/obj/W = new src.type(usr.loc)
													W.icon = src.icon
													W.EquipState = src.EquipState
													W.CarryState = src.CarryState
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
													if(W.ObjectTag == "Armour")
														usr.CraftArmour(O,W)
													W.icon_state = W.CarryState
													IngotNum = 0
													for(var/obj/I in Ingots)
														if(IngotNum != 1)
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
					if(usr.Function == "Interact" && usr.Ref == null)
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								if(usr.CurrentHand == "Right")
									if(usr.RightArm <= 25)
										usr << "<font color = red>Your right arm is damaged!<br>"
										return
									if(usr.Weapon2)
										var/obj/W = usr.Weapon2
										if(W.ObjectType == "Ranged")
											usr << "<font color = red>You can not equip anything else while using a two handed weapon!<br>"
											return
									if(usr.Weapon == null)
										src.layer = src.ItemLayer
										src.suffix = "Equip"
										src.overlays += image(/obj/HUD/E/)
										src.icon_state = "[src.CarryState] equip"
										usr.Weapon = src
										usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
										src.layer = 20
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
										return
								if(usr.CurrentHand == "Left")
									if(usr.LeftArm <= 25)
										usr << "<font color = red>Your left arm is damaged!<br>"
										return
									if(usr.Weapon)
										var/obj/W = usr.Weapon
										if(W.ObjectType == "Ranged")
											usr << "<font color = red>You can not equip anything else while using a two handed weapon!<br>"
											return
									if(usr.Weapon2 == null)
										src.layer = src.ItemLayer
										src.suffix = "Equip"
										src.overlays += image(/obj/HUD/E/)
										src.icon_state = "[src.CarryState] equip left"
										usr.Weapon2 = src
										usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
										src.layer = 20
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
										return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.Weapon == src && usr.CurrentHand == "Right")
									src.layer = src.ItemLayer
									usr.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
									usr.Weapon = null
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
								if(usr.Weapon2 == src && usr.CurrentHand == "Left")
									src.layer = src.ItemLayer
									usr.overlays-=image(src.icon,"[src.icon_state]",src.ItemLayer)
									usr.Weapon2 = null
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in usr)
							var/Known = 0
							for(var/obj/Items/A in usr.CreateList)
								if(A.EquipState == src.EquipState && A.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Gold","Copper")
										for(var/M in Mats)
											var/obj/A = new src.type()
											A.Material = "[M]"
											A.CarryState = "[M] [A.icon_state]"
											A.EquipState = "[M] [A.EquipState] equip"
											A.icon_state = A.CarryState
											A.layer = 100
											usr.CreateList += A
									else
										var/obj/A = new src.type()
										A.Material = src.Material
										A.icon_state = src.CarryState
										A.EquipState = src.EquipState
										A.CarryState = src.CarryState
										A.layer = 100
										usr.CreateList += A
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
							return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							usr.DeleteInventoryMenu()
							usr.CreateInventory()
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
				WoodenBuckler
					icon = 'shields.dmi'
					icon_state = "wooden buckler equip"
					EquipState = "wooden buckler equip"
					CarryState = "wooden buckler"
					DefenceType = "Chain"
					Weight = 3
					Dura = 100
					ItemLayer = 5
					Defence = 3
					Fuel = 50
					New()
						src.icon_state = src.CarryState
						src.layer = 4
						src.RandomItemQuality()
				Shield
					icon = 'shields.dmi'
					icon_state = "shield"
					EquipState = "shield"
					CarryState = "shield"
					DefenceType = "Plate"
					ItemLayer = 5
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 7
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Torch
					icon = 'tools.dmi'
					icon_state = "torch equip"
					EquipState = "torch equip"
					CarryState = "torch"
					Weight = 2
					Fuel = 25
					Dura = 500
					Type = "Torch"
					ItemLayer = 5
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			Extra
				Click()
					if(usr.Job == null && src.Material == "Leather" && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Material != "Leather")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Four Dry Leather Hides in order to create this item!<br>"
								return
							var/LeatherNum = 0
							var/Leathers = list()
							for(var/obj/Items/Resources/Skin/S in usr)
								if(S.Type == "Dry" && LeatherNum != 2)
									LeatherNum += 1
									Leathers += S
							if(LeatherNum != 2)
								usr << "<font color = red>You need Four Dry Leather Hides in order to create this item!<br>"
								return
							if(LeatherNum == 2 && O.Material == "Leather")
								var/LOC = usr.loc
								usr.Job = "MakeLeatherItem"
								usr.CanMove = 0
								var/Time = 200 - usr.LeatherCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Dry Leather Hides into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Leathers && usr.loc == LOC)
											if(LeatherNum == 2 && O && usr.Job == "MakeLeatherItem")
												var/Fail = prob(50 - usr.LeatherCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													var/obj/Items/Resources/Skin/S = new
													S.icon_state = "Dry Leather Scrap"
													S.name = "[O.name] Scrap"
													S.CraftPotential = O.CraftPotential / 2
													S.Weight = S.Weight / 2
													S.loc = usr.loc
													S.Type = "Dry"
													for(var/obj/I in Leathers)
														if(LeatherNum != 0)
															LeatherNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.LeatherCraftSkill * 2
												W.Defence += usr.LeatherCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftLeatherArmour(O,W)
												for(var/obj/I in Leathers)
													if(LeatherNum != 0)
														LeatherNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Dry Leather Hides could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Dry Leather Hides could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
											return
					if(usr.Function == "Interact")
						if(usr.Dead == 0)
							if(src.suffix)
								var/obj/I
								for(var/obj/Items/Ammo/A in src)
									I = A
									break
								if(I)
									I.loc = usr
									src.Weight -= I.Weight
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									usr << "<font color = green>You pull a [I] from your Quiver!<br>"
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Race in src.CantRaces)
									usr << "<font color = red>Your race cant wear that item!<br>"
									return
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								if(usr.WExtra == null)
									src.layer = src.ItemLayer
									src.suffix = "Equip"
									src.overlays += image(/obj/HUD/E/)
									src.icon_state = src.EquipState
									usr.WExtra = src
									usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
									src.layer = 20
									src.icon_state = src.CarryState
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.WExtra == src)
									src.icon_state = src.EquipState
									src.layer = src.ItemLayer
									usr.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
									usr.WExtra = null
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							usr.DeleteInventoryMenu()
							usr.CreateInventory()
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
				LeatherQuiver
					icon = 'equipment.dmi'
					icon_state = "quiver equip"
					EquipState = "quiver equip"
					CarryState = "quiver"
					DefenceType = "Leather"
					Type = "Quiver"
					ItemLayer = 5
					CanBeCrafted = 1
					Material = "Leather"
					Dura = 100
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			Back
				Click()
					if(usr.Function == "Interact")
						if(usr.Dead == 0)
							if(src.suffix)
								var/obj/I = null
								for(var/obj/Items/Ammo/A in src)
									I = A
									break
								if(I)
									I.loc = usr
									usr.Weight -= src.Weight
									src.Weight -= I.Weight
									usr.Weight += src.Weight
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									usr << "<font color = green>You pull a [I] from your Quiver!<br>"
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Race in src.CantRaces)
									usr << "<font color = red>Your race cant wear that item!<br>"
									return
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								if(usr.WBack == null)
									src.layer = src.ItemLayer
									src.suffix = "Equip"
									src.overlays += image(/obj/HUD/E/)
									src.icon_state = src.EquipState
									usr.WBack = src
									usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									if(src.Type == "Conceals")
										usr.OriginalName = usr.name
										usr.name = "Unknown"
										usr.StoredFaction = usr.Faction
										usr.Faction = "None"
									return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.WBack == src)
									src.layer = src.ItemLayer
									usr.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
									usr.WBack = null
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									if(usr.OriginalName)
										usr.name = usr.OriginalName
										usr.OriginalName = null
									if(usr.StoredFaction)
										usr.Faction = usr.StoredFaction
										usr.StoredFaction = null
									return
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							usr.DeleteInventoryMenu()
							usr.CreateInventory()
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
				SmallClothCloak
					icon = 'clothes.dmi'
					icon_state = "small cloak equip"
					EquipState = "small cloak equip"
					CarryState = "folded cloth"
					DefenceType = "Cloth"
					Type = "Conceals"
					Weight = 1
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Wolfman","Snakeman","Illithid")
					Dura = 100
					ItemLayer = 4.9
					Defence = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				ClothCloak
					icon = 'clothes.dmi'
					icon_state = "cloak equip"
					EquipState = "cloak equip"
					CarryState = "folded cloth"
					DefenceType = "Cloth"
					Type = "Conceals"
					Weight = 2
					CantRaces = list("Giant","Cyclops")
					Dura = 100
					ItemLayer = 4.9
					Defence = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SmallClothCape
					icon = 'clothes.dmi'
					icon_state = "small cape equip"
					EquipState = "small cape equip"
					CarryState = "folded cloth"
					DefenceType = "Cloth"
					Weight = 1
					CantRaces = list("Stahlite","Giant","Cyclops","Human","Frogman","Alther","Wolfman","Snakeman","Illithid")
					Dura = 100
					Fuel = 50
					ItemLayer = 4.9
					Defence = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				ClothCape
					icon = 'clothes.dmi'
					icon_state = "cape equip"
					EquipState = "cape equip"
					CarryState = "folded cloth"
					DefenceType = "Cloth"
					Weight = 1
					CantRaces = list("Giant","Cyclops","Stahlite")
					Dura = 100
					Fuel = 50
					ItemLayer = 4.9
					Defence = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			Chest
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
									if(IngotNum == 2)
										break
								if(IngotNum != 2)
									usr << "<font color = red>You need two Ingot of the same Material to forge this item!<br>"
									return
								IngotNum = 0
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
										if(Ingots)
											for(var/obj/I in Ingots)
												if(I in usr)
													IngotNum += 1
													if(IngotNum == 2)
														break
										if(IngotNum == 2 && usr.Job == "Forge")
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
															if(IngotNum != 2)
																IngotNum += 1
																usr.Weight -= I.Weight
																del(I)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti / 2
														usr.GainStats(2)
														return
													var/obj/W = new src.type(usr.loc)
													W.icon = src.icon
													W.EquipState = src.EquipState
													W.CarryState = src.CarryState
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
													if(W.ObjectTag == "Armour")
														usr.CraftArmour(O,W)
													W.icon_state = W.CarryState
													IngotNum = 0
													for(var/obj/I in Ingots)
														if(IngotNum != 2)
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
					if(usr.Function == "Interact" && usr.Ref == null)
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Race in src.CantRaces)
									usr << "<font color = red>Your race cant wear that item!<br>"
									return
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								if(usr.WChest == null)
									src.layer = src.ItemLayer
									src.suffix = "Equip"
									src.overlays += image(/obj/HUD/E/)
									src.icon_state = src.EquipState
									usr.WChest = src
									usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.WChest == src)
									src.layer = src.ItemLayer
									usr.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
									usr.WChest = null
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in usr)
							var/Known = 0
							for(var/obj/Items/A in usr.CreateList)
								if(A.EquipState == src.EquipState && A.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									var/obj/A = new src.type()
									A.Material = src.Material
									A.icon_state = src.CarryState
									A.EquipState = src.EquipState
									A.CarryState = src.CarryState
									A.layer = 100
									usr.CreateList += A
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
							return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							usr.DeleteInventoryMenu()
							usr.CreateInventory()
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
				KingsRobe
					icon = 'clothes.dmi'
					icon_state = "kings robe"
					EquipState = "kings robe"
					CarryState = "folded kings robe"
					DefenceType = "Cloth"
					Weight = 1
					Dura = 100
					Fuel = 50
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite")
					ItemLayer = 4.5
					Defence = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Robe
					icon = 'clothes.dmi'
					icon_state = "robe"
					EquipState = "robe"
					CarryState = "folded cloth"
					DefenceType = "Cloth"
					Weight = 1
					Dura = 100
					Fuel = 50
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite")
					ItemLayer = 4.5
					Defence = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				WitchHunterTrenchCoat
					icon = 'clothes.dmi'
					icon_state = "witch hunter trench"
					EquipState = "witch hunter trench"
					CarryState = "folded trench"
					DefenceType = "Cloth"
					Weight = 1
					Dura = 100
					Fuel = 50
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite")
					ItemLayer = 4.5
					Defence = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				DesertRobe
					icon = 'clothes.dmi'
					icon_state = "desert robe"
					EquipState = "desert robe"
					CarryState = "folded desert robe"
					DefenceType = "Cloth"
					Weight = 1
					Dura = 100
					Fuel = 50
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite")
					ItemLayer = 4.5
					Defence = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PriestRobe
					icon = 'clothes.dmi'
					icon_state = "priest robe"
					EquipState = "priest robe"
					CarryState = "folded priest robe"
					DefenceType = "Cloth"
					Weight = 1
					Dura = 100
					Fuel = 50
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite")
					ItemLayer = 4.5
					Defence = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				ChainShirt
					icon = 'equipment.dmi'
					icon_state = "chainshirt"
					EquipState = "chainshirt"
					CarryState = "folded chain"
					DefenceType = "Chain"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite")
					ItemLayer = 4.3
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 5
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				GiantChainShirt
					icon = 'equipment.dmi'
					icon_state = "giant chainshirt"
					EquipState = "giant chainshirt"
					CarryState = "folded chain"
					DefenceType = "Chain"
					CantRaces = list("Human","Alther","Ratling","Frogman","Stahlite","Wolfman","Snakeman")
					ItemLayer = 4.3
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 7
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				RatChainShirt
					icon = 'equipment.dmi'
					icon_state = "rat chainshirt"
					EquipState = "rat chainshirt"
					CarryState = "folded chain"
					DefenceType = "Chain"
					CantRaces = list("Giant","Cyclops","Stahlite","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.3
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 3
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SmallChainShirt
					icon = 'equipment.dmi'
					icon_state = "small chainshirt"
					EquipState = "small chainshirt"
					CarryState = "folded chain"
					DefenceType = "Chain"
					CantRaces = list("Giant","Cyclops","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.3
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 4
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			UpperBody
				Click()
					if(usr.Job == null && src.Material == "Bone" && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Material != "Bone")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Four piles of Bones in order to create this item!<br>"
								return
							var/BoneNum = 0
							var/Bones = list()
							for(var/obj/Items/Misc/Bones/B in usr)
								if(BoneNum != 4)
									BoneNum += 1
									Bones += B
							if(BoneNum != 4)
								usr << "<font color = red>You need Four piles of Bones in order to create this item!<br>"
								return
							if(BoneNum == 4 && O.Material == "Bone")
								var/LOC = usr.loc
								usr.Job = "MakeBoneItem"
								usr.CanMove = 0
								var/Time = 200 - usr.BoneCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Bone piles into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Bones && usr.loc == LOC)
											if(BoneNum == 4 && O && usr.Job == "MakeBoneItem")
												var/Fail = prob(50 - usr.BoneCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													for(var/obj/I in Bones)
														if(BoneNum != 0)
															BoneNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.BoneCraftSkill += usr.BoneCraftMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.BoneCraftSkill * 2
												W.Defence += usr.BoneCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftBoneArmour(O,W)
												for(var/obj/I in Bones)
													if(BoneNum != 0)
														BoneNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.BoneCraftSkill += usr.BoneCraftMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Bone piles could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Bone piles could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
											return
					if(usr.Job == null && src.Material == "Leather" && src in usr.CreateList )
						if(usr.Ref)
							var/obj/O = usr.Ref
							if(O.Material != "Leather")
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need Four Dry Leather Hides in order to create this item!<br>"
								return
							var/LeatherNum = 0
							var/Leathers = list()
							for(var/obj/Items/Resources/Skin/S in usr)
								if(S.Type == "Dry" && LeatherNum != 4)
									LeatherNum += 1
									Leathers += S
							if(LeatherNum != 4)
								usr << "<font color = red>You need Four Dry Leather Hides in order to create this item!<br>"
								return
							if(LeatherNum == 4 && O.Material == "Leather")
								var/LOC = usr.loc
								usr.Job = "MakeLeatherItem"
								usr.CanMove = 0
								var/Time = 200 - usr.LeatherCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Dry Leather Hides into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Leathers && usr.loc == LOC)
											if(LeatherNum == 4 && O && usr.Job == "MakeLeatherItem")
												var/Fail = prob(50 - usr.LeatherCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													var/Scraps = rand(1,2)
													while(Scraps)
														Scraps -= 1
														var/obj/Items/Resources/Skin/S = new
														S.icon_state = "Dry Leather Scrap"
														S.name = "[O.name] Scrap"
														S.CraftPotential = O.CraftPotential / 2
														S.Weight = S.Weight / 2
														S.loc = usr.loc
														S.Type = "Dry"
													for(var/obj/I in Leathers)
														if(LeatherNum != 0)
															LeatherNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.LeatherCraftSkill * 2
												W.Defence += usr.LeatherCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftLeatherArmour(O,W)
												for(var/obj/I in Leathers)
													if(LeatherNum != 0)
														LeatherNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.LeatherCraftSkill += usr.LeatherCraftSkillMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Dry Leather Hides could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Dry Leather Hides could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
											return
					if(usr.Job == null && src in usr.CreateList)
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
									if(IngotNum == 3)
										break
								if(IngotNum != 3)
									usr << "<font color = red>You need three Ingots of the same Material to forge this item!<br>"
									return
								IngotNum = 0
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
										if(Ingots)
											for(var/obj/I in Ingots)
												if(I in usr)
													IngotNum += 1
													if(IngotNum == 3)
														break
										if(IngotNum == 3 && usr.Job == "Forge")
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
															if(IngotNum != 3)
																IngotNum += 1
																usr.Weight -= I.Weight
																del(I)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti / 2
														usr.GainStats(2)
														return
													var/obj/W = new src.type(usr.loc)
													W.icon = src.icon
													W.EquipState = src.EquipState
													W.CarryState = src.CarryState
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
													if(W.ObjectTag == "Armour")
														usr.CraftArmour(O,W)
													W.icon_state = W.CarryState
													IngotNum = 0
													for(var/obj/I in Ingots)
														if(IngotNum != 3)
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Race in src.CantRaces)
									usr << "<font color = red>Your race cant wear that item!<br>"
									return
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								if(usr.WUpperBody == null)
									src.suffix = "Equip"
									src.overlays += image(/obj/HUD/E/)
									src.icon_state = src.EquipState
									usr.WUpperBody = src
									usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.WUpperBody == src)
									usr.WUpperBody = null
									usr.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in usr)
							var/Known = 0
							for(var/obj/Items/A in usr.CreateList)
								if(A.EquipState == src.EquipState && A.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Gold","Copper")
										for(var/M in Mats)
											var/obj/A = new src.type()
											A.Material = "[M]"
											A.CarryState = "[M] [A.icon_state]"
											A.EquipState = "[M] [A.EquipState] equip"
											A.icon_state = A.CarryState
											A.layer = 100
											usr.CreateList += A
									else
										var/obj/A = new src.type()
										A.Material = src.Material
										A.icon_state = src.CarryState
										A.EquipState = src.EquipState
										A.CarryState = src.CarryState
										A.layer = 100
										usr.CreateList += A
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
							return
					if(usr.Function == "Interact")
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
						return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							usr.DeleteInventoryMenu()
							usr.CreateInventory()
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
				BoneChestPlate
					icon = 'equipment.dmi'
					icon_state = "bone chest armour equip"
					EquipState = "bone chest armour equip"
					CarryState = "bone chest armour"
					DefenceType = "Chain"
					Weight = 5
					Dura = 100
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					Defence = 3
					Material = "Bone"
					CanBeCrafted = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PriestsChestPlate
					icon = 'equipment.dmi'
					icon_state = "priest chestplate"
					EquipState = "priest chestplate"
					CarryState = "inquisitor priest chestplate"
					DefenceType = "Plate"
					Weight = 15
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					Dura = 100
					ItemLayer = 4.7
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				ChestPiece
					icon = 'equipment.dmi'
					icon_state = "chest piece"
					EquipState = "chest piece"
					CarryState = "chest piece"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman")
					ItemLayer = 4.7
					CanBeCrafted = 1
					Weight = 7
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				ChestPlate
					icon = 'equipment.dmi'
					icon_state = "chestplate"
					EquipState = "chestplate"
					CarryState = "chestplate"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					Weight = 10
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				GiantChestPlate
					icon = 'equipment.dmi'
					icon_state = "giant chestplate"
					EquipState = "giant chestplate"
					CarryState = "giant chestplate"
					DefenceType = "Plate"
					CantRaces = list("Stahlite","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					Weight = 13
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SmallChestPlate
					icon = 'equipment.dmi'
					icon_state = "small chestplate"
					EquipState = "small chestplate"
					CarryState = "small chestplate"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					Weight = 7
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				RatChestPlate
					icon = 'equipment.dmi'
					icon_state = "rat chestplate"
					EquipState = "rat chestplate"
					CarryState = "rat chestplate"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					Weight = 6
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				GiantLeatherVest
					icon = 'equipment.dmi'
					icon_state = "giant leather vest equip"
					EquipState = "giant leather vest equip"
					CarryState = "giant leather vest"
					DefenceType = "Leather"
					Material = "Leather"
					CantRaces = list("Human","Alther","Ratling","Frogman","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					Weight = 2
					Defence = 3
					Dura = 100
					Fuel = 75
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				LeatherVest
					icon = 'equipment.dmi'
					icon_state = "leather vest2"
					EquipState = "leather vest2"
					CarryState = "leather vest"
					DefenceType = "Leather"
					Material = "Leather"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite")
					ItemLayer = 4.5
					Weight = 1
					CanBeCrafted = 1
					Dura = 100
					Fuel = 75
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				InquisitorsChestPlate
					icon = 'equipment.dmi'
					icon_state = "inquisitor chest"
					EquipState = "inquisitor chest"
					CarryState = "inquisitor armour"
					DefenceType = "Plate"
					Weight = 20
					Dura = 100
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					ItemLayer = 4.5
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			Head
				Click()
					if(usr.Job == null && src.Material == "Bone" && src in usr.CreateList)
						if(usr.Ref)
							var/obj/O = usr.Ref
							var/Close = 0
							if(O.Material != "Bone")
								Close = 1
							if(O.Type != "Skull")
								Close = 1
							if(Close)
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								usr << "<font color = red>You need One Skull in order to create this item!<br>"
								return
							var/BoneNum = 0
							var/Bones = list()
							for(var/obj/Items/Misc/Skull/S in usr)
								if(BoneNum != 1)
									BoneNum += 1
									Bones += S
							if(BoneNum != 1)
								usr << "<font color = red>You need One Skull in order to create this item!<br>"
								return
							if(BoneNum == 1 && O.Material == "Bone")
								var/LOC = usr.loc
								usr.Job = "MakeBoneItem"
								usr.CanMove = 0
								var/Time = 200 - usr.BoneCraftSkill * 1.5 - usr.Agility / 2 - usr.Intelligence / 2
								if(Time <= 50)
									Time = 50
								usr.DeleteInventoryMenu()
								if(usr.InvenUp)
									usr.InvenUp = 0
								usr.ResetButtons()
								for(var/obj/HUD/B in usr.client.screen)
									if(B.Type == "Inventory")
										B.icon_state = "inv off"
								view(usr) << "<font color = yellow>[usr] begins to contruct the Skull into a [src] !<br>"
								spawn(Time)
									if(usr)
										if(Bones && usr.loc == LOC)
											if(BoneNum == 1 && O && usr.Job == "MakeBoneItem")
												var/Fail = prob(50 - usr.BoneCraftSkill - usr.Agility / 4 - usr.Intelligence / 2)
												usr.Job = null
												usr.MovementCheck()
												if(Fail)
													view(usr) << "<font color = yellow>[usr] fails at crafting a [src] !<br>"
													for(var/obj/I in Bones)
														if(BoneNum != 0)
															BoneNum -= 1
															usr.Weight -= I.Weight
															del(I)
													usr.BoneCraftSkill += usr.BoneCraftMulti / 2
													usr.GainStats(3,"Yes")
													return
												var/obj/W = new src.type(usr.loc)
												W.Material = O.Material
												W.Dura += usr.BoneCraftSkill * 2
												W.Defence += usr.BoneCraftSkill / 3
												W.suffix = null
												W.density = 0
												W.opacity = 0
												if(W.ObjectTag == "Armour")
													usr.CraftBoneArmour(O,W)
												for(var/obj/I in Bones)
													if(BoneNum != 0)
														BoneNum -= 1
														usr.Weight -= I.Weight
														del(I)
												usr.BoneCraftSkill += usr.BoneCraftMulti
												usr.GainStats(2,"Yes")
												view(usr) << "<font color = yellow>[usr] finishes creating the [W] !<br>"
												return
											else
												usr << "<font color = red>Skull could not be found in your inventory, crafting failed!<br>"
												usr.Job = null
												usr.MovementCheck()
												return
										else
											usr << "<font color = red>Skull could not be found in your inventory, or you moved while creating the item. Crafting failed!<br>"
											usr.Job = null
											usr.MovementCheck()
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
									if(IngotNum == 3)
										break
								if(IngotNum != 3)
									usr << "<font color = red>You need three Ingot of the same Material to forge this item!<br>"
									return
								IngotNum = 0
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
										if(Ingots)
											for(var/obj/I in Ingots)
												if(I in usr)
													IngotNum += 1
													if(IngotNum == 3)
														break
										if(IngotNum == 3 && usr.Job == "Forge")
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
															if(IngotNum != 3)
																IngotNum += 1
																usr.Weight -= I.Weight
																del(I)
														if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
															usr.ForgingSkill += usr.ForgingSkillMulti / 2
														usr.GainStats(2)
														return
													var/obj/W = new src.type(usr.loc)
													W.icon = src.icon
													W.EquipState = src.EquipState
													W.CarryState = src.CarryState
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
													if(W.ObjectTag == "Armour")
														usr.CraftArmour(O,W)
													W.icon_state = W.CarryState
													IngotNum = 0
													for(var/obj/I in Ingots)
														if(IngotNum != 3)
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(usr.Race in src.CantRaces)
									usr << "<font color = red>Your race cant wear that item!<br>"
									return
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								if(usr.WHead == null)
									src.layer = src.ItemLayer
									src.suffix = "Equip"
									src.overlays += image(/obj/HUD/E/)
									src.icon_state = src.EquipState
									usr.WHead = src
									usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
									src.layer = 20
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									if(src.Type != "Crown")
										if(usr.Hair)
											usr.overlays -= usr.Hair
										if(usr.Beard && usr.Race != "Stahlite")
											usr.overlays -= usr.Beard
									return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.WHead == src)
									src.layer = src.ItemLayer
									usr.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
									usr.WHead = null
									src.suffix = "Carried"
									src.overlays-=image(/obj/HUD/E/)
									src.overlays+=image(/obj/HUD/C/)
									src.icon_state = src.CarryState
									src.layer = 20
									if(src.Type != "Crown")
										if(usr.Hair)
											usr.overlays += usr.Hair
										if(usr.Beard && usr.Race != "Stahlite")
											usr.overlays += usr.Beard
									usr.DeleteInventoryMenu()
									usr.CreateInventory()
									return
					if(usr.Function == "Examine")
						usr << "<font color=teal>[src.desc]"
						if(src in usr)
							var/Known = 0
							for(var/obj/Items/A in usr.CreateList)
								if(A.EquipState == src.EquipState && A.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Gold","Copper")
										for(var/M in Mats)
											var/obj/A = new src.type()
											A.Material = "[M]"
											A.CarryState = "[M] [A.icon_state]"
											A.EquipState = "[M] [A.EquipState] equip"
											A.icon_state = A.CarryState
											A.layer = 100
											usr.CreateList += A
									else
										var/obj/A = new src.type()
										A.Material = src.Material
										A.icon_state = src.CarryState
										A.EquipState = src.EquipState
										A.CarryState = src.CarryState
										A.layer = 100
										usr.CreateList += A
									usr << "<font color = blue>You take a good look at the [src] and decide that, if needed, you could create one!<br>"
								else
									usr << "<font color = red>You take a good look at the [src] but have no idea how to create one...<br>"
							return
					if(usr.Function == "Interact")
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
						return
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
							usr.client.screen -= src
							usr.Weight -= src.Weight
							view() << "<b>[usr] drops [src]<br>"
							usr.DeleteInventoryMenu()
							usr.CreateInventory()
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
				Turban
					icon = 'clothes.dmi'
					icon_state = "turban"
					EquipState = "turban equip"
					CarryState = "turban"
					DefenceType = "Cloth"
					Weight = 1
					Dura = 100
					CantRaces = list("Giant","Cyclops","Ratling","Snakeman","Illithid")
					ItemLayer = 4.6
					Defence = 2
					BaseMaterial = "Cloth"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				WitchHunterHat
					icon = 'clothes.dmi'
					icon_state = "witch hunter hat"
					EquipState = "witch hunter hat equip"
					CarryState = "witch hunter hat"
					DefenceType = "Cloth"
					Weight = 1
					Dura = 100
					CantRaces = list("Giant","Cyclops","Ratling","Snakeman","Illithid")
					ItemLayer = 4.6
					Defence = 2
					BaseMaterial = "Cloth"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				InquisitorsHelmet
					icon = 'equipment.dmi'
					icon_state = "inquisitor helmet"
					EquipState = "inquisitor helmet"
					CarryState = "inquisitor helm"
					DefenceType = "Plate"
					Weight = 20
					Dura = 100
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					ItemLayer = 4.5
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SmallCrown
					icon = 'misc.dmi'
					icon_state = "stahlite crown equip"
					EquipState = "stahlite crown equip"
					CarryState = "crown"
					DefenceType = "Plate"
					Weight = 4
					Dura = 100
					CantRaces = list("Giant","Cyclops","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					Defence = 15
					BaseMaterial = "Metal"
					Type = "Crown"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
						src.RandomItemQuality()
				Crown
					icon = 'misc.dmi'
					icon_state = "crown equip"
					EquipState = "crown equip"
					CarryState = "crown"
					DefenceType = "Plate"
					Weight = 5
					Dura = 100
					CantRaces = list("Giant","Cyclops","Ratling")
					ItemLayer = 4.9
					Defence = 15
					BaseMaterial = "Metal"
					Type = "Crown"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
						src.RandomItemQuality()
				GiantCrown
					icon = 'misc.dmi'
					icon_state = "giant crown equip"
					EquipState = "giant crown equip"
					CarryState = "crown"
					DefenceType = "Plate"
					Weight = 6
					Dura = 100
					CantRaces = list("Human","Alther","Ratling","Frogman","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.9
					Defence = 15
					BaseMaterial = "Metal"
					Type = "Crown"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
						src.RandomItemQuality()
				PriestHelmet
					icon = 'equipment.dmi'
					icon_state = "priest helm"
					EquipState = "priest helm"
					CarryState = "inquisitor priest helm"
					DefenceType = "Plate"
					Weight = 22
					Dura = 100
					CantRaces = list("Giant","Cyclops","Ratling","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					Defence = 20
					Delete = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SkullHelmet
					icon = 'equipment.dmi'
					icon_state = "skull helm equip"
					EquipState = "skull helm equip"
					CarryState = "skull helm"
					DefenceType = "Chain"
					Weight = 5
					Dura = 100
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					Defence = 5
					Material = "Bone"
					CanBeCrafted = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PlateHelmet5
					name = "Plate Helmet"
					icon = 'equipment.dmi'
					icon_state = "plate helm5"
					EquipState = "plate helm5"
					CarryState = "plate helm5"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					ItemLayer = 4.5
					Weight = 10
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PlateHelmet4
					name = "Plate Helmet"
					icon = 'equipment.dmi'
					icon_state = "plate helm4"
					EquipState = "plate helm4"
					CarryState = "plate helm4"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					ItemLayer = 4.5
					Weight = 10
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PlateHelmet3
					name = "Plate Helmet"
					icon = 'equipment.dmi'
					icon_state = "plate helm3"
					EquipState = "plate helm3"
					CarryState = "plate helm3"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					ItemLayer = 4.5
					Weight = 10
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PlateHelmet2
					name = "Plate Helmet"
					icon = 'equipment.dmi'
					icon_state = "plate helm2"
					EquipState = "plate helm2"
					CarryState = "plate helm2"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					ItemLayer = 4.5
					Weight = 10
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PlateHelmet
					icon = 'equipment.dmi'
					icon_state = "plate helm1"
					EquipState = "plate helm1"
					CarryState = "plate helm1"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Stahlite","Wolfman","Illithid")
					ItemLayer = 4.5
					Weight = 10
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PlateHelmetRat
					icon = 'equipment.dmi'
					icon_state = "rat plate helm"
					EquipState = "rat plate helm"
					CarryState = "rat plate helm"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Human","Frogman","Alther","Stahlite","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					Weight = 7
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				PlateHelmetWolf
					icon = 'equipment.dmi'
					icon_state = "wolfman plate helm"
					EquipState = "wolfman plate helm"
					CarryState = "wolfman plate helm"
					DefenceType = "Plate"
					CantRaces = list("Human","Alther","Ratling","Frogman","Stahlite","Giant","Snakeman","Cyclops","Illithid")
					ItemLayer = 4.5
					Weight = 8
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				GiantChainCoif
					icon = 'equipment.dmi'
					icon_state = "giant chain coif"
					EquipState = "giant chain coif"
					CarryState = "folded chain"
					DefenceType = "Chain"
					ItemLayer = 4.5
					CantRaces = list("Human","Alther","Ratling","Frogman","Stahlite","Wolfman","Snakeman","Illithid")
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 10
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SmallDwarvenHelmet3
					icon = 'equipment.dmi'
					icon_state = "small stahlite helm3"
					EquipState = "small stahlite helm3"
					CarryState = "small stahlite helm3"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					Weight = 7
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SmallDwarvenHelmet2
					icon = 'equipment.dmi'
					icon_state = "small stahlite helm2"
					EquipState = "small stahlite helm2"
					CarryState = "small stahlite helm2"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					Weight = 7
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				SmallDwarvenHelmet
					icon = 'equipment.dmi'
					icon_state = "small stahlite helm1"
					EquipState = "small stahlite helm1"
					CarryState = "small stahlite helm1"
					DefenceType = "Plate"
					CantRaces = list("Giant","Cyclops","Ratling","Human","Alther","Frogman","Wolfman","Snakeman","Illithid")
					ItemLayer = 4.5
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 7
					New()
						src.icon_state = src.CarryState
						src.layer = 4
