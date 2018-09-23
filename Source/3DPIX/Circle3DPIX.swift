//
//  Circle3DPIX.swift
//  Pixels3D
//
//  Created by Anton Heestand on 2018-09-22.
//  Copyright © 2018 Hexagons. All rights reserved.
//

import CoreGraphics
import Pixels
import Metal

public class Circle3DPIX: _3DPIX {
    
    public var circRes: Res = .custom(w: 64, h: 16) { didSet { setNeedsRender() } }
    public var radius: CGFloat = 0.1 { didSet { setNeedsRender() } }

    public override var instanceCount: Int {
        print("COUNT >>>>>>>>>>", vertecies.count / 2, (circRes.w * circRes.h) / 2)
        return (circRes.w * circRes.h) / 2
    }
    public override var vertecies: [Pixels.Vertex] {
        return circ()
    }
    public override var primativeType: MTLPrimitiveType {
        return .line
    }
    
    public override init(res: PIX.Res) {
        super.init(res: res)
    }
    
    func circ() -> [Pixels.Vertex] {
        var verts: [Pixels.Vertex] = []
        for j in 0..<circRes.h {
            let fj = CGFloat(j) / CGFloat(circRes.h - 1)
            for i in 0..<circRes.w {
                let fi = CGFloat(i) / CGFloat(circRes.w - 1)
                let pi = fi * .pi * 2
                let vert = Pixels.Vertex(x: (cos(pi) / res.aspect) * radius * 2 * fj, y: sin(pi) * radius * 2 * fj, z: 0.0, s: 0.0, t: 0.0)
                verts.append(vert)
            }
        }
        return verts
    }
    
}