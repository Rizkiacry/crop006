#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([9. SOKET])
    Socket CPU adalah konektor pada motherboard tempat prosesor dipasang. Terdapat dua produsen CPU utama dengan socket proprietary:

    #sub-section-title([Intel LGA 1700])
    Socket land grid array dengan 1700 pin yang terletak di motherboard. Digunakan untuk Intel Core generasi 12, 13, dan 14. Mendukung DDR5 memory dan PCIe 5.0 pada chipset kompatibel. Pin-pin ini menyambung ke trace PCB yang membawa instruksi dan data ke CPU.

    #sub-section-title([AMD AM5 (LGA 1718)])
    Socket LGA dengan 1718 contact pins untuk Ryzen 7000 series dan newer. Successor dari AM4 socket yang menggunakan PGA design. AM5 mandatory mendukung DDR5 (tidak ada DDR4 compatibility). Mensupport PCIe 5.0 lanes dari CPU pada X870E dan X870 chipsets.
  ]
})