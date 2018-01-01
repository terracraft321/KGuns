
#include "Hitters.as";
#include "ShieldCommon.as";
#include "ArcherCommon.as";
#include "TeamStructureNear.as";
#include "Knocked.as"
#include "MakeDustParticle.as";
#include "ParticleSparks.as";

const f32 ARROW_PUSH_FORCE = 22.0f;

//blob functions
void onInit(CBlob@ this) {
	this.getShape().getVars().waterDragScale = 70.0f;
    CShape@ shape = this.getShape();
	ShapeConsts@ consts = shape.getConsts();
    consts.mapCollisions = false;	 // weh ave our own map collision
	consts.bullet = true;
	consts.net_threshold_multiplier = 4.0f;
	this.server_SetTimeToDie(10.0f);	
	this.Tag("projectile");
}

void onCollision(CBlob@ this, CBlob@ blob, bool solid, Vec2f normal, Vec2f point1) {
    if (blob !is null && doesCollideWithBlob( this, blob ) && !this.hasTag("collided")) {
		if (!solid && !blob.hasTag("flesh") && (blob.getName() != "mounted_bow" || this.getTeamNum() != blob.getTeamNum())) {
			return;
		}


		f32 dmg = blob.getTeamNum() == this.getTeamNum() ? 0.0f : this.get_f32("dmg");		
		this.server_Hit(blob, point1, normal, dmg, Hitters::arrow);
	}
}

bool doesCollideWithBlob(CBlob@ this, CBlob@ blob) {
	bool check = this.getTeamNum() != blob.getTeamNum();
	if(!check) {
		CShape@ shape = blob.getShape();
		check = (shape.isStatic() && !shape.getConsts().platform);
	}

	if (check) {
		return true;
	}

	string bname = blob.getName();
	if(bname == "fishy" || bname == "food") {//anything to always hit
		return true;
	}
	if(bname == "bullet") {//anything to never hit
		return false;
	}

	return false;
}


void onTick(CBlob@ this) {
    f32 angle = (this.getVelocity()).Angle();
    Pierce(this); //map
    this.setAngleDegrees(-angle);

	CShape@ shape = this.getShape();
	shape.SetGravityScale( 0.3f + this.getTickSinceCreated()*0.1f );
}

void Pierce(CBlob @this) {
    CMap@ map = this.getMap();
	Vec2f end;
	if (map.rayCastSolidNoBlobs(this.getShape().getVars().oldpos, this.getPosition() ,end))	{
		HitMap(this, end, this.getOldVelocity(), 0.5f, Hitters::arrow);
	}
}


f32 HitBlob(CBlob@ this, Vec2f worldPoint, Vec2f velocity, f32 damage, CBlob@ hitBlob, u8 customData) {
    if (hitBlob !is null) {
		// check if shielded
		const bool hitShield = (hitBlob.hasTag("shielded") && blockAttack(hitBlob, velocity, 0.0f));

		// play sound
		if (!hitShield)	{
			if (hitBlob.hasTag("flesh")) {
				this.getSprite().PlaySound("ArrowHitFlesh.ogg");
			}
			else {
				this.getSprite().PlaySound("BulletImpact.ogg");	
				damage = 0.0f;
			}
		}
        this.server_Die();
    }
	return damage;
}

void HitMap(CBlob@ this, Vec2f worldPoint, Vec2f velocity, f32 damage, u8 customData) {	
	string rico;
	int randNum = XORRandom(6);
	if(randNum == 0) {
		rico = "rico0.ogg";
	} else if (randNum == 1) {
		rico = "rico1.ogg";
	} else if (randNum == 2) {
		rico = "rico2.ogg";	
	} else if (randNum == 3) {
		rico = "rico3.ogg";
	} else if (randNum == 4) {
		rico = "rico4.ogg";
	} else if (randNum == 5) {
		rico = "rico5.ogg";
	}

	this.getSprite().PlaySound( XORRandom(5) == 0 ? rico : "BulletImpact.ogg");
	MakeDustParticle(worldPoint, "/DustSmall.png");
	CMap@ map = this.getMap();
	f32 vellen = velocity.Length();
	TileType tile = map.getTile(worldPoint).type;
	if (map.isTileCastle(tile) || map.isTileStone(tile)) {
		sparks(worldPoint, -velocity.Angle(), Maths::Max(vellen*0.05f, damage));
	}
	this.server_Die();
}

f32 onHit(CBlob@ this, Vec2f worldPoint, Vec2f velocity, f32 damage, CBlob@ hitterBlob, u8 customData) {
	if(customData == Hitters::sword) {
		damage = 0.0f; //no cut arrows
	}
	else if(customData == Hitters::arrow) {
		damage = 0.0f; //no cut arrows
	}	
    return damage;
}

void onHitBlob(CBlob@ this, Vec2f worldPoint, Vec2f velocity, f32 damage, CBlob@ hitBlob, u8 customData) {
	// unbomb, stick to blob
	if (this !is hitBlob && customData == Hitters::arrow) {
		// affect players velocity
		f32 force = (ARROW_PUSH_FORCE * -0.125f) * Maths::Sqrt(hitBlob.getMass()+1);
		hitBlob.AddForce(velocity * force);
	}
}
