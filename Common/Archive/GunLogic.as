// blob
const string EMPTY_CLIP_SOUND = "EmptyClip.ogg";
const string PICKUP_GUN_SOUND = "PickupGun.ogg";

const uint8 NO_AMMO_INTERVAL = 35;

const string ID_SHOOT = "shoot";
const string ID_RELOAD = "reload";

const string GS_CLIP = "clip";
const string GS_TOTAL_AMMO = "totalAmmo";

const string GS_ACTION_INTERVAL = "actionInterval";

const string GS_IS_RELOADING = "isReloading";
const string GS_FINISHED_RELOADING = "finishedReloading";

const Vec2f RECOIL = Vec2f(1.0f,0.0);

void onInit(CBlob@ this) {
    AttachmentPoint@ ap = this.getAttachments().getAttachmentPointByName("PICKUP");
    if (ap !is null) {
        ap.SetKeysToTake(key_action1);
    }

    this.addCommandID(ID_SHOOT);
    this.addCommandID(ID_RELOAD);

    this.set_u8(GS_CLIP, CLIP);
    this.set_u8(GS_TOTAL_AMMO, TOTAL);
	this.set_bool(GS_IS_RELOADING, false);
	this.set_u8(GS_ACTION_INTERVAL, 0);
	this.set_bool(GS_FINISHED_RELOADING, false);
}

void onTick(CBlob@ this) {	
    if (this.isAttached()) {
		this.getCurrentScript().runFlags &= ~(Script::tick_not_sleeping); 					   		
		AttachmentPoint@ point = this.getAttachments().getAttachmentPointByName("PICKUP");	   		
        CBlob@ holder = point.getOccupied();												   
        if (holder !is null) { 

	        CShape@ shape = this.getShape();
	        CSprite@ sprite = this.getSprite();
	        const f32 aimangle = getAimAngle(this,holder);

	        // rotate towards mouse cursor
	        sprite.ResetTransform();
	        sprite.RotateBy( aimangle, holder.isFacingLeft() ? Vec2f(-8,2) : Vec2f(8,2) );
	        sprite.animation.frame = 0;

	        // fire + reload
	        if(holder.isMyPlayer())	{
	        	CControls@ controls = holder.getControls();
				if(controls !is null) {
					if(controls.isKeyJustPressed(KEY_KEY_R) 
						&& this.get_bool(GS_IS_RELOADING) == false) {
						this.set_bool(GS_IS_RELOADING, true);				
					}
				}

				uint8 actionInterval = this.get_u8(GS_ACTION_INTERVAL);
				if (actionInterval > 0) {
					actionInterval--;			
				}  else if(this.get_bool(GS_IS_RELOADING) == true 
					&& this.get_u8(GS_TOTAL_AMMO) > 0) {
						reload(this, holder);
						actionInterval = RELOAD_TIME;
				} else if(this.get_bool(GS_FINISHED_RELOADING) == true) {
					this.set_bool(GS_FINISHED_RELOADING, false);
					playSound(this, RELOAD_SOUND);
					print("reload complete");
				} else if (point.isKeyPressed(key_action1)) {
					if(this.get_u8(GS_CLIP) > 0) {
						shoot(this, aimangle, holder);
						print("" + this.get_u8(GS_CLIP) + "/" + this.get_u8(GS_TOTAL_AMMO));
						actionInterval = FIRE_INTERVAL;
					} else if(this.get_bool(GS_IS_RELOADING) == false) {
						playSound(this, EMPTY_CLIP_SOUND);
						actionInterval = NO_AMMO_INTERVAL;
					} 
				}

				this.set_u8(GS_ACTION_INTERVAL, actionInterval);	
			}
		}
    } else {
		this.getCurrentScript().runFlags |= Script::tick_not_sleeping; 
    }			
}

void shoot(CBlob@ this, const f32 aimangle, CBlob@ holder) {
	CBitStream params;
	params.write_Vec2f(this.getPosition());
	params.write_f32(aimangle);
	params.write_netid(holder.getNetworkID());
	this.SendCommand( this.getCommandID(ID_SHOOT), params );
}

void reload(CBlob@ this, CBlob@ holder) {
	CBitStream params;
	params.write_Vec2f(this.getPosition());
	params.write_netid(holder.getNetworkID());
	this.SendCommand(this.getCommandID(ID_RELOAD), params);
}

void onCommand(CBlob@ this, u8 cmd, CBitStream @params) {
	CSprite@ sprite = this.getSprite();

	if(cmd == this.getCommandID(ID_SHOOT)) {
		uint8 currentClipAmount = this.get_u8(GS_CLIP);
		currentClipAmount--;
		this.set_u8(GS_CLIP, currentClipAmount);

		Vec2f pos = params.read_Vec2f();
		f32 angle = params.read_f32();
		CBlob@ holder = getBlobByNetworkID(params.read_netid());
		if(holder !is null) {
			Vec2f velocity(1,0);
			CBlob@ ammo = server_CreateBlob(AMMO_TYPE);
			if(ammo !is null) {
				Vec2f offset(15,0);

				if(this.isFacingLeft()) {
					offset.RotateBy( angle, Vec2f(-8,-2) );
					ammo.setPosition( pos - offset );				
					angle += 180.0f;
				} else {
					offset.RotateBy( angle, Vec2f(-8,-2) );
					ammo.setPosition( pos + offset );		
				}

				velocity.RotateBy( angle );
				ammo.setVelocity( velocity * PROJECTILE_SPEED );

				ammo.IgnoreCollisionWhileOverlapped( holder );
	            ammo.SetDamageOwnerPlayer( holder.getPlayer() );
				ammo.server_setTeamNum( holder.getTeamNum() );
			}
			
			playSound(this, FIRE_SOUND);

			// animate muzzle fire
			sprite.animation.frame = 1 + XORRandom(3);
			// pull back
			sprite.TranslateBy(RECOIL);
			// shell
			Vec2f velr = getRandomVelocity( 30, 4.3f, 40.0f) *0.1f;
			ParticlePixel( this.getPosition(), Vec2f( velocity.y, velocity.x
				*(this.isFacingLeft() ? 5.0f : -5.0f) ) + velr, SColor(255,255,197,47), true );
		}
	} else if(cmd == this.getCommandID(ID_RELOAD)) {
		int currentTotalAmount = this.get_u8(GS_TOTAL_AMMO);
		int currentClipAmount = this.get_u8(GS_CLIP);
		int neededClipAmount = CLIP - currentClipAmount;
		
		if(currentTotalAmount >= neededClipAmount) {
			this.set_u8(GS_CLIP, CLIP);
			currentTotalAmount -= neededClipAmount;
			this.set_u8(GS_TOTAL_AMMO, currentTotalAmount);
		} else {
			this.set_u8(GS_CLIP, currentTotalAmount);
			currentTotalAmount = 0;
			this.set_u8(GS_TOTAL_AMMO, currentTotalAmount);
		}

		this.set_bool(GS_IS_RELOADING, false);
		this.set_bool(GS_FINISHED_RELOADING, true);
	}
}

f32 getAimAngle(CBlob@ this, CBlob@ holder) {
 	Vec2f aimvector = holder.getAimPos() - this.getPosition();
    return holder.isFacingLeft() ? -aimvector.Angle()+180.0f : -aimvector.Angle();
}

void onAttach(CBlob@ this, CBlob@ attached, AttachmentPoint @attachedPoint) {
	this.getCurrentScript().runFlags &= ~Script::tick_not_sleeping;
	this.SetDamageOwnerPlayer(attached.getPlayer());
	playSound(this, PICKUP_GUN_SOUND);
}

void onDetach(CBlob@ this, CBlob@ detached, AttachmentPoint @detachedPoint) {
    CSprite@ sprite = this.getSprite();
    sprite.ResetTransform();
    sprite.animation.frame = 0;
    this.setAngleDegrees(getAimAngle(this,detached));
}

void playSound(CBlob@ this, string soundName) {
	CBlob@ holder = this.getAttachments().getAttachmentPointByName("PICKUP").getOccupied();
	if(holder !is null) {
		CSprite@ holderSprite = holder.getSprite();
		if(holderSprite !is null) {
			holderSprite.PlaySound(soundName);
		}
	}
}