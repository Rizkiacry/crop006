#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([1. BIOS])
    BIOS (Basic Input/Output System) adalah firmware yang disimpan dalam chip memory pada motherboard, bertanggung jawab untuk hardware initialization saat sistem start-up. BIOS memverifikasi semua komponen sistem dan mengload bootloader dari storage device.

    #sub-section-title([UEFI Advantages])
    Graphical user interface dengan mouse support, support untuk disk lebih dari 2 TB melalui GPT partition scheme, Secure Boot feature untuk preventing unauthorized boot, faster parallel hardware initialization, storage boot information sebagai .efi file di hard drive bukan chip saja.

    #sub-section-title([Legacy BIOS])
    Sequential hardware initialization, MBR partition support dengan 2 TB limit, basic password protection, 16-bit architecture.

    Mayoritas motherboard modern support UEFI BIOS sepenuhnya. Beberapa UEFI implementations include Compatibility Support Module (CSM) untuk backward compatibility dengan legacy operating systems dan hardware yang dirancang untuk BIOS.
  ]
})