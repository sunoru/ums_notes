function make_config(npart, temperature, tmax, tequil, reqtemp, dt, scale, nsamp, ρ, rc, out_rdf, out_msd,
        out_st, out_vaf, lattice_pos, rng)
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

using RNG

readparse(fi=STDIN) = parse(readline(fi))
readint(fi=STDIN) = Int64(readparse(fi))
readfloat(fi=STDIN) = Float64(readparse(fi))
readbool(fi=STDIN) = Bool(readparse(fi))

function init()
    if isempty(ARGS)
        fi = STDIN
    else
        fi = open(ARGS[1])
    end
    npart = readint(fi)
    temperature = readfloat(fi)
    tmax = readfloat(fi)
    tequil = readfloat(fi)
    reqtemp = readfloat(fi)
    dt = readfloat(fi)
    scale = readbool(fi)
    nsamp = readint(fi)
    ρ = readfloat(fi)
    rc = readfloat(fi)
    out_rdf = open(readline(), "w")
    out_msd = open(readline(), "w")
    out_st = open(readline(), "w")
    out_vaf = open(readline(), "w")

    lattice_pos = eval(readparse(fi))
    rng = eval(readparse(fi))

    make_config(npart, temperature, tmax, tequil, reqtemp, dt, scale, nsamp, ρ, rc, out_rdf, out_msd, out_st,
        out_vaf, lattice_pos, rng)

end
