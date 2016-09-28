const NHIsmax = 250
const TMAx = 1000

function init_sample!(sp::MDSample, md::MDConfig)
    sys = md.system

    # radial distribution function
    rdf = sp.rdf = MDSampleRDF()
    rdf.ngr = 0
    rdf.nhgr = NHIsmax
    rdf.dg = sys.hbox / rdf.nhgr
    rdf.dgi = 1 / rdf.dg
    rdf.tempav = 0.0
    rdf.g = zeros(sp.nhgr)

    # stress tensor
    st = sp.st = MDSampleST()
    st.tstress0 = 0
    st.dstress_time = sys.nsamp * sys.dt * sys.igr
    st.sxyz00 = zeros(3)

    # velocity auto-correlation function and mean square displacement
    vacf = sp.vacf = MDSampleVACF()
    vacf.t0 = 0
    vacf.tvacf = 0
    vacf.dtime = sys.nsamp * sys.dt * sys.ivacf
    vacf.r2t = zeros(TMAx)
    vacf.nvacf = zeros(TMAx)
    vacf.vacf = zeros(TMAx)
    vacf.nstress = zeros(TMAx)
    vacf.sxyzt = zeros(TMAx, 3)

    sp
end
