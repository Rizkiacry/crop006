#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([11. PANEL BELAKANG])
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
  ]
})