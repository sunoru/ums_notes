@inline function energy(i, jb, md::MDConfig)
    x = md.status.x
    sys = md.system
    energy = 0.0
    virial = 0.0
    for j = jb:sys.npart
        if (j != i)
            dx = x[i, :] - x[j, :]
            dx -= sys.box * round(dx / sys.box)
            r² = dx[1]^2 + dx[2]^2 + dx[3]^2
            if r² <= sys.rc²
                r²i = 1 / r²
                r⁶i = r²i ^ 3
                eᵢⱼ = 4 * (r⁶i^2 - r⁶i) - sys.ecut
                virᵢⱼ = 48 * (r⁶i^2 - r⁶i/2)
                energy += eᵢⱼ
                virial += virᵢⱼ
            end
        end
    end
    energy, virial
end

function total_energy!(status::MDStatus, md::MDConfig)
    sys = md.system
    v = status.v
    energy = 0.0
    virial = 0.0
    kinetic = 0.0
    for i = 1:sys.npart
        eᵢ, virᵢ = energy(i, i+1, md)
        energy += eᵢ
        virial += virᵢ
    end
    for i = 1:length(v)
        kinetic += v[i]^2
    end
    kinetic /= 2
    energy += kinetic
    status.energy = MDEnergy(energy, virial, kinetic)
    status
end
