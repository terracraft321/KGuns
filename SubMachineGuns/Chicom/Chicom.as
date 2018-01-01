#include "Hitters.as";

//const uint8 FIRE_INTERVAL = 4;
//const float BULLET_DAMAGE = 1;
//const uint8 PROJECTILE_SPEED = 20; 

const uint8 FIRE_INTERVAL = 5;
const float BULLET_DAMAGE = 0.6;
const uint8 PROJECTILE_SPEED = 10; 
const float TIME_TILL_DIE = 0.3;

const uint8 CLIP = 32;
const uint8 TOTAL = 120;
const uint8 RELOAD_TIME = 8;

const string AMMO_TYPE = "bullet";

const string FIRE_SOUND = "AssaultFire.ogg";
const string RELOAD_SOUND  = "Reload.ogg";

const Vec2f RECOIL = Vec2f(1.0f,0.0);
const float BULLET_OFFSET_X = 10;
const float BULLET_OFFSET_Y = 0;

#include "StandardFire.as";
#include "GunStandard";
