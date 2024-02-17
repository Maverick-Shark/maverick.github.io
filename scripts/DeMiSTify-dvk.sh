#! /bin/sh
# use . DeMiSTify.sh
# Work dir: /Cores
# #

cd /Cores
git clone git@github.com:Maverick-Shark/dvk-fpga.git

#
cd dvk-fpga/
git branch demistified
git checkout demistified
git branch

#
cd /Cores/dvk-fpga/
git submodule add git@github.com:Maverick-Shark/DeMiSTify.git
git submodule update --init

#
cd /Cores/dvk-fpga/DeMiSTify/
git submodule update
git submodule init
git submodule update

#
cp /Cores/site.mk .
cp /Cores/dvk-fpga/board/MiST/build_id_verilog.tcl /Cores/dvk-fpga/

#
# top.qsf
cat > /Cores/dvk-fpga/files.qip << EOF
set_global_assignment -name VERILOG_FILE ../hdl/topboard.v
set_global_assignment -name VERILOG_FILE ../hdl/mc1201-02.v
set_global_assignment -name VERILOG_FILE ../hdl/mc1201-01.v
set_global_assignment -name VERILOG_FILE ../hdl/mc1260.v
set_global_assignment -name VERILOG_FILE ../hdl/mc1280.v
set_global_assignment -name VERILOG_FILE ../board/MiST/modules/osd.v
set_global_assignment -name VERILOG_FILE ../board/MiST/modules/user_io.v
set_global_assignment -name VERILOG_FILE ../board/MiST/modules/sd_card.v
set_global_assignment -name VERILOG_FILE ../hdl/kgd-graphics.v
set_global_assignment -name VERILOG_FILE ../hdl/ksm/vtreset.v
set_global_assignment -name VERILOG_FILE ../hdl/ksm/vtram.v
set_global_assignment -name VERILOG_FILE ../hdl/ksm/ksm.v
set_global_assignment -name VERILOG_FILE ../hdl/ksm/vregs.v
set_global_assignment -name VERILOG_FILE ../hdl/ksm/vga.v
set_global_assignment -name VERILOG_FILE ../hdl/ksm/ps2.v
set_global_assignment -name VERILOG_FILE ../hdl/ksm/ksm_vic.v
set_global_assignment -name VERILOG_FILE ../hdl/fdd-my.v
set_global_assignment -name VERILOG_FILE ../hdl/rx01.v
set_global_assignment -name VERILOG_FILE ../hdl/dw.v
set_global_assignment -name VERILOG_FILE ../hdl/rk611.v
set_global_assignment -name VERILOG_FILE ../hdl/rk11.v
set_global_assignment -name VERILOG_FILE ../hdl/sdspi.v
set_global_assignment -name VERILOG_FILE ../hdl/irpr-centronix.v
set_global_assignment -name VERILOG_FILE ../hdl/wbc_vic.v
set_global_assignment -name VERILOG_FILE ../hdl/wbc_uart.v
set_global_assignment -name VERILOG_FILE ../hdl/wbc_rst.v
set_global_assignment -name VERILOG_FILE ../hdl/m2/lsi_wb.v
set_global_assignment -name VERILOG_FILE ../hdl/m2/mcp_plm.v
set_global_assignment -name VERILOG_FILE ../hdl/m2/mcp1631.v
set_global_assignment -name VERILOG_FILE ../hdl/m2/mcp1621.v
set_global_assignment -name VERILOG_FILE ../hdl/m2/mcp1611.v
set_global_assignment -name VERILOG_FILE ../hdl/m4/am4_wb.v
set_global_assignment -name VERILOG_FILE ../hdl/m4/am4_seq.v
set_global_assignment -name VERILOG_FILE ../hdl/m4/am4_plm.v
set_global_assignment -name VERILOG_FILE ../hdl/m4/am4_mcrom.v
set_global_assignment -name VERILOG_FILE ../hdl/m4/am4_alu.v
set_global_assignment -name VERILOG_FILE ../hdl/vm1/vm1_wb.v
set_global_assignment -name VERILOG_FILE ../hdl/vm1/vm1_tve.v
set_global_assignment -name VERILOG_FILE ../hdl/vm1/vm1_reg.v
set_global_assignment -name VERILOG_FILE ../hdl/vm1/vm1_plm.v
set_global_assignment -name VERILOG_FILE ../hdl/vm2/vm2_wb.v
set_global_assignment -name VERILOG_FILE ../hdl/vm2/vm2_plm.v
set_global_assignment -name SYSTEMVERILOG_FILE ../board/MiST/modules/sdram.sv
set_global_assignment -name VERILOG_FILE ../board/MiST/ip-components/userrom.v
set_global_assignment -name VERILOG_FILE ../board/MiST/ip-components/fontrom.v
set_global_assignment -name VERILOG_FILE pll.v
set_global_assignment -name QIP_FILE pll.qip
set_global_assignment -name VERILOG_FILE ../board/MiST/ip-components/vtmem.v
set_global_assignment -name VERILOG_FILE ../board/MiST/ip-components/bootrom.v
set_global_assignment -name VERILOG_FILE ../board/MiST/ip-components/sectorbuf.v
set_global_assignment -name VERILOG_FILE ../board/MiST/ip-components/rom055.v
set_global_assignment -name VERILOG_FILE ../board/MiST/ip-components/rom000.v
set_global_assignment -name QIP_FILE ../board/MiST/ip-components/kgdvram.qip
EOF

mkdir /Cores/dvk-fpga/firmware
:> /Cores/dvk-fpga/firmware/config.h
:> /Cores/dvk-fpga/firmware/overrides.c

cd /Cores/dvk-fpga/
cp /Cores/dvk-fpga/DeMiSTify/templates/Makefile .
cp /Cores/dvk-fpga/DeMiSTify/templates/project_files.rtl .
cp /Cores/dvk-fpga/DeMiSTify/templates/project_defs.tcl .
cp /Cores/dvk-fpga/DeMiSTify/templates/demistify_config_pkg.vhd .

#
sed -i -e 's/PROJECT=project/PROJECT=dvk-fpga/g' /Cores/dvk-fpga/Makefile

# remove below line 15 if not used or it will give error
sed -i -e 's/project.qip/files.qip/g' /Cores/dvk-fpga/project_files.rtl

sed -i -e '15,$d' /Cores/dvk-fpga/project_files.rtl

sed -i -e '$a\
build_id_verilog.tcl' /Cores/dvk-fpga/project_files.rtl

read -t 5 -p "I'm going to wait for 5 seconds only ..."

cd /Cores/dvk-fpga/
make firmware

ls -l DeMiSTify/Board/poseidon-ep4cgx150/

make BOARD=poseidon-ep4cgx150 init

read -t 15 -p "I'm going to wait for 15 seconds only ..."

# #exit 0

cd poseidon-ep4cgx150
cp ../board/MiST/ip-components/pll.qip .
cp ../board/MiST/ip-components/pll.v .

cp ../DeMiSTify/templates/poseidon-ep4cgx150/poseidon_top.sv .

sed -i -e '42s/^/--/g' /Cores/dvk-fpga/demistify_config_pkg.vhd

# # sed -i -e 's/module vic20_mist/module guest_top/g' /Cores/dvk-fpga/++++++++_mist.sv

# # top.qip file
cat > /Cores/dvk-fpga/poseidon-ep4cgx150/top.qip << EOF
set_global_assignment -name QIP_FILE ../board/QMTECH-E55/ip-components/kgdvram.qip
EOF

#cd ../mist-modules/
# #git log
# git checkout master
cd /Cores/
# #
