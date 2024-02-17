#! /bin/sh
# use . DeMiSTify.sh
# Work dir: /Cores
# #

cd /Cores
git clone git@github.com:Maverick-Shark/BK0011M_MIST.git

# #
cd BK0011M_MIST/
git branch demistified
git checkout demistified
git branch

# #
cd /Cores/BK0011M_MIST/
git submodule add git@github.com:Maverick-Shark/DeMiSTify.git
git submodule update --init

# #
cd /Cores/BK0011M_MIST/DeMiSTify/
git submodule update
git submodule init
git submodule update

# #
cp /Cores/site.mk .
# cp /Cores/build_id.tcl .

# #
# # top.qsf
cat > /Cores/BK0011M_MIST/files.qip << EOF
set_global_assignment -name VERILOG_FILE ../VM1/vm1_vic.v
set_global_assignment -name VERILOG_FILE ../VM1/vm1_tve.v
set_global_assignment -name VERILOG_FILE ../VM1/vm1_plm.v
set_global_assignment -name VERILOG_FILE ../VM1/vm1_alib.v
set_global_assignment -name VERILOG_FILE ../VM1/vm1_qbus_se.v
set_global_assignment -name VERILOG_FILE ../VM1/vm1_se.v
set_global_assignment -name VERILOG_FILE pll.v
set_global_assignment -name VERILOG_FILE ../translate.v
set_global_assignment -name SYSTEMVERILOG_FILE ../keyboard.sv
set_global_assignment -name VERILOG_FILE ../ps2_mouse.v
set_global_assignment -name VERILOG_FILE ../data_io.v
set_global_assignment -name VERILOG_FILE ../user_io.v
set_global_assignment -name VERILOG_FILE ../sector_w2b.v
set_global_assignment -name VERILOG_FILE ../sector_b2d.v
set_global_assignment -name VERILOG_FILE ../sector_b2w.v
set_global_assignment -name VERILOG_FILE ../dpram.v
set_global_assignment -name SYSTEMVERILOG_FILE ../sram.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../memory.sv
set_global_assignment -name VERILOG_FILE ../sigma_delta_dac.v
set_global_assignment -name SYSTEMVERILOG_FILE ../ym2149.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../hq2x.sv
set_global_assignment -name VERILOG_FILE ../scandoubler.v
set_global_assignment -name VERILOG_FILE ../osd.v
set_global_assignment -name SYSTEMVERILOG_FILE ../video_mixer.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../video.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../disk.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../bk0011m.sv
EOF

mkdir /Cores/BK0011M_MIST/firmware
:> /Cores/BK0011M_MIST/firmware/config.h
:> /Cores/BK0011M_MIST/firmware/overrides.c

cd /Cores/BK0011M_MIST/
cp /Cores/BK0011M_MIST/DeMiSTify/templates/Makefile .
cp /Cores/BK0011M_MIST/DeMiSTify/templates/project_files.rtl .
cp /Cores/BK0011M_MIST/DeMiSTify/templates/project_defs.tcl .
cp /Cores/BK0011M_MIST/DeMiSTify/templates/demistify_config_pkg.vhd .

#
sed -i -e 's/PROJECT=project/PROJECT=BK0011M/g' /Cores/BK0011M_MIST/Makefile

# remove below line 15 if not used or it will give error
sed -i -e 's/project.qip/files.qip/g' /Cores/BK0011M_MIST/project_files.rtl

sed -i -e '15,$d' /Cores/BK0011M_MIST/project_files.rtl

sed -i -e '$a\
build_id_verilog.tcl' /Cores/BK0011M_MIST/project_files.rtl

read -t 5 -p "I'm going to wait for 5 seconds only ..."

cd /Cores/BK0011M_MIST/
make firmware

ls -l DeMiSTify/Board/poseidon-ep4cgx150/

make BOARD=poseidon-ep4cgx150 init

read -t 5 -p "I'm going to wait for 5 seconds only ..."

# #exit 0

cd poseidon-ep4cgx150
cp ../pll.v .

cp ../DeMiSTify/templates/poseidon-ep4cgx150/poseidon_top.sv .

sed -i -e '42s/^/--/g' /Cores/BK0011M_MIST/demistify_config_pkg.vhd

sed -i -e 's/module bk0011m/module guest_top/g' /Cores/BK0011M_MIST/bk0011m.sv

# top.qip file
cat > /Cores/BK0011M_MIST/poseidon-ep4cgx150/top.qip << EOF
set_global_assignment -name VERILOG_FILE pll.v
EOF

# cd ../mist-modules/
# #git log
# git checkout master
cd /Cores/
# #
