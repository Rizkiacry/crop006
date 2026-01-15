#import "../utils.typ": *
#import "../config.typ": *
//side001
#place(center + horizon, dx: -cell-inset - cell-outset, dy: -cell-inset - cell-outset - box-height-adjust)[
  #layout(size => {
    let width = size.width + 2 * cell-inset + 2 * cell-outset
    let height = size.height + 2 * cell-inset + 2 * cell-outset
    
    let src-w = 2816
    let src-h = 1100
    let content-h = 1536
    let y-offset = -(content-h - src-h) / 2
    
    let scale-factor = calc.min(width / (src-w * 1pt), height / (src-h * 1pt))
    let block-w = src-w * 1pt * scale-factor
    let block-h = src-h * 1pt * scale-factor
    
    let block-w-float = block-w / 1pt
    let block-h-float = block-h / 1pt
    
    let raw-pts = (
      (100, 100),
      (100, src-h - 100),
      (src-w - 100, src-h - 100),
      (src-w - 100, 100)
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
          #block(width: src-w * 1pt, height: src-h * 1pt, clip: true)[
            #place(top + left, dy: y-offset * 1pt)[
              #include "../assets/side001_colors/overlay.typ"
              #place(top + left, dx: 50pt, dy: 240pt, image("../assets/side001_linealpha.png", width: src-w * 1pt - 100pt))
            ]
          ]
        ]
      ]
    ]
  })
]
