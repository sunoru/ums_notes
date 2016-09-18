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

