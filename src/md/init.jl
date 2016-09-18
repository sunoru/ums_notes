function init(npart, temperature, tmax, dt, lattice_pos, rng=Base.Random.GLOBAL_RNG)
    x = zeros(npart)
    v = zeros(npart)
    xm = zeros(npart)
    status = MDStatus(x, v, xm, 0.0)
    md = MDConfig(npart, temperature, tmax, dt, status, rng)

    Σv = 0.0
    Σv² = 0.0
    for i = 1:npart
        x[i] = lattice_pos(i)
        v[i] = rand(rng, Float64) - 0.5
        Σv += v[i]
        Σv² += v[i]^2
    end
    Σv /= npart
    Σv² /= npart
    fs = √(3temperature / Σv²)
    for i = 1:npart
        v[i] = (v[i] - Σv) * fs
        xm[i] = x[i] - v[i] * dt
    end
    md
end

readfloat() = parse(Float64, readline())

function init()
    
end
