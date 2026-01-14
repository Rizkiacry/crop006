#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([5. BATERAI])
    CMOS battery adalah coin-cell lithium battery (biasanya CR2032) yang mensupply daya ke motherboard's real-time clock (RTC) dan CMOS memory saat PC powered off.

    *Fungsi:* Mempertahankan system time dan date melalui RTC chip yang menggunakan quartz crystal oscillating pada 32.768 kHz. RTC chip menyimpan registers yang menyimpan time information (hours, minutes, seconds, day, month, year). Menjaga BIOS/UEFI settings termasuk hardware configurations, boot sequence, power management settings, dan password settings antar restarts. Mencegah system revert ke default settings saat PC unplugged.

    *Lifespan:* Battery rata-rata tahan 3 tahun jika computer regularly unplugged. Signs dari weak battery: incorrect date/time display, system reverting ke default BIOS settings setiap boot, website errors seperti "your clock is ahead/behind."
  ]
})