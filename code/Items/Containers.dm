obj
	proc
		TreasureChest()
			if(src.Type == "HasTreasure")
				var/obj/Items/Currency/GoldCoin/G = new
				G.loc = src
				G.suffix = "Carried"
				G.Type = rand(1,20)
				G.name = "[G.Type] Gold Coins"
				G.CoinAdjust()
				G.overlays+=image(/obj/HUD/C/)
				var/Items = rand(0,3)
				while(Items)
					Items -= 1
					var/ItemType = rand(1,2)
					if(ItemType == 1)
						ItemType = 0
						ItemType = rand(1,10)
						if(ItemType == 1)
							var/Chest = list()
							Chest += typesof(/obj/Items/Armour/Chest/)
							for(var/O in Chest)
								var/obj/I = new O()
								if(I.CanBeCrafted)
									var/Metal = 0
									if(I.BaseMaterial == "Metal")
										Metal = 1
									if(Metal)
										var/Choose = prob(50)
										if(Choose)
											var/Make = rand(1,3)
											var/Mat = null
											if(Make == 1)
												Mat = "Iron"
											if(Make == 2)
												Mat = "Copper"
											if(Make == 3)
												Mat = "Gold"
											var/obj/A = new I.type()
											A.suffix = "Carried"
											A.layer = 100
											A.Material = Mat
											A.RandomItemQuality()
											A.name = "[A.Material] [A]"
											A.icon_state = A.CarryState
											A.overlays += image(/obj/HUD/C/)
											A.loc = src
											break
										else
											del(I)
									else
										del(I)
						if(ItemType == 2)
							var/LeftArm = list()
							LeftArm += typesof(/obj/Items/Armour/LeftArm/)
							for(var/O in LeftArm)
								var/obj/I = new O()
								if(I.CanBeCrafted)
									var/Metal = 0
									if(I.BaseMaterial == "Metal")
										Metal = 1
									if(Metal)
										var/Choose = prob(50)
										if(Choose)
											var/Make = rand(1,3)
											var/Mat = null
											if(Make == 1)
												Mat = "Iron"
											if(Make == 2)
												Mat = "Copper"
											if(Make == 3)
												Mat = "Gold"
											var/obj/A = new I.type()
											A.suffix = "Carried"
											A.layer = 100
											A.Material = Mat
											A.RandomItemQuality()
											A.name = "[A.Material] [A]"
											A.icon_state = A.CarryState
											A.overlays += image(/obj/HUD/C/)
											A.loc = src
											break
										else
											del(I)
									else
										del(I)
						if(ItemType == 3)
							var/RightArm = list()
							RightArm += typesof(/obj/Items/Armour/RightArm/)
							for(var/O in RightArm)
								var/obj/I = new O()
								if(I.CanBeCrafted)
									var/Metal = 0
									if(I.BaseMaterial == "Metal")
										Metal = 1
									if(Metal)
										var/Choose = prob(50)
										if(Choose)
											var/Make = rand(1,3)
											var/Mat = null
											if(Make == 1)
												Mat = "Iron"
											if(Make == 2)
												Mat = "Copper"
											if(Make == 3)
												Mat = "Gold"
											var/obj/A = new I.type()
											A.suffix = "Carried"
											A.layer = 100
											A.Material = Mat
											A.RandomItemQuality()
											A.name = "[A.Material] [A]"
											A.icon_state = A.CarryState
											A.overlays += image(/obj/HUD/C/)
											A.loc = src
											break
										else
											del(I)
									else
										del(I)
						if(ItemType == 4)
							var/LeftFoot = list()
							LeftFoot += typesof(/obj/Items/Armour/LeftFoot/)
							for(var/O in LeftFoot)
								var/obj/I = new O()
								if(I.CanBeCrafted)
									var/Metal = 0
									if(I.BaseMaterial == "Metal")
										Metal = 1
									if(Metal)
										var/Choose = prob(50)
										if(Choose)
											var/Make = rand(1,3)
											var/Mat = null
											if(Make == 1)
												Mat = "Iron"
											if(Make == 2)
												Mat = "Copper"
											if(Make == 3)
												Mat = "Gold"
											var/obj/A = new I.type()
											A.suffix = "Carried"
											A.layer = 100
											A.Material = Mat
											A.RandomItemQuality()
											A.name = "[A.Material] [A]"
											A.icon_state = A.CarryState
											A.overlays += image(/obj/HUD/C/)
											A.loc = src
											break
										else
											del(I)
									else
										del(I)
						if(ItemType == 5)
							var/RightFoot = list()
							RightFoot += typesof(/obj/Items/Armour/RightFoot/)
							for(var/O in RightFoot)
								var/obj/I = new O()
								if(I.CanBeCrafted)
									var/Metal = 0
									if(I.BaseMaterial == "Metal")
										Metal = 1
									if(Metal)
										var/Choose = prob(50)
										if(Choose)
											var/Make = rand(1,3)
											var/Mat = null
											if(Make == 1)
												Mat = "Iron"
											if(Make == 2)
												Mat = "Copper"
											if(Make == 3)
												Mat = "Gold"
											var/obj/A = new I.type()
											A.suffix = "Carried"
											A.layer = 100
											A.Material = Mat
											A.RandomItemQuality()
											A.name = "[A.Material] [A]"
											A.icon_state = A.CarryState
											A.overlays += image(/obj/HUD/C/)
											A.loc = src
											break
										else
											del(I)
									else
										del(I)
						if(ItemType == 6)
							var/Legs = list()
							Legs += typesof(/obj/Items/Armour/Legs/)
							for(var/O in Legs)
								var/obj/I = new O()
								if(I.CanBeCrafted)
									var/Metal = 0
									if(I.BaseMaterial == "Metal")
										Metal = 1
									if(Metal)
										var/Choose = prob(50)
										if(Choose)
											var/Make = rand(1,3)
											var/Mat = null
											if(Make == 1)
												Mat = "Iron"
											if(Make == 2)
												Mat = "Copper"
											if(Make == 3)
												Mat = "Gold"
											var/obj/A = new I.type()
											A.suffix = "Carried"
											A.layer = 100
											A.Material = Mat
											A.RandomItemQuality()
											A.name = "[A.Material] [A]"
											A.icon_state = A.CarryState
											A.overlays += image(/obj/HUD/C/)
											A.loc = src
											break
										else
											del(I)
									else
										del(I)
						if(ItemType == 7)
							var/Shields = list()
							Shields += typesof(/obj/Items/Armour/Shields/)
							for(var/O in Shields)
								var/obj/I = new O()
								if(I.CanBeCrafted)
									var/Metal = 0
									if(I.BaseMaterial == "Metal")
										Metal = 1
									if(Metal)
										var/Choose = prob(100)
										if(Choose)
											var/Make = rand(1,2)
											var/Mat = null
											if(Make == 1)
												Mat = "Iron"
											if(Make == 2)
												Mat = "Copper"
											var/obj/A = new I.type()
											A.suffix = "Carried"
											A.layer = 100
											A.Material = Mat
											A.RandomItemQuality()
											A.name = "[A.Material] [A]"
											A.icon_state = A.CarryState
											A.overlays += image(/obj/HUD/C/)
											A.loc = src
											break
										else
											del(I)
									else
										del(I)
					if(ItemType == 2)
						ItemType = 0
						ItemType = rand(1,5)
						if(ItemType == 1)
							var/Swords = list()
							Swords += typesof(/obj/Items/Weapons/Swords/)
							for(var/O in Swords)
								var/obj/I = new O()
								if(I.CanBeCrafted)
									var/Choose = prob(25)
									if(Choose)
										var/Make = rand(1,3)
										var/Mat = null
										if(Make == 1)
											Mat = "Iron"
										if(Make == 2)
											Mat = "Copper"
										if(Make == 3)
											Mat = "Silver"
										var/obj/A = new I.type()
										A.suffix = "Carried"
										A.layer = 100
										A.Material = Mat
										A.RandomItemQuality()
										A.name = "[A.Material] [A]"
										A.icon_state = A.CarryState
										A.overlays += image(/obj/HUD/C/)
										A.loc = src
										break
									else
										del(I)
						if(ItemType == 2)
							var/Axes = list()
							Axes += typesof(/obj/Items/Weapons/Axes/)
							for(var/O in Axes)
								var/obj/I = new O()
								if(I.CanBeCrafted)
									var/Choose = prob(50)
									if(Choose)
										var/Make = rand(1,3)
										var/Mat = null
										if(Make == 1)
											Mat = "Iron"
										if(Make == 2)
											Mat = "Copper"
										if(Make == 3)
											Mat = "Silver"
										var/obj/A = new I.type()
										A.suffix = "Carried"
										A.layer = 100
										A.Material = Mat
										A.RandomItemQuality()
										A.name = "[A.Material] [A]"
										A.icon_state = A.CarryState
										A.overlays += image(/obj/HUD/C/)
										A.loc = src
										break
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
										var/Make = rand(1,3)
										var/Mat = null
										if(Make == 1)
											Mat = "Iron"
										if(Make == 2)
											Mat = "Copper"
										if(Make == 3)
											Mat = "Silver"
										var/obj/A = new I.type()
										A.suffix = "Carried"
										A.layer = 100
										A.Material = Mat
										A.RandomItemQuality()
										A.name = "[A.Material] [A]"
										A.icon_state = A.CarryState
										A.overlays += image(/obj/HUD/C/)
										A.loc = src
										break
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
										var/Make = rand(1,3)
										var/Mat = null
										if(Make == 1)
											Mat = "Iron"
										if(Make == 2)
											Mat = "Copper"
										if(Make == 3)
											Mat = "Silver"
										var/obj/A = new I.type()
										A.suffix = "Carried"
										A.layer = 100
										A.Material = Mat
										A.RandomItemQuality()
										A.name = "[A.Material] [A]"
										A.icon_state = A.CarryState
										A.overlays += image(/obj/HUD/C/)
										A.loc = src
										break
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
										var/Make = rand(1,3)
										var/Mat = null
										if(Make == 1)
											Mat = "Iron"
										if(Make == 2)
											Mat = "Copper"
										if(Make == 3)
											Mat = "Silver"
										var/obj/A = new I.type()
										A.suffix = "Carried"
										A.layer = 100
										A.Material = Mat
										A.RandomItemQuality()
										A.name = "[A.Material] [A]"
										A.icon_state = A.CarryState
										A.overlays += image(/obj/HUD/C/)
										A.loc = src
										break
									else
										del(I)

	Items
		Containers
			Dura = 100
			Barrel
				icon = 'containers.dmi'
				icon_state = "barrel closed"
				Weight = 10
				WeightMax = 150
				Fuel = 50
				OpenState = "barrel"
				ClosedState = "barrel closed"
				desc = "This is a barrel, it can be used to store items in."
				Material = "Wood"
				CanBeCrafted = 1
				density = 1
				Click()
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
								usr.Job = "CreateBarrel"
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
											if(PlankNum == 4 && O && usr.Job == "CreateBarrel")
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
							if(src.suffix == null)
								if(src.Locked == 0 && usr.Job == null)
									if(src.OpenState)
										src.icon_state = src.OpenState
									if(usr.InvenUp)
										usr.CreateInventory()
									usr.CreateContainerContents(src)
									usr.Container = src
									usr << "<b>You open [src]!<br>"
									return
								else
									usr << "<b>[src] is locked, you need to find a key or smash it open!<br>"
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
			SandStoneCoffin
				icon = 'misc.dmi'
				icon_state = "sand coffin"
				Weight = 20
				suffix = "Stuck"
				WeightMax = 100
				density = 1
				desc = "This is a stone coffin, it can be used to store items in or dead bodies."
				Material = "SandStone"
				New()
					spawn(1)
						src.TreasureChest()
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
						if(src in range(1,usr))
							if(src.Locked == 0)
								if(src.OpenState)
									src.icon_state = src.OpenState
								if(usr.InvenUp)
									usr.CreateInventory()
								usr.CreateContainerContents(src)
								usr.Container = src
								usr << "<b>You open [src]!<br>"
								return
							else
								usr << "<b>[src] is locked, you need to find a key or smash it open!<br>"
								return
			StoneCoffin
				icon = 'misc.dmi'
				icon_state = "stone coffin"
				Weight = 20
				WeightMax = 100
				OpenState = "stone coffin open"
				density = 1
				suffix = "Stuck"
				ClosedState = "stone coffin"
				desc = "This is a stone coffin, it can be used to store items in or dead bodies."
				Type = "Coffin"
				Material = "Stone"
				CanBeCrafted = 1
				New()
					spawn(1)
						src.TreasureChest()
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
							if(BrickNum == 3 && O.Type == "LargeBrick")
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
												if(BrickNum != 3)
													BrickNum += 1
													Bricks += B
											if(BrickNum == 3 && O && usr.Job == "CreateStoneCoffin")
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
							if(src.Locked == 0)
								if(src.OpenState)
									src.icon_state = src.OpenState
								if(usr.InvenUp)
									usr.CreateInventory()
								usr.CreateContainerContents(src)
								usr.Container = src
								usr << "<b>You open [src]!<br>"
								return
							else
								usr << "<b>[src] is locked, you need to find a key or smash it open!<br>"
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
			Cart
				icon = 'tools.dmi'
				icon_state = "Iron cart"
				Weight = 20
				WeightMax = 400
				Fuel = 0
				OpenState = "Iron cart"
				ClosedState = "Iron cart"
				desc = "This is a iron cart, it can be used to store items in."
				Material = "Iron"
				CanBeCrafted = 1
				New()
					spawn(1)
						src.TreasureChest()
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
													if(IngotNum == 5)
														break
										if(IngotNum == 5 && usr.Job == "Forge")
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
													W.icon = src.icon
													W.Material = O.Material
													W.name = "[W.Material] [W.name]"
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
					if(usr.Function == "Interact")
						if(src in range(1,usr))
							if(src.suffix == null)
								if(src.Locked == 0)
									if(src.OpenState)
										src.icon_state = src.OpenState
									if(usr.InvenUp)
										usr.CreateInventory()
									usr.CreateContainerContents(src)
									usr.Container = src
									usr << "<b>You open [src]!<br>"
									return
								else
									usr << "<b>[src] is locked, you need to find a key or smash it open!<br>"
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
			IronChest
				icon = 'containers.dmi'
				icon_state = "Iron chest"
				Weight = 10
				WeightMax = 200
				Fuel = 0
				OpenState = "Iron chest open"
				ClosedState = "Iron chest"
				desc = "This is a iron chest, it can be used to store items in."
				Material = "Iron"
				CanBeCrafted = 1
				Dura = 100
				New()
					spawn(1)
						src.TreasureChest()
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
									if(O != usr.Weapon)
										usr << "<font color = red>Equip the Hammer first!<br>"
										return
									var/list/menu = new()
									menu += "Repair Chest"
									if(src.KeyCode)
										menu += "Repair Lock"
									menu += "Cancel"
									var/Result = input(usr,"Choose an Area of the chest to repair.", "Choose", null) in menu
									if (Result == "Cancel")
										return
									if(Result == "Repair Chest")
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
											usr << "<font color = red>You will need one Iron Ingot to Repair this chest!<br>"
											return
										if(CanRepair == 0)
											usr << "<font color = red>Cant Repair with others near!<br>"
											return
										if(src.Dura >= usr.ForgingSkill * 2 + 100)
											usr << "<font color = red>This chest is beyond your skill to repair!<br>"
											return
										var/LOC = usr.loc
										usr.Job = "Repair Chest"
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
													if(usr.Job == "Repair Chest")
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
														if(src.Dura <= usr.ForgingSkill * 2 + 101)
															src.Dura = usr.ForgingSkill * 2 + 101
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
													if(usr.Job == "Repair Lock")
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
										usr << "<font color = red>That is the wrong key for this chest!<br>"
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
										usr << "<font color = red>This chest appears to already have a Lock Fitted.<br>"
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
														if(usr.Job == "Fit Lock")
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
															O.icon_state = "[O.icon_state] fitted chest"
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
														usr.GainStats(2)
														return
													var/obj/W = new src.type(usr.loc)
													W.Material = O.Material
													W.Dura += usr.ForgingSkill * 2
													W.suffix = null
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
					if(usr.Function == "Combat" && usr.Job == null)
						if(usr in range(1,src))
							if(src.icon_state != src.OpenState)
								var/list/menu = new()
								menu += "Attack Chest"
								if(src.KeyCode)
									menu += "Attack Lock"
								menu += "Cancel"
								var/Result = input(usr,"Choose an Area of the chest to attack.", "Choose", null) in menu
								if (Result == "Cancel")
									return
								if (Result == "Attack Lock")
									for(var/obj/Items/Misc/Lock/L in src)
										view(usr) << "<font color = red>[usr] begins an attempt at breaking [src]'s [L]!<br>"
										usr.Job = "SmashLock"
										usr.CanMove = 0
										var/LOC = usr.loc
										var/Time = 150 - usr.Agility / 2
										if(Time <= 10)
											Time = 10
										spawn(Time)
											if(L && usr && src && usr.loc == LOC && usr.Job == "SmashLock" && src.icon_state != src.OpenState)
												var/DMG = usr.Strength
												if(usr.Weapon)
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
												usr.DetermineWeaponSkill()
												if(usr.CurrentSkillLevel)
													DMG = DMG + usr.CurrentSkillLevel / 4
												usr.Job = null
												usr.MovementCheck()
												var/WontDamage = 25 - DMG
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
								if (Result == "Attack Chest")
									view(usr) << "<font color = red>[usr] begins an attempt at breaking the [src]!<br>"
									usr.Job = "SmashChest"
									usr.CanMove = 0
									var/LOC = usr.loc
									var/Time = 150 - usr.Agility / 2
									if(Time <= 10)
										Time = 10
									spawn(Time)
										if(usr && src && usr.loc == LOC && usr.Job == "SmashChest" && src.icon_state != src.OpenState)
											var/DMG = usr.Strength
											if(usr.Weapon)
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
											usr.DetermineWeaponSkill()
											if(usr.CurrentSkillLevel)
												DMG = DMG + usr.CurrentSkillLevel / 4
											usr.Job = null
											usr.MovementCheck()
											var/WontDamage = 33 - DMG
											var/CantDamage = prob(WontDamage)
											if(DMG >= 0 && CantDamage != 1)
												src.Dura -= DMG
												if(src.Dura <= 0)
													usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [src] open<br>")
													range(src) << "<font color = red>[src] makes a loud metallic noise as it bends open after [usr] attacks it!<br>"
													for(var/obj/Items/I in src)
														if(I.suffix != "Fitted")
															I.loc = src.loc
															I.suffix = null
															I.overlays = null
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
					if(usr.Function == "Interact")
						if(src in range(1,usr))
							if(src.suffix == null)
								if(src.Locked == 0)
									if(src.OpenState)
										src.icon_state = src.OpenState
										src.overlays = null
										for(var/obj/Items/Misc/Lock/L in src)
											if(L.suffix == "Fitted")
												L.icon_state = "[L.Material] lock fitted chest open"
												src.overlays += L
									if(usr.InvenUp)
										usr.CreateInventory()
									usr.CreateContainerContents(src)
									usr.Container = src
									usr << "<b>You open [src]!<br>"
									return
								else
									usr << "<font color = red>[src] is locked, you need to find a key or smash it open!<br>"
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
							for(var/obj/Items/Misc/Lock/L in src)
								if(L.suffix == "Fitted")
									usr << "<font color=teal>[src] appears to have an [L] inside it.<br>"
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
			WoodenChest
				icon = 'containers.dmi'
				icon_state = "chest"
				Weight = 10
				WeightMax = 100
				Fuel = 35
				OpenState = "chest open"
				ClosedState = "chest"
				desc = "This is a wooden chest, it can be used to store items in."
				Material = "Wood"
				CanBeCrafted = 1
				Dura = 50
				New()
					spawn(1)
						src.TreasureChest()
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
									if(O != usr.Weapon)
										usr << "<font color = red>Equip the Saw first!<br>"
										return
									var/list/menu = new()
									menu += "Repair Chest"
									if(src.KeyCode)
										menu += "Repair Lock"
									menu += "Cancel"
									var/Result = input(usr,"Choose an Area of the chest to repair.", "Choose", null) in menu
									if (Result == "Cancel")
										return
									if(Result == "Repair Chest")
										var/HasPlank = 0
										for(var/obj/Items/Resources/Plank/P in usr)
											HasPlank = 1
											break
										var/CanRepair = 1
										for(var/mob/M in range(1,src))
											if(M != usr)
												CanRepair = 0
										if(HasPlank == 0)
											usr << "<font color = red>You will need one Wooden Plank to Repair this chest!<br>"
											return
										if(CanRepair == 0)
											usr << "<font color = red>Cant Repair with others near!<br>"
											return
										if(src.Dura >= usr.CarpentrySkill * 2 + 50)
											usr << "<font color = red>This chest is beyond your skill to repair!<br>"
											return
										var/LOC = usr.loc
										usr.Job = "Repair Chest"
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
													if(usr.Job == "Repair Chest")
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
														if(src.Dura <= usr.CarpentrySkill * 2 + 51)
															src.Dura = usr.CarpentrySkill * 2 + 51
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
													if(usr.Job == "Repair Lock")
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
										usr << "<font color = red>That is the wrong key for this chest!<br>"
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
										usr << "<font color = red>This chest appears to already have a Lock Fitted.<br>"
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
														if(usr.Job == "Fit Lock")
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
															O.icon_state = "[O.icon_state] fitted chest"
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
					if(usr.Function == "Combat" && usr.Job == null)
						if(usr in range(1,src))
							if(src.icon_state != src.OpenState)
								var/list/menu = new()
								menu += "Attack Chest"
								if(src.KeyCode)
									menu += "Attack Lock"
								menu += "Cancel"
								var/Result = input(usr,"Choose an Area of the chest to attack.", "Choose", null) in menu
								if (Result == "Cancel")
									return
								if (Result == "Attack Lock")
									for(var/obj/Items/Misc/Lock/L in src)
										usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [L] open<br>")
										view(usr) << "<font color = red>[usr] begins an attempt at breaking [src]'s [L]!<br>"
										usr.Job = "SmashLock"
										usr.CanMove = 0
										var/LOC = usr.loc
										var/Time = 150 - usr.Agility / 2
										if(Time <= 10)
											Time = 10
										spawn(Time)
											if(L && usr && src && usr.loc == LOC && usr.Job == "SmashLock" && src.icon_state != src.OpenState)
												var/DMG = usr.Strength
												if(usr.Weapon)
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
												usr.DetermineWeaponSkill()
												if(usr.CurrentSkillLevel)
													DMG = DMG + usr.CurrentSkillLevel / 4
												usr.Job = null
												usr.MovementCheck()
												var/WontDamage = 25 - DMG
												var/CantDamage = prob(WontDamage)
												if(DMG >= 0 && CantDamage != 1)
													L.Dura -= DMG
													if(L.Dura <= 0)
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
								if (Result == "Attack Chest")
									view(usr) << "<font color = red>[usr] begins an attempt at breaking the [src]!<br>"
									usr.Job = "SmashChest"
									usr.CanMove = 0
									var/LOC = usr.loc
									var/Time = 150 - usr.Agility / 2
									if(Time <= 10)
										Time = 10
									spawn(Time)
										if(usr && src && usr.loc == LOC && usr.Job == "SmashChest" && src.icon_state != src.OpenState)
											var/DMG = usr.Strength
											if(usr.Weapon)
												var/obj/W = usr.Weapon
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
													DMG += rand(W.Dura / 2,W.Dura)
													W.Dura -= rand(0.1,2)
													if(W.ObjectType == "Axe")
														DMG += 15
													if(W.ObjectType == "Blunt")
														DMG += 10
													if(W.TwoHander && usr.Weapon2 == null)
														DMG += W.Weight / 2
													usr.CheckWeaponDura(W)
											if(usr.Weapon2)
												var/obj/W = usr.Weapon2
												if(W.ObjectTag == "Weapon")
													DMG += W.Weight / 2
													DMG += rand(W.Dura / 2,W.Dura)
													W.Dura -= rand(0.1,2)
													if(W.ObjectType == "Axe")
														DMG += 15
													if(W.ObjectType == "Blunt")
														DMG += 10
													if(W.TwoHander && usr.Weapon == null)
														DMG += W.Weight / 2
													usr.CheckWeaponDura(W)
											usr.DetermineWeaponSkill()
											if(usr.CurrentSkillLevel)
												DMG = DMG + usr.CurrentSkillLevel / 4
											usr.Job = null
											usr.MovementCheck()
											var/WontDamage = 25 - DMG
											var/CantDamage = prob(WontDamage)
											if(DMG >= 0 && CantDamage != 1)
												src.Dura -= DMG
												if(src.Dura <= 0)
													usr.Log_player("<font color = red><b>([usr.key])[usr]-[usr.x],[usr.y],[usr.z]-smashes a [src] open<br>")
													range(src) << "<font color = red>[src] makes a loud creaking noise as it splinters into pieces after [usr] attacks it!<br>"
													for(var/obj/Items/I in src)
														if(I.suffix != "Fitted")
															I.loc = src.loc
															I.suffix = null
															I.overlays = null
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
								usr.Job = "CreateChest"
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
											if(PlankNum == 4 && O && usr.Job == "CreateChest")
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
							if(src.suffix == null)
								if(src.Locked == 0)
									if(src.OpenState)
										src.icon_state = src.OpenState
										src.overlays = null
										for(var/obj/Items/Misc/Lock/L in src)
											if(L.suffix == "Fitted")
												L.icon_state = "[L.Material] lock fitted chest open"
												src.overlays += L
									if(usr.InvenUp)
										usr.CreateInventory()
									usr.CreateContainerContents(src)
									usr.Container = src
									usr << "<b>You open [src]!<br>"
									return
								else
									usr << "<font color = red>[src] is locked, you need to find a key or smash it open!<br>"
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
							for(var/obj/Items/Misc/Lock/L in src)
								if(L.suffix == "Fitted")
									usr << "<font color=teal>[src] appears to have an [L] inside it.<br>"
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
			ChestofDrawers
				icon = 'furniture.dmi'
				icon_state = "chest of drawers"
				Weight = 15
				WeightMax = 150
				Fuel = 50
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
								usr.Job = "CreateDrawers"
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
											if(PlankNum == 4 && O && usr.Job == "CreateDrawers")
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
							if(src.suffix == null)
								if(src.Locked == 0)
									if(src.OpenState)
										src.icon_state = src.OpenState
									if(usr.InvenUp)
										usr.CreateInventory()
									usr.CreateContainerContents(src)
									usr.Container = src
									usr << "<b>You open [src]!<br>"
									return
								else
									usr << "<b>[src] is locked, you need to find a key or smash it open!<br>"
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
