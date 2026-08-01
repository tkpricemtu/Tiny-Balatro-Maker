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
    movefile('Balatro.exe','Balatro2.zip');
end
if isfile('Balatro2.zip')
    % Unzip 'Balatro.zip'
    unzip('Balatro2.zip');
end
delete Balatro2.zip

%% open globals.lua
globalsID = fopen('globals.lua','w');
ix = 1;
tline = fgetl(globalsID);
globalsTxt{ix} = tline;
while ischar(tline)
    ix = ix+1;
    tline = fgetl(globalsID);
    globalsTxt{ix} = tline;
end

%% open cardarea.lua
cardareaID = fopen('cardarea.lua','w');
ix = 1;
tline = fgetl(cardareaID);
cardareaTxt{ix} = tline;
while ischar(tline)
    ix = ix+1;
    tline = fgetl(cardareaID);
    cardareaTxt{ix} = tline;
end

%% open game.lua
gameID = fopen('game.lua','w');
ix = 1;
tline = fgetl(gameID);
gameTxt{ix} = tline;
while ischar(tline)
    ix = ix+1;
    tline = fgetl(gameID);
    gameTxt{ix} = tline;
end

%% open misc.lua
miscID = fopen('functions/misc_functions.lua','w');
ix = 1;
tline = fgetl(miscID);
miscTxt{ix} = tline;
while ischar(tline)
    ix = ix+1;
    tline = fgetl(miscID);
    miscTxt{ix} = tline;
end

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
% cardareaTxt{439} = cardareaTxt{439}(1:28);
% cardareaTxt{420} = cardareaTxt{420}(1:32);

% overwrite the default cards with the "Grandma mode" cards in resources
movefile('resources/textures/1x/8BitDeck_opt2.png','resources/textures/1x/8BitDeck_opt2OLD.png')
copyfile('BalatroGrandmaH1.png','resources/textures/1x/8BitDeck_opt2.png')
movefile('resources/textures/2x/8BitDeck_opt2.png','resources/textures/2x/8BitDeck_opt2OLD.png')
copyfile('BalatroGrandmaH2.png','resources/textures/2x/8BitDeck_opt2.png')

%% write files

% globals
% for ix = 1:(numel(globalsTxt))
%     if globalsTxt{ix+1}==-1
%         fprintf(globalsID,'%s',globalsTxt{ix});
%         break
%     else
%         fprintf(globalsID,'%s\n',globalsTxt{ix});
%     end
% end

% cardarea
% for ix = 1:(numel(cardareaTxt))
%     if cardareaTxt{ix+1}==-1
%         fprintf(cardareaID,'%s',cardareaTxt{ix});
%         break
%     else
%         fprintf(cardareaID,'%s\n',cardareaTxt{ix});
%     end
% end

% game
% for ix = 1:(numel(gameTxt))
%     if gameTxt{ix+1}==-1
%         fprintf(gameID,'%s',gameTxt{ix});
%         break
%     else
%         fprintf(gameID,'%s\n',gameTxt{ix});
%     end
% end

% misc
% for ix = 1:(numel(miscTxt))
%     if miscTxt{ix+1}==-1
%         fprintf(miscID,'%s',miscTxt{ix});
%         break
%     else
%         fprintf(miscID,'%s\n',miscTxt{ix});
%     end
% end

%% zip everything and create the exe

zip('Balatro',{'engine',...
    'functions',...
    'localization',...
    'resources',...
    'version.jkr',...
    'back.lua',...
    'blind.lua',...
    'card.lua',...
    'card_character.lua',...
    'cardarea.lua',...
    'challenges.lua',...
    'conf.lua',...
    'game.lua',...
    'globals.lua',...
    'main.lua',...
    'tag.lua'});
movefile('Balatro.zip','Balatro.exe');


%% close everything and delete leftover files
% fclose to allow everything to be deleted
fclose('all');

% delete the given files
delete('version.jkr','back.lua','blind.lua','card.lua',...
    'card_character.lua','cardarea.lua','challenges.lua','conf.lua',...
    'game.lua','globals.lua','main.lua','tag.lua');

% delete everything in the folders
delete('engine\*')
rmdir engine
delete('functions\*')
rmdir functions
delete('localization\*')
rmdir localization
delete('resources\fonts\*')
rmdir resources\fonts
delete('resources\shaders\*')
rmdir resources\shaders
delete('resources\sounds\*')
rmdir resources\sounds
delete('resources\textures\1x\collabs\*')
rmdir resources\textures\1x\collabs
delete('resources\textures\1x\*')
rmdir resources\textures\1x
delete('resources\textures\2x\collabs\*')
rmdir resources\textures\2x\collabs
delete('resources\textures\2x\*')
rmdir resources\textures\2x
rmdir resources\textures
delete('resources\*')
rmdir resources