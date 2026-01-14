#import "../utils.typ": *
#import "../config.typ": *
//side001
#place(center + horizon, dx: -cell-inset - cell-outset, dy: -cell-inset - cell-outset - box-height-adjust)[
  #layout(size => {
    let width = size.width + 2 * cell-inset + 2 * cell-outset
    let height = size.height + 2 * cell-inset + 2 * cell-outset
    
    let src-w = 2816
    let src-h = 1100
    
    let scale-factor = calc.min(width / (src-w * 1pt), height / (src-h * 1pt))
    let block-w = src-w * 1pt * scale-factor
    let block-h = src-h * 1pt * scale-factor
    
    align(center + horizon)[
      #block(width: block-w, height: block-h)[
        #scale(scale-factor * 100%, origin: center + horizon)[
          #block(width: src-w * 1pt, height: src-h * 1pt)[
            #include "../assets/side001_colors/overlay.typ"
          ]
        ]
      ]
    ]
  })
]
