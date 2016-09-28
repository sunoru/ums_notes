function velocs!(st::MDStatus, md::MDConfig)
    sys = md.system
    v = st.v
    v² = 0.0
    @simd for i = 1:length(v)
        @inbounds v² += v[i]
    end
    v² /= 3sys.npart
    f = √(sys.reqtemp / v²)
    @simd for i = 1:length(v)
        @inbounds v[i] *= f
    end
    st
end
