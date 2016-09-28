include("lattice.jl")
include("setvel.jl")
include("init_sample.jl")

function make_config(npart, tmax, tequil, reqtemp, dt, scale, nsamp, ρ, rc, igr, ivacf, t0vacf, t0stress,
        tdifmax, out_rdf, out_msd, out_st, out_vaf, lattice!, rng)
    box = (npart / ρ)^(1 / 3)
    hbox = box / 2
    rc = min(rc, hbox)
    rc² = rc^2
    ecut = 4 * (1 / rc²^6 - 1 / rc²^3)
    system = MDSystem(npart, tmax, tequil, reqtemp, dt, scale, nsamp, ρ, rc, rc², ecut, box, hbox, igr, ivacf, t0vacf, t0stress, tdifmax)

    x = zeros(npart, 3)
    v = zeros(npart, 3)
    xm = zeros(npart, 3)
    force = zeros(npart, 3)
    en = MDEnergy(0.0, 0.0, 0.0)
    status = MDStatus(x, v, xm, 0.0, 0, 0.0, force, en)

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
    igr = readint(fi)
    ivacf = readint(fi)
    t0vacf = readint(fi)
    t0stress = readint(fi)
    tdifmax = readint(fi)

    out_rdf = open(readline(), "w")
    out_msd = open(readline(), "w")
    out_st = open(readline(), "w")
    out_vaf = open(readline(), "w")

    lattice! = eval(readparse(fi))
    rng = eval(readparse(fi))

    md = make_config(npart, tmax, tequil, reqtemp, dt, scale, nsamp, ρ, rc, igr, ivacf, t0vacf, t0stress,
        tdifmax, out_rdf, out_msd, out_st, out_vaf, lattice!, rng)

    lattice!(md.status, md)
    set_velocity!(md.status, md)

    init_sample!(md.status.sample, md)

    return md
end
