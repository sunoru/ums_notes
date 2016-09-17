# Molecular Dynamics

include("init.jl")

function main()
    md = init()
    status = md.status
    status.t = 0
    while status.t < md.tmax
        force(f, en)
        integrate(f, en)
        status.t += md.delt
        sample()
    end
end

main()
