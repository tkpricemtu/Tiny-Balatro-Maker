%% close everything and delete leftover files
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