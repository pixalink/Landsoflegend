obj
	proc
		CreateLeather()
			spawn(rand(1000,3000))
				if(src)
					if(src.icon_state != "Dry Leather Hide")
						src.icon_state = "Dry Leather Hide"
						src.name = "Dry [src.name]"
						src.Type = "Dry"

	Items
		Resources
			GoldOre
				icon = 'materials.dmi'
				icon_state = "Gold ore"
				Weight = 20
				Type = "Ore"
				Material = "Gold"
				New()
					src.CraftPotential = rand(10,100)
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
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
			SilverOre
				icon = 'materials.dmi'
				icon_state = "Silver ore"
				Weight = 15
				Type = "Ore"
				Material = "Silver"
				New()
					src.CraftPotential = rand(10,100)
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
				Click()
					if(usr.Function == "Interact")
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
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
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
			Charcoal
				icon = 'materials.dmi'
				icon_state = "charcoal"
				Weight = 2
				New()
					src.CraftPotential = rand(10,100)
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
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
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
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
					if(usr.Function == "Interact")
						if(src in usr)
							usr << "<font color=green>Click another object to interact with this one!<br>"
							usr.Ref = src
							return
			Coal
				icon = 'materials.dmi'
				icon_state = "Coal"
				Weight = 10
				Fuel = 200
				New()
					src.CraftPotential = rand(10,100)
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
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
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
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
					if(usr.Function == "Interact")
						if(src in usr)
							usr << "<font color=green>Click another object to interact with this one!<br>"
							usr.Ref = src
							return
			CopperOre
				icon = 'materials.dmi'
				icon_state = "Copper ore"
				Weight = 12
				Type = "Ore"
				Material = "Copper"
				New()
					src.CraftPotential = rand(10,100)
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
				Click()
					if(usr.Function == "Interact")
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
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
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
			IronOre
				icon = 'materials.dmi'
				icon_state = "Iron ore"
				Weight = 15
				Type = "Ore"
				Material = "Iron"
				New()
					src.CraftPotential = rand(10,100)
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
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
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
						return
					if(usr.Function == "StoneShard")
						usr << "<font color=green>You scratch the Iron Ore and the Stone Shard together and create sparks!<br>"
						for(var/obj/Items/Resources/CampSite/C in range(1,usr))
							if(C.icon_state != "campfire")
								if(C.Fuel)
									C.icon_state = "campfire"
									C.OnFire = 1
									view(C) << "<font color=yellow>[C] sets on fire!<br>"
									C.luminosity = 5
									C.CreateSmoke()
									C.Burn(0)
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
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
			Brick
				icon = 'materials.dmi'
				icon_state = "brick"
				Weight = 10
				Material = "Stone"
				Type = "SmallBrick"
				New()
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
				Click()
					if(usr.Function == "Interact")
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						if(src.suffix == null)
							if(src in range(1,usr))
								var/obj/W = null
								var/CanDo = 0
								if(usr.Weapon)
									W = usr.Weapon
									if(W.Type == "Hammer")
										CanDo = 1
									else
										W = null
								if(usr.Weapon2 && W == null)
									W = usr.Weapon2
									if(W.Type == "Hammer")
										CanDo = 1
									else
										W = null
								if(CanDo && W)
									if(usr.Job == null)
										if(W.Dura <= 1)
											usr << "<font color = red>The [W] is Broken, you can not do this job!<br>"
											return
										view(usr) << "<font color=yellow>[usr] begins to hammer the brick into stone shards!<br>"
										W.Dura -= rand(0.5,1)
										usr.CheckWeaponDura(W)
										usr.Job = "MakeShards"
										usr.CanMove = 0
										var/Time = 150 - usr.MasonarySkill * 2
										if(Time <= 20)
											Time = 20
										spawn(Time)
											if(src && usr)
												if(src in range(1,usr))
													if(usr.Job == "MakeShards")
														usr.Job = null
														usr.MasonarySkill += usr.MasonarySkillMulti
														var/Shards = 2
														while(Shards)
															var/obj/Items/Resources/StoneShard/SS = new
															SS.loc = src.loc
															Shards -= 1
														usr.MovementCheck()
														del(src)
												else
													usr << "<font color = red>The brick was moved, job failed!<br>"
													usr.MovementCheck()
											else
												if(usr)
													usr << "<font color = red>The brick was moved, job failed!<br>"
													usr.MovementCheck()
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
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
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
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
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
			Scrap
				icon = 'materials.dmi'
				icon_state = "Iron scrap"
				Weight = 10
				Type = "Ore"
				New()
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
				Click()
					if(usr.Function == "Interact")
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
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
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
			Ingot
				icon = 'materials.dmi'
				icon_state = "Iron ingot"
				Weight = 10
				Type = "Ingot"
				New()
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
				Click()
					if(usr.Function == "Interact")
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
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
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
			LargeBrick
				icon = 'materials.dmi'
				icon_state = "large brick"
				Material = "Stone"
				Type = "LargeBrick"
				Weight = 40
				New()
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
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
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						if(src.suffix == null)
							if(src in range(1,usr))
								var/obj/W = null
								var/CanDo = 0
								if(usr.Weapon)
									W = usr.Weapon
									if(W.Type == "Hammer")
										CanDo = 1
									else
										W = null
								if(usr.Weapon2 && W == null)
									W = usr.Weapon2
									if(W.Type == "Hammer")
										CanDo = 1
									else
										W = null
								if(CanDo && W)
									if(usr.Job == null)
										if(W.Dura <= 1)
											usr << "<font color = red>The [W] is Broken, you can not do this job!<br>"
											return
										view(usr) << "<font color=yellow>[usr] begins to hammer the large brick into smaller bricks!<br>"
										W.Dura -= rand(0.5,1)
										usr.CheckWeaponDura(W)
										usr.Job = "MakeBricks"
										usr.CanMove = 0
										var/Time = 150 - usr.MasonarySkill * 2
										if(Time <= 20)
											Time = 20
										spawn(Time)
											if(src && usr)
												if(src in range(1,usr))
													if(usr.Job == "MakeBricks")
														usr.Job = null
														view(usr) << "<font color=yellow>[usr] finishes hammering the large brick into smaller bricks!<br>"
														usr.MasonarySkill += usr.MasonarySkillMulti
														var/Bricks = 4
														var/ExtraBrick = prob(usr.MasonarySkill)
														if(ExtraBrick)
															Bricks += rand(1,4)
														while(Bricks)
															var/obj/Items/Resources/Brick/B = new
															B.loc = src.loc
															Bricks -= 1
														usr.MovementCheck()
														del(src)
												else
													usr << "<font color = red>The large brick was moved, job failed!<br>"
													usr.MovementCheck()
											else
												if(usr)
													usr << "<font color = red>The [src] was moved, job failed!<br>"
													usr.MovementCheck()
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
			StoneShard
				icon = 'materials.dmi'
				icon_state = "stone shard"
				Weight = 3
				New()
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
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
						if(src in usr)
							usr << "<font color=green>Click another object to interact with this one!<br>"
							usr.Function = "StoneShard"
							usr.Ref = src
							return
					if(usr.Function == "StoneShard")
						if(usr.Ref != src)
							usr << "<font color=green>You scratch the two Stone Shards together and create sparks!<br>"
							for(var/obj/Items/Misc/StoneForge/S in range(1,usr))
								if(S.Type != "Lit")
									var/Burn = 0
									for(var/obj/Items/Resources/Coal/C in S)
										Burn += 2000
									for(var/obj/Items/Resources/Charcoal/Ch in S)
										Burn += 500
									if(Burn >= 1)
										for(var/obj/Items/Resources/Coal/C in S)
											del(C)
										for(var/obj/Items/Resources/Charcoal/Ch in S)
											del(Ch)
										S.ForgeBurn(Burn)
										S.icon_state = "forge lit"
										S.Type = "Lit"
										S.desc = "This Stone Forge seems to be burning away nicely<br>"
										view(usr) << "<font color = yellow>[usr] lights the [S] using two [src]!<br>"
										return
							for(var/obj/Items/Resources/CampSite/C in range(1,usr))
								var/Succeed = prob(15)
								if(Succeed)
									if(C.icon_state != "campfire")
										if(C.Fuel)
											view(C) << "<font color=yellow>[C] sets on fire!<br>"
											C.icon_state = "campfire"
											C.OnFire = 1
											C.luminosity = 5
											C.CreateSmoke()
											C.Burn(0)
											usr.Ref = null
											usr.Function = null
											for(var/obj/Items/Foods/F in range(1,C))
												if(F.CookingFood == 1 && C.OnFire)
													F.Cook(F.loc,C,usr,0,0)
													view(6,F) << "<font color = yellow>The near by [F] begins to cook!<br>"
											for(var/turf/T in range(1,src))
												if(T.Material == "Wood")
													for(var/mob/M in Players)
														if(M.Admin)
															M << "<font color = teal><b>([usr.key])[usr] has lit a camp site on fire next to a wooden wall/floor at [usr.x],[usr.y],[usr.z]!<br>"
															usr.Log_player("<font color = red><b>([usr.key])[usr] lights a camp site on fire near wooden floor/wall at [usr.x],[usr.y],[usr.z]</font><br>")
					if(usr.Ref)
						var/obj/I = usr.Ref
						if(I.Material == "iron")
							usr << "<font color=green>You scratch the Iron Ore and the Stone Shard together and create sparks!<br>"
							for(var/obj/Items/Resources/CampSite/C in range(1,usr))
								if(C.icon_state != "campfire")
									if(C.Fuel)
										C.icon_state = "campfire"
										C.OnFire = 1
										view(C) << "<font color=yellow>[C] sets on fire!<br>"
										C.luminosity = 5
										C.CreateSmoke()
										C.Burn(0)
										usr.Ref = null
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
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
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
			SpiderWeb
				icon = 'materials.dmi'
				icon_state = "web"
				Weight  = 1
				Click()
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
			Skin
				icon = 'skins.dmi'
				icon_state = "Human skin"
				Weight  = 1
				Material = "Leather"
				New()
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
				Click()
					if(usr.Function == "Interact")
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
			Ash
				icon = 'materials.dmi'
				icon_state = "ash"
				Weight  = 1
				New()
					spawn(2000)
						if(src)
							if(src.suffix == null)
								del(src)
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
			Branch
				icon = 'materials.dmi'
				icon_state = "branch"
				Weight = 2
				Fuel = 25
				Dura = 25
				ItemLayer = 7
				Quality = 2
				DamageType = "Blunt"
				EquipState = "branch equip"
				CarryState = "branch"
				New()
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
				Click()
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								if(usr.Weapon == null)
									if(usr.RightArm >= 25)
										src.layer = 5
										src.suffix = "Equip"
										src.overlays += image(/obj/HUD/E/)
										src.icon_state = src.EquipState
										usr.Weapon = src
										usr.overlays+=image(src.icon,src.icon_state,src.ItemLayer)
										src.layer = 20
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
										return
									else
										usr << "<font color =red>You cant do that with a damaged arm!<br>"
										return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.Weapon == src)
									src.layer = 5
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
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						if(src in usr)
							usr << "<font color=green>Click another object to interact with this one!<br>"
							usr.Ref = src
							return
						if(src.suffix == null)
							if(src in range(1,usr))
								var/Num = 0
								var/Branches = list()
								for(var/obj/Items/Resources/Branch/B in range(1,usr))
									if(B.suffix == null)
										if(Num <= 3)
											Num += 1
											Branches += B
								if(Num >= 3)
									if(usr.Job == null)
										view(usr) << "<font color=yellow>[usr] begins to place some branches together!<br>"
										usr.Job = "MakeCampFire"
										usr.CanMove = 0
										var/Time = 150 - usr.CarpentrySkill * 2
										if(Time <= 20)
											Time = 20
										spawn(Time)
											if(usr && src)
												if(src in range(1,usr))
													if(src.suffix == null && usr.Job == "MakeCampFire")
														usr.Job = null
														usr.CarpentrySkill += usr.CarpentrySkillMulti
														var/obj/Items/Resources/CampSite/S = new
														S.loc = src.loc
														usr.MovementCheck()
														for(var/obj/I in Branches)
															del(I)
														for(var/turf/T in range(1,S))
															if(T.Material == "Wood")
																for(var/mob/M in Players)
																	if(M.Admin)
																		M << "<font color = teal><b>([usr.key])[usr] has created a camp site next to a wooden wall/floor at [usr.x],[usr.y],[usr.z]!<br>"
																		usr.Log_player("<font color = red><b>([usr.key])[usr] creates a camp site near wooden floor/wall at [usr.x],[usr.y],[usr.z]</font><br>")
												else
													usr << "<font color = red>The branches were moved, job failed!<br>"
													usr.MovementCheck()
											else
												if(usr)
													usr << "<font color = red>The [src] was moved, job failed!<br>"
													usr.MovementCheck()
								else
									usr << "<font color=green>You need three branches in order to create a camp fire!<br>"
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
			Stone
				icon = 'materials.dmi'
				icon_state = "stone"
				layer = 2
				Weight = 40
				New()
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
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
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						if(src.suffix == null)
							if(src in range(1,usr))
								var/obj/W = null
								var/CanDo = 0
								if(usr.Weapon)
									W = usr.Weapon
									if(W.Type == "Hammer")
										CanDo = 1
									else
										W = null
								if(usr.Weapon2 && W == null)
									W = usr.Weapon2
									if(W.Type == "Hammer")
										CanDo = 1
									else
										W = null
								if(CanDo && W)
									if(usr.Job == null)
										if(W.Dura <= 1)
											usr << "<font color = red>The [W] is Broken, you can not do this job!<br>"
											return
										view(usr) << "<font color=yellow>[usr] begins to hammer the stone into a large brick!<br>"
										W.Dura -= rand(0.5,1)
										usr.CheckWeaponDura(W)
										usr.Job = "MakeBrick"
										usr.CanMove = 0
										var/Time = 150 - usr.MasonarySkill * 2
										if(Time <= 20)
											Time = 20
										spawn(Time)
											if(usr && src)
												if(src in range(1,usr))
													if(usr.Job == "MakeBrick")
														usr.Job = null
														view(usr) << "<font color=yellow>[usr] finishes hammering the stone into a large brick!<br>"
														usr.MasonarySkill += usr.MasonarySkillMulti
														var/Bricks = 1
														var/ExtraBrick = prob(usr.MasonarySkill)
														if(ExtraBrick)
															Bricks += 1
														while(Bricks)
															var/obj/Items/Resources/LargeBrick/B = new
															B.loc = src.loc
															Bricks -= 1
														usr.MovementCheck()
														del(src)
												else
													usr << "<font color = red>The stone was moved, job failed!<br>"
													usr.MovementCheck()
											else
												if(usr)
													usr << "<font color = red>The [src] was moved, job failed!<br>"
													usr.MovementCheck()
					if(usr.Function == "PickUp")
						if(src.suffix == "Carried" && src in usr)
							src.overlays = null
							src.loc = usr.loc
							src.suffix = null
							src.layer = 4
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
			Block
				icon = 'materials.dmi'
				icon_state = "block"
				Type = "Block"
				Material = "Wood"
				Weight = 4
				Fuel = 50
				New()
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
				Click()
					if(usr.Function == "Interact")
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
			Plank
				icon = 'materials.dmi'
				icon_state = "plank"
				Weight = 5
				Fuel = 100
				Type = "Plank"
				Material = "Wood"
				New()
					src.pixel_x = rand(-16,16)
					src.pixel_y = rand(-16,16)
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
						usr << "<font color=green>Click another object to interact with this one!<br>"
						usr.Ref = src
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
			CampSite
				icon = 'misc.dmi'
				icon_state = "campsite"
				Fuel = 150
				Click()
					if(src in range(1,usr))
						if(usr.Function == "Interact")
							if(src.icon_state == "campfire")
								if(usr.Fainted)
									usr << "<font color =red>You have fainted and cant do that!<br>"
									return
								if(usr.Stunned)
									usr << "<font color =red>You are stunned and cant do that!<br>"
									return
								if(usr.Ref)
									var/obj/O = usr.Ref
									if(O.Fuel)
										view(usr) << "<font color = yellow>[usr] throws a [O] into the [src]!<br>"
										usr.Weight -= O.Weight
										src.Fuel += O.Fuel / 4
										del(O)
										if(usr.InvenUp)
											usr.DeleteInventoryMenu()
											usr.InvenUp = 0
										return
							if(src.icon_state == "campsite")
								if(usr.Fainted)
									usr << "<font color =red>You have fainted and cant do that!<br>"
									return
								if(usr.Stunned)
									usr << "<font color =red>You are stunned and cant do that!<br>"
									return
								if(usr.Weapon)
									var/obj/I = usr.Weapon
									if(I.Type == "Torch Lit")
										view(usr) << "<font color = yellow>[usr] places the Lit Torch into the Camp Site!<br>"
										src.icon_state = "campfire"
										src.OnFire = 1
										src.luminosity = 5
										src.CreateSmoke()
										src.Burn(0)
										for(var/obj/Items/Foods/F in range(1,src))
											if(F.CookingFood == 1 && src.OnFire)
												F.Cook(F.loc,src,usr,0,0)
												view(6,F) << "<font color = yellow>The near by [F] begins to cook!<br>"
										for(var/turf/T in range(1,src))
											if(T.Material == "Wood")
												for(var/mob/M in Players)
													if(M.Admin)
														M << "<font color = teal><b>([usr.key])[usr] has lit a camp site on fire next to a wooden wall/floor at [usr.x],[usr.y],[usr.z]!<br>"
														usr.Log_player("<font color = red><b>([usr.key])[usr] lights a camp site on fire near wooden floor/wall at [usr.x],[usr.y],[usr.z]</font><br>")
										return
								if(usr.Weapon2)
									var/obj/I = usr.Weapon2
									if(I.Type == "Torch Lit")
										view(usr) << "<font color = yellow>[usr] places the Lit Torch into the Camp Site!<br>"
										src.icon_state = "campfire"
										src.OnFire = 1
										src.luminosity = 5
										src.CreateSmoke()
										src.Burn(0)
										for(var/obj/Items/Foods/F in range(1,src))
											if(F.CookingFood == 1 && src.OnFire)
												F.Cook(F.loc,src,usr,0,0)
												view(6,F) << "<font color = yellow>The near by [F] begins to cook!<br>"
										for(var/turf/T in range(1,src))
											if(T.Material == "Wood")
												for(var/mob/M in Players)
													if(M.Admin)
														M << "<font color = teal><b>([usr.key])[usr] has lit a camp site on fire next to a wooden wall/floor at [usr.x],[usr.y],[usr.z]!<br>"
														usr.Log_player("<font color = red><b>([usr.key])[usr] lights a camp site on fire near wooden floor/wall at [usr.x],[usr.y],[usr.z]</font><br>")
										return
							if(src.icon_state == "campfire")
								if(usr.Fainted)
									usr << "<font color =red>You have fainted and cant do that!<br>"
									return
								if(usr.Stunned)
									usr << "<font color =red>You are stunned and cant do that!<br>"
									return
								if(usr.Weapon)
									var/obj/I = usr.Weapon
									if(I.Type == "Torch")
										view(usr) << "<font color = yellow>[usr] places the Torch into the fire!<br>"
										usr.overlays-=image(I.icon,I.icon_state,I.ItemLayer)
										I.CarryState = "torch lit"
										I.EquipState = "torch lit equip"
										I.icon_state = I.EquipState
										I.Type = "Torch Lit"
										I.LightProc(usr)
										usr.overlays+=image(I.icon,I.icon_state,I.ItemLayer)
										return
								if(usr.Weapon2)
									var/obj/I = usr.Weapon2
									if(I.Type == "Torch")
										view(usr) << "<font color = yellow>[usr] places the Torch into the fire!<br>"
										usr.overlays-=image(I.icon,"[I.icon_state] left",I.ItemLayer)
										I.CarryState = "torch lit"
										I.EquipState = "torch lit equip"
										I.icon_state = I.EquipState
										I.Type = "Torch Lit"
										I.LightProc(usr)
										usr.overlays+=image(I.icon,"[I.icon_state] left",I.ItemLayer)
										return

			Log
				icon = 'materials.dmi'
				icon_state = "log"
				Fuel = 100
				Click()
					if(usr.Function == "Interact")
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						if(src.suffix == null)
							if(src in range(1,usr))
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
										view(usr) << "<font color=yellow>[usr] begins to hack the log into blocks!<br>"
										W.Dura -= rand(0.5,1)
										usr.CheckWeaponDura(W)
										usr.Job = "MakeBlocks"
										usr.CanMove = 0
										var/Time = 150 - usr.WoodCuttingSkill * 2
										if(Time <= 20)
											Time = 20
										spawn(Time)
											if(src && usr)
												if(src in range(1,usr))
													if(usr.Job == "MakeBlocks")
														usr.Job = null
														usr.WoodCuttingSkill += usr.WoodCuttingSkillMulti
														usr.GainStats(3)
														var/Blocks = 3
														var/ExtraBlock = prob(usr.WoodCuttingSkill)
														if(ExtraBlock)
															Blocks += rand(1,3)
														while(Blocks)
															var/obj/Items/Resources/Block/B = new
															B.loc = src.loc
															Blocks -= 1
														usr.MovementCheck()
														del(src)
												else
													usr << "<font color = red>The log was moved, job failed!<br>"
													usr.MovementCheck()
											else
												if(usr)
													usr << "<font color = red>The [src] was moved, job failed!<br>"
													usr.MovementCheck()
								CanDo = 0
								if(usr.Weapon)
									W = usr.Weapon
									if(W.Type == "Saw")
										CanDo = 1
									else
										W = null
								if(usr.Weapon2 && W == null)
									W = usr.Weapon2
									if(W.Type == "Saw")
										CanDo = 1
									else
										W = null
								if(CanDo && W)
									if(usr.Job == null)
										if(W.Dura <= 1)
											usr << "<font color = red>The [W] is Broken, you can not do this job!<br>"
											return
										view(usr) << "<font color=yellow>[usr] begins to saw the log into planks!<br>"
										W.Dura -= rand(0.5,1)
										usr.CheckWeaponDura(W)
										usr.Job = "MakePlanks"
										usr.CanMove = 0
										var/Time = 300 - usr.WoodCuttingSkill * 2
										if(Time <= 50)
											Time = 50
										spawn(Time)
											if(usr && src)
												if(src in range(1,usr))
													if(usr.Job == "MakePlanks")
														usr.Job = null
														usr.WoodCuttingSkill += usr.WoodCuttingSkillMulti
														usr.GainStats(3)
														var/Planks = 3
														var/ExtraPlank = prob(usr.WoodCuttingSkill)
														if(ExtraPlank)
															Planks += rand(1,3)
														while(Planks)
															var/obj/Items/Resources/Plank/P = new
															P.loc = src.loc
															Planks -= 1
														usr.MovementCheck()
														del(src)
												else
													usr << "<font color = red>The [src] was moved, job failed!<br>"
													usr.MovementCheck()
											else
												if(usr)
													usr << "<font color = red>The [src] was moved, job failed!<br>"
													usr.MovementCheck()
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
			FelledTree
				icon = 'plants.dmi'
				icon_state = "felled tree"
				Fuel = 100
				name = "Fallen Tree"
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
					if(usr.Function == "Interact")
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						if(src in range(1,usr))
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
									view(usr) << "<font color=yellow>[usr] begins to chop the fallen tree into a log!<br>"
									W.Dura -= rand(0.5,1)
									usr.CheckWeaponDura(W)
									usr.Job = "MakeLogs"
									usr.CanMove = 0
									var/Time = 150 - usr.WoodCuttingSkill * 2
									if(Time <= 20)
										Time = 20
									spawn(Time)
										if(src && usr)
											if(src in range(1,usr))
												if(usr.Job == "MakeLogs")
													usr.Job = null
													usr.WoodCuttingSkill += usr.WoodCuttingSkillMulti
													var/Logs = 1
													var/ExtraLog = prob(usr.WoodCuttingSkill)
													if(ExtraLog)
														Logs += 1
													while(Logs)
														var/obj/Items/Resources/Log/L = new
														L.loc = src.loc
														Logs -= 1
													var/obj/Items/Resources/Branch/B = new
													B.loc = src.loc
													var/obj/Items/Resources/Branch/B2 = new
													B2.loc = src.loc
													var/obj/Items/Resources/Branch/B3 = new
													B3.loc = src.loc
													usr.MovementCheck()
													del(src)
											else
												usr << "<font color = red>The fallen tree was moved, job failed!<br>"
												usr.MovementCheck()
										else
											if(usr)
												usr << "<font color = red>The fallen tree was moved, job failed!<br>"
												usr.MovementCheck()

				New()
					src.overlays += /obj/Items/Resources/FelledTreePart2
			FelledTreePart2
				icon = 'plants.dmi'
				icon_state = "felled tree 2"
				pixel_x = 32
				Fuel = 100
				name = "Fallen Tree"
			FelledTree2
				icon = 'plants.dmi'
				icon_state = "felled tree2"
				name = "Fallen Tree"
				Click()
					if(usr.Function == "Interact")
						if(usr.Fainted)
							usr << "<font color =red>You have fainted and cant do that!<br>"
							return
						if(usr.Stunned)
							usr << "<font color =red>You are stunned and cant do that!<br>"
							return
						if(src in range(1,usr))
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
									view(usr) << "<font color=yellow>[usr] begins to chop the fallen tree into branches!<br>"
									W.Dura -= rand(0.5,1)
									usr.CheckWeaponDura(W)
									usr.Job = "MakeLogs"
									usr.CanMove = 0
									var/Time = 150 - usr.WoodCuttingSkill * 2
									if(Time <= 20)
										Time = 20
									spawn(Time)
										if(src && usr)
											if(src in range(1,usr))
												if(usr.Job == "MakeLogs")
													usr.Job = null
													usr.WoodCuttingSkill += usr.WoodCuttingSkillMulti
													var/obj/Items/Resources/Branch/B = new
													B.loc = src.loc
													var/obj/Items/Resources/Branch/B2 = new
													B2.loc = src.loc
													var/obj/Items/Resources/Branch/B3 = new
													B3.loc = src.loc
													var/obj/Items/Resources/Branch/B4 = new
													B4.loc = src.loc
													var/obj/Items/Resources/Branch/B5 = new
													B5.loc = src.loc
													var/obj/Items/Resources/Branch/B6 = new
													B6.loc = src.loc
													usr.MovementCheck()
													del(src)
											else
												usr << "<font color = red>The fallen tree was moved, job failed!<br>"
												usr.MovementCheck()
										else
											if(usr)
												usr << "<font color = red>The fallen tree was moved, job failed!<br>"
												usr.MovementCheck()
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
				New()
					src.overlays += /obj/Items/Resources/FelledTreePart2_2
			FelledTreePart2_2
				icon = 'plants.dmi'
				icon_state = "felled tree2 2"
				pixel_x = 32
