# Molecular Dynamics

include("types.jl")
include("init.jl")
include("energy.jl")

function main()
    md = init()
    st = md.status
    sys = md.system
    nstep = sys.tmax ÷ sys.dt
    nstep10 = nstep ÷ 10
    while st.t < sys.tmax
        #force(f, en)
        #integrate(f, en)

        sample!(st, md)
    end
end

main()
