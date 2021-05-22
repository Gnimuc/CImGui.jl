if Sys.isbsd() && !Sys.isapple()
    const time_t = Int64
elseif Sys.iswindows() && Sys.ARCH === :x86_64
    const time_t = Clonglong
else
    const time_t = Clong
end
