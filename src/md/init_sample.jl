const NHIsmax = 250

function init_sample!(sp::MDSample, md::MDConfig)
    sys = md.system
    sp.ngr = 0.0
    sp.nhgr = NHIsmax
    sp.dg = sys.hbox / sp.nhgr
    sp.dgi = 1 / sp.dg
end
