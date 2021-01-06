git clone ssh://git.amazon.com/pkg/MacOSEncryptedVolumeTools
MacOSEncryptedVolumeTools/bin/create-encrypted-apfs-volume workplace
MacOSEncryptedVolumeTools/bin/create-encrypted-apfs-volume brazil-pkg-cache   # add " -quota 50g" if you want to limit the size of this volume but keep in mind you can't change the quota later
brazil prefs --global --key packagecache.cacheRoot --value /Volumes/brazil-pkg-cache/   # if you've previously set up brazil package cache, run "brazil-package-cache stop" before this line, and "brazil-package-cache start" after
ln -s /Volumes/workplace ~/ws
rm -rf MacOSEncryptedVolumeTools  # optional
