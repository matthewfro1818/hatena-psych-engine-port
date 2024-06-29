package states.stages;

import hxvlc.flixel.FlxVideoSprite;
import flixel.text.FlxText.FlxTextAlign;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.text.FlxText;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxAxes;
import flixel.ui.FlxBar;
import backend.MusicBeatState;
import objects.Note;
import substates.GameOverSubstate;

class StickStage extends BaseStage
{
    var acc:FlxText;
    var mis:FlxText;
    var scr:FlxText;
	var com:FlxText;
	
	var strumLines:Note;

    var flipBar:FlxBar;

    var ratingTxtTimeout = 0;
	
	var flashing = false;

	var color:FlxColor;

	var instance:Int;

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

	var card:FlxSprite;

	var i:FlxText;

    var cutscene:FlxVideoSprite;

	var accuracyTxt:FlxText;
	var scoreTxt:FlxText;
	var missesTxt:FlxText;
	
	var iconName:String;
	
	var healthBar:FlxBar;

	var BG:FlxSprite;


function postCreate()
{
	camGame.followLerp = 0;

	cutscene = new FlxVideoSprite(0, 0);
    cutscene.load(Paths.video("hatena-cutscene"));
    cutscene.visible = false;

	camHUD.visible = false;

	FlxG.camera.bgColor = -1;

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

	FlxG.camera.bgColor = -1;

		scoreTxt = new FlxText(healthBar.x + 50, healthBar.y + 30, Std.int(healthBar.width - 100), "Score:0", 16);
		missesTxt = new FlxText(healthBar.x + 50, healthBar.y + 30, Std.int(healthBar.width - 100), "Misses:0", 16);
		accuracyTxt = new FlxText(healthBar.x + 50, healthBar.y + 30, Std.int(healthBar.width - 100), "Accuracy:-% (N/A)", 16);

		for(text in [scoreTxt, missesTxt, accuracyTxt]) {
			text.scrollFactor.set();
			add(text);
		}
		scoreTxt.alignment = RIGHT;
		missesTxt.alignment = CENTER;
		accuracyTxt.alignment = LEFT;
    	accuracyTxt.visible = scoreTxt.visible = missesTxt.visible = PlayState.instance.healthBar.visible = PlayState.instance.healthBar.visible = false; 		
	
	PlayState.instance.iconP1.visible = false;
	PlayState.instance.iconP2.visible = false;
	trace("bf x "+boyfriend.x+" y "+boyfriend.y);
	trace("dad x "+dad.x+" y "+dad.y);

    //the Bar of Health.
	flipBar = new FlxBar(0, 0, 444, 100, this, 0, 2);
    flipBar.createImageBar(Paths.image("game/hud/flipnote/barwhite"), Paths.image("game/hud/flipnote/barblue"));
    flipBar.cameras = [camHUD]; 
	flipBar.flipX = true;
	flipBar.scale.set(1.5, 1.5);
	flipBar.screenCenter(FlxAxes.X);
	flipBar.x -= 4;
	flipBar.y = FlxG.height - 70;
	flipBar.numDivisions = 876;
	add(flipBar);

    //the Texts.
	scr = new FlxText(15, 75, 0, "Score:" + PlayState.instance.songScore, 30);
	mis = new FlxText(15, 45, 0, "Fails: " + PlayState.instance.songMisses, 30);
	com = new FlxText(0, 690, 0, "000", 30);
	com.screenCenter(FlxAxes.X);
	com.alpha = 0.001;

	for (i in [scr, mis, acc, com]) {
		i.setFormat(Paths.font('DSbios.ttf'), 32, 0xFF000000, (i == com ? FlxTextAlign.CENTER : FlxTextAlign.LEFT), FlxTextBorderStyle.OUTLINE, 0xFFFFFFFF);
		i.borderSize = 2; 
		i.cameras = [camHUD];
		add(i);
	}
    
	dRagon.alpha = 0.001;
	bomb.alpha = 0.001;
	plant.alpha = 0.001;

	clouds = new FlxBackdrop(Paths.image("stages/flipnote/iphoneclouds"), FlxAxes.X);
	clouds.velocity.set(40, 0);
	clouds.scrollFactor.set(0.3, 0.3);
	clouds.y = -50;
	clouds.scale.set(5, 5);
	insert(members.indexOf(iphonebuildings), clouds); 

	stars = new FlxBackdrop(Paths.image("stages/flipnote/nightbg"), FlxAxes.X);
	stars.velocity.set(90, 0);
	stars.scale.set(5, 5);
	insert(members.indexOf(mountainsfar), stars); 

	for (i in [gizmowall, gizmofloor, boos, piano, spotlight, clouds, iphonebuildings, iphonestore, iphoneroad, bomb, plant, stars, flag])
	i.visible = false;
}

function onNoteCreation(Note) {
	var note = Note.note;
	if (Note.note.isSustainNote) {
		note.loadGraphic(Paths.image('game/notes/flipnote/arrowEnds'), true, 7, 6);
		note.animation.add("hold", [Note.strumID]);
		note.animation.add("holdend", [4 + Note.strumID]);
	} else {
		note.loadGraphic(Paths.image('game/notes/flipnote/arrows'), true, 17, 17);
		note.animation.add("scroll", [4 + Note.strumID]);
	}
	note.scale.set(4.5, 4.5);
	note.updateHitbox();
}
function onStrumCreation(Note) {
	if (Note.player == 0) return;

	Note.cancel();

	var strum = Note.strum;
	strum.loadGraphic(Paths.image('game/notes/flipnote/arrows'), true, 17, 17);
	strum.animation.add("static", [Note.strumID]);

	strum.scale.set(4.5, 4.5);
	strum.updateHitbox();
}
function onPostNoteCreation(Note) {
    if (Note.note.isSustainNote) Note.note.alpha = 1;
}
function postUpdate(elapsed)
{
	if (scr != null)
		scr.text = "Score: " + PlayState.instance.songScore;
	if (mis != null)
		mis.text = "Fails: " + PlayState.instance.songMisses;
	switch (com.text.length)
	{
		case 1:
			com.text = "00" + com.text;
		case 2:
			com.text = "0" + com.text;
	}
}

override function beatHit()
	{
		switch (curBeat)
		{
			case 552:
				trace(camHUD.visible);
				trace(camHUD.alpha);
			case 680:
				dad.x = -680;
				dad.y = -50;
			case 752:
				dad.x = -160;
				dad.y = 100;
		}
	}
override function stepHit()
	{
		switch (curStep)
		{
			case 80: boyfriend.alpha = 0.25; case 88: boyfriend.alpha = 0.5; case 96: boyfriend.alpha = 0.75; case 104: boyfriend.alpha = 1; 
			case 112: dad.alpha = 0.25; case 120: dad.alpha = 0.5; case 128: dad.alpha = 0.75; case 136: dad.alpha = 1;
			case 1806:
				//PART 3
				defaultCamZoom = 0.95;
				FlxG.camera.zoom = defaultCamZoom;
			    insert(members.indexOf(dad), BG);
			case 2208:
				//PART 4
				defaultCamZoom = 0.55;
				FlxG.camera.zoom = defaultCamZoom;
			    camGame.alpha = 1;
			case 2592 | 2608 | 2624 | 2640:
				defaultCamZoom += 0.04;
				FlxG.camera.zoom = defaultCamZoom;
			case 2716:
			    defaultCamZoom = 0.7;
				FlxG.camera.zoom = defaultCamZoom;
			case 2720:
				//PART 5
				defaultCamZoom = 0.95;
				FlxG.camera.zoom = defaultCamZoom;
			case 2736:
				camGame.alpha = 1;
			case 3008:
				camHUD.alpha = 0.001;
			case 3024:
				//PART 6
				FlxG.camera.zoom = defaultCamZoom;
				cutscene.play();
			case 3152:
				remove(cutscene);
			case 3280:
				insert(members.indexOf(dad), BG);
			case 3472 | 3488 | 3504 | 3520:
				defaultCamZoom += 0.04;
				FlxG.camera.zoom = defaultCamZoom;
			case 3552:
				defaultCamZoom = 0.65;
				FlxG.camera.zoom = defaultCamZoom;
		
		}
	}
function whiteFlash() {
	if (!FlxG.save.data.epilepsy_toggle)
	{
		FlxTween.cancelTweensOf(BG);
		BG.alpha = 1;
	}
}
}