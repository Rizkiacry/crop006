#import "../utils.typ": *
#import "../config.typ": *

#module-box((width, height) => {
  block(width: width, height: height + box-height-adjust)[
    #let content = text(
      weight: "bold",
      size: header-size,
      fill: border-color,
      tracking: -2pt,
      top-edge: "cap-height",
      bottom-edge: "baseline"
    )[MOTHERBOARD]
    
    #fit-to-width(content, width)
  ]
})
