package states.stages;

import hxvlc.flixel.FlxVideoSprite;
import flixel.text.FlxText.FlxTextAlign;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxAxes;
import flixel.ui.FlxBar;
import backend.MusicBeatState;
import objects.HealthIcon;
import backend.BaseStage;
import substates.GameOverSubstate;

class stickstage extends BaseStage
{
	var com:FlxText;
    var acc:FlxText;
	var scr:FlxText;
	var mis:FlxText;

	var color:FlxColor;

	var instance:Int;
	var camZooming:Int;

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
	var	iphonebuildings:FlxSprite;
	var	iphonestore:FlxSprite;
	var	iphoneroad:FlxSprite;

	var stars:FlxBackdrop;
	var clouds:FlxBackdrop;

	var dragonChance:Int;
	var fgCharacters:Int;
	var ratingTxtTimeout:Int;

	var card:FlxSprite;

	var BG:FlxSprite;

	var i = new FlxText();

    var cutscene:FlxVideoSprite;

	public var healthBar:FlxBar;

	override function create()
	{

	camGame.followLerp = 0;

	cutscene = new FlxVideoSprite(0, 0);
    cutscene.load(Paths.video("hatena-cutscene"));
    cutscene.visible = false;

	BG = new FlxSprite();
    BG.makeGraphic(1750, 1350, FlxColor.WHITE);
    BG.scrollFactor.set(0, 0);
    BG.screenCenter();	
	add(BG); 

	camHUD.visible = false;

	BG.alpha = 0.001;

	FlxG.camera.bgColor = -1;

    //the Bar of Health.
	var healthBar = new FlxBar(0, 0, 444, 100, this, 'health', 0, 2);
    healthBar.createImageBar(Paths.image("game/hud/flipnote/barwhite"), Paths.image("game/hud/flipnote/barblue"));
    healthBar.cameras = [camHUD]; 
	healthBar.flipX = true;
	healthBar.scale.set(1.5, 1.5);
	healthBar.screenCenter(FlxAxes.X);
	healthBar.x -= 4;
	healthBar.y = FlxG.height - 70;
	healthBar.numDivisions = 876;
	add(healthBar);

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

	}
	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit()
	{
	    switch (curStep)
	   	{
			case 80: boyfriend.alpha = 0.25;
			case 88: boyfriend.alpha = 0.5;
			case 96: boyfriend.alpha = 0.75;
			case 104: boyfriend.alpha = 1; 
			case 112: dad.alpha = 0.25; 
			case 120: dad.alpha = 0.5;
			case 128: dad.alpha = 0.75;
			case 136: dad.alpha = 1; 
			case 144:
			    BG.alpha = 0.001;
				boyfriend.color = FlxColor.WHITE;
				dad.color = FlxColor.WHITE;
			case 208: camHUD.visible = true;
			case 464:
				BG.color = FlxColor.BLACK;
			case 480: BG.alpha = 0.001;
			case 864:
				BG.color = FlxColor.WHITE;
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
				BG.color = FlxColor.BLACK;
				boyfriend.visible = true;
				cutscene.visible = false;
				remove(cutscene);
			case 3272:
				BG.alpha = 0.001;
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
	override function beatHit()
	{
	   	switch (curBeat)
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
			case 820: 
				dRagon.visible = false;
				sun.visible = false;
				stars.visible = true;
			case 884: flag.visible = false;		
		}
	}
}