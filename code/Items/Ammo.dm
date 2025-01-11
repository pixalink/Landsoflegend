obj
	proc
		RangedMove()
			if(src)
				if(src.Target)
					var/turf/T = src.Target
					step_towards(src,T)
					for(var/atom/A in range(0,src))
						if(ismob(A) && A != src.Owner)
							var/mob/M = A
							if(M.Dead == 0)
								var/mob/Own = src.Owner
								if(M.Target == null)
									M.Target = Own
								if(M.Weapon)
									var/obj/S = M.Weapon
									if(S.Type == "Shield")
										var/Block = 0 + M.Agility / 3 + M.ShieldSkill / 3
										var/Blocks = prob(Block)
										if(Blocks)
											view(6,src) << "<font color = red>[M] blocks the [src] using their [S]!<br>"
											Own.CombatSkillTransfer(M)
											if(M && M.Target == null)
												M.Target = src.Owner
											del(src)
											return
								if(M.Weapon2)
									var/obj/S = M.Weapon2
									if(S.Type == "Shield")
										var/Block = 0 + M.Agility / 3 + M.ShieldSkill / 3
										var/Blocks = prob(Block)
										if(Blocks)
											view(6,src) << "<font color = red>[M] blocks the [src] using their [S]!<br>"
											Own.CombatSkillTransfer(M)
											if(M && M.Target == null)
												M.Target = src.Owner
											del(src)
											return
								var/Dodge = 0 + M.Agility / 2
								var/DodgeMath = 0
								for(var/obj/Items/Armour/Ar in M)
									if(Ar.suffix == "Equip")
										DodgeMath += Ar.Weight / 3
								if(M.Strength <= DodgeMath)
									Dodge -= DodgeMath
								var/Dodges = prob(Dodge)
								if(Dodges && M.Fainted == 0 && M.Stunned == 0)
									view(6,src) << "<font color = red>[M] dodges the [src]!<br>"
									src.suffix = null
									src.Target = null
									Own.CombatSkillTransfer(M)
									if(M && M.Target == null)
										M.Target = src.Owner
									src.Owner = null
									return
								var/Bat = 0 + M.CurrentSkillLevel / 5 + M.Agility / 2.5
								var/BatMath = 0
								for(var/obj/Items/Armour/Ar in M)
									if(Ar.suffix == "Equip")
										BatMath += Ar.Weight / 3
								if(M.Strength <= BatMath)
									Bat -= BatMath
								var/Bats = prob(Bat)
								if(Bats && M.Fainted == 0 && M.Stunned == 0)
									view(6,src) << "<font color = red>[M] bats [src] away!<br>"
									src.suffix = null
									src.Target = null
									Own.CombatSkillTransfer(M)
									if(M && M.Target == null)
										M.Target = src.Owner
									src.Owner = null
									return
								var/Miss = 60 - Own.RangedSkill * 2
								if(Miss <= 5)
									Miss = 5
								var/Misses = prob(Miss)
								if(Misses)
									view(6,src) << "<font color = red>[src] misses its target!<br>"
									src.suffix = null
									src.Target = null
									Own.CombatSkillTransfer(M)
									if(M && M.Target == null)
										M.Target = src.Owner
									src.Owner = null
									return
								view(6,src) << "<font color = red>[src] flies into [M]!<br>"
								src.suffix = null
								if(src.Type >= 1)
									M.ArrowDamage(src.Type,src)
								if(M && M.Target == null)
									M.Target = src.Owner
								var/Gain = 25 - Own.RangedSkill / 3
								if(Gain <= 2)
									Gain = 2
								var/Gains = prob(Gain)
								if(Gains)
									if(Own.RangedSkill <= Own.SkillCap && Own.RangedSkill <= WorldSkillsCap)
										Own.RangedSkill += Own.RangedSkillMulti
								Own.CombatSkillTransfer(M)
								src.Owner = null
								return
						if(isturf(A))
							if(A.density && A.opacity)
								view(6,src) << "<font color = red>[src] hits [A] and breaks!<br>"
								del(src)
								return
					if(src && src.Target in range(0,src))
						src.suffix = null
						src.Owner = null
						return
				else
					src.suffix = null
					src.Owner = null
					return
			spawn(1) src.RangedMove()

	Items
		Ammo
			WoodenArrow
				icon = 'misc.dmi'
				icon_state = "wooden arrow"
				Fuel = 10
				Weight = 2
				Click()
					if(usr.Function == "Interact" && src.suffix == "StuckIn")
						var/Can = 0
						if(usr.LeftArm >= 20)
							Can = 1
						if(usr.RightArm >= 20)
							Can = 2
						if(Can)
							view(usr) << "<font color = purple>[usr] pulls out the [src]!<br>"
							src.suffix = null
							src.overlays = null
							src.loc = usr.loc
							usr.Weight -= src.Weight
							usr.Blood -= src.Type
							usr.Bleed()
							usr.DeleteInventoryMenu()
							if(usr.InvenUp)
								usr.CreateInventory()
					if(usr.Function == "Transfer")
						if(usr.Container)
							var/obj/C = usr.Container
							if(src.suffix == "Carried")
								if(src in C)
									if(C in range(1,usr))
										if(usr.Weight <= usr.WeightMax)
											if(usr.WExtra)
												var/obj/I = usr.WExtra
												if(I.suffix == "Equip")
													if(I.Type == "Quiver")
														var/Num = 0
														for(var/obj/O in I)
															Num += 1
														if(Num <= 30)
															usr.Weight -= I.Weight
															I.Weight += src.Weight
															usr.Weight += I.Weight
															src.suffix = "Carried"
															C.Weight -= src.Weight
															src.loc = I
															if(usr.InvenUp)
																usr.CreateInventory()
															usr.CreateContainerContents(C)
															usr << "<font color = green>You pick up [src] and place it in your [I]<br>"
															return
														else
															usr.Weight += src.Weight
															C.Weight -= src.Weight
															src.suffix = "Carried"
															src.loc = usr
															if(usr.InvenUp)
																usr.CreateInventory()
															usr.CreateContainerContents(C)
															usr << "<font color = red>[I] has too many arrows in it, you place the [src] in your inventory!<br>"
															return
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
						if(src in range(1,usr))
							if(usr.Dead == 0)
								if(src.suffix == null)
									if(usr.Weight <= usr.WeightMax)
										if(usr.WExtra)
											var/obj/I = usr.WExtra
											if(I.suffix == "Equip")
												if(I.Type == "Quiver")
													var/Num = 0
													for(var/obj/O in I)
														Num += 1
													if(Num <= 30)
														usr.Weight -= I.Weight
														I.Weight += src.Weight
														usr.Weight += I.Weight
														src.suffix = "Carried"
														src.loc = I
														usr << "<font color = green>You pick up [src] and place it in your [I]<br>"
														return
													else
														usr.Weight += src.Weight
														src.suffix = "Carried"
														src.loc = usr
														usr << "<font color = red>[I] has too many arrows in it, you place the [src] in your inventory!<br>"
														return
										else
											usr.Weight += src.Weight
											src.suffix = "Carried"
											src.overlays+=image(/obj/HUD/C/)
											src.loc = usr
											usr << "<b>You pick up [src]!<br>"
											return
									else
										usr << "<font color = red>Your carrying enough already!<br>"
										return
								if(src.suffix == "Carried" && src in usr)
									usr.Weight -= src.Weight
									src.overlays = null
									src.suffix = null
									src.loc = usr.loc
									src.layer = 4
									usr.client.screen -= src
									usr << "<b>You drop [src]!<br>"
									for(var/obj/HUD/Text/T in usr.client.screen)
										if(T.Type == "Weight")
											del(T)
									if(usr.InvenUp)
										usr.Text("Weight",usr,4,15,0,10,"Weight - [usr.Weight]/[usr.WeightMax]")
									usr.Delete("ScrollMiddle","BoxDelete")
									return
