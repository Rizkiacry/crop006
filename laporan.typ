#set page(width: 11in, height: 17in, margin: 0.5in)
#set text(font: "Times New Roman", size: 10pt, lang: "id")

#let heading_style(text) = {
  set text(weight: "bold", size: 12pt, fill: rgb("#1f4788"))
  text
}

#let subheading_style(text) = {
  set text(weight: "bold", size: 10pt, fill: rgb("#2d5aa0"))
  text
}

// --- COVER / GROUP INFO ---
#align(center)[
  #text(size: 18pt, weight: "bold", fill: rgb("#1f4788"))[MEMBEDAH KOMPONEN MOTHERBOARD (PAPAN INDUK)]
  
  #v(0.1in)
  
  #text(size: 12pt, weight: "bold")[Kelompok 9]
  
  #grid(
    columns: (auto, auto),
    gutter: 1em,
    align: left,
    [FX. Oktabimo DwiPriabudi Sumintro], [(202531085)],
    [Zain Akbar Rizkia], [(202531091)],
    [Iqbal Raihan Raffianza], [(202531111)],
    [Gilang Azhar Robani], [(202531114)]
  )
]

#v(0.2in)

// --- DEFINISI ---
== Definisi dan Fungsi

Apa itu Motherboard? Motherboard adalah papan sirkuit utama pada komputer maupun laptop yang menjadi tempat berbagai komponen penting saling terhubung dan berkomunikasi. Bisa dibilang bahwa motherboard termasuk perangkat keras (hardware) utama dalam sistem komputer yang memiliki peran penting. Secara sederhana, fungsi motherboard adalah sebagai penghubung antara komponen-komponen seperti prosesor (CPU), RAM, VGA (GPU), storage, dan perangkat input/output lainnya. Tanpa motherboard, komponen-komponen ini tidak akan bisa bekerja dengan baik.

Dalam tinjauan teknis, Motherboard adalah papan sirkuit cetak utama yang menghubungkan dan mengkoordinasikan komunikasi antara semua komponen elektronik penting sistem komputer. Papan ini menampung CPU, memori RAM, chipset, dan menyediakan interface untuk semua perangkat peripheral. Motherboard berfungsi sebagai tulang punggung sistem komputer, memastikan setiap komponen dapat berkomunikasi secara efisien dan terkoordinasi.

#v(0.15in)

// --- JENIS MOTHERBOARD ---
== Jenis-Jenis Motherboard

Apa saja jenis-jenis motherboard? Berikut adalah klasifikasi berdasarkan ukuran dan spesifikasi:

=== ATX (Advanced Technology eXtended)
#align(center, image("assets/components/atx_motherboard.jpg", width: 60%))
Merupakan motherboard dengan ukuran standar untuk desktop PC dengan banyak slot ekspansi. 

Diperkenalkan Intel tahun 1995, ATX adalah standar motherboard desktop yang paling umum digunakan. Ukurannya 305 mm × 244 mm (12 inci × 9,6 inci). Motherboard ATX menawarkan 4-7 slot ekspansi PCIe, multiple RAM slots, numerous USB ports, dan konektor power 24-pin. Desain ini memberikan keseimbangan optimal antara expandability dan ukuran case standar.

=== Micro-ATX (mATX)
#align(center, image("assets/components/matx_motherboard.svg", width: 60%))
Merupakan jenis motherboard yang lebih kecil dari ATX, cocok untuk PC yang lebih ringkas.

Distandarkan tahun 1997, Micro-ATX mengukur 244 mm × 244 mm (9,6 inci × 9,6 inci). Ini adalah subset mounting points ATX penuh, memungkinkan backward compatibility dengan case ATX. Motherboard mATX memiliki 2-4 slot ekspansi PCIe, 4 RAM slot, dan menggunakan power connector ATX standar. Cocok untuk small form factor builds tanpa mengorbankan fitur esensial.

=== Mini-ITX
#align(center, image("assets/components/mini_itx.jpg", width: 60%))
Merupakan jenis motherboard dengan ukuran paling kecil, sering digunakan untuk sistem PC mini atau HTPC (Home Theater PC).

Mini-ITX berukuran 170 mm × 170 mm (6,7 inci × 6,7 inci), dirancang untuk komputer ultra-compact. Format ini memiliki satu PCIe slot untuk GPU dan expandability terbatas. Ideal untuk HTPC dan sistem dengan space constraint, namun mengorbankan beberapa expansion options.

#v(0.15in)

#align(center, text(size: 14pt, weight: "bold", fill: rgb("#1f4788"))[ANALISIS KOMPONEN MOTHERBOARD])
#v(0.1in)

// --- BIOS / UEFI ---
== BIOS dan UEFI
#align(center, image("assets/components/bios_uefi.JPG", width: 60%))

BIOS merupakan program perangkat lunak yang dapat memberikan instruksi dasar pada komputer saat diaktifkan, termasuk proses booting. BIOS bertanggung jawab untuk mendeteksi komponen-komponen perangkat keras dan memuat sistem operasi komputer. Secara teknis, BIOS (Basic Input/Output System) adalah firmware yang disimpan dalam chip memory pada motherboard, bertanggung jawab untuk hardware initialization saat sistem start-up. BIOS memverifikasi semua komponen sistem dan mengload bootloader dari storage device.

Pada beberapa Motherboard, BIOS tradisional digantikan oleh UEFI. UEFI memungkinkan komputer untuk boot lebih cepat, menyediakan lebih banyak alat diagnostik, dan menyediakan antarmuka yang lebih efisien antara sistem operasi dan komponen komputer. UEFI (Unified Extensible Firmware Interface) adalah replacement modern untuk legacy BIOS dengan capabilities lebih advanced:

*UEFI Advantages:* Graphical user interface dengan mouse support, support untuk disk lebih dari 2 TB melalui GPT partition scheme, Secure Boot feature untuk preventing unauthorized boot, faster parallel hardware initialization, storage boot information sebagai .efi file di hard drive bukan chip saja.

*Legacy BIOS:* Sequential hardware initialization, MBR partition support dengan 2 TB limit, basic password protection, 16-bit architecture. Mayoritas motherboard modern support UEFI BIOS sepenuhnya.

#v(0.15in)

// --- CPU SOCKET ---
== Soket CPU (Socket)

Juga dikenal sebagai slot CPU, komponen ini digunakan untuk menghubungkan mikroprosesor dengan papan sirkuit cetak (PCB) tanpa perlu menyolder, sehingga memudahkan pemasangan atau penggantian CPU pada motherboard. Soket CPU umumnya ditemukan pada PC dan server. Socket CPU adalah konektor pada motherboard tempat prosesor dipasang.

Jenis-jenis soket CPU yang umum meliputi Pin Grid Array (PGA) dan Land Grid Array (LGA). Perbedaan antara keduanya adalah PGA menempatkan pin pada prosesor dan lubang pada soket, sedangkan LGA memiliki soket dengan pin yang dipasang pada prosesor. Terdapat dua produsen CPU utama dengan socket proprietary:

*Intel LGA 1700:* Socket land grid array dengan 1700 pin yang terletak di motherboard. Digunakan untuk Intel Core generasi 12, 13, dan 14. Mendukung DDR5 memory dan PCIe 5.0 pada chipset kompatibel. Pin-pin ini menyambung ke trace PCB yang membawa instruksi dan data ke CPU.
#align(center, image("assets/components/lga_1700.jpg", width: 50%))

*AMD AM5 (LGA 1718):* Socket LGA dengan 1718 contact pins untuk Ryzen 7000 series dan newer. Successor dari AM4 socket yang menggunakan PGA design. AM5 mandatory mendukung DDR5 (tidak ada DDR4 compatibility). Mensupport PCIe 5.0 lanes dari CPU pada X870E dan X870 chipsets.
#align(center, image("assets/components/am5.png", width: 50%))

#v(0.15in)

// --- CHIPSET ---
== Chipset
#align(center, image("assets/components/chipset.jpg", width: 60%))

Chipset motherboard adalah "otak" atau pengontrol lalu lintas data pada papan sirkuit utama (motherboard) yang bertugas mengelola komunikasi antara CPU, RAM, kartu grafis, penyimpanan (SSD/HDD), dan perangkat periferal lainnya. Chipset ini menentukan kompatibilitas komponen (misalnya, jenis RAM atau prosesor yang didukung) dan fitur yang tersedia di motherboard, seperti opsi overclocking atau jumlah port USB/M.2, berfungsi sebagai jembatan vital agar semua komponen bisa bekerja sama secara efisien.

Lebih detailnya, Chipset adalah sekumpulan integrated circuit chips yang berfungsi sebagai central hub komunikasi. Dalam sistem modern, fungsi yang dulunya dipecah menjadi Northbridge (koneksi CPU-RAM-GPU) dan Southbridge (I/O peripherals) telah diintegrasikan. Northbridge functions sekarang embedded di CPU package, sementara Southbridge functionality dikombinasikan dalam single Platform Controller Hub yang terhubung ke CPU melalui dedicated PCIe lanes. Chipset mengelola:
• Koordinasi data antar komponen
• Bus control dan electrical standards
• Interface provisioning (USB, SATA, PCIe)
• Power management dan voltage regulation
• Support untuk hardware features seperti overclocking

#v(0.15in)

// --- PCIE ---
== Slot Ekspansi PCIe
#align(center, image("assets/components/pcie_slot.jpg", width: 60%))

PCIe adalah standar antarmuka berkecepatan tinggi yang digunakan dalam komputer untuk menghubungkan berbagai komponen ke motherboard. Standar ini menggantikan standar lama seperti PCI dan AGP, menawarkan kinerja dan bandwidth yang jauh lebih baik. PCIe telah menjadi standar de facto untuk menghubungkan segala sesuatu mulai dari kartu grafis hingga perangkat penyimpanan dalam komputer modern. PCIe diperkenalkan pada tahun 2003 sebagai pengganti standar yang lebih lama. Arsitektur point-to-point-nya memungkinkan kecepatan yang lebih tinggi dan transfer data yang lebih efisien.

PCIe (PCI Express) slots memungkinkan instalasi expansion cards untuk meningkatkan fungsi sistem. Setiap slot memiliki jumlah data lanes berbeda yang menentukan bandwidth transfer:

*PCIe x1:* Satu lane dengan ukuran 25 mm. Digunakan untuk low-speed devices seperti sound cards, network adapters, dan simple I/O cards.
*PCIe x4:* Empat lanes dengan ukuran 39 mm. Cocok untuk NVMe SSDs expansion cards, 4K capture devices, dan medium-performance peripherals.
*PCIe x8:* Delapan lanes dengan ukuran 56 mm. Jarang digunakan di desktop consumer market.
*PCIe x16:* Enam belas lanes dengan ukuran 82 mm. Slot terstandar untuk graphics cards dan GPU. Memberikan bandwidth maksimal untuk data-intensive peripherals.

Backward compatibility memungkinkan x1 atau x4 cards untuk dipasang di x8 atau x16 slots dengan operasi di speed native card tersebut.

#v(0.15in)

// --- RAM ---
== Slot DIMM dan Memori RAM
#align(center, image("assets/components/dimm_slot.jpg", width: 60%))

Slot RAM pada motherboard PC adalah saluran panjang, umumnya terletak dekat dengan CPU. Terdapat penjepit di setiap ujung soket, yang akan terkunci rapat di sekitar tepi RAM saat dipasang. Menekan RAM ke dalam soket akan mengaktifkan penjepit ini, sehingga penjepit harus dinonaktifkan sebelum Anda dapat melepas RAM yang terpasang. Biasanya, motherboard memiliki total 4 slot RAM atau dua pasang jika menggunakan dual-channel.

DIMM slots adalah konektor tempat RAM modules dipasang. Motherboard modern menggunakan DDR5 SDRAM dengan spesifikasi:

*DDR5 Memory:* Memulai kecepatan 4800 MT/s, meningkat hingga 8800 MT/s atau lebih. Ini 50% lebih cepat dari DDR4 maximum 3200 MT/s. DDR5 menggunakan voltage 1.1V dibanding DDR4 1.2V.
*Memory Density:* DDR5 mendukung capacities hingga 512 GB per DIMM, octupling dari DDR4's 64 GB maximum.
*Module Features:* On-Die ECC untuk error correction pada chip level, CRC protection pada read/write operations. Center notch acts sebagai physical key, preventing installation dari incompatible memory types.

#v(0.15in)

// --- STORAGE (M.2 & SATA) ---
== Konektor Penyimpanan (Storage)

=== Konektor M.2
#align(center, image("assets/components/m2_slot.jpg", width: 60%))
Slot M.2 pada motherboard adalah antarmuka compact dan berkecepatan tinggi untuk kartu ekspansi internal, terutama SSD, yang menawarkan kinerja jauh lebih cepat daripada drive SATA lama dengan menggunakan jalur PCIe. M.2 adalah interface modern yang versatile untuk menghubungkan storage devices internal. Interface ini menggantikan standar mSATA yang lebih tua:

*M.2 M Key:* Menggunakan PCIe x4 interface, memberikan read/write speeds hingga 7000 MB/s. Dirancang untuk NVMe SSDs yang membutuhkan high performance.
*M.2 B Key:* Menggunakan PCIe x2 atau SATA interface, ideal untuk older atau lower-performance storage.
*M.2 B+M Key:* Dual-notch design compatible dengan both M dan B connectors.

=== Konektor SATA
#align(center, image("assets/components/sata_port.jpg", width: 60%))
Port SATA adalah konektor pada motherboard komputer yang memungkinkan pemasangan perangkat penyimpanan SATA. Biasanya berupa port kecil berbentuk persegi panjang dengan deretan pin logam. Port SATA sebagian besar telah menggantikan teknologi antarmuka paralel yang lebih lama seperti IDE dan SCSI karena kecepatan transfer data yang lebih cepat.

SATA (Serial ATA) mengalami evolusi dengan tiga generasi:
*SATA I (SATA 1.5 Gb/s):* Transfer rate 1,5 gigabit per detik.
*SATA II (SATA 3 Gb/s):* Transfer rate 3,0 gigabit per detik.
*SATA III (SATA 6 Gb/s):* Transfer rate 6,0 gigabit per detik, throughput 600 MB/s. Standar modern diperkenalkan Juli 2008.

#v(0.15in)

// --- POWER SYSTEM ---
== Sistem Daya (Power)

=== Konektor ATX 24-Pin
#align(center, image("assets/components/atx_24pin.jpg", width: 60%))
Konektor ATX 24-pin adalah kabel daya utama dari catu daya (PSU) ke papan induk, menyediakan daya esensial untuk komponen seperti CPU, RAM, dan chipset. Konektor ini berkembang dari desain 20-pin untuk menambah daya (terutama +12V) dan pin ground untuk perangkat keras modern.

Diperkenalkan pada ATX 2.0 specification tahun 2003, connector ini dibagi menjadi dua bagian dengan small protrusion. Bagian initial menyediakan power dari PSU dengan maximum 75W. Bagian second berisi data paths untuk power delivery. Tambahan 4 pins dalam 24-pin connector dibanding predecessor memberikan higher current capacity pada +12V rail. Separate 8-pin EPS/ATX 12V connector juga required pada modern systems untuk delivering dedicated CPU power.

=== Voltage Regulator Module (VRM)
#align(center, image("assets/components/vrm.jpg", width: 60%))
VRM merupakan singkatan dari Voltage Regulator Module. Komponen ini terdiri dari sekelompok komponen yang terintegrasi pada motherboard yang membentuk sirkuit yang mengambil output 12 volt yang dihasilkan oleh catu daya, kemudian mengonversi dan mengaturnya agar sesuai dengan persyaratan tegangan spesifik dari CPU, GPU, dan RAM.

Secara teknis, VRM adalah buck converter. VRM terdiri dari power MOSFET devices, inductors, dan capacitors yang disolder pada motherboard. Desain VRM modern menggunakan multiphase topology dimana setiap phase berisi set regulators, inductors, dan capacitors. Processor berkomunikasi dengan VRM melalui VID (Voltage Identification) bits pada startup, menginformasikan VRM tentang required supply voltage.

=== Baterai CMOS
CMOS singkatan dari Complementary Metal Oxide Semiconductor. Chip ini memiliki tenaga dari baterai di motherboard yang menyimpan setelan atau pengaturan BIOS dan juga memberi daya ketika komputer tidak menyala. CMOS memiliki peran sebagai sebuah RAM dengan kapasitas kecil yang bisa menjadi memori penyimpanan data hardware pengaturan tanggal, pengaturan booting, dan lainnya.

CMOS battery adalah coin-cell lithium battery (biasanya CR2032). Fungsinya mempertahankan system time dan date melalui RTC chip yang menggunakan quartz crystal oscillating pada 32.768 kHz. Battery rata-rata tahan 3 tahun jika computer regularly unplugged.

#v(0.15in)

// --- BACK PANEL ---
== Panel Belakang (Back Panel I/O)

Panel belakang motherboard adalah tepi berlapis logam pada motherboard yang menonjol dari casing komputer, yang menampung port-port penting untuk menghubungkan periferal eksternal seperti monitor, keyboard, mouse, dan speaker. Back panel ini dilengkapi dengan metal I/O shield yang provides grounding dan structural protection. Komponen utamanya meliputi:

*USB Ports:* Tersedia dalam berbagai generasi (USB 2.0 hingga USB Type-C yang supports reversible orientation).
*Audio Connectors:* Line-in untuk input audio, Line-out untuk output, Microphone input jack.
*Network:* Gigabit Ethernet port untuk network connectivity, beberapa high-end boards termasuk 2.5Gb atau 10Gb networking.
*Display Outputs:* HDMI dan DisplayPort untuk video transmission (hanya bekerja jika CPU memiliki integrated graphics).
*Grounding:* Metal backplate memiliki small tabs yang membuat contact dengan metal parts, providing electrical grounding untuk connectors dan preventing potential EMI.

#v(0.15in)

== Daftar Pustaka

#set text(size: 9pt)

1. Intel. (2026). LGA 1700 Socket Specification. www.intel.com
2. AMD. (2025). AM5 Socket Chipsets and Motherboards Guide. www.amd.com
7. Wikipedia Contributors. (2025). Socket AM5. en.wikipedia.org
8. Wikipedia Contributors. (2025). PCI Express. en.wikipedia.org
9. Wikipedia Contributors. (2025). Voltage Regulator Module. en.wikipedia.org
11. Nahil. (2025). Motherboard Components and Basic Functions. nahil.com.sa
12. Superops. (2026). BIOS vs UEFI: The Ultimate Firmware Comparison. superops.com
17. DuroPC. (2024). The Difference Between PCIe x1, x4, x8, x16 and x32. duropc.com
