function sample1!(st::MDStatus, md::MDConfig)

end
function sample!(st::MDStatus, md::MDConfig)
    sample1!(st, md)
    sample2!(st, md)
    st
end
