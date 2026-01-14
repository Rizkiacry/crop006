#set page(width: 11in, height: 17in, margin: 0.5in)
#set text(font: "Calibri", size: 10pt, lang: "id")

#let heading_style(body) = {
  set text(weight: "bold", size: 12pt, fill: rgb("#1f4788"))
  block(above: 1.2em, below: 0.5em, body)
}

#let subheading_style(body) = {
  set text(weight: "bold", size: 10pt, fill: rgb("#2d5aa0"))
  block(above: 1em, below: 0.5em, body)
}

#show heading.where(level: 2): it => heading_style(it.body)
#show heading.where(level: 3): it => subheading_style(it.body)

== MOTHERBOARD

#v(0.1in)

== Definisi dan Fungsi

Motherboard adalah papan sirkuit cetak utama yang menghubungkan dan mengkoordinasikan komunikasi antara semua komponen elektronik penting sistem komputer. Papan ini menampung CPU, memori RAM, chipset, dan menyediakan interface untuk semua perangkat peripheral. Motherboard berfungsi sebagai tulang punggung sistem komputer, memastikan setiap komponen dapat berkomunikasi secara efisien dan terkoordinasi.

== Jenis-Jenis Motherboard

=== ATX (Advanced Technology eXtended)

Diperkenalkan Intel tahun 1995, ATX adalah standar motherboard desktop yang paling umum digunakan. Ukurannya 305 mm × 244 mm (12 inci × 9,6 inci). Motherboard ATX menawarkan 4-7 slot ekspansi PCIe, multiple RAM slots, numerous USB ports, dan konektor power 24-pin. Desain ini memberikan keseimbangan optimal antara expandability dan ukuran case standar.

=== Micro-ATX (mATX)

Distandarkan tahun 1997, Micro-ATX mengukur 244 mm × 244 mm (9,6 inci × 9,6 inci). Ini adalah subset mounting points ATX penuh, memungkinkan backward compatibility dengan case ATX. Motherboard mATX memiliki 2-4 slot ekspansi PCIe, 4 RAM slot, dan menggunakan power connector ATX standar. Cocok untuk small form factor builds tanpa mengorbankan fitur esensial.

=== Mini-ITX

Mini-ITX berukuran 170 mm × 170 mm (6,7 inci × 6,7 inci), dirancang untuk komputer ultra-compact. Format ini memiliki satu PCIe slot untuk GPU dan expandability terbatas. Ideal untuk HTPC dan sistem dengan space constraint, namun mengorbankan beberapa expansion options.

#v(0.15in)

== 2. SLOT EKSPANSI PCIe

PCIe (PCI Express) slots memungkinkan instalasi expansion cards untuk meningkatkan fungsi sistem. Setiap slot memiliki jumlah data lanes berbeda yang menentukan bandwidth transfer:

*PCIe x1:* Satu lane dengan ukuran 25 mm. Digunakan untuk low-speed devices seperti sound cards, network adapters, dan simple I/O cards. Bandwidth terbatas namun sufficient untuk peripheral yang tidak memerlukan high-speed transfer.

*PCIe x4:* Empat lanes dengan ukuran 39 mm. Cocok untuk NVMe SSDs expansion cards, 4K capture devices, dan medium-performance peripherals. Memberikan bandwidth 4× lebih tinggi dari x1.

*PCIe x8:* Delapan lanes dengan ukuran 56 mm. Jarang digunakan di desktop consumer market. Lebih sering ditemukan di high-end HEDT motherboards dan server systems untuk RAID controllers dan advanced network cards.

*PCIe x16:* Enam belas lanes dengan ukuran 82 mm. Slot terstandar untuk graphics cards dan GPU. Memberikan bandwidth maksimal untuk data-intensive peripherals.

Backward compatibility memungkinkan x1 atau x4 cards untuk dipasang di x8 atau x16 slots dengan operasi di speed native card tersebut. Down-plugging (memasang card yang lebih besar ke slot lebih kecil) tidak didukung secara fisik.

#v(0.15in)

== 1. BIOS

BIOS (Basic Input/Output System) adalah firmware yang disimpan dalam chip memory pada motherboard, bertanggung jawab untuk hardware initialization saat sistem start-up. BIOS memverifikasi semua komponen sistem dan mengload bootloader dari storage device.

UEFI (Unified Extensible Firmware Interface) adalah replacement modern untuk legacy BIOS dengan capabilities lebih advanced:

*UEFI Advantages:* Graphical user interface dengan mouse support, support untuk disk lebih dari 2 TB melalui GPT partition scheme, Secure Boot feature untuk preventing unauthorized boot, faster parallel hardware initialization, storage boot information sebagai .efi file di hard drive bukan chip saja.

*Legacy BIOS:* Sequential hardware initialization, MBR partition support dengan 2 TB limit, basic password protection, 16-bit architecture.

Mayoritas motherboard modern support UEFI BIOS sepenuhnya. Beberapa UEFI implementations include Compatibility Support Module (CSM) untuk backward compatibility dengan legacy operating systems dan hardware yang dirancang untuk BIOS.

== (reserved for 006.typ)

== 11. PANEL BELAKANG

Back panel adalah area pada rear motherboard dimana external connectors terkumpul, dilengkapi dengan metal I/O shield yang provides grounding dan structural protection.

*USB Ports:* Tersedia dalam berbagai generasi:
– USB 2.0: 480 Mbps theoretical speed
– USB 3.0/3.1: hingga 5 Gbps
– USB 3.2: hingga 20 Gbps
– USB Type-C: supports reversible orientation dan advanced features

*Audio Connectors:* Line-in untuk input audio dari external devices, Line-out untuk output ke speakers/headphones, Microphone input jack.

*Network:* Gigabit Ethernet port untuk network connectivity, beberapa high-end boards termasuk 2.5Gb atau 10Gb networking.

*Display Outputs:* HDMI untuk video dan audio output (hanya bekerja jika CPU memiliki integrated graphics), DisplayPort untuk high-bandwidth video transmission, legacy VGA (D-Sub) pada older boards.

*Grounding:* Metal backplate memiliki small tabs yang membuat contact dengan metal parts dari motherboard connectors, providing electrical grounding untuk connectors. Proper grounding prevents potential EMI (electromagnetic interference) dan improves signal integrity.

== (Reserved for 008.typ)

== 10. VRM

VRM adalah buck converter yang menyuplai CPU dan chipset dengan voltage yang sesuai, mengkonversi +3.3V, +5V, atau +12V menjadi voltage lebih rendah yang dibutuhkan komponen tersebut. VRM terdiri dari power MOSFET devices, inductors, dan capacitors yang disolder pada motherboard.

Desain VRM modern menggunakan multiphase topology dimana setiap phase berisi set regulators, inductors, dan capacitors. Dengan mendistribusikan load across multiple phases, VRM dapat handle varying current demands lebih efektif, meningkatkan efficiency dan mengurangi heat generation.

Processor berkomunikasi dengan VRM melalui VID (Voltage Identification) bits pada startup, menginformasikan VRM tentang required supply voltage. VRM kemudian menerapkan PWM (Pulse Width Modulation) untuk rapidly switch regulators on/off, mengontrol average voltage output dengan precision. Negative feedback loop dalam VRM membandingkan reference voltage (dari BIOS atau processor) dengan actual monitored voltage, modifying PWM signal untuk accurate regulation.

#v(0.15in)

== 9. SOKET

Socket CPU adalah konektor pada motherboard tempat prosesor dipasang. Terdapat dua produsen CPU utama dengan socket proprietary:

*Intel LGA 1700:* Socket land grid array dengan 1700 pin yang terletak di motherboard. Digunakan untuk Intel Core generasi 12, 13, dan 14. Mendukung DDR5 memory dan PCIe 5.0 pada chipset kompatibel. Pin-pin ini menyambung ke trace PCB yang membawa instruksi dan data ke CPU.

*AMD AM5 (LGA 1718):* Socket LGA dengan 1718 contact pins untuk Ryzen 7000 series dan newer. Successor dari AM4 socket yang menggunakan PGA design. AM5 mandatory mendukung DDR5 (tidak ada DDR4 compatibility). Mensupport PCIe 5.0 lanes dari CPU pada X870E dan X870 chipsets.

#v(0.15in)

== 3. KONEKTOR SATA

SATA (Serial ATA) adalah interface standar untuk menghubungkan storage devices seperti hard drives dan SSDs ke motherboard. SATA mengalami evolusi dengan tiga generasi:

*SATA I (SATA 1.5 Gb/s):* Transfer rate 1,5 gigabit per detik, throughput 150 MB/s. Standar awal yang diperkenalkan 2003.

*SATA II (SATA 3 Gb/s):* Transfer rate 3,0 gigabit per detik, throughput 300 MB/s. Diperkenalkan April 2004, menggandakan kecepatan predecessor.

*SATA III (SATA 6 Gb/s):* Transfer rate 6,0 gigabit per detik, throughput 600 MB/s. Standar modern diperkenalkan Juli 2008. Semua generasi SATA backward compatible, memungkinkan drives lama bekerja di interface newer dengan speed dibatasi oleh capability terendah.

#v(0.15in)

== 4. CHIPSET

Chipset adalah sekumpulan integrated circuit chips yang berfungsi sebagai central hub komunikasi. Chipset mengatur aliran data antara CPU, RAM, storage devices, graphics cards, dan peripheral lainnya. Dalam sistem modern, fungsi yang dulunya dipecah menjadi Northbridge (koneksi CPU-RAM-GPU) dan Southbridge (I/O peripherals) telah diintegrasikan. Northbridge functions sekarang embedded di CPU package, sementara Southbridge functionality dikombinasikan dalam single Platform Controller Hub yang terhubung ke CPU melalui dedicated PCIe lanes. Chipset mengelola:

• Koordinasi data antar komponen
• Bus control dan electrical standards
• Interface provisioning (USB, SATA, PCIe)
• Power management dan voltage regulation
• Support untuk hardware features seperti overclocking

#v(0.15in)

== 5. BATERAI

CMOS battery adalah coin-cell lithium battery (biasanya CR2032) yang mensupply daya ke motherboard's real-time clock (RTC) dan CMOS memory saat PC powered off.

*Fungsi:* Mempertahankan system time dan date melalui RTC chip yang menggunakan quartz crystal oscillating pada 32.768 kHz. RTC chip menyimpan registers yang menyimpan time information (hours, minutes, seconds, day, month, year). Menjaga BIOS/UEFI settings termasuk hardware configurations, boot sequence, power management settings, dan password settings antar restarts. Mencegah system revert ke default settings saat PC unplugged.

*Lifespan:* Battery rata-rata tahan 3 tahun jika computer regularly unplugged. Signs dari weak battery: incorrect date/time display, system reverting ke default BIOS settings setiap boot, website errors seperti "your clock is ahead/behind."

#v(0.15in)

== 6. KONEKTOR M.2

M.2 adalah interface modern yang compact dan versatile untuk menghubungkan storage devices internal. Interface ini menggantikan standar mSATA yang lebih tua dan menggunakan PCIe lanes untuk komunikasi:

*M.2 M Key:* Menggunakan PCIe x4 interface, memberikan read/write speeds hingga 7000 MB/s. Dirancang untuk NVMe SSDs yang membutuhkan high performance. Notch connector terletak lima pins dari right end, memastikan correct physical orientation.

*M.2 B Key:* Menggunakan PCIe x2 atau SATA interface, ideal untuk older atau lower-performance storage. Notch terletak enam pins dari left end connector. Backward compatibility dengan SATA devices.

*M.2 B+M Key:* Dual-notch design compatible dengan both M dan B connectors, memberikan flexibility untuk berbagai device types.

#v(0.15in)

== 7. KONEKTOR ATX 24 PIN

Konektor ATX 24-pin adalah main power supply connector untuk motherboard, diperkenalkan pada ATX 2.0 specification tahun 2003. Ini menggantikan earlier 20-pin design untuk meet power demands lebih tinggi.

*Design:* Connector dibagi menjadi dua bagian dengan small protrusion. Bagian initial menyediakan power dari PSU dengan maximum 75W. Bagian second berisi data paths untuk power delivery. Tambahan 4 pins dalam 24-pin connector dibanding predecessor memberikan higher current capacity pada +12V rail yang powers CPU dan GPU.

*Power Distribution:* Modern PSUs sering feature detachable 20+4-pin connectors untuk compatibility dengan older motherboards. ATX 2.2 specification memperkenalkan multi-rail architecture dengan independent +12V rails untuk isolate power delivery ke CPU dan GPU, reducing electromagnetic interference.

*Backward Compatibility:* 24-pin PSU dapat power 20-pin motherboard dengan leaving extra four pins unconnected. Sebaliknya, 20-pin PSU mungkin struggle dengan high-power systems karena limited +12V capacity.

Separate 8-pin EPS/ATX 12V connector juga required pada modern systems untuk delivering dedicated CPU power.

#v(0.15in)

== 8. SLOT DIMM

DIMM slots adalah konektor tempat RAM modules dipasang. Motherboard modern menggunakan DDR5 SDRAM dengan spesifikasi:

*DDR5 Memory:* Memulai kecepatan 4800 MT/s, meningkat hingga 8800 MT/s atau lebih. Ini 50% lebih cepat dari DDR4 maximum 3200 MT/s. DDR5 menggunakan voltage 1.1V dibanding DDR4 1.2V, mengurangi power consumption 20%. Setiap DDR5 module memiliki on-board PMIC (Power Management Integrated Circuit) untuk power regulation yang lebih baik.

*Memory Density:* DDR5 mendukung capacities hingga 512 GB per DIMM, octupling dari DDR4's 64 GB maximum. Architecture menggunakan 32 banks dalam 8 bank groups (vs DDR4's 16 banks dalam 4 groups) dan doubled burst length dari 8 menjadi 16, meningkatkan efficiency dan bandwidth.

*Module Features:* On-Die ECC untuk error correction pada chip level, CRC protection pada read/write operations, dan temperature sensors pada server-class modules untuk precise thermal control. Center notch acts sebagai physical key, preventing installation dari incompatible memory types.
