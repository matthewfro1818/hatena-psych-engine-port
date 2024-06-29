function onCreate()
	makeAnimatedLuaSprite('card', 'stages/flipnote/hatenaCards', -350, -80);
	scaleObject('card', 2.1, 2.1);
	screenCenter('card')
	setscrollFactor('card', 0, 0)
	setProperty('card.visible', false)
	addAnimationByPrefix('card', 'intro', 'intro', 6, true);
	addAnimationByPrefix('card', 'end', 'end', 6, true);
	playAnimation('card', 'intro')
	addLuaSprite('card');
	makeLuaSprite('BG', '', 0, 0);
	setProperty('BG.visible', false)
	makeGraphic('BG', 1750, 1350, 'FFFFFF')
	addLuaSprite('BG');
	makeLuaSprite('sun', 'stages/flipnote/hatenasun', -220, -100);
	setProperty('sun.visible', false)
	scaleObject('sun', 4, 4);
	addLuaSprite('sun');
	makeAnimatedLuaSprite('dRagon', 'stages/flipnote/dragon', -1500, 100);
	setProperty('dRagon.visible', false)
	scaleObject('dRagon', 4, 4);
	addAnimationByPrefix('dRagon', 'fly', 'dragon', 6, true);
	playAnimation('dRagon', 'fly')
	addLuaSprite('dRagon');
	makeLuaSprite('mountainsfar', 'stages/flipnote/farmountains', -230, -80);
	setProperty('mountainsfar.visible', false)
	scaleObject('mountainsfar', 4, 4);
	addLuaSprite('mountainsfar');
	makeLuaSprite('mountainsnear', 'stages/flipnote/nearmountains', -230, -80);
	setProperty('mountainsnear.visible', false)
	scaleObject('mountainsnear', 4, 4);
	addLuaSprite('mountainsnear');
	makeLuaSprite('ground', 'stages/flipnote/hatenaground', -230, -660);
	setProperty('ground.visible', false)
	scaleObject('ground', 4, 4);
	addLuaSprite('ground');
	makeAnimatedLuaSprite('flag', 'stages/flipnote/tornflag', -220, -30);
	setProperty('flag.visible', false)
	scaleObject('flag', 4, 4);
	addAnimationByPrefix('flag', 'flag', 'flag', 24, true);
	playAnimation('flag', 'flag')
	addLuaSprite('flag');
	makeLuaSprite('gizmowall', 'stages/flipnote/gizmowall', -230, -20);
	setProperty('gizmowall.visible', false)
	scaleObject('gizmowall', 4, 4);
	addLuaSprite('gizmowall');
	makeLuaSprite('gizmofloor', 'stages/flipnote/gizmofloor', -230, -62);
	setProperty('gizmofloor.visible', false)
	scaleObject('gizmofloor', 4, 4);
	addLuaSprite('gizmofloor');
	makeLuaSprite('piano', 'stages/flipnote/piano', -230, -660);
	setProperty('piano.visible', false)
	scaleObject('piano', 4, 4);
	addLuaSprite('piano');
	makeAnimatedLuaSprite('boos', 'stages/flipnote/boos', -1500, 100);
	setProperty('boos.visible', false)
	scaleObject('boos', 4, 4);
	addAnimationByPrefix('boos', 'bop', 'boos', 6, true);
	playAnimation('boos', 'bop')
	addLuaSprite('boos');
	makeLuaSprite('spotlight', 'stages/flipnote/spotlight', 280, 70);
	setProperty('spotlight.visible', false)
	scaleObject('spotlight', 4, 4);
	addLuaSprite('spotlight');
	makeLuaSprite('iphonebuildings', 'stages/flipnote/iphonebuildings', -380, -280);
	setProperty('iphonebuildings.visible', false)
	scaleObject('iphonebuildings', 4, 4);
	addLuaSprite('iphonebuildings');
	makeLuaSprite('iphonestore', 'stages/flipnote/iphonestore', -380, -220);
	setProperty('iphonestore.visible', false)
	scaleObject('iphonestore', 4, 4);
	addLuaSprite('iphonestore');
	makeLuaSprite('iphoneroad', 'stages/flipnote/iphoneroad', -380, -220);
	setProperty('iphoneroad.visible', false)
	scaleObject('iphoneroad', 4, 4);
	addLuaSprite('iphoneroad');
	makeAnimatedLuaSprite('bomb', 'stages/flipnote/iphonebobomb', -380, 160);
	setProperty('bomb.visible', false)
	scaleObject('bomb', 4, 4);
	addAnimationByPrefix('bomb', 'bomb', 'iphonebobomb', 24, true);
	playAnimation('bomb', 'bomb')
	addLuaSprite('bomb');
	makeAnimatedLuaSprite('plant', 'stages/flipnote/iphoneplant', -380, 160);
	setProperty('plant.visible', false)
	scaleObject('plant', 4, 4);
	addAnimationByPrefix('plant', 'plant', 'iphoneplant', 24, true);
	playAnimation('plant', 'plant')
	addLuaSprite('plant');
end

function onBeatHit()
			if curBeat == 36 then
            	setProperty('sun.visible', true)
            	setProperty('flag.visible', true)
             	setProperty('BG.visible', true)
	         	setProperty('dRagon.visible', true)
				setProperty('mountainsfar.visible', true)
				setProperty('mountainsnear.visible', true)
            	setProperty('ground.visible', true)
			end
			if curBeat == 256 then
            	setProperty('sun.visible', false)
            	setProperty('flag.visible', false)
	         	setProperty('dRagon.visible', false)
				setProperty('mountainsfar.visible', false)
				setProperty('mountainsnear.visible', false)
            	setProperty('ground.visible', false)
             	setProperty('gizmowall.visible', true)
             	setProperty('gizmofloor.visible', true)
             	setProperty('boos.visible', true)
             	setProperty('piano.visible', true)
			end
			if curBeat == 448 then
             	setProperty('gizmowall.visible', false)
             	setProperty('gizmofloor.visible', false)
             	setProperty('boos.visible', false)
             	setProperty('piano.visible', false)
			end
			if curBeat == 450 then
            	setProperty('spotlight.visible', true)
			end
			if curBeat == 548 then
             	setProperty('spotlight.visible', false)
			end
			if curBeat == 552 then
             	setProperty('clouds.visible', true)
             	setProperty('iphonebuildings.visible', true)
             	setProperty('iphonestore.visible', true)
             	setProperty('iphoneroad.visible', true)
             	setProperty('bomb.visible', true)
             	setProperty('plant.visible', true)
			end
			if curBeat == 680 then
             	setProperty('clouds.visible', false)
             	setProperty('iphonebuildings.visible', false)
             	setProperty('iphonestore.visible', false)
             	setProperty('iphoneroad.visible', true)
             	setProperty('bomb.visible', false)
             	setProperty('plant.visible', false)
            	setProperty('spotlight.visible', true)
			end
			if curBeat == 752 then
            	setProperty('spotlight.visible', false)
			end
			if curBeat == 788 then
            	setProperty('sun.visible', true)
            	setProperty('flag.visible', true)
	         	setProperty('dRagon.visible', true)
				setProperty('mountainsfar.visible', true)
				setProperty('mountainsnear.visible', true)
            	setProperty('ground.visible', true)
			end
			if curBeat == 820 then
             	setProperty('BG.visible', false)
            	setProperty('sun.visible', false)
	         	setProperty('dRagon.visible', false)
            	setProperty('stars.visible', true)
			end
			if curBeat == 884 then
            	setProperty('flag.visible', false)
			end
end
function onStepHit()
            if curStep == 16 then
            	setProperty('card.visible', true)
            end
		    if curStep == 144 then
            	setProperty('card.visible', false)
			end
			if curStep == 208 then
            	setProperty('camHUD.visible', true)
			end
			if curStep == 1792 then
			    setProperty('boyfriend.visible', false)
			end
			if curStep == 2208 then
			    setProperty('boyfriend.visible', true)
			end
			if curStep == 2720 then
            	setProperty('camHUD.visible', false)
			end
			if curStep == 2736 then
			    setProperty('camGame.visible', true)
			end
			if curStep == 3024 then
				--PART 6
			    setProperty('boyfriend.visible', false)
			    setProperty('cutscene.visible', true)
			end
			if curStep == 3152 then
			    setProperty('boyfriend.visible', true)
			    setProperty('cutscene.visible', false)
			end
			if curStep == 3552 then
			    setProperty('boyfriend.visible', false)
			    setProperty('dad.visible', false)
            	setProperty('camHUD.visible', false)
            	setProperty('card.visible', true)
            	playAnimation('card', 'end')
			end
end