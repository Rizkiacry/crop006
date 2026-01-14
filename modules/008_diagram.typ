#import "../utils.typ": *
#import "../config.typ": *
//top001
#place(top + left, dx: -cell-inset - cell-outset, dy: -cell-inset - cell-outset - box-height-adjust)[
  #layout(size => {
    let width = size.width + 2 * cell-inset + 2 * cell-outset
    let height = size.height + 2 * cell-inset + 2 * cell-outset
    
    let src-w = 2336
    let src-h = 1824
    
    let scale-factor = calc.min(width / (src-w * 1pt), height / (src-h * 1pt))
    
    let block-w = src-w * 1pt * scale-factor
    let block-h = src-h * 1pt * scale-factor
    
    let block-w-float = block-w / 1pt
    let block-h-float = block-h / 1pt
    
    let raw-pts = (
      (91, 103),
      (89, 1617),
      (265, 1795),
      (562, 1798),
      (628, 1739),
      (1230, 1739),
      (1302, 1798),
      (2152, 1799),
      (2272, 1692),
      (2259, 99)
    )
    
    let pts = raw-pts.map(p => (
      p.at(0) / src-w * block-w-float,
      p.at(1) / src-h * block-h-float
    ))
    
    align(top + left)[
      #block(width: block-w, height: block-h)[
        #place(top + left, rounded-polygon(
          pts, 
          0, 
          stroke: (thickness: 2 * border-thickness, paint: border-color)
        ))
        #place(top + left, rounded-polygon(
          pts, 
          corner-radius / 1pt, 
          fill: rgb("#fce0b6")
        ))
        #scale(scale-factor * 100%, origin: top + left)[
          #block(width: src-w * 1pt, height: src-h * 1pt)[
            #include "../assets/top001_colors/overlay.typ"
          ]
        ]
      ]
    ]
  })
]
