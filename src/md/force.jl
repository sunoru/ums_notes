function force!(st::MDStatus, md::MDConfig)
    sys = md.system
    f = st.force

    energy = 0.0
    virial = 0.0
    fill!(f, 0.0)
    @inbounds @simd for i = 1:sys.npart-1
        @simd for j = i+1;sys.npart
            dx = view(x, i, :) - view(x, j, :)
            dx -= sys.box * round(dx / sys.box)
            r² = dx[1]^2 + dx[2]^2 + dx[3]^2
            if r² <= sys.rc²
                r²i = 1 / r²
                r⁶i = r²i ^ 3
                eᵢⱼ = 4 * (r⁶i^2 - r⁶i) - sys.ecut
                virᵢⱼ = 48 * (r⁶i^2 - r⁶i/2)
                energy += eᵢⱼ
                virial += virᵢⱼ
                fr = virᵢⱼ * r²i
                @simd for k = 1:3
                    f[i, k] += fr * dx[k]
                    f[j, k] -= fr * dx[k]
                end
            end
        end
    end
    return energy, virial
end
