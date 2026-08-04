function unzipme
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