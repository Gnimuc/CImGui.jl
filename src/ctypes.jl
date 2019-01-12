## TODO: pending https://github.com/JuliaLang/julia/issues/29420
# this one is suggested in the issue, but it looks like time_t and tm are two different things?
# const Ctime_t = Base.Libc.TmStruct

const Ctm = Base.Libc.TmStruct
const Ctime_t = UInt
const Cclock_t = UInt

const int8_t = Int8
const uint8_t = UInt8
const int16_t = Int16
const uint16_t = UInt16
const int32_t = Int32
const uint32_t = UInt32
const uintptr_t = Csize_t
