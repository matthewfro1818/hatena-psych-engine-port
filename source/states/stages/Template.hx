package states.stages;

import states.stages.objects.*;

class Template extends BaseStage
{
    var acc:FlxText;
	var scr:FlxText;
	var mis:FlxText;

	var color:FlxColor;

	var instance:Int;
	var camZooming:Int;
	var stage:Int;

	var newIcon2:HealthIcon;
	var newIcon1:HealthIcon;
	var iconName:HealthIcon;

	var sun:FlxSprite;
	var bomb:FlxSprite;
	var plant:FlxSprite;
	var mountainsfar:FlxSprite;
	var mountainsnear:FlxSprite;
	var ground:FlxSprite;
	var dRagon:FlxSprite;
	var flag:FlxSprite;
	var	gizmowall:FlxSprite;
	var	gizmofloor:FlxSprite;
	var	boos:FlxSprite;
	var piano:FlxSprite;
	var spotlight:FlxSprite;
	var	stars:FlxSprite;
	var	iphonebuildings:FlxSprite;
	var	iphonestore:FlxSprite;
	var	iphoneroad:FlxSprite;
	
	var dragonChance:Int;
	var fgCharacters:Int;
	var ratingTxtTimeout:Int;

	var card:FlxSprite;

	var BG:FlxSprite;

	var i = new FlxText();

    var cutscene:FlxVideoSprite;


	override function create()
	{

	camGame.followLerp = 0;

	color.iTime = 0;
	color.sat = 50;
	color.val = 0.1;
	
	cutscene = new FlxVideoSprite(0, 0);
    cutscene.load(Paths.video("hatena-cutscene"));
    cutscene.visible = false;

	BG = new FlxSprite();
    BG.makeGraphic(1750, 1350, FlxColor.WHITE);
    BG.scrollFactor.set(0, 0);
    BG.screenCenter();	
	add(BG); 

	boyfriend.color = FlxColor.BLACK;
	dad.color = FlxColor.BLACK;
	boyfriend.alpha = 0.001;
	dad.alpha = 0.001;
	camHUD.visible = false;

	BG.alpha = 0.001;

	FlxG.camera.bgColor = -1;
    GameOverSubstate.script = 'data/scripts/gameovers/hatena';

    //the Bar of Health.
	var healthBar = new FlxBar(0, 0, FlxBar.LEFT_TO_RIGHT, 444, 100, this, 'health', 0, 2);
    healthBar.createImageBar(Paths.image("game/hud/flipnote/barwhite"), Paths.image("game/hud/flipnote/barblue"));
    healthBar.cameras = [camHUD]; 
	healthBar.flipX = true;
	healthBar.scale.set(1.5, 1.5);
	healthBar.screenCenter(FlxAxes.X);
	healthBar.x -= 4;
	healthBar.y = FlxG.height - 70;
	healthBar.numDivisions = 876;
	add(healthBar);
    
	//the Eye Cons. XP
    var newIcon1 = new HealthIcon(boyfriend != null ? boyfriend.getIcon() : "face", true);
	updateIcon(iconName = "lonewarrior");
    newIcon1.y = healthBar.y - (newIcon1.height / 2) + 16;
    newIcon1.antialiasing = false;
	newIcon1.cameras = [camHUD];
    insert(members.indexOf(healthBar) + 2, newIcon1);
	newIcon1.x = healthBar.x +480;

	for (i in [scr, mis, acc, com]) {
		i.setFormat(Paths.font('DSbios.ttf'), 32, 0xFF000000, (i == com ? FlxTextAlign.CENTER : FlxTextAlign.LEFT), FlxTextBorderStyle.OUTLINE, 0xFFFFFFFF);
		i.borderSize = 2; 
		i.cameras = [camHUD];
		add(i);
	}
    
	dRagon.alpha = 0.001;
	bomb.alpha = 0.001;
	plant.alpha = 0.001;

	var clouds = new FlxBackdrop(Paths.image("stages/flipnote/iphoneclouds"), FlxAxes.X);
	clouds.velocity.set(40, 0);
	clouds.scrollFactor.set(0.3, 0.3);
	clouds.y = -50;
	clouds.scale.set(5, 5);
	insert(members.indexOf(iphonebuildings), clouds); 

	var stars = new FlxBackdrop(Paths.image("stages/flipnote/nightbg"), FlxAxes.X);
	stars.velocity.set(90, 0);
	stars.scale.set(5, 5);
	insert(members.indexOf(mountainsfar), stars); 

	for (i in [gizmowall, gizmofloor, boos, piano, spotlight, clouds, iphonebuildings, iphonestore, iphoneroad, bomb, plant, stars, flag])
	i.visible = false;

	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
	}

	override function update(elapsed:Float)
	{
		// Code here
	}

	
	override function countdownTick(count:BaseStage.Countdown, num:Int)
	{
		switch(count)
		{
			case THREE: //num 0
			case TWO: //num 1
			case ONE: //num 2
			case GO: //num 3
			case START: //num 4
		}
	}

	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit()
	{
    	case 'hatena':
	    	switch (curStep)
	    	{
			case 16: FlxTween.tween(card, {alpha: 0.001}, 0.8);
			case 80: boyfriend.alpha = 0.25; case 88: boyfriend.alpha = 0.5; case 96: boyfriend.alpha = 0.75; case 104: boyfriend.alpha = 1; 
			case 112: dad.alpha = 0.25; case 120: dad.alpha = 0.5; case 128: dad.alpha = 0.75; case 136: dad.alpha = 1; 
			case 144: 
				card.animation.stop();
				card.visible = false;
			    BG.alpha = 0.001;
				boyfriend.color = FlxColor.WHITE;
				dad.color = FlxColor.WHITE;
			case 208: camHUD.visible = true;
			case 464:
				BG.color = FlxColor.BLACK;
			    FlxTween.tween(BG, {alpha: 0.9}, 1.2, {ease: FlxEase.expoOut});
			case 480: BG.alpha = 0.001;
			case 864:
				BG.color = FlxColor.WHITE;
			    FlxTween.tween(BG, {alpha: 1}, 0.4, {ease: FlxEase.expoOut});
			    boyfriend.color = FlxColor.BLACK;
				dad.color = FlxColor.BLACK;
			case 992:
			    BG.color = FlxColor.BLACK;
				boyfriend.color = FlxColor.WHITE;
				dad.color = FlxColor.WHITE;
			case 1024:
				//PART 2
				BG.alpha = 0.5;
			case 1152: BG.alpha = 0.001;
			case 1394: FlxTween.tween(BG, {alpha: 0.8}, 0.1);
			case 1408: BG.alpha = 0.001;
			case 1656: BG.alpha = 0.25;
			case 1660: BG.alpha = 0.5;
			case 1792:
			    boyfriend.visible = false;
			    BG.alpha = 1;
			case 1806:
				//PART 3
				defaultCamZoom = 0.95;
				FlxG.camera.zoom = defaultCamZoom;
			    //boyfriend.shader = color;
			    BG.alpha = 0.001;
			    insert(members.indexOf(dad), BG);
			case 1807: BG.alpha = 1;
			case 1808: BG.alpha = 0.001;
			case 2194: FlxTween.tween(camGame, {alpha: 0.001}, 0.4);
			case 2208:
				//PART 4
				BG.alpha = 0.001;
				defaultCamZoom = 0.55;
				FlxG.camera.zoom = defaultCamZoom;
			    camGame.alpha = 1;
				boyfriend.visible = true;
			case 2592 | 2608 | 2624 | 2640:
				defaultCamZoom += 0.04;
				FlxG.camera.zoom = defaultCamZoom;
			case 2712: BG.alpha = 0.5;
			case 2716:
				BG.alpha = 0.8;
			    defaultCamZoom = 0.7;
				FlxG.camera.zoom = defaultCamZoom;
			case 2720:
				//PART 5
			    camGame.visible = false;
				BG.alpha = 0.001;
				BG.color = FlxColor.WHITE;
				defaultCamZoom = 0.95;
				FlxG.camera.zoom = defaultCamZoom;
			case 2736:
			    //boyfriend.shader = null;
				camGame.alpha = 1;
				camGame.fade(FlxColor.BLACK, 9, true);
				camGame.visible = true;
			case 2910:
				FlxTween.tween(camGame.scroll, {x: -760}, 8, {ease: FlxEase.sineInOut});
			case 3008:
				camHUD.alpha = 0.001;
			case 3024:
				//PART 6
				FlxG.camera.zoom = defaultCamZoom;
				boyfriend.visible = false;
				cutscene.play();
				cutscene.visible = true;
			case 3142:
				//FlxTween.tween(camHUD, {alpha: 1}, 0.2);
				camHUD.alpha = 1;
			case 3152: 
				remove(BG);
				insert(members.indexOf(stage.getSprite("sun")), BG);
				BG.color = FlxColor.BLACK;
				boyfriend.visible = true;
				cutscene.visible = false;
				remove(cutscene);
			case 3272:
			    flashing = false;
				FlxTween.cancelTweensOf(BG);
				BG.alpha = 0.001;
				FlxTween.tween(BG, {alpha: 1}, 0.7, {ease: FlxEase.sineOut});
			case 3280: 
				remove(BG);
				insert(members.indexOf(dad), BG);
				BG.alpha = 0.001;
			case 3472 | 3488 | 3504 | 3520:
				defaultCamZoom += 0.04;
				FlxG.camera.zoom = defaultCamZoom;
				BG.alpha += 0.16;
			case 3536:
				BG.alpha = 1;
				BG.color = FlxColor.WHITE;
			    boyfriend.color = FlxColor.BLACK;
				dad.color = FlxColor.BLACK;
			case 3552:
				defaultCamZoom = 0.65;
				FlxG.camera.zoom = defaultCamZoom;
			    boyfriend.visible = false;
				dad.visible = false;
				camHUD.visible = false;
				card.animation.play('end');
				card.alpha = 1;
				card.visible = true;
	    	}
	}

	function updateIcon(iconName:String) {
    	remove(newIcon2);
    	newIcon2 = new HealthIcon(iconName, false);
    	newIcon2.y = healthBar.y - (newIcon2.height / 2) + 16;
    	newIcon2.antialiasing = false;
    	health -=0.00002;
    	newIcon2.cameras = [camHUD];
    	insert(members.indexOf(healthBar) + 2, newIcon2);
        newIcon2.x = healthBar.x +480;
        newIcon2.x = healthBar.x -180;
    }
	

    override function dragonflies() {
   	if (dRagon.alpha == 1) return;
    	dRagon.x = 1500;
	    dRagon.alpha = 1;
    	trace("haiii!! :3 -dragon");
    	FlxTween.tween(dRagon, {x: -600}, 12, {
	    	onComplete: function()
		    	{
	     			dRagon.alpha = 0.001;
	     		}
    		});
    }
    override function bombWalk() {
	if (bomb.alpha == 1) return;
    	bomb.alpha = 1;
    	bomb.flipX = FlxG.random.bool();
        bomb.x = (bomb.flipX ? -1650 : 1200);
	    FlxTween.tween(bomb, {x: (bomb.flipX ? 1100 : -1650)}, 6, {
		onComplete: function()
			{
				bomb.alpha = 0.001;
			}
		});
	}
    
    override function plantWalk() {
	if (plant.alpha == 1) return;
    	plant.alpha = 1;
    	plant.flipX = FlxG.random.bool();
        plant.x = (plant.flipX ? -1650 : 1200);
    	FlxTween.tween(plant, {x: (plant.flipX ? 1100 : -1650)}, 6, {
		onComplete: function()
			{
				plant.alpha = 0.001;
			}
		});
    }
	override function beatHit()
	{
		/*for (i in [newIcon1, newIcon2]){
			i.scale.set(1.2, 1.2);
			FlxTween.tween(i.scale, {x: 1, y: 1}, (0.8 * (1 / (Conductor.bpm / 60))));
		}
		*/
		
        if (beat % 2 == 0) boos.animation.play('bop', true);
		dragonChance = FlxG.random.int(1, 60);
		fgCharacters = FlxG.random.int(1, 20);
		//trace(dragonChance);
		if (dragonChance == 1) dragonflies();
		if (fgCharacters == 1) bombWalk();
		if (fgCharacters == 2) plantWalk();
		if (ratingTxtTimeout > 0)
			ratingTxtTimeout -= 1;
	
		if (ratingTxtTimeout == 0)
		{
			fliprating.alpha = 0.001;
			com.alpha = 0.001;
		}

    	case 'hatena':
	    	switch (urBeat)
		    {
			case 36:
				sun.visible = true;
				mountainsfar.visible = true;
				mountainsnear.visible = true;
				ground.visible = true;
				dRagon.visible = true;
			    flag.visible = true;
				gizmowall.visible = false;
				gizmofloor.visible = false;
				boos.visible = false;
				piano.visible = false;
				spotlight.visible = false;
			case 216: FlxTween.tween(flag, {alpha: 0.001}, 0.4, {ease: FlxEase.expoOut});
			case 256:
				sun.visible = false;
				mountainsfar.visible = false;
				mountainsnear.visible = false;
				ground.visible = false;
				flag.visible = false;
				dRagon.visible = false;
				gizmowall.visible = true;
				gizmofloor.visible = true;
				boos.alpha = 0.001;
				boos.visible = true;
				piano.visible = true;
			case 414: FlxTween.tween(boos, {alpha: 1}, 0.6);
			case 448:
				FlxG.camera.bgColor = 0;
				gizmowall.visible = false;
				gizmofloor.visible = false;
				boos.visible = false;
				piano.visible = false;
			case 450:
				spotlight.visible = true;
			case 548: spotlight.visible = false;
			case 552:
				FlxG.camera.bgColor = -1;
				clouds.visible = true;
				iphonebuildings.visible = true;
				iphonestore.visible = true;
				iphoneroad.visible = true;
				bomb.visible = true;
				plant.visible = true;
				trace(camHUD.visible);
				trace(camHUD.alpha);
			case 680:
				clouds.visible = false;
				iphonebuildings.visible = false;
				iphonestore.visible = false;
				iphoneroad.visible = false;
				bomb.visible = false;
				plant.visible = false;
				spotlight.visible = true;
				FlxG.camera.bgColor = 0;
				dad.x = -680;
				dad.y = -50;
				for (i in [newIcon1, newIcon2, healthBar, fliprating, com, scr, acc, mis]) i.visible = false;
			case 752:
				FlxG.camera.bgColor = -1;
				dad.x = -160;
				dad.y = 100;
				spotlight.visible = false;
			case 788:
			   sun.visible = true;
	           mountainsfar.visible = true;
	           mountainsnear.visible = true;
	           ground.visible = true;
	           flag.alpha = 1;
			   flag.visible = true;
	           dRagon.visible = true;
			   for (i in [newIcon1, newIcon2, healthBar, fliprating, com, scr, acc, mis]) i.visible = true;
			case 820: 
				dRagon.visible = false;
				sun.visible = false;
				stars.visible = true;
			case 884: flag.visible = false;		
	    }
	}
	override function sectionHit()
	{
		// Code here
	}

	// Substates for pausing/resuming tweens and timers
	override function closeSubState()
	{
		if(paused)
		{
			//timer.active = true;
			//tween.active = true;
		}
	}

	override function openSubState(SubState:flixel.FlxSubState)
	{
		if(paused)
		{
			//timer.active = false;
			//tween.active = false;
		}
	}

	// For events
	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "My Event":
		}
	}
	override function eventPushed(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events that doesn't need different assets based on its values
		switch(event.event)
		{
			case "My Event":
				//precacheImage('myImage') //preloads images/myImage.png
				//precacheSound('mySound') //preloads sounds/mySound.ogg
				//precacheMusic('myMusic') //preloads music/myMusic.ogg
		}
	}
	override function eventPushedUnique(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events where its values affect what assets should be preloaded
		switch(event.event)
		{
			case "My Event":
				switch(event.value1)
				{
					// If value 1 is "blah blah", it will preload these assets:
					case 'blah blah':
						//precacheImage('myImageOne') //preloads images/myImageOne.png
						//precacheSound('mySoundOne') //preloads sounds/mySoundOne.ogg
						//precacheMusic('myMusicOne') //preloads music/myMusicOne.ogg

					// If value 1 is "coolswag", it will preload these assets:
					case 'coolswag':
						//precacheImage('myImageTwo') //preloads images/myImageTwo.png
						//precacheSound('mySoundTwo') //preloads sounds/mySoundTwo.ogg
						//precacheMusic('myMusicTwo') //preloads music/myMusicTwo.ogg
					
					// If value 1 is not "blah blah" or "coolswag", it will preload these assets:
					default:
						//precacheImage('myImageThree') //preloads images/myImageThree.png
						//precacheSound('mySoundThree') //preloads sounds/mySoundThree.ogg
						//precacheMusic('myMusicThree') //preloads music/myMusicThree.ogg
				}
		}
	}
}