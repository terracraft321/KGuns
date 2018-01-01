#include "Hitters.as";

const uint8 FIRE_INTERVAL = 23;
const float BULLET_DAMAGE = 2.5; //Irrelevent
const uint8 PROJECTILE_SPEED = 10; 
const float TIME_TILL_DIE = 0.5;

const uint8 CLIP = 6;
const uint8 TOTAL = 18;
const uint8 RELOAD_TIME = 40;

const string AMMO_TYPE = "plasmaorb";
const string AMMO_SPRITE = "PlasmaBullet.png";
const bool SNIPER = false;
const uint8 SNIPER_TIME = 0;

const string FIRE_SOUND = "PlasmaFire.ogg";
const string RELOAD_SOUND  = "PlasmaReload.ogg";

const Vec2f RECOIL = Vec2f(1.0f,0.0);
const float BULLET_OFFSET_X = 4;
const float BULLET_OFFSET_Y = 2;

#include "StandardFire.as";
#include "GunStandard";