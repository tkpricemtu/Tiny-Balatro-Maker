% tinyBalatroMaker.m
%
% This script takes a standard Balatro.exe file from a standard steam
% install and modifies it to be more legible on a small screen; it is
% specifically designed for 640 x 480 handhelds. This Balatro.exe file can 
% be substituted for the vanilla Balatro.exe when installing the Portmaster
% port or using the Android apk generator. These are the requirements:
% - Balatro.exe must be in the same folder as this script
% - NotoSans-CondensedBold.ttf must be in the Images folder. I probably
% should've called this folder "Assets" or something but I don't feel like
% changing it. 

clc
clearvars
close all



%% open files
unzipme;

cardareaFN = 'UnzipLocation/cardarea.lua';
gameFN     = 'UnzipLocation/game.lua';
miscFN     = 'UnzipLocation/functions/misc_functions.lua';
globalsFN  = 'UnzipLocation/globals.lua';
UIdefFN    = 'UnzipLocation/functions/UI_definitions.lua';
blindFN    = 'UnzipLocation/blind.lua';
commonFN   = 'UnzipLocation/functions/common_events.lua';
buttonCBFN = 'UnzipLocation/functions/button_callbacks.lua';

cardareaTxt = readlines(cardareaFN);
gameTxt     = readlines(gameFN);
miscTxt     = readlines(miscFN);
globalsTxt  = readlines(globalsFN);
UIdefTxt    = readlines(UIdefFN);
blindTxt    = readlines(blindFN);
commonTxt   = readlines(commonFN);
buttonCBTxt = readlines(buttonCBFN);

%% changes

% overwrite font 
newfont = 'Images\NotoSans-CondensedBold.ttf';
movefile('UnzipLocation\resources\fonts\m6x11plus.ttf','UnzipLocation\resources\fonts\m6x11plusOLD.ttf');
copyfile(newfont,'UnzipLocation\resources\fonts\m6x11plus.ttf')
 
% increase overall text size by 40%
gameTxt{969} = [gameTxt{969}(1:155) '4' gameTxt{969}(156:end)];
gameTxt{975} = [gameTxt{975}(1:153) '4' gameTxt{975}(154:end)];

% increase scale of tooltips
miscTxt{1761} = [miscTxt{1761} '*1.13'];

% increase font of the card count indicators from 0.3 to 0.42
cardareaTxt{285} = [cardareaTxt{285}(1:101) '42' cardareaTxt{285}(103:end)]; % card count font scale
cardareaTxt{286} = [cardareaTxt{286}(1:62)  '42' cardareaTxt{286}(64:end)];  % slash font scale
cardareaTxt{287} = [cardareaTxt{287}(1:101) '42' cardareaTxt{287}(103:end)]; % card limit font scale
 
% adjust location and font size of peek deck indicator
cardareaTxt{371} = [cardareaTxt{371}(1:72) '2' cardareaTxt{371}(73:end)];    % increase padding from 0.1 to 0.12
cardareaTxt{372} = [cardareaTxt{372}(1:199) '72' cardareaTxt{372}(201:end)]; % increase button scale from 0.6 to 0.72
cardareaTxt{374} = [cardareaTxt{374}(1:77) '576' cardareaTxt{374}(80:end)];  % increase "peek" text from 0.48 to 0.576
cardareaTxt{377} = [cardareaTxt{377}(1:77) '456' cardareaTxt{377}(80:end)];  % increase "deck" text from 0.38 to 0.456
cardareaTxt{381}(57) = '3'; % change x offset from x=-0.5 to x=-0.3
cardareaTxt{381}(61) = '1'; % change y offset from y=0.1 to y=1.1
% 
% % adjust location of blind marquee
blindTxt{126}    = [blindTxt{126}(1:end-1) '-0.8']; % change y offset
blindTxt{748}    = [blindTxt{748}(1:end-1) '-0.8']; % change y offset
 
% adjust joker, deck and consumable spots
commonTxt{9}     = [commonTxt{9}(1:end-5) '+ 0.2']; % change x offset of jokers
commonTxt{10}    = [commonTxt{10}(1:end-1) '-1.9']; % change y offset of jokers
commonTxt{13}    = [commonTxt{13}(1:end-1) '-1.9']; % change y offset of consumables
commonTxt{15}    = [commonTxt{15}(1:end-1) '5'];    % change x offset of deck

% reduced number of the cash out dots, was causing issues
commonTxt{940} = [ commonTxt{940}(1:78) '........' commonTxt{940}(117:end)];

% remove rotation of the cards by setting the card.T.r values to 0 
cardareaTxt{439} = cardareaTxt{439}(1:28);
cardareaTxt{454} = cardareaTxt{454}(1:28);
cardareaTxt{469} = cardareaTxt{469}(1:28);
cardareaTxt{484} = cardareaTxt{484}(1:28);
cardareaTxt{512} = cardareaTxt{512}(1:28);

% flatten cards in hand to all have the same height
cardareaTxt{444} = [cardareaTxt{444}(1:73) '- 0.3'];
cardareaTxt{460} = [cardareaTxt{460}(1:81) '- 0.2'];
cardareaTxt{474} = [cardareaTxt{474}(1:80) cardareaTxt{474}(end-28:end)];
cardareaTxt{486} = [cardareaTxt{486}(1:180) cardareaTxt{486}(end-19:end)];
cardareaTxt{489} = [cardareaTxt{489}(1:81) cardareaTxt{489}(end-28:end)];

% increase button size by 40%
UIdefTxt{6149} = [UIdefTxt{6149}(1:35) '(' UIdefTxt{6149}(36:53) ...
    ')*1.4,(' UIdefTxt{6149}(55:72) ')*1.4,' UIdefTxt{6149}(74:end)] ;
% 
% % shift Play/Discard buttons down and to the left 
buttonCBTxt{832} = [buttonCBTxt{832}(1:44) '-0.9' ...
    buttonCBTxt{832}(46:48) '1.3' buttonCBTxt{832}(52:end)];
gameTxt{3049} = [gameTxt{3049}(1:46) '-0.9' gameTxt{3049}(48:50) ...
    '1.3' gameTxt{3049}(54:end)]; 
 
% increase size of the Sell and Use buttons, adjust for no overlap
% minw = 1.3, 'sell' and 1.9 or 1.4
UIdefTxt{422} = [UIdefTxt{422}(1:84) '.3' UIdefTxt{422}(85:158) ...
    '9' UIdefTxt{422}(160:164) '.4' UIdefTxt{422}(165:end)];
% minh = 0.6
UIdefTxt{425} = [UIdefTxt{425}(1:55) '6' UIdefTxt{425}(57:end)];
% maxw = 1.3
UIdefTxt{428} = [UIdefTxt{428}(1:56) '.3' UIdefTxt{428}(57:end)];
% change 0.6 and -0.6 to 1.3 and -1.3
UIdefTxt{438}(138:140) = '1.3';
UIdefTxt{438}(169:171) = '1.3';
% 
% % move main menu UI elements down
commonTxt{758} = [commonTxt{758}(1:end-1) '1.9'];
commonTxt{767} = [commonTxt{767}(1:65) '1.9' commonTxt{767}(67:end)];
% 
% increase size of main menu logo
gameTxt{1569}  = [gameTxt{1569}(1:23) '4' gameTxt{1569}(25:end)];

% move version number up
gameTxt{1712}  = [gameTxt{1712}(1:47) '-1.6' gameTxt{1712}(49:end)];

% adjust width of Joker and Consumable boxes
gameTxt{2228} = [gameTxt{2228}(1:18) '5.29' gameTxt{2228}(22:end)];
gameTxt{2230} = [gameTxt{2230}(1:24) '1.96' gameTxt{2230}(28:end)];

% move shop item costs up. 
UIdefTxt{875}(88) = '1';
UIdefTxt{875}(95:96) = '10';

% increase minimum height of hand display 
UIdefTxt{1341} = [UIdefTxt{1341}(1:98) 'minh = 3.2, ', UIdefTxt{1341}(99:end)];

% shift blind alignment down, 3.75 -> 4
UIdefTxt{1405} = [UIdefTxt{1405}(1:79) '4.2' UIdefTxt{1405}(84:end)];

% overwrite the default high visibility cards with the "Grandma mode" cards in resources
movefile('UnzipLocation/resources/textures/1x/8BitDeck_opt2.png',...
    'UnzipLocation/resources/textures/1x/8BitDeck_opt2OLD.png')
copyfile('Images/BalatroGrandmaH1b.png',...
    'UnzipLocation/resources/textures/1x/8BitDeck_opt2.png')
movefile('UnzipLocation/resources/textures/2x/8BitDeck_opt2.png',...
    'UnzipLocation/resources/textures/2x/8BitDeck_opt2OLD.png')
copyfile('Images/BalatroGrandmaH2b.png',...
    'UnzipLocation/resources/textures/2x/8BitDeck_opt2.png')

% XY swap, personal preference
UIdefTxt{6131} = [UIdefTxt{6131}(1:end-2) 'G.F_SWAP_XY_BUTTONS and 3 or 2,'];
UIdefTxt{6132} = [UIdefTxt{6132}(1:end-2) 'G.F_SWAP_XY_BUTTONS and 2 or 3,'];
globalsTxt{30}(30:34) = 'true ';
% skip tutorial
globalsTxt{14}(28:32) = 'true ';

%% write files
writelines(cardareaTxt,cardareaFN);
writelines(gameTxt,gameFN);
writelines(miscTxt,miscFN);
writelines(globalsTxt,globalsFN);
writelines(UIdefTxt,UIdefFN);
writelines(blindTxt,blindFN);
writelines(commonTxt,commonFN);
writelines(buttonCBTxt,buttonCBFN);

%% zip everything and create the exe
zip('Balatro.zip','*','UnzipLocation');
movefile('Balatro.zip','Balatro.exe');
cleanrepo

%% Functions

function unzipme
% This script does everything needed to unzip the files hidden in 

if isfile('Balatro.exe')
    % Rename 'Balatro.exe' to 'Balatro.zip'
    movefile('Balatro.exe','BalatroOLD.exe');
end
if isfile('BalatroOLD.exe')
    copyfile('BalatroOLD.exe','BalatroOLD.zip');
end
if isfile('BalatroOLD.zip')
    % Unzip 'Balatro.zip'
    unzip('BalatroOLD.zip','UnzipLocation');
end
delete BalatroOLD.zip
end

function cleanrepo
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
end
