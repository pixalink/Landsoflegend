obj
	Items
		Limb
			CookingFood = 1
			Type = 40
			Weight = 4
			Fuel = 50
			New()
				src.tag = "Limb"
			Click()
				if(usr.Function == "Eat")
					if(src.icon == 'Skeleton.dmi')
						return
					if(src in usr)
						if(usr.Hunger <= src.Type)
							usr.Hunger += src.Type
						else
							usr << "<font color = yellow>You eat the [src], but you will need somthing a little better in order to sate your hunger!<br>"
							usr.Hunger += src.Type / 10
						if(usr.Hunger >= 100)
							usr.Hunger = 100
						view(usr) << "<font color =yellow>[usr] eats [src]!<br>"
						if(src.CookingFood == 1 && usr.CanEatRawMeats == 0)
							var/AlreadyIll = 0
							if("Ill" in usr.Afflictions)
								AlreadyIll = 1
							if(AlreadyIll == 0)
								usr.Afflictions += "Ill"
								usr.Illness(35)
						if(src.CookingFood == 1 && usr.CanEatRawMeats == 1)
							var/AlreadyIll = 0
							if("Ill" in usr.Afflictions)
								AlreadyIll = 1
							if(AlreadyIll == 0)
								var/GetsIll = prob(50)
								if(GetsIll)
									usr.Afflictions += "Ill"
									usr.Illness(25)
						usr.Weight -= src.Weight
						del(src)
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
						src.overlays = null
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
						for(var/obj/Items/Resources/CampSite/CS in range(1,src))
							if(src.CookingFood == 1 && CS.OnFire)
								Cook(src.loc,CS,usr,0,0)
								view(usr) << "<font color = yellow>[usr] places down a [src] to cook!<br>"
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
