#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([4. CHIPSET])
    Chipset mengatur aliran power dan data. Chipset dahulu dipecah menjadi Northbridge (koneksi CPU-RAM-GPU) dan Southbridge (I/O peripherals). Northbridge sekarang embedded di CPU dan Southbridge menjadi single Platform Controller Hub.]
})
