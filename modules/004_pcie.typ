#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([2. SLOT EKSPANSI PCIe])
    PCIe (PCI Express) slots memungkinkan instalasi expansion cards untuk meningkatkan fungsi sistem. Setiap slot memiliki jumlah data lanes berbeda yang menentukan bandwidth transfer:

    *PCIe x1:* Satu lane dengan ukuran 25 mm. Digunakan untuk low-speed devices seperti sound cards, network adapters, dan simple I/O cards.

    *PCIe x4:* Empat lanes dengan ukuran 39 mm. Cocok untuk NVMe SSDs expansion cards, 4K capture devices, dan medium-performance peripherals. 

    *PCIe x8:* Delapan lanes dengan ukuran 56 mm. Jarang digunakan di desktop consumer market. 

    *PCIe x16:* Enam belas lanes dengan ukuran 82 mm. Slot terstandar untuk graphics cards dan GPU.

    Backward compatibility memungkinkan x1 atau x4 cards untuk dipasang di x8 atau x16 slots dengan operasi di speed native card tersebut. Down-plugging (memasang card yang lebih besar ke slot lebih kecil) tidak didukung secara fisik.
  ]
})
