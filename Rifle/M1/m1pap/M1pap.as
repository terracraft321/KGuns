#include "Hitters.as";

const uint8 FIRE_INTERVAL = 15; //40;
const float BULLET_DAMAGE = 4.0; //2.5
const uint8 PROJECTILE_SPEED = 22; 
const float TIME_TILL_DIE = 0.8;

const uint8 CLIP = 24; //True to the weapon ;)
const uint8 TOTAL = 120;
const uint8 RELOAD_TIME = 15; //40;

const string AMMO_TYPE = "bullet";
const string AMMO_SPRITE = "Bullet.png";
const bool SNIPER = false;
const uint8 SNIPER_TIME = 0;

const string FIRE_SOUND = "AutoFire.ogg";
const string RELOAD_SOUND  = "Reload.ogg";

const Vec2f RECOIL = Vec2f(1.0f,0.0);
const float BULLET_OFFSET_X = 6;
const float BULLET_OFFSET_Y = 1;

#include "StandardFire.as";
#include "GunStandard";
