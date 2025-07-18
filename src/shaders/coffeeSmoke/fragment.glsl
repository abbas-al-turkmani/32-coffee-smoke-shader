uniform float uTime;
uniform sampler2D uPerlinTexture;

varying vec2 vUv;

void main()
{
    // Scale and animate 
    vec2 smokeUv = vUv;
    smokeUv *=0.5;
    smokeUv.y -=uTime *0.03;
    // Smoke
    float smoke = texture(uPerlinTexture,smokeUv).r;
    // Remap
    smoke *= smoothstep(0.4,1.0,smoke);
    // Edges
    
    smoke *= smoothstep(0.0,0.1,vUv.x);
    smoke *= smoothstep(0.0,0.1,vUv.y);
    smoke *= smoothstep(0.0,0.1,1.0-vUv.x);
    smoke *= smoothstep(0.0,0.4,1.0-vUv.y);

    // Final Color
    gl_FragColor = vec4(0.6,0.3,0.2,smoke);
    // gl_FragColor = vec4(1.0,0.0,0.0,1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}