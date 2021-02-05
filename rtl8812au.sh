git clone "https://github.com/gnab/rtl8812au.git" /usr/src/rtl8812au-git
#sed -i 's/PACKAGE_VERSION="@PKGVER@"/PACKAGE_VERSION="git"/g' /usr/src/rtl88x2bu-git/dkms.conf
dkms add -m rtl8812au -v git
#sudo dkms build -m rtl8812au -v git
#sudo dkms install -m rtl8812au -v git
dkms autoinstall
