#!/bin/bash

# Make Deb Package for Phishing (^.^)
_PACKAGE=Xphisher
_VERSION=3.0
_ARCH="all"
PKG_NAME="${_PACKAGE}_${_VERSION}_${_ARCH}.deb"

if [[ ! -e "scripts/launch.sh" ]]; then
        echo "lauch.sh should be in the \`scripts\` Directory. Exiting..."
        exit 1
fi

if [[ ${1,,} == "termux" || $(uname -o) == *'Android'* ]];then
        _depend="ncurses-utils, proot, resolv-conf, "
        _bin_dir="/data/data/com.termux/files/"
        _opt_dir="/data/data/com.termux/files/usr/"
        #PKG_NAME=${_PACKAGE}_${_VERSION}_${_ARCH}_termux.deb
fi

_depend+="curl, php, unzip"
_bin_dir+="usr/bin"
_opt_dir+="opt/${_PACKAGE}"

if [[ -d "A.Ali" ]]; then rm -fr A.Ali; fi
mkdir -p A.Ali
mkdir -p A.Ali/${_bin_dir} A.Ali/$_opt_dir A.Ali/DEBIAN 

cat <<- CONTROL_EOF > A.Ali/DEBIAN/control
Package: ${_PACKAGE}
Version: ${_VERSION}
Architecture: ${_ARCH}
Maintainer: @A.Ali
Depends: ${_depend}
Homepage: https://github.com/A-Davil/Xphisher.git
Description: An automated phishing tool with 5 templates and this Tool is made for educational purpose only !
CONTROL_EOF

cat <<- PRERM_EOF > A.Ali/DEBIAN/prerm
#!/bin/bash
rm -fr $_opt_dir
exit 0
PRERM_EOF

chmod 755 A.Ali/DEBIAN
chmod 755 A.Ali/DEBIAN/{control,prerm}
cp -fr scripts/launch.sh A.Ali/$_bin_dir/$_PACKAGE
chmod 755 A.Ali/$_bin_dir/$_PACKAGE
cp -fr .github/ .sites/ LICENSE README.md Xphisher.sh A.Ali/$_opt_dir
dpkg-deb --build A.Ali${PKG_NAME}
rm -fr A.Ali



