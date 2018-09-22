//
//  Nil3DVTX.metal
//  Pixels3DShaders
//
//  Created by Hexagons on 2018-09-22.
//  Copyright © 2018 Hexagons. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn{
    packed_float2 position;
    packed_float2 texCoord;
};

struct VertexOut{
    float4 position [[position]];
    float2 texCoord;
};

vertex VertexOut nil3DVTX(const device VertexIn* vertecies [[ buffer(0) ]],
                          unsigned int vid [[ vertex_id ]]) {
    
    VertexIn vtxIn = vertecies[vid];
    float x = vtxIn.position[0];
    float y = vtxIn.position[1];
    
    VertexOut vtxOut;
    vtxOut.position = float4(x, y, 0, 1);
    vtxOut.texCoord = vtxIn.texCoord;
    
    return vtxOut;
}
