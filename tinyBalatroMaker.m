% tinyBalatroMaker.m
%
% This script takes a standard Balatro.exe file from a standard steam
% install and modifies it to be more legible on a small screen; it is
% specifically designed for 640 x 480 handhelds. This Balatro.exe file can 
% be substituted for the vanilla Balatro.exe when installing the Portmaster
% port or using the Android apk generator. These are the requirements:
% - Balatro.exe must be in the same folder as this script
clc
clearvars
close all

if isfile('Balatro.exe')
    % Rename 'Balatro.exe' to 'Balatro.zip'
    movefile('Balatro.exe','Balatro2.exe');
end
if isfile('Balatro2.exe')
    copyfile('Balatro2.exe','Balatro2.zip');
end
if isfile('Balatro2.zip')
    % Unzip 'Balatro.zip'
    unzip('Balatro2.zip','UnzipLocation');
end
delete Balatro2.zip

%% open files
%globalsTxt = readlines('UnzipLocation/globals.lua');
cardareaTxt = readlines('UnzipLocation/cardarea.lua');
%gameTxt = readlines('UnzipLocation/game.lua');
%miscTxt = readlines('UnzipLocation/functions/misc_functions.lua');

%% changes
% changing the scaling of the cards from 2.4 to 2.7 on lines 274 and 275
% globalsTxt{274}(21) = '7';
% globalsTxt{275}(21) = '7';
% 
% % overwrite font
% 
% 
% % increase the text size
% miscTxt{1761} = [miscTxt{1761} '*1.12'];
% 
% % remove rotation of the cards by setting the card.T.r values to 0.
cardareaTxt{420} = cardareaTxt{420}(1:32);
cardareaTxt{432} = [cardareaTxt{432}(1:27) '0'];
cardareaTxt{439} = cardareaTxt{439}(1:28);
cardareaTxt{454} = cardareaTxt{454}(1:28);
cardareaTxt{469} = cardareaTxt{469}(1:28);
cardareaTxt{484} = cardareaTxt{484}(1:28);
cardareaTxt{512} = cardareaTxt{512}(1:28);

% overwrite the default cards with the "Grandma mode" cards in resources
movefile('UnzipLocation/resources/textures/1x/8BitDeck_opt2.png',...
    'UnzipLocation/resources/textures/1x/8BitDeck_opt2OLD.png')
copyfile('Images/BalatroGrandmaH1.png',...
    'UnzipLocation/resources/textures/1x/8BitDeck_opt2.png')
movefile('UnzipLocation/resources/textures/2x/8BitDeck_opt2.png',...
    'UnzipLocation/resources/textures/2x/8BitDeck_opt2OLD.png')
copyfile('Images/BalatroGrandmaH2.png',...
    'UnzipLocation/resources/textures/2x/8BitDeck_opt2.png')

%% write files

% globals
% for ix = 1:(numel(globalsTxt))
%     if globalsTxt{ix+1}==-1
%         fprintf(globalsID,'%s',globalsTxt{ix});
%         break
%     else
%         fprintf(globalsID,'%s/n',globalsTxt{ix});
%     end
% end

% cardarea
cardareaID = fopen('UnzipLocation/cardarea.lua','w');
for ii = 1:length(cardareaTxt)
    fprintf(cardareaID,[cardareaTxt{ii} '\n']);
end

% game
% for ix = 1:(numel(gameTxt))
%     if gameTxt{ix+1}==-1
%         fprintf(gameID,'%s',gameTxt{ix});
%         break
%     else
%         fprintf(gameID,'%s/n',gameTxt{ix});
%     end
% end

% misc
% for ix = 1:(numel(miscTxt))
%     if miscTxt{ix+1}==-1
%         fprintf(miscID,'%s',miscTxt{ix});
%         break
%     else
%         fprintf(miscID,'%s/n',miscTxt{ix});
%     end
% end

%% zip everything and create the exe
fclose('all');
zip('Balatro.zip','/*','UnzipLocation');
movefile('Balatro.zip','Balatro.exe');


%% close everything and delete leftover files

% delete everything in the UnzipLocation folder, there's probably a better
% way to do this but this works
delete('UnzipLocation/engine/*')
rmdir UnzipLocation/engine
delete('UnzipLocation/functions/*')
rmdir UnzipLocation/functions
delete('UnzipLocation/localization/*')
rmdir UnzipLocation/localization
delete('UnzipLocation/resources/fonts/*')
rmdir UnzipLocation/resources/fonts
delete('UnzipLocation/resources/shaders/*')
rmdir UnzipLocation/resources/shaders
delete('UnzipLocation/resources/sounds/*')
rmdir UnzipLocation/resources/sounds
delete('UnzipLocation/resources/textures/1x/collabs/*')
rmdir UnzipLocation/resources/textures/1x/collabs
delete('UnzipLocation/resources/textures/1x/*')
rmdir UnzipLocation/resources/textures/1x
delete('UnzipLocation/resources/textures/2x/collabs/*')
rmdir UnzipLocation/resources/textures/2x/collabs
delete('UnzipLocation/resources/textures/2x/*')
rmdir UnzipLocation/resources/textures/2x
rmdir UnzipLocation/resources/textures
delete('UnzipLocation/resources/*')
rmdir UnzipLocation/resources
delete('UnzipLocation/*')

%% Old
%% open globals.lua
% globalsID = fopen('UnzipLocation/globals.lua','w');
% ix = 1;
% tline = fgetl(globalsID);
% globalsTxt{ix} = tline;
% while ischar(tline)
%     ix = ix+1;
%     tline = fgetl(globalsID);
%     globalsTxt{ix} = tline;
% end