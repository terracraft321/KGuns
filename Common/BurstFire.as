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
    
	this.set_bool("beginReload", false);
	this.set_bool("doReload", false);
	this.set_u8("actionInterval", 0);

	this.set_bool("isBursting", false);
	this.set_u8("burstCount", 0);
}

void onTick(CBlob@ this) {
	int burstCount;

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
						&& this.get_bool("beginReload") == false) {
						this.set_bool("beginReload", true);				
					}
				}

				uint8 actionInterval = this.get_u8("actionInterval");
				if (actionInterval > 0) {
					actionInterval--;			
				} else if(this.get_bool("isBursting") == true) {
					shoot(this, aimangle, holder);
					burstCount = this.get_u8("burstCount");
					burstCount++;
					this.set_u8("burstCount", burstCount);
					actionInterval = FIRE_INTERVAL;

					if(burstCount == MAX_BURST) {
						this.set_bool("isBursting", false);
						burstCount = 0;
						this.set_u8("burstCount", burstCount);
					}
				} else if(this.get_bool("beginReload") == true 
					&& this.get_u8("total") > 0) {
						actionInterval = RELOAD_TIME;
						this.set_bool("beginReload", false);
						this.set_bool("doReload", true);
				} else if(this.get_bool("doReload") == true) {
					reload(this, holder);
					playSound(this, RELOAD_SOUND);
					this.set_bool("doReload", false);
					print("reload complete");
				} else if (point.isKeyPressed(key_action1)) {
					if(this.get_u8("clip") > 0) {
						burstCount = this.get_u8("burstCount");
						burstCount++;
						if(this.get_u8("clip") < MAX_BURST) {
							burstCount += MAX_BURST - this.get_u8("clip");
						}
						shoot(this, aimangle, holder);
						actionInterval = FIRE_INTERVAL;
						this.set_bool("isBursting", true);
						
						this.set_u8("burstCount", burstCount);

					} else if(this.get_bool("isReloading") == false) {
						playSound(this, "EmptyClip.ogg");
						actionInterval = NO_AMMO_INTERVAL;
					} 
				}

				this.set_u8("actionInterval", actionInterval);	
			}
		}
    } else {
		this.getCurrentScript().runFlags |= Script::tick_not_sleeping; 
    }			
}







