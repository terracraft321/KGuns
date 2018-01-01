#include "Hitters.as";

const uint8 FIRE_INTERVAL = 9;
const float BULLET_DAMAGE = 1;
const uint8 PROJECTILE_SPEED = 16; 
const float TIME_TILL_DIE = 0.5;

const uint8 CLIP = 7;
const uint8 TOTAL = 41;
const uint8 RELOAD_TIME = 32;

const string AMMO_TYPE = "bullet";
const bool SNIPER = false;
const uint8 SNIPER_TIME = 0;

const string FIRE_SOUND = "PistolFire.ogg";
const string RELOAD_SOUND  = "Reload.ogg";

const Vec2f RECOIL = Vec2f(1.0f,0.0);
const float BULLET_OFFSET_X = 8;
const float BULLET_OFFSET_Y = 1;

#include "StandardFire.as";
#include "GunStandard";
