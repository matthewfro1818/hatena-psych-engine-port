function onEvent(eventName, value1, value2)
   if eventName == 'playVideo' then
       startVideo('test')
		return Function_Stop;
   end
end