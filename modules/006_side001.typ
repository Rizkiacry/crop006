#import "../utils.typ": *
#import "../config.typ": *
//side001
#module-box((width, height) => {
  block(width: width, height: height + box-height-adjust)[
    #align(center + horizon)[
    ]
  ]
})
