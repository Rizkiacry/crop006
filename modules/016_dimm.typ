#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([8. SLOT DIMM])
    DIMM slots adalah konektor tempat RAM modules dipasang. Motherboard modern menggunakan DDR5 SDRAM dengan spesifikasi:

    *DDR5 Memory:* Memulai kecepatan 4800 MT/s, meningkat hingga 8800 MT/s atau lebih. Ini 50% lebih cepat dari DDR4 maximum 3200 MT/s. DDR5 menggunakan voltage 1.1V dibanding DDR4 1.2V, mengurangi power consumption 20%. Setiap DDR5 module memiliki on-board PMIC (Power Management Integrated Circuit) untuk power regulation yang lebih baik.

    *Memory Density:* DDR5 mendukung capacities hingga 512 GB per DIMM, octupling dari DDR4's 64 GB maximum. Architecture menggunakan 32 banks dalam 8 bank groups (vs DDR4's 16 banks dalam 4 groups) dan doubled burst length dari 8 menjadi 16, meningkatkan efficiency dan bandwidth.

    *Module Features:* On-Die ECC untuk error correction pada chip level, CRC protection pada read/write operations, dan temperature sensors pada server-class modules untuk precise thermal control. Center notch acts sebagai physical key, mencegah installation dari incompatible memory types.
  ]
})