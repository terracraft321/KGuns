#include "Hitters.as";

const uint8 FIRE_INTERVAL = 3;
const float BULLET_DAMAGE = 0.5;
const uint8 PROJECTILE_SPEED = 20; 
const float TIME_TILL_DIE = 0.8;

const uint8 CLIP = 12;
const uint8 TOTAL = 64;
const uint8 RELOAD_TIME = 15;

const string AMMO_TYPE = "bullet";

const string FIRE_SOUND = "PistolSilence.ogg";
const string RELOAD_SOUND  = "Reload.ogg";

const Vec2f RECOIL = Vec2f(1.0f,0.0);
const float BULLET_OFFSET_X = 12;
const float BULLET_OFFSET_Y = 1;

#include "StandardFire.as";
#include "GunStandard";
