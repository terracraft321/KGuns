#include "Hitters.as";

const uint8 FIRE_INTERVAL = 5;
const float BULLET_DAMAGE = 0.6; 
const uint8 PROJECTILE_SPEED = 22; 
const float TIME_TILL_DIE = 0.3; 

const uint8 CLIP = 30; 
const uint8 TOTAL = 120;
const uint8 RELOAD_TIME = 7;

const string AMMO_TYPE = "bullet";
const bool SNIPER = false;
const uint8 SNIPER_TIME = 0;

const string FIRE_SOUND = "PistolFire.ogg";
const string RELOAD_SOUND  = "Reload.ogg";

const Vec2f RECOIL = Vec2f(1.0f,0.0);
const float BULLET_OFFSET_X = 3;
const float BULLET_OFFSET_Y = 0;

#include "StandardFire.as";
#include "GunStandard";
