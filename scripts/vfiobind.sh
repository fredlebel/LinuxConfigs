#! /bin/sh

vfiobind() {
    dev="$1"
    vendor=$(cat /sys/bus/pci/devices/$dev/vendor)
    device=$(cat /sys/bus/pci/devices/$dev/device)
    if [ -e /sys/bus/pci/devices/$dev/driver ]; then
        echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
    fi
    echo $vendor $device > /sys/bus/pci/drivers/vfio-pci/new_id
}

vfiobind 0000:01:00.0
vfiobind 0000:01:00.1

# qemu-kvm \
    # -m 8G \
    # -cpu host \
    # -smp sockets=1,cores=3,threads=2 \
    # -device pci-assign,host=01:00.0 \
    # -device pci-assign,host=01:00.1 \
    # vmImage.img
