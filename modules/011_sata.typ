#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([3. KONEKTOR SATA])
    SATA (Serial ATA) adalah interface single lane storage devices seperti hard drives dan SSDs.
    
    *SATA I (SATA 1.5 Gb/s):* Transfer rate 1,5 Gb/s. Diperkenalkan 2003.

    *SATA II (SATA 3 Gb/s):* Transfer rate 3,0 Gb/s. Diperkenalkan April 2004.

    *SATA III (SATA 6 Gb/s):* Transfer rate 6,0 Gb/s. Diperkenalkan Juli 2008. Semua generasi SATA backward compatible, artinya drives lama bekerja di interface newer dengan speed dibatasi oleh spek terendah.
  ]
})
