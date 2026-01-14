#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([7. KONEKTOR ATX 24 PIN])
    Konektor ATX 24-pin adalah main power supply connector untuk motherboard, diperkenalkan pada ATX 2.0 specification tahun 2003. Ini menggantikan earlier 20-pin design untuk meet power demands lebih tinggi.

    *Design:* Connector dibagi menjadi dua bagian dengan small protrusion. Bagian initial menyediakan power dari PSU dengan maximum 75W. Bagian second berisi data paths untuk power delivery. Tambahan 4 pins dalam 24-pin connector dibanding predecessor memberikan higher current capacity pada +12V rail yang powers CPU dan GPU.

    *Power Distribution:* Modern PSUs sering feature detachable 20+4-pin connectors untuk compatibility dengan older motherboards. ATX 2.2 specification memperkenalkan multi-rail architecture dengan independent +12V rails untuk isolate power delivery ke CPU dan GPU, reducing electromagnetic interference.

    *Backward Compatibility:* 24-pin PSU dapat power 20-pin motherboard dengan leaving extra four pins unconnected. Sebaliknya, 20-pin PSU mungkin struggle dengan high-power systems karena limited +12V capacity.
  ]
})