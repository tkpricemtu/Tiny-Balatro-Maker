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