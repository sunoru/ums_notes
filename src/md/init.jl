type MDStatus
    x::Vector{Float64}  # Positions
    v::Vector{Float64}  # Velocities
    xm::Vector{Float64} # Positoins previouss time step
    t::Float64          # Time
end

type MDConfig
    npart::Int          # Number of particles
    temp::Float64       # Temperature
    tmax::Float64       # Max time
    dt::Float64         # Time step
    status::MDStatus    # Status
    rng::AbstractRNG    # RNG
end

function init(npart, temperature, tmax, dt, lattice_pos, rng=Base.Random.GLOBAL_RNG)
    x = zeros(npart)
    v = zeros(npart)
    xm = zeros(npart)
    status = MDStatus(x, v, xm, 0.0)
    md = MDConfig(npart, temperature, tmax, dt, status, rng)

    x, v = md.status.x, md.status.v
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

function init()
    readline()
end
