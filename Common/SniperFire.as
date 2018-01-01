const uint8 NO_AMMO_INTERVAL = 35;

void onInit(CBlob@ this) {
    AttachmentPoint@ ap = this.getAttachments().getAttachmentPointByName("PICKUP");
    if (ap !is null) {
        ap.SetKeysToTake(key_action1);
    }

    this.addCommandID("shoot");
    this.addCommandID("reload");

    this.set_u8("clip", CLIP);
    this.set_u8("total", TOTAL);
    this.set_u8("chargeTimer", 0);
	
	this.set_bool("beginReload", false);
	this.set_bool("doReload", false);
	this.set_u8("actionInterval", 0);
	this.Tag("gun");
}

void onTick(CBlob@ this) {	
    if (this.isAttached()) {
		this.getCurrentScript().runFlags &= ~(Script::tick_not_sleeping); 					   		
		AttachmentPoint@ point = this.getAttachments().getAttachmentPointByName("PICKUP");	   		
        CBlob@ holder = point.getOccupied();
        u8 chargeTimer = this.get_u8("chargeTimer");												   
        if (holder !is null) { 
	

	        CShape@ shape = this.getShape();
	        CSprite@ sprite = this.getSprite();
	        
			Vec2f aimvector = holder.getAimPos() - this.getPosition();
			//f32 aimangle = 0 - aimvector.Angle() + (this.isFacingLeft() == true ? 180.0f : 0);
			const f32 aimangle = getAimAngle(this,holder);

	        // rotate towards mouse cursor
	        sprite.ResetTransform();
	        sprite.RotateBy( aimangle, holder.isFacingLeft() ? Vec2f(-5,3) : Vec2f(5,3) );
	        sprite.animation.frame = 0;

	        // fire + reload
		uint8 actionInterval = this.get_u8("actionInterval");
	        if(holder.isMyPlayer())	{
	        	//check for clip amount error
				if(this.get_u8("clip") > CLIP) {
					this.set_u8("clip", 0);
				}
	        	
				CControls@ controls = holder.getControls();
				if(controls !is null) {
					if(controls.isKeyJustPressed(KEY_KEY_R) 
						&& this.get_bool("beginReload") == false
						&& this.get_u8("clip") < CLIP) {
						this.set_bool("beginReload", true);				
					}
				}
				if (actionInterval > 0) {
					actionInterval--;			
				} else if(this.get_bool("beginReload") == true 
					&& this.get_u8("total") > 0) {
						actionInterval = RELOAD_TIME;
						this.set_bool("beginReload", false);
						this.set_bool("doReload", true);
				} else if(this.get_bool("doReload") == true) {
					reload(this, holder);
					sprite.PlaySound(RELOAD_SOUND);
					this.set_bool("doReload", false);
				} else if (point.isKeyPressed(key_action1) && actionInterval == 0) {
					chargeTimer++;
					this.set_u8("chargeTimer", chargeTimer);
					string time3 = chargeTimer;
					print(time3);
				}

				if (chargeTimer >= SNIPER_TIME)
					{
					if(this.isInWater()) {
						sprite.PlaySound("EmptyClip.ogg");
						chargeTimer = 0;
						this.set_u8("chargeTimer", chargeTimer);
						actionInterval = NO_AMMO_INTERVAL;
						this.set_u8("actionInterval", actionInterval);
						}				
					else if(this.get_u8("clip") > 0) {
						//chargeTimer++;
						shoot(this, aimangle, holder);
						chargeTimer = 0;
						this.set_u8("chargeTimer", chargeTimer);
						actionInterval = FIRE_INTERVAL;
						this.set_u8("actionInterval", actionInterval);
						}
					else if( this.get_bool("beginReload") == false ) 
						{
						sprite.PlaySound("EmptyClip.ogg");
						chargeTimer = 0;
						this.set_u8("chargeTimer", chargeTimer);
						actionInterval = NO_AMMO_INTERVAL;
						this.set_u8("actionInterval", actionInterval);
						}
					}
				this.set_u8("actionInterval", actionInterval);
					
			}
		this.set_u8("actionInterval", actionInterval);
		if (point.isKeyJustReleased(key_action1))
		{
			chargeTimer = 0;
			this.set_u8("chargeTimer", chargeTimer);
		}
		}
    } else {
		this.getCurrentScript().runFlags |= Script::tick_not_sleeping; 
    }			
}

f32 getAimAngle( CBlob@ this, CBlob@ holder )
{
 	Vec2f aimvector = holder.getAimPos() - this.getPosition();
    return holder.isFacingLeft() ? -aimvector.Angle()+180.0f : -aimvector.Angle();
}