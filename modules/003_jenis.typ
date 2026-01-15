#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([Jenis-Jenis Motherboard])
    
    #sub-section-title([ATX (Advanced Technology eXtended)])
    #align(center, image("../assets/components/atx_motherboard.jpg", width: 90%))
    Diperkenalkan Intel tahun 1995, ATX adalah standar motherboard desktop yang paling umum digunakan. Ukurannya 305 mm × 244 mm (12 inci × 9,6 inci). Motherboard ATX menawarkan 4-7 slot ekspansi PCIe, multiple RAM slots, numerous USB ports, dan konektor power 24-pin. Desain ini memberikan keseimbangan optimal antara expandability dan ukuran case standar.

    #sub-section-title([Micro-ATX (mATX)])
    #align(center, image("../assets/components/matx_motherboard.svg", width: 90%))
    Distandarkan tahun 1997, Micro-ATX mengukur 244 mm × 244 mm (9,6 inci × 9,6 inci). Ini adalah subset mounting points ATX penuh, memungkinkan backward compatibility dengan case ATX. Motherboard mATX memiliki 2-4 slot ekspansi PCIe, 4 RAM slot, dan menggunakan power connector ATX standar. Cocok untuk small form factor builds tanpa mengorbankan fitur esensial.

    #sub-section-title([Mini-ITX])
    #align(center, image("../assets/components/mini_itx.jpg", width: 90%))
    Mini-ITX berukuran 170 mm × 170 mm (6,7 inci × 6,7 inci), dirancang untuk komputer ultra-compact. Format ini memiliki satu PCIe slot untuk GPU dan expandability terbatas. Ideal untuk HTPC dan sistem dengan space constraint, namun mengorbankan beberapa expansion options.
  ]
})
