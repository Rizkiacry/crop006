#import "config.typ": *

#let rounded-polygon(points, radius, fill: none, stroke: none) = {
  let n = points.len()
  
  // Math on floats
  let sub(a, b) = (a.at(0) - b.at(0), a.at(1) - b.at(1))
  let add(a, b) = (a.at(0) + b.at(0), a.at(1) + b.at(1))
  let scale(v, s) = (v.at(0) * s, v.at(1) * s)
  let len(v) = calc.sqrt(v.at(0) * v.at(0) + v.at(1) * v.at(1))
  let norm(v) = {
    let l = len(v)
    if l == 0 { (0, 0) } else { scale(v, 1/l) }
  }
  let to-pt(p) = (p.at(0) * 1pt, p.at(1) * 1pt)

  let corners = ()
  for i in range(n) {
    let p = points.at(i)
    let prev = points.at(calc.rem(i - 1 + n, n))
    let next = points.at(calc.rem(i + 1, n))
    
    let u = sub(prev, p)
    let v = sub(next, p)
    
    let u-norm = norm(u)
    let v-norm = norm(v)
    
    let dot = u-norm.at(0) * v-norm.at(0) + u-norm.at(1) * v-norm.at(1)
    let clamped-dot = if dot > 1 { 1 } else if dot < -1 { -1 } else { dot }
    let angle = calc.acos(clamped-dot)
    
    // Check if angle is essentially straight (pi)
    let dist = if calc.abs(angle.rad() - calc.pi) < 0.001 {
      0
    } else {
      radius / calc.tan(angle / 2)
    }
    
    let S = add(p, scale(u-norm, dist))
    let E = add(p, scale(v-norm, dist))
    
    corners.push((S: S, E: E, P: p))
  }
  
  let segments = ()
  // Start at the end of the last corner
  segments.push(curve.move(to-pt(corners.at(n - 1).E)))
  
  for i in range(n) {
    let c = corners.at(i)
    // Line to start of corner
    segments.push(curve.line(to-pt(c.S))) 
    // Quadratic bezier to end of corner
    segments.push(curve.quad(to-pt(c.P), to-pt(c.E)))
  }
  
  segments.push(curve.close())
  
  curve(fill: fill, stroke: stroke, ..segments)
}

#let module-box(body) = {
  place(top + left, dx: -cell-inset, dy: -cell-inset - box-height-adjust)[
    #layout(size => {
      let width = size.width + 2 * cell-inset
      let height = size.height + 2 * cell-inset
      body(width, height)
    })
  ]
}

#let fit-to-width(content, width) = {
  let m = measure(content)
  scale(x: (width / m.width) * 100%, origin: top + left)[#content]
}

#let content-block(width, height, body) = {
  block(width: width, height: height + box-height-adjust)[
    #set text(
      size: body-size,
      top-edge: "cap-height",
      bottom-edge: "baseline"
    )
    #set par(justify: true, leading: body-leading)
    #body
  ]
}

#let section-title(title) = {

  set text(weight: "bold", size: body-size * 1.1, fill: border-color.darken(30%))

  upper(title)

  v(0.2em)

}



#let sub-section-title(title) = {

  set text(weight: "bold", size: body-size * 0.9, fill: border-color.darken(15%))

  title

  v(0.1em)

}
