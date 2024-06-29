import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextAlign;
import flixel.addons.display.FlxBackdrop;
import flixel.ui.FlxBar;
import funkin.backend.MusicBeatState;
MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;

// the stuffs.. idk
if (FlxG.save.data.fpschanges_toggle) window.frameRate = 24;
function onSubstateClose() if (FlxG.save.data.fpschanges_toggle) window.frameRate = 24;

var acc:FlxText;
var mis:FlxText;
var scr:FlxText;
var flipBar:FlxBar;
var newIcon1:HealthIcon;
var newIcon2:HealthIcon;
var fliprating:FlxSprite = new FlxSprite(0, 600);
fliprating.frames = Paths.getFrames("game/hud/flipnote/ratings");
fliprating.animation.addByPrefix("shit", "shit", 0, false);
fliprating.animation.addByPrefix("bad", "bad", 0, false);
fliprating.animation.addByPrefix("good", "good", 0, false);
fliprating.animation.addByPrefix("sick", "sick", 0, false);
fliprating.scale.set(1.5, 1.5);
var ratingTxtTimeout = 0;

function postCreate()
{
	FlxG.camera.bgColor = -1;
    GameOverSubstate.script = 'data/scripts/gameovers/hatena';

	PlayState.instance.accuracyTxt.visible = PlayState.instance.scoreTxt.visible = PlayState.instance.missesTxt.visible = PlayState.instance.comboGroup.visible = PlayState.instance.healthBar.visible = PlayState.instance.healthBarBG.visible = false; 		
	PlayState.instance.iconP1.visible = false;
	PlayState.instance.iconP2.visible = false;
	trace("bf x "+boyfriend.x+" y "+boyfriend.y);
	trace("dad x "+dad.x+" y "+dad.y);

    //the Bar of Health.
	flipBar = new FlxBar(0, 0, FlxBar.LEFT_TO_RIGHT, 444, 100, this, 'health', 0, 2);
    flipBar.createImageBar(Paths.image("game/hud/flipnote/barwhite"), Paths.image("game/hud/flipnote/barblue"));
    flipBar.cameras = [camHUD]; 
	flipBar.flipX = true;
	flipBar.scale.set(1.5, 1.5);
	flipBar.screenCenter(FlxAxes.X);
	flipBar.x -= 4;
	flipBar.y = FlxG.height - 70;
	flipBar.numDivisions = 876;
	add(flipBar);
    
	//the Eye Cons. XP
    newIcon1 = new HealthIcon(boyfriend != null ? boyfriend.getIcon() : "face", true);
	updateIcon(iconName = "lonewarrior");
    newIcon1.y = flipBar.y - (newIcon1.height / 2) + 16;
    newIcon1.antialiasing = false;
	newIcon1.cameras = [camHUD];
    insert(members.indexOf(flipBar) + 2, newIcon1);
	newIcon1.x = flipBar.x +480;

	fliprating.cameras = [camHUD];
	fliprating.screenCenter(FlxAxes.X);
	fliprating.alpha = 0.001;
	add(fliprating);

    //the Texts.
	acc = new FunkinText(15, 15, 0, "Accuracy: " + PlayState.instance.accuracy * 100 + "%", 30);
	scr = new FunkinText(15, 75, 0, "Score:" + PlayState.instance.songScore, 30);
	mis = new FunkinText(15, 45, 0, "Fails: " + PlayState.instance.misses, 30);
	com = new FunkinText(0, 690, 0, "000", 30);
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
	
	playerStrums.forEach(function(a)
		{
			FlxTween.cancelTweensOf(a);
			a.alpha = 1;
		});
}

function updateIcon(iconName:String) {
	remove(newIcon2);
	newIcon2 = new HealthIcon(iconName, false);
	newIcon2.y = flipBar.y - (newIcon2.height / 2) + 16;
	newIcon2.antialiasing = false;
	health -=0.00002;
	newIcon2.cameras = [camHUD];
	insert(members.indexOf(flipBar) + 2, newIcon2);
    newIcon2.x = flipBar.x +480;
    newIcon2.x = flipBar.x -180;
}

function onNoteCreation(event) {
	if (event.note.strumLine == cpuStrums) return;

	event.cancel();

	var note = event.note;
	if (event.note.isSustainNote) {
		note.loadGraphic(Paths.image('game/notes/flipnote/arrowEnds'), true, 7, 6);
		note.animation.add("hold", [event.strumID]);
		note.animation.add("holdend", [4 + event.strumID]);
	} else {
		note.loadGraphic(Paths.image('game/notes/flipnote/arrows'), true, 17, 17);
		note.animation.add("scroll", [4 + event.strumID]);
	}
	note.scale.set(4.5, 4.5);
	note.updateHitbox();
}
function onStrumCreation(event) {
	if (event.player == 0) return;

	event.cancel();

	var strum = event.strum;
	strum.loadGraphic(Paths.image('game/notes/flipnote/arrows'), true, 17, 17);
	strum.animation.add("static", [event.strumID]);
	strum.animation.add("pressed", [4 + event.strumID, 8 + event.strumID], 12, false);
	strum.animation.add("confirm", [12 + event.strumID, 16 + event.strumID], 24, false);

	strum.scale.set(4.5, 4.5);
	strum.updateHitbox();
}
function onPostNoteCreation(event) {
    if (event.note.isSustainNote) event.note.alpha = 1;
}

//The Ratings System.
function onPlayerHit(event:NoteHitEvent)
	{
		
		if (!event.note.isSustainNote)
		{
			ratingTxtTimeout = 4;
			switch (event.rating)
			{
				case 'sick':
					fliprating.animation.play('sick');
				case 'good':
					fliprating.animation.play('good');
				case 'bad':
					fliprating.animation.play('bad');
				case 'shit':
					fliprating.animation.play('shit');
			}
			
			if (PlayState.instance.combo%2==0) fliprating.angle = -5;
			else if (PlayState.instance.combo%2 == 1) fliprating.angle = 5;
			fliprating.alpha = 1;
			com.alpha = 1;
	}
}
function onPlayerMiss(event) fliprating.alpha = 0.001;

function dragonflies() {
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

function bombWalk() {
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
function plantWalk() {
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

function postUpdate(elapsed)
{
	flipBar.value = health;
	newIcon1.health = healthBar.percent / 100;
    newIcon2.health = 1 - (healthBar.percent / 100);
	camZooming = false;
	if (acc != null)
		acc.text = "Accuracy: " + (PlayState.instance.accuracy != -1 ? (FlxMath.roundDecimal(PlayState.instance.accuracy * 100, 2)) : "--") + "%";
	if (scr != null)
		scr.text = "Score: " + PlayState.instance.songScore;
	if (mis != null)
		mis.text = "Fails: " + PlayState.instance.misses;
	if (com != null)
	    com.text = PlayState.instance.combo;
	switch (com.text.length)
	{
		case 1:
			com.text = "00" + com.text;
		case 2:
			com.text = "0" + com.text;
	}
}

function beatHit(beat)
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
		} //

		switch (beat)
		{
			case 36: flag.visible = true;
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
				strumLines.members[1].characters[0].x = 720;
				strumLines.members[1].characters[0].y = 120;
			case 414: FlxTween.tween(boos, {alpha: 1}, 0.6);
			case 448:
				FlxG.camera.bgColor = 0;
				gizmowall.visible = false;
				gizmofloor.visible = false;
				boos.visible = false;
				piano.visible = false;
			case 450:
				spotlight.visible = true;
				strumLines.members[1].characters[0].x = 760;
				strumLines.members[1].characters[0].y = 100;
			case 548: spotlight.visible = false;
			case 552:
				FlxG.camera.bgColor = -1;
				clouds.visible = true;
				iphonebuildings.visible = true;
				iphonestore.visible = true;
				iphoneroad.visible = true;
				bomb.visible = true;
				plant.visible = true;
				strumLines.members[1].characters[0].x = 840;
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
				for (i in [newIcon1, newIcon2, flipBar, fliprating, com, scr, acc, mis]) i.visible = false;
			case 681:
				strumLines.members[1].characters[0].x = 355;
				strumLines.members[1].characters[0].y = -50;
			case 752:
				FlxG.camera.bgColor = -1;
				strumLines.members[1].characters[0].x = 760;
				strumLines.members[1].characters[0].y = 100;
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
			   for (i in [newIcon1, newIcon2, flipBar fliprating, com, scr, acc, mis]) i.visible = true;
			case 820: 
				dRagon.visible = false;
				sun.visible = false;
				stars.visible = true;
			case 884: flag.visible = false;		
	    }
	}
var stage:Stage = null;
function create() {
	stage = loadStage('farm');
}
function update(elapsed) {
	stage.update(elapsed);
}
function beatHit(curBeat) {
	stage.onBeat();
} 