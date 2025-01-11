obj
	proc
		DemonicSwordMagic()
			var/mob/L = null
			if(ismob(src.loc))
				L = src.loc
			if(src.suffix == "Equip")
				var/WillSpeak = prob(10)
				if(WillSpeak)
					var/Speaks = rand(1,10)
					if(Speaks == 1)
						Speaks = "Kill everything..."
					if(Speaks == 2)
						Speaks = "Release me..."
					if(Speaks == 3)
						Speaks = "Feed the swords hunger..."
					if(Speaks == 4)
						Speaks = "Give in to your emotions..."
					if(Speaks == 5)
						Speaks = "Allow me to enter your world through you..."
					if(Speaks == 6)
						Speaks = "I can make you powerful..."
					if(Speaks == 7)
						Speaks = "Can you feel the power?!..."
					if(Speaks == 8)
						Speaks = "Embrace the darkness..."
					if(Speaks == 9)
						Speaks = "Ha...ha...ha..."
					if(Speaks == 10)
						Speaks = "Crush...Kill...Destroy ..."
					for(var/mob/M in src)
						if(L)
							M.loc = L.loc
							M.Speak(Speaks,0)
							M.loc = src
				if(L)
					for(var/mob/M in orange(1,L))
						if(M.client)
							var/Attack = prob(25)
							if(Attack)
								view(6,L) << "<font color = yellow>[src] flares furiously as [L]'s eyes seem to glaze over. [L] attempts to strike out towards [M], having been temporarily possessed by the strange Blade.<br>"
								L.Target = M
					var/BreakOut = prob(1 - L.Strength / 100 - L.Intelligence / 100)
					if(src.Dura <= 1)
						BreakOut = 1
					if(BreakOut)
						view(6,L) << "<font color = purple>[src] begins to ignite furiously with Demonic Flame. Having used [L]'s blood energy, the Demon within the Blade breaks loose!<br>"
						for(var/mob/M in src)
							M.loc = L.loc
							M.CancelDefaultProc = 0
							M.NormalAI()
							M.Target = L
						L.Weight -= src.Weight
						L.overlays-=image(src.icon,src.icon_state,src.ItemLayer)
						L.DeleteInventoryMenu()
						if(L.InvenUp)
							L.InvenUp = 0
						del(src)
						return
			else
				var/WillSpeak = prob(10)
				if(WillSpeak)
					var/Speaks = rand(1,5)
					if(Speaks == 1)
						Speaks = "Use the sword..."
					if(Speaks == 2)
						Speaks = "Only through using the sword will you become mighty..."
					if(Speaks == 3)
						Speaks = "The sword will make you powerful..."
					if(Speaks == 4)
						Speaks = "You must use the sword, it is the only way to save your world..."
					if(Speaks == 5)
						Speaks = "Only in using the sword can you hope to save everything you love..."
					for(var/mob/M in src)
						if(L)
							M.loc = L.loc
							M.Speak(Speaks,0)
							M.loc = src
			spawn(100)
				if(src)
					src.DemonicSwordMagic()

	Items
		Weapons
			layer = 5
			ObjectTag = "Weapon"
			BaseMaterial = "Metal"
			ItemLayer = 7
			Ranged
				ObjectType = "Ranged"
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
														W.EquipState = src.EquipState
														W.CarryState = src.CarryState
														W.Material = O.Material
														W.name = "[W.Material] [W.name]"
														if(W.ObjectTag == "Weapon")
															usr.CraftWeapon(O,W)
														W.icon_state = W.CarryState
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
								if(usr.CurrentHand == "Right")
									if(usr.RightArm <= 25)
										usr << "<font color = red>Your right arm is damaged!<br>"
										return
									if(usr.Weapon2)
										var/obj/W = usr.Weapon2
										if(W.ObjectType == "Ranged")
											usr << "<font color = red>You can not equip anything else while using a two handed weapon!<br>"
											return
										if(W.Type == "Shield")
											usr << "<font color = red>You can not equip anything else while using a two handed weapon!<br>"
											return
									if(usr.Weapon == null)
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
								if(usr.CurrentHand == "Left")
									if(usr.LeftArm <= 25)
										usr << "<font color = red>Your left arm is damaged!<br>"
										return
									if(usr.Weapon)
										var/obj/W = usr.Weapon
										if(W.ObjectType == "Ranged")
											usr << "<font color = red>You can not equip anything else while using a two handed weapon!<br>"
											return
										if(W.Type == "Shield")
											usr << "<font color = red>You can not equip anything else while using a two handed weapon!<br>"
											return
									if(usr.Weapon2 == null)
										src.layer = 5
										src.suffix = "Equip"
										src.overlays += image(/obj/HUD/E/)
										src.icon_state = "[src.EquipState] left"
										usr.Weapon2 = src
										usr.overlays+=image(src.icon,"[src.icon_state]",src.ItemLayer)
										src.layer = 20
										usr.DeleteInventoryMenu()
										usr.CreateInventory()
										return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.Weapon == src && usr.CurrentHand == "Right")
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
								if(usr.Weapon2 == src && usr.CurrentHand == "Left")
									src.layer = 5
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
							for(var/obj/Items/W in usr.CreateList)
								if(W.EquipState == src.EquipState && W.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Copper","Silver")
										for(var/M in Mats)
											var/obj/W = new src.type()
											W.Material = "[M]"
											W.CarryState = "[M] [W.icon_state]"
											W.EquipState = "[M] [W.EquipState] equip"
											W.icon_state = W.CarryState
											W.layer = 100
											usr.CreateList += W
									else
										var/obj/W = new src.type()
										W.Material = src.Material
										W.icon_state = src.CarryState
										W.EquipState = src.EquipState
										W.CarryState = src.CarryState
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
							src.overlays = null
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
									src.overlays+=image(/obj/HUD/C/)
									usr.Weight += src.Weight
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
				WoodenBow
					icon = 'weapons.dmi'
					icon_state = "bow equip"
					EquipState = "bow equip"
					CarryState = "bow"
					DamageType = "Blunt"
					Weight = 4
					ItemLayer = 7
					Dura = 100
					Quality = 7
					New()
						src.icon_state = src.CarryState
						src.layer = 4
						src.RandomItemQuality()
				Bow
					icon = 'weapons.dmi'
					icon_state = "bow"
					EquipState = "bow"
					CarryState = "bow"
					DamageType = "Blunt"
					ItemLayer = 7
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			Spears
				ObjectType = "Spear"
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
														W.EquipState = src.EquipState
														W.CarryState = src.CarryState
														W.Material = O.Material
														W.name = "[W.Material] [W.name]"
														if(W.ObjectTag == "Weapon")
															usr.CraftWeapon(O,W)
														W.icon_state = W.CarryState
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
									if(usr.Weapon == null)
										if(usr.Weapon2)
											var/HasShield = 0
											if(istype(usr.Weapon2,/obj/Items/Armour/Shields/))
												HasShield = 1
											if(HasShield == 0)
												return
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
								if(usr.CurrentHand == "Left")
									if(usr.Weapon2 == null)
										if(usr.Weapon)
											var/HasShield = 0
											if(istype(usr.Weapon,/obj/Items/Armour/Shields/))
												HasShield = 1
											if(HasShield == 0)
												return
										if(usr.LeftArm >= 25)
											src.layer = 5
											src.suffix = "Equip"
											src.overlays += image(/obj/HUD/E/)
											src.icon_state = "[src.EquipState] left"
											usr.Weapon2 = src
											usr.overlays+=image(src.icon,"[src.icon_state]",src.ItemLayer)
											src.layer = 20
											usr.DeleteInventoryMenu()
											usr.CreateInventory()
											return
										else
											usr << "<font color =red>You cant do that with a damaged arm!<br>"
											return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.Weapon == src && usr.CurrentHand == "Right")
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
								if(usr.Weapon2 == src && usr.CurrentHand == "Left")
									src.layer = 5
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
							for(var/obj/Items/W in usr.CreateList)
								if(W.EquipState == src.EquipState && W.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Copper","Silver")
										for(var/M in Mats)
											var/obj/W = new src.type()
											W.Material = "[M]"
											W.CarryState = "[M] [W.icon_state]"
											W.EquipState = "[M] [W.EquipState] equip"
											W.icon_state = W.CarryState
											W.layer = 100
											usr.CreateList += W
									else
										var/obj/W = new src.type()
										W.Material = src.Material
										W.icon_state = src.CarryState
										W.EquipState = src.EquipState
										W.CarryState = src.CarryState
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
							src.overlays = null
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
									src.overlays+=image(/obj/HUD/C/)
									usr.Weight += src.Weight
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
				Trident
					icon = 'weapons.dmi'
					icon_state = "Iron trident equip"
					EquipState = "Iron trident equip"
					CarryState = "Iron trident"
					DamageType = "Slash"
					Weight = 5
					Dura = 1000
					Quality = 10
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Spear
					icon = 'weapons.dmi'
					icon_state = "spear"
					EquipState = "spear"
					CarryState = "spear"
					CanBeCrafted = 1
					TwoHander = 1
					Weight = 4
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			Blunts
				ObjectType = "Blunt"
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
														W.EquipState = src.EquipState
														W.CarryState = src.CarryState
														W.Material = O.Material
														W.name = "[W.Material] [W.name]"
														if(W.ObjectTag == "Weapon")
															usr.CraftWeapon(O,W)
														W.icon_state = W.CarryState
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
						return
					if(usr.Function == "Interact" && usr.Ref)
						if(isobj(usr.Ref))
							var/obj/O = usr.Ref
							if(O.Material == "Stone")
								if(src.suffix != "Equip")
									usr << "<font color = red>Equip the Hammer before continuing!<br>"
									return
								if(src.Dura <= 1)
									usr << "<font color = red>The Hammer is Broken, you can not do this job!<br>"
									return
								usr.MovementCheck()
								if(usr.CanMove)
									usr.CreateMasonaryMenu(O)
								return
							if(O.Type == "Ingot")
								if(src.suffix != "Equip")
									usr << "<font color = red>Equip the Hammer before continuing!<br>"
									return
								if(src.Dura <= 1)
									usr << "<font color = red>The Hammer is broken!<br>"
									return
								var/NearForge = null
								var/NearAnvil = null
								for(var/obj/Items/Misc/StoneForge/F in range(1,usr))
									if(NearForge == null)
										if(F.Type == "Lit")
											NearForge = F
											break
										else
											usr << "<font color = red>The near by Forge is not lit!<br>"
								for(var/obj/Items/Misc/Anvil/A in range(1,usr))
									NearAnvil = A
								if(NearForge && NearAnvil && usr.Job == null)
									usr.MovementCheck()
									if(usr.CanMove)
										usr.CreateForgeMenu(O)
									return
								else
									usr << "<font color = red>Need to be near both a Forge and Anvil!<br>"
							else
								if(O.Dura <= 33 && O.Material)
									if(src.suffix != "Equip")
										usr << "<font color = red>Equip the Hammer before continuing!<br>"
										return
									if(src.Dura <= 1)
										usr << "<font color = red>The Hammer is broken!<br>"
										return
									var/CanRepair = 0
									if(O.ObjectTag == "Weapon")
										CanRepair = 1
									if(O.ObjectTag == "Armour")
										CanRepair = 1
									if(CanRepair)
										var/NearForge = null
										var/NearAnvil = null
										for(var/obj/Items/Misc/StoneForge/F in range(1,usr))
											if(NearForge == null)
												if(F.Type == "Lit")
													NearForge = F
													break
												else
													usr << "<font color = red>The near by Forge is not lit!<br>"
										for(var/obj/Items/Misc/Anvil/A in range(1,usr))
											NearAnvil = A
										if(NearForge && NearAnvil && usr.Job == null)
											view(usr) << "<font color = yellow>[usr] begins to repair the [O]!<br>"
											usr.Job = "Repair"
											var/LOC = usr.loc
											var/Time = 250 - usr.ForgingSkill * 2 + usr.Strength / 2
											spawn(Time)
												if(usr)
													if(O && usr.Job == "Repair" && usr.loc == LOC)
														if(O in usr)
															var/Fail = prob(50 - usr.ForgingSkill - usr.Strength / 2 - usr.Agility / 2)
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
																		var/DMG = prob(50)
																		if(DMG)
																			DMG = "They damage it slightly"
																		view(usr) << "<font color = yellow>[usr] fails at repairing the [O]! [DMG] Quality removed.<br>"
																		if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
																			usr.ForgingSkill += usr.ForgingSkillMulti / 4
																		usr.GainStats(3)
																		if(DMG)
																			if(O.ObjectTag == "Armour" && O.Defence >= 1)
																				O.Defence -= rand(1,3)
																			if(O.ObjectTag == "Weapon" && O.Quality >= 1)
																				O.Quality -= rand(1,3)
																		return
																	O.Dura += usr.ForgingSkill * 2 + usr.Strength + 2
																	if(usr.ForgingSkill <= usr.SkillCap && usr.ForgingSkill <= WorldSkillsCap)
																		usr.ForgingSkill += usr.ForgingSkillMulti
																	usr.GainStats(3)
																	view(usr) << "<font color = yellow>[usr] finishes repairing the [O] !<br>"
																	return
																else
																	usr << "<font color = red>The Anvil was moved, or you moved away from it, repair failed!<br>"
																	usr.MovementCheck()
																	return
															else
																usr << "<font color = red>The Forge was moved, or you moved away from it, or the forge was not lit, repair failed!<br>"
																usr.MovementCheck()
																return
														else
															usr.MovementCheck()
															return
													else
														usr.MovementCheck()
														return
						return
					if(usr.Function == "Interact" && usr.Ref == null)
						if(src.Type == "Shovel")
							usr << "<font color=green>Double Click turf to dig!<br>"
						else
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
									if(usr.Weapon == null)
										if(usr.Weapon2)
											var/HasShield = 0
											if(istype(usr.Weapon2,/obj/Items/Armour/Shields/))
												HasShield = 1
											if(HasShield == 0)
												return
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
								if(usr.CurrentHand == "Left")
									if(usr.Weapon2 == null)
										if(usr.Weapon)
											var/HasShield = 0
											if(istype(usr.Weapon,/obj/Items/Armour/Shields/))
												HasShield = 1
											if(HasShield == 0)
												return
										if(usr.LeftArm >= 25)
											src.layer = 5
											src.suffix = "Equip"
											src.overlays += image(/obj/HUD/E/)
											src.icon_state = "[src.EquipState] left"
											usr.Weapon2 = src
											usr.overlays+=image(src.icon,"[src.icon_state]",src.ItemLayer)
											src.layer = 20
											usr.DeleteInventoryMenu()
											usr.CreateInventory()
											return
										else
											usr << "<font color =red>You cant do that with a damaged arm!<br>"
											return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.Weapon == src && usr.CurrentHand == "Right")
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
								if(usr.Weapon2 == src && usr.CurrentHand == "Left")
									src.layer = 5
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
							for(var/obj/Items/W in usr.CreateList)
								if(W.EquipState == src.EquipState && W.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Copper","Silver")
										for(var/M in Mats)
											var/obj/W = new src.type()
											W.Material = "[M]"
											W.CarryState = "[M] [W.icon_state]"
											W.EquipState = "[M] [W.EquipState] equip"
											W.icon_state = W.CarryState
											W.layer = 100
											usr.CreateList += W
									else
										var/obj/W = new src.type()
										W.Material = src.Material
										W.icon_state = src.CarryState
										W.EquipState = src.EquipState
										W.CarryState = src.CarryState
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
							src.overlays = null
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
				InquisitorsMaul
					icon = 'weapons.dmi'
					icon_state = "inquisitor maul2"
					EquipState = "inquisitor maul2"
					CarryState = "inquisitor maul"
					DamageType = "Blunt"
					Weight = 25
					Type = "Hammer"
					Dura = 100
					ItemLayer = 7
					Quality = 18
					TwoHander = 1
					Delete = 1
					Material = "Silver"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				InquisitorsStaff
					icon = 'weapons.dmi'
					icon_state = "inquisitor staff2"
					EquipState = "inquisitor staff2"
					CarryState = "inquisitor staff"
					DamageType = "Blunt"
					Weight = 15
					ItemLayer = 7
					Dura = 100
					Quality = 15
					Delete = 1
					TwoHander = 1
					Material = "Silver"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Hammer
					icon = 'tools.dmi'
					icon_state = "hammer"
					EquipState = "hammer"
					CarryState = "hammer"
					DamageType = "Blunt"
					Type = "Hammer"
					CanBeCrafted = 1
					Quality = 5
					Weight = 5
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Shovel
					icon = 'tools.dmi'
					icon_state = "shovel"
					EquipState = "shovel"
					CarryState = "shovel"
					DamageType = "Blunt"
					Type = "Shovel"
					CanBeCrafted = 1
					TwoHander = 1
					Weight = 4
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Mace2
					name = "Mace"
					icon = 'weapons.dmi'
					icon_state = "mace2"
					EquipState = "mace2"
					CarryState = "mace2"
					DamageType = "Blunt"
					CanBeCrafted = 1
					Weight = 6
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Mace
					icon = 'weapons.dmi'
					icon_state = "mace"
					EquipState = "mace"
					CarryState = "mace"
					DamageType = "Blunt"
					CanBeCrafted = 1
					Weight = 6
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Maul
					icon = 'weapons.dmi'
					icon_state = "maul"
					EquipState = "maul"
					CarryState = "maul"
					DamageType = "Blunt"
					CanBeCrafted = 1
					TwoHander = 1
					BaseMaterial = "Metal"
					Weight = 8
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Maul2
					name = "Maul"
					icon = 'weapons.dmi'
					icon_state = "maul2"
					EquipState = "maul2"
					CarryState = "maul2"
					DamageType = "Blunt"
					CanBeCrafted = 1
					TwoHander = 1
					Weight = 8
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			Axes
				ObjectType = "Axe"
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
								var/Time = 250 - usr.ForgingSkill * 2 - usr.Strength / 2
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
														W.EquipState = src.EquipState
														W.CarryState = src.CarryState
														W.Material = O.Material
														W.name = "[W.Material] [W.name]"
														if(W.ObjectTag == "Weapon")
															usr.CraftWeapon(O,W)
														W.icon_state = W.CarryState
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								if(usr.CurrentHand == "Right")
									if(usr.Weapon == null)
										if(usr.Weapon2)
											var/HasShield = 0
											if(istype(usr.Weapon2,/obj/Items/Armour/Shields/))
												HasShield = 1
											if(HasShield == 0)
												return
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
								if(usr.CurrentHand == "Left")
									if(usr.Weapon2 == null)
										if(usr.Weapon)
											var/HasShield = 0
											if(istype(usr.Weapon,/obj/Items/Armour/Shields/))
												HasShield = 1
											if(HasShield == 0)
												return
										if(usr.LeftArm >= 25)
											src.layer = 5
											src.suffix = "Equip"
											src.overlays += image(/obj/HUD/E/)
											src.icon_state = "[src.EquipState] left"
											usr.Weapon2 = src
											usr.overlays+=image(src.icon,"[src.icon_state]",src.ItemLayer)
											src.layer = 20
											usr.DeleteInventoryMenu()
											usr.CreateInventory()
											return
										else
											usr << "<font color =red>You cant do that with a damaged arm!<br>"
											return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.Weapon == src && usr.CurrentHand == "Right")
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
								if(usr.Weapon2 == src && usr.CurrentHand == "Left")
									src.layer = 5
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
							for(var/obj/Items/W in usr.CreateList)
								if(W.EquipState == src.EquipState && W.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Copper","Silver")
										for(var/M in Mats)
											var/obj/W = new src.type()
											W.Material = "[M]"
											W.CarryState = "[M] [W.icon_state]"
											W.EquipState = "[M] [W.EquipState] equip"
											W.icon_state = W.CarryState
											W.layer = 100
											usr.CreateList += W
									else
										var/obj/W = new src.type()
										W.Material = src.Material
										W.icon_state = src.CarryState
										W.EquipState = src.EquipState
										W.CarryState = src.CarryState
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
							src.overlays = null
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
				PickAxe
					icon = 'tools.dmi'
					icon_state = "pickaxe"
					EquipState = "pickaxe"
					CarryState = "pickaxe"
					Type = "PickAxe"
					DamageType = "Blunt"
					ItemLayer = 7
					CanBeCrafted = 1
					Quality = 5
					TwoHander = 1
					Weight = 7
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Hatchet
					icon = 'tools.dmi'
					icon_state = "hatchet"
					EquipState = "hatchet"
					CarryState = "hatchet"
					Type = "Hatchet"
					ItemLayer = 7
					CanBeCrafted = 1
					Quality = 5
					Weight = 5
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				BattleAxe
					icon = 'weapons.dmi'
					icon_state = "doubleaxe"
					EquipState = "doubleaxe"
					CarryState = "doubleaxe"
					ItemLayer = 7
					CanBeCrafted = 1
					TwoHander = 1
					Weight = 8
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			Daggers
				ObjectType = "Dagger"
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
														W.EquipState = src.EquipState
														W.CarryState = src.CarryState
														W.Material = O.Material
														W.name = "[W.Material] [W.name]"
														if(W.ObjectTag == "Weapon")
															usr.CraftWeapon(O,W)
														W.icon_state = W.CarryState
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
					if(usr.Function == "Interact" && usr.Ref)
						if(isobj(usr.Ref))
							var/obj/O = usr.Ref
							if(O.Material == "Leather")
								if(src.suffix != "Equip")
									usr << "<font color = red>Equip the Dagger before continuing!<br>"
									return
								if(src.Dura <= 1)
									usr << "<font color = red>The Dagger is Broken, you can not do this job!<br>"
									return
								usr.MovementCheck()
								if(usr.CanMove)
									usr.CreateLeatherMenu(O)
								return
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
					if(usr.Function == "Equip")
						if(src.suffix == "Carried")
							if(src in usr)
								if(src.Dura <= 0)
									usr << "<font color = red>[src] is broken, you cant use that!<br>"
									return
								if(usr.CurrentHand == "Right")
									if(usr.Weapon == null)
										if(usr.Weapon2)
											var/obj/W = usr.Weapon2
											if(W.ObjectTag == "Weapon" && W.TwoHander)
												usr << "<font color = red>You can not dual wield when using large two handed swords!<br>"
												return
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
								if(usr.CurrentHand == "Left")
									if(usr.Weapon2 == null)
										if(usr.Weapon)
											var/obj/W = usr.Weapon
											if(W.ObjectTag == "Weapon" && W.TwoHander)
												usr << "<font color = red>You can not dual wield when using large two handed swords!<br>"
												return
										if(usr.LeftArm >= 25)
											src.layer = 5
											src.suffix = "Equip"
											src.overlays += image(/obj/HUD/E/)
											src.icon_state = "[src.EquipState] left"
											usr.Weapon2 = src
											usr.overlays+=image(src.icon,"[src.icon_state]",src.ItemLayer)
											src.layer = 20
											usr.DeleteInventoryMenu()
											usr.CreateInventory()
											return
										else
											usr << "<font color =red>You cant do that with a damaged arm!<br>"
											return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.Weapon == src && usr.CurrentHand == "Right")
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
								if(usr.Weapon2 == src && usr.CurrentHand == "Left")
									src.layer = 5
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
							for(var/obj/Items/W in usr.CreateList)
								if(W.EquipState == src.EquipState && W.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Copper","Silver")
										for(var/M in Mats)
											var/obj/W = new src.type()
											W.Material = "[M]"
											W.CarryState = "[M] [W.icon_state]"
											W.EquipState = "[M] [W.EquipState] equip"
											W.icon_state = W.CarryState
											W.layer = 100
											usr.CreateList += W
									else
										var/obj/W = new src.type()
										W.Material = src.Material
										W.icon_state = src.CarryState
										W.EquipState = src.EquipState
										W.CarryState = src.CarryState
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
							src.overlays = null
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
				Dagger
					icon = 'weapons.dmi'
					icon_state = "dagger"
					EquipState = "dagger"
					CarryState = "dagger"
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Scissor
					icon = 'tools.dmi'
					icon_state = "scissors"
					EquipState = "scissors"
					CarryState = "scissors"
					Type = "CutsHair"
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
			Swords
				ObjectType = "Sword"
				Click()
					if(usr.Function == "Interact" && usr.Ref)
						if(isobj(usr.Ref))
							var/obj/O = usr.Ref
							var/CraftObj = 0
							if(O.Type == "Plank")
								CraftObj = 1
							if(O.Type == "Block")
								CraftObj = 1
							if(CraftObj)
								if(src.Type != "Saw")
									usr << "<font color = red>Equip A Saw before continuing!<br>"
									return
								if(src.suffix != "Equip")
									usr << "<font color = red>Equip the Saw before continuing!<br>"
									return
								if(src.Dura <= 1)
									usr << "<font color = red>The saw is Broken, you can not do this job!<br>"
									return
								usr.MovementCheck()
								if(usr.CanMove)
									usr.CreateCarpentryMenu(O)
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
														W.EquipState = src.EquipState
														W.CarryState = src.CarryState
														W.Material = O.Material
														W.name = "[W.Material] [W.name]"
														if(W.ObjectTag == "Weapon")
															usr.CraftWeapon(O,W)
														W.icon_state = W.CarryState
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
									if(usr.Weapon == null)
										if(usr.Weapon2)
											var/obj/W = usr.Weapon2
											if(W.ObjectTag == "Weapon" && W.TwoHander)
												usr << "<font color = red>You can not dual wield when using large two handed swords!<br>"
												return
											if(W.ObjectTag == "Weapon" && src.TwoHander)
												usr << "<font color = red>You can not dual wield when using large two handed swords!<br>"
												return
											if(W.ObjectTag == "Weapon" && W.ObjectType == "Axe")
												return
											if(W.ObjectTag == "Weapon" && W.ObjectType == "Spear")
												return
											if(W.ObjectTag == "Weapon" && W.ObjectType == "Blunt")
												return
											if(W.ObjectTag == "Weapon" && W.ObjectType == "Ranged")
												return
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
								if(usr.CurrentHand == "Left")
									if(usr.Weapon2 == null)
										if(usr.Weapon)
											var/obj/W = usr.Weapon
											if(W.ObjectTag == "Weapon" && W.TwoHander)
												usr << "<font color = red>You can not dual wield when using large two handed swords!<br>"
												return
											if(W.ObjectTag == "Weapon" && src.TwoHander)
												usr << "<font color = red>You can not dual wield when using large two handed swords!<br>"
												return
											if(W.ObjectTag == "Weapon" && W.ObjectType == "Axe")
												return
											if(W.ObjectTag == "Weapon" && W.ObjectType == "Spear")
												return
											if(W.ObjectTag == "Weapon" && W.ObjectType == "Blunt")
												return
											if(W.ObjectTag == "Weapon" && W.ObjectType == "Ranged")
												return
										if(usr.LeftArm >= 25)
											src.layer = 5
											src.suffix = "Equip"
											src.overlays += image(/obj/HUD/E/)
											src.icon_state = "[src.EquipState] left"
											usr.Weapon2 = src
											usr.overlays+=image(src.icon,"[src.icon_state]",src.ItemLayer)
											src.layer = 20
											usr.DeleteInventoryMenu()
											usr.CreateInventory()
											return
										else
											usr << "<font color =red>You cant do that with a damaged arm!<br>"
											return
						if(src.suffix == "Equip")
							if(src in usr)
								if(usr.Weapon == src && usr.CurrentHand == "Right")
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
								if(usr.Weapon2 == src && usr.CurrentHand == "Left")
									src.layer = 5
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
							for(var/obj/Items/W in usr.CreateList)
								if(W.EquipState == src.EquipState && W.Material == src.Material)
									Known = 1
							if(Known == 0)
								if(src.CanBeCrafted)
									if(src.BaseMaterial == "Metal")
										var/Mats = list("Iron","Copper","Silver")
										for(var/M in Mats)
											var/obj/W = new src.type()
											W.Material = "[M]"
											W.CarryState = "[M] [W.icon_state]"
											W.EquipState = "[M] [W.EquipState] equip"
											W.icon_state = W.CarryState
											W.layer = 100
											usr.CreateList += W
									else
										var/obj/W = new src.type()
										W.Material = src.Material
										W.icon_state = src.CarryState
										W.EquipState = src.EquipState
										W.CarryState = src.CarryState
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
							src.overlays = null
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
				DemonicSword
					icon = 'weapons.dmi'
					icon_state = "demon sword equip"
					EquipState = "demon sword equip"
					CarryState = "demon sword"
					DamageType = "Slash"
					Weight = 1
					Dura = 1000
					Quality = 33
					Delete = 1
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				BroadSword
					icon = 'weapons.dmi'
					icon_state = "broadsword"
					EquipState = "broadsword"
					CarryState = "broadsword"
					CanBeCrafted = 1
					TwoHander = 1
					Weight = 8
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Scimitar
					icon = 'weapons.dmi'
					icon_state = "scimitar"
					EquipState = "scimitar"
					CarryState = "scimitar"
					CanBeCrafted = 1
					Weight = 6
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Sabre
					icon = 'weapons.dmi'
					icon_state = "sabre"
					EquipState = "sabre"
					CarryState = "sabre"
					CanBeCrafted = 1
					Weight = 5
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				LongSword
					icon = 'weapons.dmi'
					icon_state = "sword"
					EquipState = "sword"
					CarryState = "sword"
					DamageType = "Slash"
					CanBeCrafted = 1
					BaseMaterial = "Metal"
					Weight = 4
					New()
						src.icon_state = src.CarryState
						src.layer = 4
				Saw
					icon = 'tools.dmi'
					icon_state = "saw"
					EquipState = "saw"
					CarryState = "saw"
					Type = "Saw"
					CanBeCrafted = 1
					Quality = 5
					Weight = 3
					BaseMaterial = "Metal"
					New()
						src.icon_state = src.CarryState
						src.layer = 4
