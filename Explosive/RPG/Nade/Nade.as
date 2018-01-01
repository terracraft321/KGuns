const u32 FUSE = 120;

void onInit(CBlob@ this) {
    this.getShape().getVars().waterDragScale = 8.0f;
    
    this.set_f32("explosive_radius", 18.0f);
    this.set_f32("explosive_damage", 4.0f);
    this.set_f32("map_damage_radius", 36.0f);
    this.set_f32("map_damage_ratio", 0.5f);
    this.set_bool("map_damage_raycast", true);

	this.getShape().getConsts().collideWhenAttached = true;
}

void boom(CBlob@ this) {
	this.Tag("exploding");
	this.server_SetHealth(-1.0f);
	this.getSprite().Gib();
	this.server_Die();
}

void onCollision(CBlob@ this, CBlob@ blob, bool solid) {
	if(blob !is null && this.getTeamNum() != blob.getTeamNum()) {
		if(blob.hasTag("door") 
		   || blob.getMass() > 500.0f 
		   || blob.hasTag("flesh") 
		   || blob.getShape().vellen > 5.0f 
		) {
			boom(this);
		}		
	}
}

void onTick(CBlob@ this) {
	f32 angle = (this.getVelocity()).Angle();
	this.setAngleDegrees(-angle);
	CShape@ shape = this.getShape();

	if(this.getTickSinceCreated() >= FUSE) {
		boom(this);
	} else if(this.isOnGround() 
		|| this.isOnWall()
		|| this.isOnCeiling()
	) {

	boom(this);
	}
}