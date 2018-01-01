#include "Hitters.as";
//Top shotgun

const uint8 FIRE_INTERVAL = 10;
const float BULLET_DAMAGE = 0.5;
const uint8 PROJECTILE_SPEED = 10;
const float TIME_TILL_DIE = 0.6;

const uint8 CLIP = 5;
const uint8 TOTAL = 32;
const uint8 RELOAD_TIME = 25;

const string AMMO_TYPE = "pellet";
const bool SNIPER = false;
const uint8 SNIPER_TIME = 0;

const string FIRE_SOUND = "shotgun.ogg";
const string RELOAD_SOUND  = "Reload.ogg";

const Vec2f RECOIL = Vec2f(1.0f,0.0);
const float BULLET_OFFSET_X = 6;
const float BULLET_OFFSET_Y = 0;

#include "ShotgunFire2.as";
#include "ShotgunStandard.as";