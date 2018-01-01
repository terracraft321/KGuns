#include "Hitters.as";

const uint8 FIRE_INTERVAL = 50;
const float BULLET_DAMAGE = 0; //Irrelevent
const uint8 PROJECTILE_SPEED = 10; 
const float TIME_TILL_DIE = 120; //Irrelevent

const uint8 CLIP = 1;
const uint8 TOTAL = 10;
const uint8 RELOAD_TIME = 60;

const string AMMO_TYPE = "bomb";
const bool SNIPER = false;
const uint8 SNIPER_TIME = 0;

const string FIRE_SOUND = "RPGFire.ogg";
const string RELOAD_SOUND  = "Reload.ogg";

const Vec2f RECOIL = Vec2f(1.0f,0.0);
const float BULLET_OFFSET_X = 10;
const float BULLET_OFFSET_Y = 0;

#include "StandardFire.as";
#include "GunStandard";