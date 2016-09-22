function set_velocity!(status::MDStatus, md::MDConfig)
    v = status.v
    st = md.system
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
    v₀ /= st.npart
    v₀t = zeros(3)
    f = √(3st.npart * st.temperature / v²)
    @inbounds @simd for j = 1:3
        for i = 1:st.npart
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
    v² /= 3st.npart
    v₀t /= st.npart
    status.temp = v²
    return st
end
