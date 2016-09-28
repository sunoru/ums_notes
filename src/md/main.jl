# Molecular Dynamics

include("types.jl")
include("init.jl")
include("force.jl")
include("energy.jl")
include("solve.jl")
include("velocs.jl")

function main()
    md = init()
    st = md.status
    sys = md.system
    total_energy!(st, md)
    nstep = sys.tmax ÷ sys.dt
    nstep10 = nstep ÷ 10
    while st.t < sys.tmax
        energy, virial = force!(st, md)
        kinetic = solve!(st, md)
        st.time += sys.delt
        st.energy = MDEnergy(energy += kinetic, virial, kinetic)
        st.step += 1
        if st.time < sys.tequil
            if sys.scale && st.step % 20 == 0
                velocs!(st, md)
            end
        elseif st.step % sys.nsamp == 0
            sample!(st.sample, md)
        end
    end
end

main()
