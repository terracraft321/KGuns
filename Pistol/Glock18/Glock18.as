#include "Hitters.as";

const uint8 FIRE_INTERVAL = 6;
const float BULLET_DAMAGE = 0.6;
const uint8 PROJECTILE_SPEED = 15; 
const float TIME_TILL_DIE = 0.4;

const uint8 CLIP = 20;
const uint8 TOTAL = 120;
const uint8 RELOAD_TIME = 15;

const string AMMO_TYPE = "bullet";

const string FIRE_SOUND = "PistolFire.ogg";
const string RELOAD_SOUND  = "Reload.ogg";

const Vec2f RECOIL = Vec2f(1.0f,0.0);
const float BULLET_OFFSET_X = 8;
const float BULLET_OFFSET_Y = 1;

#include "StandardFire.as";
#include "GunStandard";
