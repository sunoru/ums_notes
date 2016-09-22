function simple_cubic!(status::MDStatus, md::MDConfig)
    x = status.x
    system = md.system
    n = Int(floor(system.npart^(1/3))) + 1
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
                if itel < system.npart
                    itel += 1
                    x[itel, 1] = dx
                    y[itel, 1] = dy
                    z[itel, 1] = dz
                end
            end
        end
    end
    return md
end
