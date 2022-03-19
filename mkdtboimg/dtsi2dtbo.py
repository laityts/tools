import os

DTB_NAME = "dtb_tmp"
DTS_NAME = "dtsi"

for i in range(20):
    fi  = DTS_NAME + "." + str(i)
    fo  = DTB_NAME + "." + str(i)
    cmd = "./dtc/dtc -I dts -O dtb " + fi + " -o " + fo
    if os.path.isfile(fi):
        print(cmd)
        os.system(cmd)
        os.chmod(fo,0o777)
        os.remove(fi)
    else:
        break

cmd  = "./mkdtboimg/mkdtimg create dtbo.img --page_size=4096 " + fo

os.system(cmd)