function make_config(npart, tmax, tequil, reqtemp, dt, scale, nsamp, ρ, rc, out_rdf, out_msd,
        out_st, out_vaf, lattice!, rng)
    box = (npart / ρ)^(1 / 3)
    hbox = box / 2
    rc = min(rc, hbox)
    rc² = rc^2
    ecut = 4 * (1 / rc²^6 - 1 / rc²^3)
    system = MDSystem(npart, tmax, tequil, reqtemp, dt, scale, nsamp, ρ, rc, rc², ecut, box, hbox)

    x = zeros(npart, 3)
    v = zeros(npart, 3)
    xm = zeros(npart, 3)
    status = MDStatus(x, v, xm, 0.0, 0, 0.0)

    md = MDConfig(system, status, lattice!, rng, out_rdf, out_msd, out_st, out_vaf)

    return md
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

    lattice! = eval(readparse(fi))
    rng = eval(readparse(fi))

    md = make_config(npart, tmax, tequil, reqtemp, dt, scale, nsamp, ρ, rc, out_rdf, out_msd, out_st,
        out_vaf, lattice, rng)

    lattice!(md.status, md)
    set_velocity!(md.status, md)

    return md
end
