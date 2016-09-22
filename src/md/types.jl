type MDStatus
    x::Matrix{Float64}  # Positions
    v::Matrix{Float64}  # Velocities
    xm::Matrix{Float64} # Positoins previouss time step
    temp::Float64       # Temperature
    step::Int64         # Step
    t::Float64          # Time
end

immutable MDSystem
    npart::Int64        # Number of particles
    tmax::Float64       # Max time
    tequil::Float64     # Total equilibration time
    reqtemp::Float64    # Requisted temperature
    dt::Float64         # Time step
    scale::Bool         # Determine whether to use temperature scaling
    nsamp::Int64        # Sample frequency
    ρ::Float64          # Density
    rc::Float64         # Cut-off radius of the potential
    rc²::Float64
    ecut::Float64       # Cut-off energy
    box::Float64        # Box length
    hbox::Float64       # Half of box
end

type MDConfig
    system::MDSystem
    status::MDStatus    # Status

    lattice::Function

    rng::AbstractRNG    # RNG
    out_rdf::IOStream   # Output file for radial distribution function
    out_msd::IOStream   # Output file for velocity autocorrelation function and mean square displacement
    out_st::IOStream    # Output file for stress tensor
    out_vaf::IOStream   # Output file for velocity autocorrelation function with error bars
end

