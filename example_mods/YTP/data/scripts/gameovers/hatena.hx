import funkin.backend.MusicBeatState;

gameOverSong = 'flipnoteDeath';
retrySFX = 'gameover/flipnote/deathEnd';
lossSFXName = "gameover/flipnote/gameOver";
var enterSound:FlxSound = FlxG.sound.load(Paths.sound("gameover/flipnote/deathEnd"));

var gameoverSprite:FlxSprite = new FlxSprite(0, 0);
gameoverSprite.frames = Paths.getFrames("stages/flipnote/hatenagameover");
gameoverSprite.animation.addByPrefix("loop", "Symbol 1", 24, true);
gameoverSprite.animation.addByPrefix("enter", "Symbol 2", 24, false);
gameoverSprite.scale.set(4, 4);
gameoverSprite.updateHitbox();

function create () {
    
	trace("hiii");
	gameoverSprite.alpha = 0.001;
	add(gameoverSprite);
	gameoverSprite.animation.play('loop');
}

function postCreate() {
	character.visible = false;
	camOver = new FlxCamera(0, 0, 960, 720);
	camOver.bgColor = FlxColor.BLACK;
	FlxG.cameras.add(camOver, false);
	gameoverSprite.cameras = [camOver];
}

function beatHit(cur:Int) {
	if(cur != 0) return;

	FlxTween.tween(gameoverSprite, {alpha: 1}, 4);
}

function onEnd(event) {
    event.cancel();
	FlxTween.cancelTweensOf(gameoverSprite);
	gameoverSprite.alpha = 1;
	FlxG.sound.music.stop();
	enterSound.play(true);
	gameoverSprite.animation.play('enter', true);
	trace("entere");
	new FlxTimer().start(1, function(tmr:FlxTimer)
		{

			MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
			FlxG.switchState(new PlayState());

		});

}