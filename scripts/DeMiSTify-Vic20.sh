#! /bin/sh
# use . DeMiSTify-Vic20.sh
# Work dir: /Cores/
# Will create /Cores/VIC20_MiST folder
# #

cd /Cores
git clone git@github.com:Maverick-Shark/VIC20_MiST.git

# #
cd VIC20_MiST/
git branch demistified
git checkout demistified
git branch

# #
cd /Cores/VIC20_MiST/
git submodule add git@github.com:Maverick-Shark/DeMiSTify.git
git submodule update --init

# #
cd /Cores/VIC20_MiST/DeMiSTify/
# # git submodule update
git submodule init
git submodule update

# #
cp /Cores/site.mk .

# #
# # From VIC20_MiST/vic20_SiDi128.qsf (by Gyurco)
cat > /Cores/VIC20_MiST/files.qip << EOF
set_global_assignment -name QIP_FILE ../T65/T65.qip
set_global_assignment -name QIP_FILE ../mist-modules/mist.qip
set_global_assignment -name SYSTEMVERILOG_FILE ../vic20.sv
set_global_assignment -name VERILOG_FILE ../keyboard.v
set_global_assignment -name SYSTEMVERILOG_FILE ../sdram.sv
set_global_assignment -name VERILOG_FILE ../sigma_delta_dac.v
set_global_assignment -name VHDL_FILE ../c1530.vhd
set_global_assignment -name VHDL_FILE ../tap_fifo.vhd
set_global_assignment -name VHDL_FILE ../vic20/vic20_clocks.vhd
set_global_assignment -name VHDL_FILE ../vic20/vic20.vhd
set_global_assignment -name VHDL_FILE ../vic20/rc_filter_1o.vhd
set_global_assignment -name VHDL_FILE ../vic20/m6561.vhd
set_global_assignment -name VERILOG_FILE ../vic20/megacart_nvram.v
set_global_assignment -name VERILOG_FILE ../vic20/megacart.v
set_global_assignment -name VHDL_FILE ../c1541/via6522.vhd
set_global_assignment -name VHDL_FILE ../c1541/spram.vhd
set_global_assignment -name SYSTEMVERILOG_FILE ../c1541/mist_sd_card.sv
set_global_assignment -name VHDL_FILE ../c1541/gcr_floppy.vhd
set_global_assignment -name VHDL_FILE ../c1541/c1541_sd.vhd
set_global_assignment -name VHDL_FILE ../c1541/c1541_logic.vhd
set_global_assignment -name VHDL_FILE ../memories/ram_conf_8192x8.vhd
set_global_assignment -name VHDL_FILE ../memories/ram_conf_2048x8.vhd
set_global_assignment -name VHDL_FILE ../memories/ram_conf_1024x8.vhd
set_global_assignment -name VHDL_FILE ../memories/ram_conf_1024x4.vhd
set_global_assignment -name VHDL_FILE ../memories/gen_rom.vhd
set_global_assignment -name SDC_FILE vic20.sdc
set_global_assignment -name QIP_FILE pll_vic20.qip
set_global_assignment -name QIP_FILE pll_reconfig.qip
set_global_assignment -name QIP_FILE rom_reconfig_pal.qip
set_global_assignment -name QIP_FILE rom_reconfig_ntsc.qip
EOF

# # Firmware folder
mkdir /Cores/VIC20_MiST/firmware
:> /Cores/VIC20_MiST/firmware/config.h
:> /Cores/VIC20_MiST/firmware/overrides.c

cd /Cores/VIC20_MiST/
cp /Cores/VIC20_MiST/DeMiSTify/templates/Makefile .
cp /Cores/VIC20_MiST/DeMiSTify/templates/project_files.rtl .
cp /Cores/VIC20_MiST/DeMiSTify/templates/project_defs.tcl .
cp /Cores/VIC20_MiST/DeMiSTify/templates/demistify_config_pkg.vhd .

# Change project name
sed -i -e 's/PROJECT=project/PROJECT=vic-20/g' /Cores/VIC20_MiST/Makefile

# /Cores/VIC20_MiST/project_files.rtl
# change project.qip by files.qip entry
sed -i -e 's/project.qip/files.qip/g' /Cores/VIC20_MiST/project_files.rtl
# remove below line 15 if not used or it will give error
sed -i -e '15,$d' /Cores/VIC20_MiST/project_files.rtl

# #sed -i -e '$d' /Cores/VIC20_MiST/project_files.rtl
# #sed -i -e '$s/^/## /' /Cores/VIC20_MiST/project_files.rtl

# #sed -i -e '/firmware_std/d' /Cores/VIC20_MiST/project_files.rtl
# #sed -i -e '/standard/d' /Cores/VIC20_MiST/project_files.rtl

# add build_id.tcl entry (at the end of file)
sed -i -e '$a\
build_id.tcl' /Cores/VIC20_MiST/project_files.rtl

# #sed -i -e '$a\
# #\
# ### Pre-flow scripts\
# ### rtl/build_id.tcl\
# #build_id.tcl\
# #' /Cores/VIC20_MiST/project_files.rtl
# # echo 'build_id.tcl' >> /Cores/VIC20_MiST/project_files.rtl

# 5sec pause
read -t 5 -p "I'm going to wait for 5 seconds only ..."

cd /Cores/VIC20_MiST/
make firmware

ls -l /Cores/VIC20_MiST/DeMiSTify/Board/poseidon-ep4cgx150/

make BOARD=poseidon-ep4cgx150 init

# 5sec pause
read -t 5 -p "I'm going to wait for 5 seconds only ..."

cd /Cores/VIC20_MiST/poseidon-ep4cgx150
cp ../pll_vic20.qip .
cp ../pll_vic20.v .
cp ../pll_vic20_ntsc.mif .
cp ../pll_vic20_pal.mif .
cp ../pll_reconfig.qip .
cp ../pll_reconfig.v .
cp ../pll27.qip .
cp ../pll27.vhd .

cp ../rom_reconfig_pal.qip .
cp ../rom_reconfig_pal.v .
cp ../rom_reconfig_ntsc.qip .
cp ../rom_reconfig_ntsc.v .

cp ../DeMiSTify/templates/poseidon-ep4cgx150/poseidon_top.sv .

# /Cores/VIC20_MiST/demistify_config_pkg.vhd
sed -i -e '42s/^/--/g' /Cores/VIC20_MiST/demistify_config_pkg.vhd
# # sed -i -e '$s/^/## /' /Cores/VIC20_MiST/project_files.rtl

# # cd VIC20_MiST
# # vi vic20.sv
# # Mod vic20.sv (/Cores/VIC20_MiST/vic20.sv) file
# #  module vic20_mist -> module guest_top
sed -i -e 's/module vic20_mist/module guest_top/g' /Cores/VIC20_MiST/vic20.sv

# # Create top.qip file
cat > /Cores/VIC20_MiST/poseidon-ep4cgx150/top.qip << EOF
set_global_assignment -name QIP_FILE pll27.qip
set_global_assignment -name QIP_FILE pll_vic20.qip
set_global_assignment -name QIP_FILE pll_reconfig.qip
set_global_assignment -name QIP_FILE rom_reconfig_pal.qip
set_global_assignment -name QIP_FILE rom_reconfig_ntsc.qip
EOF

# # vi /Cores/VIC20_MiST/poseidon-ep4cgx150/pll27.vhd
# # vi /Cores/VIC20_MiST/poseidon-ep4cgx150/pll_vic20.v

# Mod pll files to adapt clocks and frequency

sed -i -e 's/27,/50,/g' /Cores/VIC20_MiST/poseidon-ep4cgx150/pll27.vhd
sed -i -e 's/37037,/20000,/g' /Cores/VIC20_MiST/poseidon-ep4cgx150/pll27.vhd

sed -i -e 's/27000000,/50000000,/g' /Cores/VIC20_MiST/poseidon-ep4cgx150/pll_vic20.v
sed -i -e 's/37037,/20000,/g' /Cores/VIC20_MiST/poseidon-ep4cgx150/pll_vic20.v

cd /Cores/VIC20_MiST/mist-modules/
# # git log
git checkout master
cd /Cores/
# #
