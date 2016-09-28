function sample!(sp::MDSample, md::MDConfig)
    st = md.status
    sys = md.system
    ρ = 0.0
    enp = 0.0
    press = 0.0
    rdf = sp.rdf
    if st.step % sys.igr == 0
        rdf.ngr += 1
        rdf.tempav += st.temp
        sxyz = zeros(3)
        for i = 1:sys.npart
            for j = i+1:sys.npart
                dx = x[i, 1:3] - x[j, 1:3]
                dx -= sys.box * round(dx / sys.box)
                r² = dx[1]^2 + dx[2]^2 + dx[3]^2
                if r² <= sys.hbox ^ 2
                    r = √r²
                    ig = r*dgi
                end
        end
    end
end
