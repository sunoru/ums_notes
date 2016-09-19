type MDStatus
    x::Vector{Float64}  # Positions
    v::Vector{Float64}  # Velocities
    xm::Vector{Float64} # Positoins previouss time step
    step::Int64         # Step
    t::Float64          # Time
end

type MDConfig
    npart::Int64        # Number of particles
    temp::Float64       # Temperature
    tmax::Float64       # Max time
    tequil::Float64     # Total equilibration time
    reqtemp::Float64    # Requisted temperature
    dt::Float64         # Time step
    scale::Bool         # Determine whether to use temperature scaling
    nsamp::Int64        # Sample frequency
    ρ::Float64          # Density
    rc::Float64         # cut-off radius of the potential

    status::MDStatus    # Status

    rng::AbstractRNG    # RNG
    out_rdf::IOStream   # Output file for radial distribution function
    out_msd::IOStream   # Output file for velocity autocorrelation function and mean square displacement
    out_st::IOStream    # Output file for stress tensor
    out_vaf::IOStream   # Output file for velocity autocorrelation function with error bars
end

