#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([6. KONEKTOR M.2])
    M.2 adalah interface modern yang compact dan versatile untuk menghubungkan storage devices internal. Interface ini menggantikan standar mSATA yang lebih tua dan menggunakan PCIe lanes untuk komunikasi:

    *M.2 M Key:* Menggunakan PCIe x4 interface, memberikan read/write speeds hingga 7000 MB/s. Dirancang untuk NVMe SSDs yang membutuhkan high performance. Notch connector terletak lima pins dari right end, memastikan correct physical orientation.

    *M.2 B Key:* Menggunakan PCIe x2 atau SATA interface, ideal untuk older atau lower-performance storage. Notch terletak enam pins dari left end connector. Backward compatibility dengan SATA devices.

    *M.2 B+M Key:* Dual-notch design compatible dengan both M dan B connectors, memberikan flexibility untuk berbagai device types.
  ]
})