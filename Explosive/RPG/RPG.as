#include "Hitters.as";

const uint8 FIRE_INTERVAL = 60;
const float BULLET_DAMAGE = 0; //Irrelevent
const uint8 PROJECTILE_SPEED = 16; 
const float TIME_TILL_DIE = 120; //Irrelevent

const uint8 CLIP = 1;
const uint8 TOTAL = 4;
const uint8 RELOAD_TIME = 80;

const string AMMO_TYPE = "nade";
const bool SNIPER = true;
const uint8 SNIPER_TIME = 25;

const string FIRE_SOUND = "RPGFire.ogg";
const string RELOAD_SOUND  = "Reload.ogg";

const Vec2f RECOIL = Vec2f(1.0f,0.0);
const float BULLET_OFFSET_X = 12;
const float BULLET_OFFSET_Y = 1;

#include "SniperFire.as";
#include "SniperStandard";