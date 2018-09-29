//
//  Particles3DPIX.swift
//  Pixels3D
//
//  Created by Hexagons on 2018-09-27.
//  Copyright © 2018 Hexagons. All rights reserved.
//

import CoreGraphics
import Metal
import Pixels

public class Particles3DPIX: _3DPIX {
    
//    public var gridRes: Res { didSet { setNeedsRender() } }
    
    open override var customVertexShaderName: String? { return "particle3DVTX" }

    open override var customVertexTextureActive: Bool { return true }
    open override var customVertexPixIn: (PIX & PIXOut)? { return sourcePixIn }
    
    public var sourcePixIn: (PIX & PIXOut)? = nil {
        didSet {
            if let src = sourcePixIn {
                prep()
                src.customLink(to: self)
            } else {
                oldValue?.customDelink(from: self)
            }
        }
    }
    
    public override var vertecies: [Pixels.Vertex] {
        return particles.map({ vec -> Pixels.Vertex in
            return Pixels.Vertex(x: vec.x/* / res.aspect*/, y: vec.y, z: vec.z, s: 0.0, t: 0.0)
        })
    }
    public override var instanceCount: Int {
        return particles.count //sourcePixIn?.resolution?.count ?? 0
    }
    public override var primativeType: MTLPrimitiveType { return .point }
    
    var cachedVertecies: Pixels.Vertecies?
    
//    public var count: Int = 1024// { didSet { setNeedsRender() } }
    public var particles: [_3DVec] = []// { didSet { setNeedsRender() } }
//    public var emittors:  [_3DVec] = []// { didSet { setNeedsRender() } }
//    public var size: CGFloat = 1.0
    
    var aspect: CGFloat {
        return res.aspect
    }
    
//    let startTime = Date()
//    var time: CGFloat {
//        return CGFloat(-startTime.timeIntervalSinceNow)
//    }
    open override var vertexUniforms: [CGFloat] {
        return [aspect]
    }
    
    
    public override init(res: Res) {
        super.init(res: res)
    }
    
    func prep() {
        guard let src = sourcePixIn else { return }
        guard let res = src.resolution else { return }
        guard particles.count != res.count else { return }
        particles = Pixels3D.uvVecMap(res: res)
        setNeedsRender()
    }
    
//    public func pop() {
//        guard !emittors.isEmpty else {
//            if !particles.isEmpty {
//                particles = []
//                setNeedsRender()
//            }
//            return
//        }
//        particles = []
//        var i = 0
//        for _ in 0..<count {
//            let emittor = emittors[i]
//            particles.append(emittor)
//            i = (i + 1) % emittors.count
//        }
//        setNeedsRender()
//    }
    
//    public override func customVertecies() -> Pixels.Vertecies? {
//        guard !particles.isEmpty else { return nil }
//        if cachedVertecies == nil {
//            cachedVertecies = super.customVertecies()
//        }
//        return cachedVertecies!
//    }
    
    required convenience init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
