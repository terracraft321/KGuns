#include "Hitters.as";

const uint8 FIRE_INTERVAL = 5; //5;
const float BULLET_DAMAGE = 2; //1.0;
const uint8 PROJECTILE_SPEED = 30; //25;
const float TIME_TILL_DIE = 0.8; // 0.7 to 0.8

const uint8 CLIP = 6;
const uint8 TOTAL = 48;
const uint8 RELOAD_TIME = 10; //

const string AMMO_TYPE = "bullet";

const string FIRE_SOUND = "PistolFire.ogg";
const string RELOAD_SOUND  = "Reload.ogg";

const Vec2f RECOIL = Vec2f(1.0f,0.0);
const float BULLET_OFFSET_X = 8;
const float BULLET_OFFSET_Y = 1;

#include "StandardFire.as";
#include "GunStandard";
