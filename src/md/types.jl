type MDSampleRDF
    ngr::Int64
    nhgr::Int64
    dg::Float64
    dgi::Float64
    tempav::Float64
    g::Vector{Float64}
    MDSampleRDF() = new()
end

type MDSampleST
    tstress0::Float64
    dstress_time::Float64
    sxyz00::Vector{Float64}
    MDSampleST() = new()
end

type MDSampleVACF
    t0::Float64
    tvacf::Float64
    dtime::Float64
    r2t::Vector{Float64}
    nvacf::Vector{Float64}
    vacf::Vector{Float64}
    nstress::Vector{Float64}
    sxyzt::Matrix{Float64}  # 1 for yz, 2 for xz, 3 for xy.
    MDSampleVACF() = new()
end

type MDSample
    rdf::MDSampleRDF
    st::MDSampleST
    vacf::MDSampleVACF

    MDSample() = new()
end

immutable MDEnergy
    energy::Float64     # Total energy
    virial::Float64     # Total Virial
    kinetic::Float64    # Kinetic energy
end

type MDStatus
    x::Matrix{Float64}  # Positions
    v::Matrix{Float64}  # Velocities
    xm::Matrix{Float64} # Positoins previouss time step
    temp::Float64       # Temperature
    step::Int64         # Step
    t::Float64          # Time
    force::Matrix{Float64}
    energy::MDEnergy    # Total energy
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
    igr::Int64
    ivacf::Int64
    t0vacf::Int64
    t0stress::Int64
    tdifmax::Int64
end

type MDConfig
    system::MDSystem
    status::MDStatus

    lattice::Function
    rng::AbstractRNG

    out_rdf::IOStream   # Output file for radial distribution function
    out_msd::IOStream   # Output file for velocity autocorrelation function and mean square displacement
    out_st::IOStream    # Output file for stress tensor
    out_vaf::IOStream   # Output file for velocity autocorrelation function with error bars
end

