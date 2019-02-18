# helper convertion functions
Base.convert(::Type{ImVec2}, x::NTuple{2}) = ImVec2(x...)
Base.convert(::Type{ImVec4}, x::NTuple{4}) = ImVec4(x...)
Base.convert(::Type{ImVec4}, x::ImU32) = ColorConvertU32ToFloat4(x)
Base.convert(::Type{ImU32}, x::ImVec4) = ColorConvertFloat4ToU32(x)

# put this in CEnum.jl?
using CSyntax.CEnum: Cenum, enum_names, enum_values

Base.:|(a::T, b::Integer) where {T<:Cenum{UInt32}} = UInt32(a) | UInt32(b)
Base.:|(a::Integer, b::T) where {T<:Cenum{UInt32}} = UInt32(b) | UInt32(a)

Base.:&(a::T, b::Integer) where {T<:Cenum{UInt32}} = UInt32(a) & UInt32(b)
Base.:&(a::Integer, b::T) where {T<:Cenum{UInt32}} = UInt32(b) & UInt32(a)

ShowFlags(::Type{T}) where {T<:Cenum} = foreach(x->println(x), zip(enum_names(T), enum_values(T)))
GetFlags(::Type{T}) where {T<:Cenum} = zip(enum_names(T), enum_values(T)) |> collect

# simple unsafe destruction helper
function UnsafeGetPtr(x::Ptr{T}, name::Symbol) where {T}
    offset = x
    type = T
    flag = false
    for i = 1:fieldcount(T)
        name == fieldname(T, i) || continue
        flag = true
        type = fieldtype(T, i)
        offset += fieldoffset(T, i)
        break
    end
    flag || throw(ArgumentError("$T has no field named $name."))
    return Ptr{type}(offset)
end

function Get(x::Ptr{T}, name::Symbol) where {T}
    GC.@preserve x begin
        value = unsafe_load(UnsafeGetPtr(x, name))
    end
    return value
end

function Set(x::Ptr{T}, name::Symbol, value::S) where {T,S}
    GC.@preserve x value begin
        unsafe_store!(UnsafeGetPtr(x, name), value)
    end
    return value
end
