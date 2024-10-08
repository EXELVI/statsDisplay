local monitor = peripheral.wrap("left");
local detector = peripheral.wrap("environmentDetector_0");
monitor.clear();
local running = true;
function getCurrentTime()
	local time = os.time();
	return textutils.formatTime(time, true);
end;

local function centerText(monitor, yPos, text, color)
	local width, height = monitor.getSize();
	local xPos = math.floor((width - string.len(text)) / 2) + 1;
	monitor.setCursorPos(xPos, yPos);
	monitor.setTextColor(color);
	monitor.write(text);
end;
local display = "time";
local function onTouch(x, y)
	if display == "time" then
		display = "weather";
	elseif display == "weather" then
		display = "radiation";
	elseif display == "radiation" then
		display = "time";
	end;
	print(display);
end;
local function handleEvents()
	while running do
		local event, side, x, y = os.pullEvent("monitor_touch");
		if event == "monitor_touch" then
			onTouch(x, y);
		end;
	end;
end;
function isNight()
	local time = os.time();
	return time >= 18;
end;

local rssFeed = "https://www.repubblica.it/rss/homepage/rss2.0.xml?ref=RHFT";
local response = http.get(rssFeed);
if response then
	local rssData = response.readAll();
	response.close();
	local titoli = {};
	for titolo in rssData:gmatch("<title>(.-)</title>") do
		table.insert(titoli, titolo);
	end;
	print("Titoli caricati: " .. #titoli);
	parallel.waitForAny(handleEvents, function()
		local timee = 0;
		while true do
			local time = getCurrentTime();
			monitor.setTextScale(2);
			centerText(monitor, 4, "EXELVI's", colors.blue);
			if display == "time" then
				centerText(monitor, 6, "               ", colors.white);
				centerText(monitor, 6, time, colors.white);
			elseif display == "weather" then
				local rain = detector.isRaining();
				local isThunder = detector.isThunder();
				local randomValue = math.random(1, 5);
				local isTrue = randomValue == 1;
				local isNighttime = isNight();
				local weather = rain and (isThunder and "Temporali" or "Pioggia") or
					(isNighttime and "Cielo pulito" or "Soleggiato");
				centerText(monitor, 6, "               ", colors.white);
				local txtcolor = colors.white;
				if rain then
					if isThunder then
						txtcolor = isTrue and colors.yellow or colors.blue;
					else
						txtcolor = colors.blue;
					end;
				elseif isNighttime then
					txtcolor = colors.lightBlue;
				else
					txtcolor = colors.yellow;
				end;
				centerText(monitor, 6, weather, txtcolor);
			elseif display == "radiation" then
				local radiation = detector.getRadiation();
				local radiationRaw = detector.getRadiationRaw();
				centerText(monitor, 6, "               ", colors.white);
				local txtcolor = colors.white;
				if radiationRaw < 0.0000002 then
					txtcolor = colors.green;
				elseif radiationRaw < 0.0005 then
					txtcolor = colors.yellow;
				elseif radiationRaw < 0.1 then
					txtcolor = colors.orange;
				elseif radiationRaw < 10 then
					txtcolor = colors.red;
				else
					txtcolor = colors.purple;
				end;
				centerText(monitor, 6, math.floor(radiation.radiation * 100) / 100 .. " " .. radiation.unit, txtcolor);
			end;



			monitor.setCursorPos(1, 10);
			monitor.setTextColor(colors.white);

			if (timee > 10) then
				timee = 0;
				local titolo = titoli[math.random(1, #titoli)];
				monitor.clearLine();
				print(titolo);
				monitor.write(titolo);
			else 
				timee = timee + 1;
			end;

			os.sleep(0.1);
		end;
	end);
else
	print("Errore nel caricamento del feed RSS");
end;
