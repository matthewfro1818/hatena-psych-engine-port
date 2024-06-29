import hxvlc.flixel.FlxVideoSprite;

var devMode = false;
if (whiteTransition) whiteTransition = false;

var card:FlxSprite = new FlxSprite(-350, -80);
card.frames = Paths.getFrames("stages/flipnote/hatenaCards");
card.animation.addByPrefix("intro", "intro", 12, true);
card.animation.addByPrefix("end", "end", 12, true);
card.scale.set(2.1, 2.1);
card.scrollFactor.set(0, 0);
card.screenCenter();


var color:CustomShader = new CustomShader('rainbow');
var BG = new FlxSprite();
BG.makeGraphic(1750, 1350, FlxColor.WHITE);
BG.scrollFactor.set(0, 0);
BG.screenCenter();
var flashing = false;

if(FlxG.save.data.midsongvids_toggle) {
var cutscene = new FlxVideoSprite(0, 0);
cutscene.load(Assets.getPath(Paths.video("hatena-cutscene")));
cutscene.visible = false;
}

//Hatena Running Man
var willRunningMan = FlxG.random.int(1, 69);
var whenRunningMan = FlxG.random.int(1, 3552);
var runningManofHatena:FlxSprite = new FlxSprite(1000, -300);
if (willRunningMan == 1) {
runningManofHatena.frames = Paths.getFrames("stages/flipnote/man");
runningManofHatena.animation.addByPrefix("run", "man", 24, true);
runningManofHatena.scale.set(0.6, 0.6);
runningManofHatena.updateHitbox();
trace("Hatena Running Man. "+whenRunningMan+". Are you ready?");
}

function create() {
	if(FlxG.save.data.midsongvids_toggle) {
	cutscene.bitmap.onFormatSetup.add(function()
		{
			cutscene.cameras = [camGame];
			cutscene.scale.set(1.5, 1.5);
			cutscene.scrollFactor.set(0, 0);
			cutscene.antialiasing = false;
			cutscene.screenCenter();
			//cutscene.updateHitbox();
		});
		insert(members.indexOf(boyfriend)+3, cutscene);
	}
}
function postCreate()
{
	strumLines.members[2].characters[0].visible = false;
	strumLines.members[3].characters[0].visible = false;
	camGame.followLerp = 0;
	center();
    
	color.iTime = 0;
	color.sat = 50;
	//color.val = 0.1;
	
	insert(members.indexOf(dad), BG);
	
	add(BG);
	card.animation.play('intro');
	card.visible = false;
	add(card);

	if (!devMode) {
	boyfriend.color = FlxColor.BLACK;
	dad.color = FlxColor.BLACK;
	boyfriend.alpha = 0.001;
	dad.alpha = 0.001;
	camHUD.visible = false;
	}
	if (devMode) BG.alpha = 0.001;

	if (willRunningMan == 1) {
	runningManofHatena.cameras = [camHUD2];
	add(runningManofHatena);
	runningManofHatena.animation.play('run');
	}
	
}

function center() {
	camGame.focusOn(FlxPoint.weak(540, 460));
	//FlxG.camera.targetOffset.set(-390, 180);
	if (strumLines.members[2].characters[0].visible && strumLines.members[3].characters[0].visible) defaultCamZoom = 0.55; else defaultCamZoom = 0.65;
	FlxG.camera.zoom = defaultCamZoom;
	//camGame.snapToTarget();
}
function guy() {
	if (strumLines.members[2].characters[0].visible && !strumLines.members[3].characters[0].visible) 
		camGame.focusOn(FlxPoint.weak(dad.cameraOffset.x + 380, dad.cameraOffset.y + 440)); else 
		camGame.focusOn(FlxPoint.weak(dad.cameraOffset.x + 350, dad.cameraOffset.y + 500));
	//FlxG.camera.targetOffset.set(250, 260);
	defaultCamZoom = 1.0;
	FlxG.camera.zoom = defaultCamZoom;
	//camGame.snapToTarget();
}

//camera triggers
function bf() {
	camGame.focusOn(FlxPoint.weak(boyfriend.cameraOffset.x + 760, boyfriend.cameraOffset.y + 500));
	//FlxG.camera.targetOffset.set(-120, 320);
	defaultCamZoom = 1.0;
	FlxG.camera.zoom = defaultCamZoom;
	//camGame.snapToTarget();
}
function onPlayerHit(event:NoteHitEvent)
{
	event.showSplash = false;
}

function onCountdown(event:CountdownEvent)
{
	event.cancel();
}

//cutscene pausing
function onSubstateOpen() {
	if(!FlxG.save.data.midsongvids_toggle) return;
	if (cutscene.visible) cutscene.pause();
}
function onSubstateClose() {
	if(!FlxG.save.data.midsongvids_toggle) return;
	if (cutscene.visible) cutscene.play();
}
function onSongStart() if (!devMode) card.visible = true;

function stepHit(step)
	{
		switch (step)
		{
			case 0:
				dRagon.visible = false;
				clouds.visible = false;
				iphonebuildings.visible = false;
				iphonestore.visible = false;
				iphoneroad.visible = false;
				bomb.visible = false;
				plant.visible = false;
				gizmowall.visible = false;
				gizmofloor.visible = false;
				boos.visible = false;
				piano.visible = false;
				sun.visible = false;
				mountainsfar.visible = false;
				mountainsnear.visible = false;
				ground.visible = false;
				flag.visible = false;
				dRagon.visible = false;
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
				FlxTween.tween(strumLines.members[0].characters[0], {alpha: 0.001}, 1.2);
			    BG.color = FlxColor.BLACK;
				boyfriend.color = FlxColor.WHITE;
				dad.color = FlxColor.WHITE;
			case 1024:
				//PART 2
				BG.alpha = 0.5;
				strumLines.members[0].characters[0].visible = false;
				strumLines.members[2].characters[0].visible = true;
			case 1152: BG.alpha = 0.001;
			case 1394: FlxTween.tween(BG, {alpha: 0.8}, 0.1);
			case 1408: BG.alpha = 0.001;
			case 1656: BG.alpha = 0.25;
			case 1660: BG.alpha = 0.5;
			case 1792:
				strumLines.members[2].characters[0].visible = false;
			    boyfriend.visible = false;
			    BG.alpha = 1;
			case 1806:
				//PART 3
				defaultCamZoom = 0.95;
				FlxG.camera.zoom = defaultCamZoom;
			    //boyfriend.shader = color;
			    camHUD.addShader(color);
			    strumLines.members[3].characters[0].visible = true;
			    BG.alpha = 0.001;
			    insert(members.indexOf(dad), BG);
			case 1807: BG.alpha = 1;
			case 1808: BG.alpha = 0.001;
			case 2060: 
				if (!FlxG.save.data.epilepsy_toggle)
				{
					flashing = true;
				}
			case 2192: flashing = false;
			case 2194: FlxTween.tween(camGame, {alpha: 0.001}, 0.4);
			case 2208:
				//PART 4
				BG.alpha = 0.001;
				defaultCamZoom = 0.55;
				FlxG.camera.zoom = defaultCamZoom;
			    camGame.alpha = 1;
				strumLines.members[2].characters[0].alpha = 0.001;
				strumLines.members[2].characters[0].visible = true;
				boyfriend.visible = true;
			case 2272: FlxTween.tween(strumLines.members[2].characters[0], {alpha: 1}, 0.5);
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
				strumLines.members[0].characters[0].alpha = 0.001;
				strumLines.members[0].characters[0].visible = true;
				strumLines.members[2].characters[0].visible = false;
				strumLines.members[3].characters[0].visible = false;
				BG.alpha = 0.001;
				BG.color = FlxColor.WHITE;
				defaultCamZoom = 0.95;
				FlxG.camera.zoom = defaultCamZoom;
			case 2736:
			    //boyfriend.shader = null;
				camGame.alpha = 1;
				camHUD.removeShader(color);
				camGame.fade(FlxColor.BLACK, 9, true);
				camGame.visible = true;
			case 2910:
				FlxTween.tween(camGame.scroll, {x: -760}, 8, {ease: FlxEase.sineInOut});
				FlxTween.tween(strumLines.members[0].characters[0], {alpha: 1}, 6, {startDelay: 2});
			case 3008:
				camHUD.alpha = 0.001;
			case 3024:
				//PART 6
			    center();
				FlxG.camera.zoom = defaultCamZoom;
				if(FlxG.save.data.midsongvids_toggle) {
				boyfriend.visible = false;
				strumLines.members[0].characters[0].visible = false;
				cutscene.play();
				cutscene.visible = true;
				} else {
					boyfriend.color = FlxColor.BLACK;
					dad.color = FlxColor.BLACK;
				}

			case 3142:
				camHUD.addShader(color);
				//FlxTween.tween(camHUD, {alpha: 1}, 0.2);
				camHUD.alpha = 1;
			case 3152: 
				remove(BG);
				insert(members.indexOf(stage.getSprite("sun")), BG);
				flashing = true;
				BG.color = FlxColor.BLACK;
			    if(FlxG.save.data.midsongvids_toggle) {
				    boyfriend.visible = true;
				    strumLines.members[0].characters[0].visible = true;
					cutscene.visible = false;
					remove(cutscene);
				} else {
					boyfriend.color = FlxColor.WHITE;
					dad.color = FlxColor.WHITE;
				}	
			case 3272:
			    flashing = false;
				FlxTween.cancelTweensOf(BG);
				BG.alpha = 0.001;
				FlxTween.tween(BG, {alpha: 1}, 0.7, {ease: FlxEase.sineOut});
			case 3280: 
				camHUD.removeShader(color);
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
		if (willRunningMan == 1 && step == whenRunningMan) FlxTween.tween(runningManofHatena, {x: -400, y: 600}, 2);
	}
function whiteFlash() {
	if (!FlxG.save.data.epilepsy_toggle)
	{
		FlxTween.cancelTweensOf(BG);
		BG.alpha = 1;
		FlxTween.tween(BG, {alpha: 0.001}, 1.6);
	}
}


function beatHit(beat) {
	if (flashing) {

	  if (strumLines.members[0].characters[0].visible) {
		if (beat % 2 == 0) {
			FlxTween.cancelTweensOf(BG);
		    BG.alpha = 0.001;
			FlxTween.tween(BG, {alpha: 0.5}, 0.8, {ease: FlxEase.sineOut});
		}
	    } else { 
			FlxTween.cancelTweensOf(BG);
		    BG.alpha = 0.001;
			FlxTween.tween(BG, {alpha: 1}, 0.4, {ease: FlxEase.circIn});
	    }
	}

}
function onSongEnd(){
	skipTransition = false;
	FlxG.save.data.hatenaDone = true;
	trace("oh.");
}