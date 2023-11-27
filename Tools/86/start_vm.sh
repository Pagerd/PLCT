#!/usr/bin/env bash

# The script is created for starting a riscv64 qemu virtual machine with specific parameters.

RESTORE=$(echo -en '\001\033[0m\002')
YELLOW=$(echo -en '\001\033[00;33m\002')

## Configuration
vcpu=8
memory=8
bri="br0"
tap="tap"
memory_append=`expr $memory \* 1024`
#drive="mugen_ready.qcow2"
#drive="img_bak.qcow2"
drive="img_base.qcow2"
#drive="x86_test.qcow2"
#drive="openEuler-23.09-x86_64.qcow2"
#fw="fw_payload_oe_uboot_2304.bin"
kernel="vmlinuz"
initrd="initrd.img"
ssh_port=12057




cmd="qemu-system-x86_64 \
  -nographic -M pc -accel kvm \
  -cpu host \
  -smp "$vcpu" -m "$memory"G \
  -drive file="$drive",format=qcow2,id=hd0,if=none \
  -object rng-random,filename=/dev/urandom,id=rng0 \
  -device virtio-vga \
  -device virtio-rng,rng=rng0 \
  -device virtio-blk,drive=hd0 \
  -device virtio-net,netdev=usernet \
  -netdev user,id=usernet,hostfwd=tcp::"$ssh_port"-:22 \
  -device qemu-xhci -usb -device usb-kbd -device usb-tablet \
  -netdev tap,id=net${tap}0,ifname=${tap}0,script=no,downscript=no \
  -device virtio-net-pci,netdev=net${tap}0,mac=52:54:00:11:45:01 \
  -drive if=pflash,format=raw,file=OVMF.fd"


echo ${YELLOW}:: Starting VM...${RESTORE}
echo ${YELLOW}:: Using following configuration${RESTORE}
echo ""
echo ${YELLOW}vCPU Cores: "$vcpu"${RESTORE}
echo ${YELLOW}Memory: "$memory"G${RESTORE}
echo ${YELLOW}Disk: "$drive"${RESTORE}
echo ${YELLOW}SSH Port: "$ssh_port"${RESTORE}
echo ""
echo ${YELLOW}:: NOTE: Make sure ONLY ONE .qcow2 file is${RESTORE}
echo ${YELLOW}in the current directory${RESTORE}
echo ""
echo ${YELLOW}:: Tip: Try setting DNS manually if QEMU user network doesn\'t work well. ${RESTORE}
echo ${YELLOW}:: HOWTO -\> https://serverfault.com/a/810639 ${RESTORE}
echo ""
echo ${YELLOW}:: Tip: If \'ping\' reports permission error, try reinstalling \'iputils\'. ${RESTORE}
echo ${YELLOW}:: HOWTO -\> \'sudo dnf reinstall iputils\' ${RESTORE}
echo ""

sleep 2

echo $cmd
eval $cmd
