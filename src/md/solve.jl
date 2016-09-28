function solve!(st::MDStatus, md::MDConfig)
    sys = md.system
    f = st.force
    x = st.x
    v = st.v
    v² = 0.0
    @inbounds for i = 1:sys.npart
        vt = v[i, 1:3]
        v[i, 1] += sys.dt * f[i, 1]
        v[i, 2] += sys.dt * f[i, 2]
        v[i, 3] += sys.dt * f[i, 3]
        x[i, 1] += sys.dt * v[i, 1]
        x[i, 2] += sys.dt * v[i, 2]
        x[i, 3] += sys.dt * v[i, 3]
        v² += (v[i, 1] + vt[1])^2 + (v[i, 2] + vt[2])^2 + (v[i, 3] + vt[3])^2
    end
    kinetic = v² / 8
end
