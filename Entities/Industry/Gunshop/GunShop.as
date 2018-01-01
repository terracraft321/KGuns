// Gunshop

#include "Requirements.as"
#include "ShopCommon.as";
#include "Descriptions.as";
#include "WARCosts.as";
#include "CheckSpam.as";

s32 cost_magnum = 25;

void onInit(CBlob@ this)
{
	this.set_TileType("background tile", CMap::tile_wood_back);

	this.getSprite().SetZ(-50); //background
	this.getShape().getConsts().mapCollisions = false;

	// SHOP
	this.set_Vec2f("shop offset", Vec2f_zero);
	this.set_Vec2f("shop menu size", Vec2f(17, 2));
	this.set_string("shop description", "Buy");
	this.set_u8("shop icon", 25);

	// CLASS
	this.set_Vec2f("class offset", Vec2f(-6, 0));
	this.set_string("required class", "knight");
	
	{
		ShopItem@ s = addShopItem(this, "Magnum", "$magnum$", "magnum", "A Powerful Magnum", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", cost_magnum);
	}
	{
		ShopItem@ s = addShopItem(this, "Deagle", "$deagle$", "deagle", "Most powerful handgun on earth", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "M1", "$m1$", "m1", "A Semiautomatic rifle", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "AA12", "$aa12$", "aa12", "Automatic Rifle", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "AK-47", "$ak47$", "ak47", "Automatic Rifle", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "M4", "$m4$", "m4", "Automatic Rifle", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "M16", "$m16$", "m16", "Automatic Rifle", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "Sniper", "$sniper$", "sniper", "A Semi-Automatic Rifle", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "Shogun", "$shotgunla$", "shotgunla", "Shotgun", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "Remington870", "$remington870$", "remington870", "Shotgun", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "Sawnoffshotgun", "$sawnoffshotgun$", "sawnoffshotgun", "Shotgun", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "gl", "$gl$", "gl", "Granade Launcher", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	{
		ShopItem@ s = addShopItem(this, "rpg", "$rpg$", "rpg", "Rocket Proppelled Launcher", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "plasma", "$plasma$", "plasma", "Plasma Cannon", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "coltcobra", "$coltcobra$", "coltcobra", "A Pistol", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "coltanaconda", "$coltanaconda$", "anaconda", "A Another Pistol", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "goldengun", "$goldengun$", "sawnoffshotgun", "GoldenGun 007", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	{
		ShopItem@ s = addShopItem(this, "Cz75Auto", "$Cz75Auto$", "Cz75Auto", "A Self Defence Weapon", true);
//		AddRequirement(s.requirements, "coin", "", "Coins", 25);
	}
	}
}

void GetButtonsFor(CBlob@ this, CBlob@ caller)
{
	if(caller.getConfig() == this.get_string("required class"))
	{
		this.set_Vec2f("shop offset", Vec2f_zero);
	}
	else
	{
		this.set_Vec2f("shop offset", Vec2f(6, 0));
	}
	this.set_bool("shop available", this.isOverlapping(caller));
}

void onCommand( CBlob@ this, u8 cmd, CBitStream @params )
{
	if (cmd == this.getCommandID("shop made item"))
	{
		this.getSprite().PlaySound( "ChaChing.ogg");
	}
}