#! /bin/bash

# dtb2dts
if [ "$1" = "dtb" ]; then
for i in `find *.dtb`; do
    dts=${i%.*}.dts
    dtc/dtc -q -I dtb -O dts -o $dts $i
    sudo rm -rf $i
    sudo mv -f $dts out/$dts
done
fi

# dts2dtb
if [ "$1" = "dts" ]; then
for i in `find *.dts`; do
    dtb=${i%.*}.dtb
    dtc/dtc -q -I dts -O dtb -o $dtb $i
    sudo rm -rf $i
    sudo mv -f $dtb out/$dtb
done
fi

# dtbo2dtsi
if [ "$1" = "dtbo" ]; then
    sudo chmod 777 dtbo.img
    python mkdtboimg/dtbo2dtsi.py dtbo.img
    sudo mv -f dtsi.* out/
fi

# dtsi2dtbo
if [ "$1" = "dtsi" ]; then
    python mkdtboimg/dtsi2dtbo.py dtsi.*
    sudo chmod 777 dtbo.img
    sudo mv -f dtbo.img out/dtbo.img
fi

# mkbootimg
if [ "$1" = "unpack" ]; then
    sudo chmod 777 boot.img
    mkbootimg/mkboot boot.img boot
    rm -rf boot.img
    mv boot/kernel ./image.gz-dtb
    split-appended-dtb/split-appended-dtb image.gz-dtb
    for i in `find *.dtb`; do
        dts=${i%.*}.dts
        dtc/dtc -q -I dtb -O dts -o $dts $i
        rm -rf $i
        mv -f $dts out/$dts
    done
    rm -rf image.gz-dtb
    mv -f kernel out/kernel
fi
if [ "$1" = "repack" ]; then
    cd out
    for i in `find *.dts`; do
        dtb=${i%.*}.dtb
        ../dtc/dtc -q -I dts -O dtb -o $dtb $i
        sudo rm -rf $i
    done
    cat *.dtb kernel > image.gz-dtb
    sudo chmod 777 image.gz-dtb
    sudo rm kernel
    sudo rm *.dtb
    cd ..
    mv out/image.gz-dtb boot/kernel
#    mkbootimg/mkboot boot boot.img
fi

