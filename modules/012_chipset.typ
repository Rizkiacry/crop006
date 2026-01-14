#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([4. CHIPSET])
    Chipset adalah sekumpulan integrated circuit chips yang berfungsi sebagai central hub komunikasi. Chipset mengatur aliran data antara CPU, RAM, storage devices, graphics cards, dan peripheral lainnya. Dalam sistem modern, fungsi yang dulunya dipecah menjadi Northbridge (koneksi CPU-RAM-GPU) dan Southbridge (I/O peripherals) telah diintegrasikan. Northbridge functions sekarang embedded di CPU package, sementara Southbridge functionality dikombinasikan dalam single Platform Controller Hub yang terhubung ke CPU melalui dedicated PCIe lanes. Chipset mengelola:

    • Koordinasi data antar komponen
    • Bus control dan electrical standards
    • Interface provisioning (USB, SATA, PCIe)
    • Power management dan voltage regulation
    • Support untuk hardware features seperti overclocking
  ]
})