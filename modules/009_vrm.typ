#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  content-block(width, height)[
    #section-title([10. VRM])
    VRM adalah buck converter yang menyuplai CPU dan chipset dengan voltage yang sesuai, mengkonversi +3.3V, +5V, atau +12V menjadi voltage lebih rendah yang dibutuhkan komponen tersebut. VRM terdiri dari power MOSFET devices, inductors, dan capacitors yang disolder pada motherboard.

    Desain VRM modern menggunakan multiphase topology dimana setiap phase berisi set regulators, inductors, dan capacitors. Dengan mendistribusikan load across multiple phases, VRM dapat handle varying current demands lebih efektif, meningkatkan efficiency dan mengurangi heat generation.

    Processor berkomunikasi dengan VRM melalui VID (Voltage Identification) bits pada startup, menginformasikan VRM tentang required supply voltage. VRM kemudian menerapkan PWM (Pulse Width Modulation) untuk rapidly switch regulators on/off, mengontrol average voltage output with precision. Negative feedback loop dalam VRM membandingkan reference voltage (dari BIOS atau processor) dengan actual monitored voltage, modifying PWM signal untuk accurate regulation.
  ]
})