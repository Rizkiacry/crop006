#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([2. SLOT EKSPANSI PCI Express])
    PCIe slots memungkinkan instalasi expansion cards. Setiap slot memiliki jumlah data lanes berbeda yang menentukan bandwidth transfer:

    *PCIe x1:* Satu lane ukuran 25 mm. Digunakan untuk low-speed devices seperti sound cards, network adapters, dan simple I/O cards.

    *PCIe x4:* Empat lanes ukuran 39 mm. Cocok untuk NVMe SSDs expansion cards, 4K capture devices, dan medium-performance peripherals. 

    *PCIe x8:* Delapan lanes ukuran 56 mm. Jarang digunakan di desktop consumer market. 

    *PCIe x16:* Enam belas lanes ukuran 82 mm. Slot terstandar untuk graphics cards dan GPU.

    Backward compatibility memungkinkan x1 atau x4 cards untuk dipasang di x8 atau x16 slots dengan speed native.
  ]
})
