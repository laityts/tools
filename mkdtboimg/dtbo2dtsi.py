import os
import shutil

DTB_NAME = "dtb_tmp"
DTS_NAME = "dtsi"

os.system("./mkdtboimg/mkdtimg dump dtbo.img -b " + DTB_NAME)

for i in range(20):
    fi  = DTB_NAME + "." + str(i)
    fo  = DTS_NAME + "." + str(i)
    cmd = "./dtc/dtc -I dtb -O dts " + fi + " -o " + fo 
    if os.path.isfile(fi):
        print(cmd)
        os.system(cmd)
        os.chmod(fo,0o777)
        os.remove(fi)
    else:
        break