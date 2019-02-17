# helper convertion functions
Base.convert(::Type{ImVec2}, x::NTuple{2}) = ImVec2(x...)
Base.convert(::Type{ImVec4}, x::NTuple{4}) = ImVec4(x...)

# put this in CEnum.jl?
using CSyntax.CEnum: Cenum

Base.:|(a::T, b::Integer) where {T<:Cenum{UInt32}} = UInt32(a) | UInt32(b)
Base.:|(a::Integer, b::T) where {T<:Cenum{UInt32}} = UInt32(b) | UInt32(a)

Base.:&(a::T, b::Integer) where {T<:Cenum{UInt32}} = UInt32(a) & UInt32(b)
Base.:&(a::Integer, b::T) where {T<:Cenum{UInt32}} = UInt32(b) & UInt32(a)
