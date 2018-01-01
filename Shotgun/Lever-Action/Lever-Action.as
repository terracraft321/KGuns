#include "Hitters.as";

const uint8 FIRE_INTERVAL = 40;
const float BULLET_DAMAGE = 1;
const uint8 PROJECTILE_SPEED = 19;
const float TIME_TILL_DIE = 0.20;

const uint8 CLIP = 1;
const uint8 TOTAL = 15;
const uint8 RELOAD_TIME = 30;

const string AMMO_TYPE = "bullet";
const bool SNIPER = false;
const uint8 SNIPER_TIME = 0;

const string FIRE_SOUND = "shotgun.ogg";
const string RELOAD_SOUND  = "Reload.ogg";

const Vec2f RECOIL = Vec2f(1.0f,0.0);
const float BULLET_OFFSET_X = 6;
const float BULLET_OFFSET_Y = 0;

#include "ShotgunFire.as";
#include "ShotgunStandard.as";