function simple_cubic!(st::MDStatus, md::MDConfig)
    x = st.x
    sys = md.system
    n = Int(floor(sys.npart^(1/3))) + 1
    del = box / n
    itel = 0
    dx = -del
    for i = 1:n
        dx += del
        dy = -del
        for j = 1:n
            dy += del
            dz = -del
            for k = 1:n
                dz += del
                if itel < sys.npart
                    itel += 1
                    x[itel, 1] = dx
                    y[itel, 1] = dy
                    z[itel, 1] = dz
                end
            end
        end
    end
    return st
end
