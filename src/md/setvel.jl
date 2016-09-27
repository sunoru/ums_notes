function set_velocity!(st::MDStatus, md::MDConfig)
    v = st.v
    sys = md.system
    v₀ = zeros(3)
    v² = 0.0
    rand!(md.rng, v)
    @inbounds @simd for i = 1:length(v)
        v[i] -= 0.5
    end
    @inbounds @simd for i = 1:3
        v₀[i] = sum(view(v, :, i))
    end
    v² = 0.0
    @inbounds @simd for i = 1:length(v)
        v² += v[i]^2
    end
    v₀ /= sys.npart
    v₀t = zeros(3)
    f = √(3sys.npart * sys.temperature / v²)
    @inbounds @simd for j = 1:3
        for i = 1:sys.npart
            v[i, j] -= v₀[j]
            v[i, j] *= f
        end
    end
    @inbounds @simd for i = 1:3
        v₀t[i] = sum(view(v, :, i))
    end
    v² = 0.0
    @inbounds @simd for i = 1:length(v)
        v² += v[i]^2
    end
    v² /= 3sys.npart
    v₀t /= sys.npart
    st.temp = v²
    return st
end
