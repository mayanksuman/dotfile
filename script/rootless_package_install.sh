#!/usr/bin/env bash 

# Please try to install using homebrew first, if it does not work then, 
# use following functions.


# For Debian
# This function install package by downloading it and its depedencies and 
# untarring it in ~/.local_build/. The ~/.local_build/usr/bin should be in 
# $PATH.
function install_package_debian() {
    BUILD_DIR="/tmp/.build_dir"
    if [ -d "$BUILD_DIR" ]; then 
        echo "Warning: Build directory (${BUILD_DIR}) exist. Deleting ..."
        rm -rf package_content
    fi
    mkdir -p "$BUILD_DIR"
    
    PACKAGE=$1
    cd "$BUILD_DIR" && \
        apt-get download $(apt-cache depends --recurse --no-recommends \
        --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances \
        --no-pre-depends ${PACKAGE} | grep "^\w") && \
        cd -
    
    mkdir -p $HOME/.local_build
    # unpack only the data part from the .deb file
    # see https://en.wikipedia.org/wiki/Deb_%28file_format%29
    for file in "$BUILD_DIR/"*deb; do
        ar p ${file} data.tar.xz | tar xJv --overwrite -f - -C "${HOME}/.local_build"
    done
    # ar is part of binutils and xz is part of xz-utils
    rm -rf "$BUILD_DIR"
}


# For RedHat
# This function install package by downloading it and its depedencies and 
# untarring it in ~/.local_build/. The ~/.local_build/usr/bin should be in 
# $PATH.
function install_package_redhat() {
    BUILD_DIR="/tmp/.build_dir"
    if [ -d "$BUILD_DIR" ]; then 
        echo "Warning: Build directory (${BUILD_DIR}) exist. Deleting ..."
        rm -rf package_content
    fi
    mkdir -p "$BUILD_DIR"
    
    PACKAGE=$1
    cd "$BUILD_DIR" && yumdownloader --resolve $package && cd -
    
    mkdir -p $HOME/.local_build
    # unpack only .rpm file in ~/.local_build/
    for file in "$BUILD_DIR/"*deb; do
        cd "$HOME/.local_build/" && (rpm2cpio ${file} | cpio -id) && cd -
    done
    rm -rf "$BUILD_DIR"
}
