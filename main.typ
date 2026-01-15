#import "config.typ": *
#import "utils.typ": *

#show strong: it => box(
  fill: rgb("#FCE0B6"),
  radius: 2pt,
  inset: (x: 3pt, y: 1pt),
  text(weight: "regular", it.body)
)

#show underline: set underline(stroke: 1.5pt + rgb("#FCE0B6"), offset: 2pt)

#set page(
  width: 6 * col-width + 5 * gutter-size + 2 * page-margin,
  height: 7 * row-height + 6 * gutter-size + 2 * page-margin,
  margin: page-margin,
  fill: border-color
)

#set text(font: "Space Grotesk")

#let cell(body) = {
  rect(
    width: 100%,
    height: 100%,
    stroke: border-thickness + border-color,
    radius: corner-radius,
    outset: cell-outset,
    inset: cell-inset,
    fill: white,
    body
  )
}

#grid(
  columns: (col-width,) * 6,
  rows: (row-height,) * 7,
  gutter: gutter-size,
  grid.cell(x: 0, y: 0, colspan: 2)[#cell[#include "modules/001_motherboard.typ"]],
  grid.cell(x: 2, y: 0, colspan: 2)[#cell[#include "modules/002_definisi.typ"]],
  grid.cell(x: 4, y: 0, colspan: 1)[#cell[
    #module-box((width, height) => {
      content-block(width, height)[
        #set align(center + horizon)
        *KELOMPOK 9* \
        #v(0.5em)
        *FX. Oktabimo DwiPriabudi S.* (202531085) \
        *Zain Akbar Rizkia* (202531091) \
        *Iqbal Raihan Raffianza* (202531111) \
        *Gilang Azhar Robani* (202531114)
      ]
    })
  ]],
  grid.cell(x: 5, y: 0, rowspan: 7)[#cell[#include "modules/003_jenis.typ"]],
  grid.cell(x: 0, y: 1, rowspan: 3)[#cell[#include "modules/004_pcie.typ"]],
  grid.cell(x: 1, y: 1)[#cell[#include "modules/005_bios.typ"]],
  grid.cell(x: 2, y: 1, colspan: 2)[#cell[#include "modules/006_side001.typ"]],
  grid.cell(x: 4, y: 1)[#cell[#include "modules/007_backpanel.typ"]],
  grid.cell(x: 1, y: 2, colspan: 3, rowspan: 4)[#cell[#include "modules/008_diagram.typ"]],
  grid.cell(x: 4, y: 2)[#cell[#include "modules/009_vrm.typ"]],
  grid.cell(x: 4, y: 3, rowspan: 3)[#cell[#include "modules/010_socket.typ"]],
  grid.cell(x: 0, y: 4, rowspan: 2)[#cell[#include "modules/011_sata.typ"]],
  grid.cell(x: 0, y: 6)[#cell[#include "modules/012_chipset.typ"]],
  grid.cell(x: 1, y: 6)[#cell[#include "modules/013_battery.typ"]],
  grid.cell(x: 2, y: 6)[#cell[#include "modules/014_m2.typ"]],
  grid.cell(x: 3, y: 6)[#cell[#include "modules/015_atx24.typ"]],
  grid.cell(x: 4, y: 6)[#cell[#include "modules/016_dimm.typ"]],
)
