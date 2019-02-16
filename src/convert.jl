# helper convertion functions
Base.convert(::Type{ImVec2}, x::NTuple{2}) = ImVec2(x...)
Base.convert(::Type{ImVec4}, x::NTuple{4}) = ImVec4(x...)
