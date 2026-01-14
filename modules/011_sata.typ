#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([3. KONEKTOR SATA])
    SATA (Serial ATA) adalah interface standar untuk menghubungkan storage devices seperti hard drives dan SSDs ke motherboard. SATA mengalami evolusi dengan tiga generasi:

    *SATA I (SATA 1.5 Gb/s):* Transfer rate 1,5 gigabit per detik, throughput 150 MB/s. Standar awal yang diperkenalkan 2003.

    *SATA II (SATA 3 Gb/s):* Transfer rate 3,0 gigabit per detik, throughput 300 MB/s. Diperkenalkan April 2004, menggandakan kecepatan predecessor.

    *SATA III (SATA 6 Gb/s):* Transfer rate 6,0 gigabit per detik, throughput 600 MB/s. Standar modern diperkenalkan Juli 2008. Semua generasi SATA backward compatible, memungkinkan drives lama bekerja di interface newer dengan speed dibatasi oleh capability terendah.
  ]
})