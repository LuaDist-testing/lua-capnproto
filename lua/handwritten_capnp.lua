-- require "luacov"
local ffi = require "ffi"
local capnp = require "capnp"
local bit = require "bit"
local util = require "capnp.util"

local ceil              = math.ceil
local write_struct_field= capnp.write_struct_field
local read_struct_field = capnp.read_struct_field
local read_text         = capnp.read_text
local write_text        = capnp.write_text
local get_enum_val      = capnp.get_enum_val
local get_enum_name     = capnp.get_enum_name
local get_data_off      = capnp.get_data_off
local write_listp_buf   = capnp.write_listp_buf
local write_structp_buf = capnp.write_structp_buf
local write_structp     = capnp.write_structp
local read_struct_buf   = capnp.read_struct_buf
local read_listp_struct = capnp.read_listp_struct
local read_list_data    = capnp.read_list_data
local write_list        = capnp.write_list
local write_list_data   = capnp.write_list_data
local ffi_new           = ffi.new
local ffi_string        = ffi.string
local ffi_cast          = ffi.cast
local ffi_copy          = ffi.copy
local ffi_fill          = ffi.fill
local band, bor, bxor = bit.band, bit.bor, bit.bxor

local ok, new_tab = pcall(require, "table.new")

if not ok then
    new_tab = function (narr, nrec) return {} end
end

local round8 = function(size)
    return ceil(size / 8) * 8
end

local str_buf
local default_segment_size = 4096

local function get_str_buf(size)
    if size > default_segment_size then
        return ffi_new("char[?]", size)
    end

    if not str_buf then
        str_buf = ffi_new("char[?]", default_segment_size)
    end
    return str_buf
end

local _M = new_tab(2, 8)


_M.T1 = {
    id = 13624321058757364083,
    displayName = "proto/example.capnp:T1",
    dataWordCount = 5,
    pointerCount = 8,
    discriminantCount = 3,
    discriminantOffset = 10,

    fields = {
        { name = "i0", default = 0, ["type"] = "uint32" },
        { name = "i1", default = 0, ["type"] = "uint16" },
        { name = "b0", default = 0, ["type"] = "bool" },
        { name = "i2", default = 0, ["type"] = "int8" },
        { name = "b1", default = 0, ["type"] = "bool" },
        { name = "i3", default = 0, ["type"] = "int32" },
        { name = "s0", default = "opaque pointer", ["type"] = "struct" },
        { name = "e0", default = "enum1", ["type"] = "enum" },
        { name = "l0", default = "opaque pointer", ["type"] = "list" },
        { name = "t0", default = "", ["type"] = "text" },
        { name = "e1", default = "enum5", ["type"] = "enum" },
        { name = "d0", default = "", ["type"] = "data" },
        { name = "ui0", default = 0, ["type"] = "int32" },
        { name = "ui1", default = 0, ["type"] = "int32" },
        { name = "uv0", default = "Void", ["type"] = "void" },
        { name = "g0", default = nil, ["type"] = "group" },
        { name = "u0", default = nil, ["type"] = "group" },
        { name = "ls0", default = "opaque pointer", ["type"] = "list" },
        { name = "du0", default = 65535, ["type"] = "uint32" },
        { name = "db0", default = 1, ["type"] = "bool" },
        { name = "end", default = 0, ["type"] = "bool" },
        { name = "o0", default = nil, ["type"] = "anyPointer" },
        { name = "lt0", default = "opaque pointer", ["type"] = "list" },
    },
    calc_size_struct = function(data)
        local size = 104
        -- struct
        if data.s0 then
            size = size + _M.T1.T2.calc_size_struct(data.s0)
        end
        -- list
        if data.l0 then
            size = size + round8(#data.l0 * 1) -- num * acutal size
        end
        -- text
        if data.t0 then
            size = size + round8(#data.t0 + 1) -- size 1, including trailing NULL
        end
        -- data
        if data.d0 then
            size = size + round8(#data.d0)
        end
        -- composite list
        -- struct
        if data.g0 then
            size = size + _M.T1.g0.calc_size_struct(data.g0)
        end
        -- struct
        if data.u0 then
            size = size + _M.T1.u0.calc_size_struct(data.u0)
        end
        if data.ls0 then
            size = size + 8
            local num2 = #data.ls0
            for i2=1, num2 do
                size = size + _M.T1.T2.calc_size_struct(data.ls0[i2])
            end
        end
        if data.lt0 then
            local num2 = #data.lt0
            for i2=1, num2 do
                size = size + 8
                size = size + round8(#data.lt0[i2] * 1 + 1) -- num * acutal size
            end
        end
        return size
    end,

    calc_size = function(data)
        local size = 16 -- header + root struct pointer
        return size + _M.T1.calc_size_struct(data)
    end,

    flat_serialize = function(data, p32, pos)
        pos = pos and pos or 104
        local start = pos
        local dscrm
        if data["i0"] and (type(data["i0"]) == "number"
                or type(data["i0"]) == "boolean") then

            write_struct_field(p32, data["i0"], "uint32", 32, 0, 0)
        end
        if data["i1"] and (type(data["i1"]) == "number"
                or type(data["i1"]) == "boolean") then

            write_struct_field(p32, data["i1"], "uint16", 16, 2, 0)
        end
        if data["b0"] and (type(data["b0"]) == "number"
                or type(data["b0"]) == "boolean") then

            write_struct_field(p32, data["b0"], "bool", 1, 48, 0)
        end
        if data["i2"] and (type(data["i2"]) == "number"
                or type(data["i2"]) == "boolean") then

            write_struct_field(p32, data["i2"], "int8", 8, 7, 0)
        end
        if data["b1"] and (type(data["b1"]) == "number"
                or type(data["b1"]) == "boolean") then

            write_struct_field(p32, data["b1"], "bool", 1, 49, 0)
        end
        if data["i3"] and (type(data["i3"]) == "number"
                or type(data["i3"]) == "boolean") then

            write_struct_field(p32, data["i3"], "int32", 32, 2, 0)
        end
        if data["s0"] and type(data["s0"]) == "table" then
            local data_off = get_data_off(_M.T1, 0, pos)
            write_structp_buf(p32, _M.T1, _M.T1.T2, 0, data_off)
            local size = _M.T1.T2.flat_serialize(data["s0"], p32 + pos / 4)
            pos = pos + size
        end
        if data["e0"] and type(data["e0"]) == "string" then
            local val = get_enum_val(data["e0"], 0, _M.T1.EnumType1, "T1.e0")
            write_struct_field(p32, val, "uint16", 16, 6)
        end
        if data["l0"] and type(data["l0"]) == "table" then
            local data_off = get_data_off(_M.T1, 1, pos)
            pos = pos + write_list(p32 + _M.T1.dataWordCount * 2 + 1 * 2, data["l0"], (data_off + 1) * 8, "list", "int8")
        end
        if data["t0"] and type(data["t0"]) == "string" then
            local data_off = get_data_off(_M.T1, 2, pos)

            local len = #data["t0"] + 1
            write_listp_buf(p32, _M.T1, 2, 2, len, data_off)

            ffi_copy(p32 + pos / 4, data["t0"])
            pos = pos + round8(len)
        end
        if data["e1"] and type(data["e1"]) == "string" then
            local val = get_enum_val(data["e1"], 0, _M.EnumType2, "T1.e1")
            write_struct_field(p32, val, "uint16", 16, 7)
        end
        if data["d0"] and type(data["d0"]) == "string" then
            local data_off = get_data_off(_M.T1, 3, pos)

            local len = #data["d0"]
            write_listp_buf(p32, _M.T1, 3, 2, len, data_off)

            -- prevent copying trailing '\0'
            ffi_copy(p32 + pos / 4, data["d0"], len)
            pos = pos + round8(len)
        end
        if data["ui0"] then
            dscrm = 0
        end

        if data["ui0"] and (type(data["ui0"]) == "number"
                or type(data["ui0"]) == "boolean") then

            write_struct_field(p32, data["ui0"], "int32", 32, 4, 0)
        end
        if data["ui1"] then
            dscrm = 1
        end

        if data["ui1"] and (type(data["ui1"]) == "number"
                or type(data["ui1"]) == "boolean") then

            write_struct_field(p32, data["ui1"], "int32", 32, 4, 0)
        end
        if data["uv0"] then
            dscrm = 2
        end

        if data["g0"] and type(data["g0"]) == "table" then
            -- groups are just namespaces, field offsets are set within parent
            -- structs
            pos = pos + _M.T1.g0.flat_serialize(data["g0"], p32, pos) - 104
        end

        if data["u0"] and type(data["u0"]) == "table" then
            -- groups are just namespaces, field offsets are set within parent
            -- structs
            pos = pos + _M.T1.u0.flat_serialize(data["u0"], p32, pos) - 104
        end

        if data["ls0"] and type(data["ls0"]) == "table" then
            local num, size, old_pos = #data["ls0"], 0, pos
            local data_off = get_data_off(_M.T1, 4, pos)
            pos = pos + write_list(p32 + _M.T1.dataWordCount * 2 + 4 * 2, data["ls0"], (data_off + 1) * 8, "list", "struct", _M.T1.T2)
        end
        if data["du0"] and (type(data["du0"]) == "number"
                or type(data["du0"]) == "boolean") then

            write_struct_field(p32, data["du0"], "uint32", 32, 9, 65535)
        end
        if data["db0"] and (type(data["db0"]) == "number"
                or type(data["db0"]) == "boolean") then

            write_struct_field(p32, data["db0"], "bool", 1, 50, 1)
        end
        if data["end"] and (type(data["end"]) == "number"
                or type(data["end"]) == "boolean") then

            write_struct_field(p32, data["end"], "bool", 1, 51, 0)
        end
        if data["lt0"] and type(data["lt0"]) == "table" then
            local data_off = get_data_off(_M.T1, 6, pos)
            pos = pos + write_list(p32 + _M.T1.dataWordCount * 2 + 6 * 2, data["lt0"], (data_off + 1) * 8, "list", "text")
        end
        if dscrm then
            _M.T1.which(p32, 10, dscrm) --buf, discriminantOffset, discriminantValue
        end

        return pos - start + 104
    end,

    serialize = function(data, p8, size)
        if not p8 then
            size = _M.T1.calc_size(data)

            p8 = get_str_buf(size)
        end
        ffi_fill(p8, size)
        local p32 = ffi_cast("int32_t *", p8)

        p32[0] = 0                                    -- 1 segment
        p32[1] = (size - 8) / 8

        write_structp(p32 + 2, _M.T1, 0)               -- skip header
        _M.T1.flat_serialize(data, p32 + 4)            -- skip header & struct pointer

        return ffi_string(p8, size)
    end,

    which = function(buf, offset, n)
        if n then
            -- set value
            write_struct_field(buf, n, "uint16", 16, offset)
        else
            -- get value
            return read_struct_field(buf, "uint16", 16, offset)
        end
    end,

    parse_struct_data = function(buf, data_word_count, pointer_count, header, tab)
        local s = tab

        local dscrm = _M.T1.which(buf, 10) --buf, dscrmriminantOffset, dscrmriminantValue


        s["i0"] = read_struct_field(buf, "uint32", 32, 0, 0)
        s["i1"] = read_struct_field(buf, "uint16", 16, 2, 0)
        s["b0"] = read_struct_field(buf, "bool", 1, 48, 0)
        s["i2"] = read_struct_field(buf, "int8", 8, 7, 0)
        s["b1"] = read_struct_field(buf, "bool", 1, 49, 0)
        s["i3"] = read_struct_field(buf, "int32", 32, 2, 0)
        local p = buf + (5 + 0) * 2 -- buf, dataWordCount, offset
        local off, dw, pw = read_struct_buf(p, header)
        if off and dw and pw then
            if not s["s0"] then
                s["s0"] = new_tab(0, 2)
            end
            _M.T1.T2.parse_struct_data(p + 2 + off * 2, dw, pw, header, s["s0"])
        else
            s["s0"] = nil
        end


        local val = read_struct_field(buf, "uint16", 16, 6)
        s["e0"] = get_enum_name(val, 0, _M.T1.EnumType1Str)

        local off, size, num = read_listp_struct(buf, header, _M.T1, 1)
        if off and num then
            s["l0"] = read_list_data(buf + (5 + 1 + 1 + off) * 2, header, num, "int8") -- dataWordCount + offset + pointerSize + off
        else
            s["l0"] = nil
        end

        s["t0"] = read_text(buf, header, _M.T1, 2, nil)
--[[
        local off, size, num = read_listp_struct(buf, header, _M.T1, 2)
        if off and num then
            s["t0"] = ffi.string(buf + (5 + 2 + 1 + off) * 2, num - 1) -- dataWordCount + offset + pointerSize + off
        else
            s["t0"] = nil
        end
]]
        local val = read_struct_field(buf, "uint16", 16, 7)
        s["e1"] = get_enum_name(val, 0, _M.EnumType2Str)
        local off, size, num = read_listp_struct(buf, header, _M.T1, 3)
        if off and num then
            s["d0"] = ffi.string(buf + (5 + 3 + 1 + off) * 2, num) -- dataWordCount + offset + pointerSize + off
        else
            s["d0"] = nil
        end

        if dscrm == 0 then

        s["ui0"] = read_struct_field(buf, "int32", 32, 4, 0)
        else
            s["ui0"] = nil
        end

        if dscrm == 1 then

        s["ui1"] = read_struct_field(buf, "int32", 32, 4, 0)
        else
            s["ui1"] = nil
        end

        if dscrm == 2 then

        s["uv0"] = "Void"
        else
            s["uv0"] = nil
        end

        if not s["g0"] then
            s["g0"] = new_tab(0, 4)
        end
        _M.T1["g0"].parse_struct_data(buf, _M.T1.dataWordCount, _M.T1.pointerCount,
                header, s["g0"])

        if not s["u0"] then
            s["u0"] = new_tab(0, 4)
        end
        _M.T1["u0"].parse_struct_data(buf, _M.T1.dataWordCount, _M.T1.pointerCount,
                header, s["u0"])

        -- composite list
        local off, size, num = read_listp_struct(buf, header, _M.T1, 4)
        if off and num then
            s["ls0"] = read_list_data(buf + (5 + 4 + 1 + off) * 2, header, num, "struct", _M.T1.T2) -- dataWordCount + offset + pointerSize + off
        else
            s["ls0"] = nil
        end
        s["du0"] = read_struct_field(buf, "uint32", 32, 9, 65535)
        s["db0"] = read_struct_field(buf, "bool", 1, 50, 1)
        s["end"] = read_struct_field(buf, "bool", 1, 51, 0)
        local off, size, num = read_listp_struct(buf, header, _M.T1, 6)
        if off and num then
            s["lt0"] = read_list_data(buf + (5 + 6 + 1 + off) * 2, header, num, "text") -- dataWordCount + offset + pointerSize + off
        else
            s["lt0"] = nil
        end
        return s
    end,

    parse = function(bin, tab)
        if #bin < 16 then
            return nil, "message too short"
        end

        local header = new_tab(0, 4)
        local p = ffi_cast("uint32_t *", bin)
        header.base = p

        local nsegs = p[0] + 1
        header.seg_sizes = {}
        for i=1, nsegs do
            header.seg_sizes[i] = p[i]
        end
        local pos = round8(4 + nsegs * 4)
        header.header_size = pos / 8
        p = p + pos / 4

        if not tab then
            tab = new_tab(0, 8)
        end
        local off, dw, pw = read_struct_buf(p, header)
        if off and dw and pw then
            return _M.T1.parse_struct_data(p + 2 + off * 2, dw, pw, header, tab)
        else
            return nil
        end
    end,

}

_M.T1.T2 = {
    id = 17202330444354522981,
    displayName = "proto/example.capnp:T1.T2",
    dataWordCount = 2,
    pointerCount = 1,
    discriminantCount = 0,
    discriminantOffset = 0,

    fields = {
        { name = "f0", default = 0, ["type"] = "float32" },
        { name = "f1", default = 0, ["type"] = "float64" },
        { name = "sd0", default = "", ["type"] = "data" },
    },
    calc_size_struct = function(data)
        local size = 24
        -- data
        if data.sd0 then
            size = size + round8(#data.sd0)
        end
        return size
    end,

    calc_size = function(data)
        local size = 16 -- header + root struct pointer
        return size + _M.T1.T2.calc_size_struct(data)
    end,

    flat_serialize = function(data, p32, pos)
        pos = pos and pos or 24
        local start = pos
        local dscrm
        if data["f0"] and (type(data["f0"]) == "number"
                or type(data["f0"]) == "boolean") then

            write_struct_field(p32, data["f0"], "float32", 32, 0, 0)
        end
        if data["f1"] and (type(data["f1"]) == "number"
                or type(data["f1"]) == "boolean") then

            write_struct_field(p32, data["f1"], "float64", 64, 1, 0)
        end
        if data["sd0"] and type(data["sd0"]) == "string" then
            local data_off = get_data_off(_M.T1.T2, 0, pos)

            local len = #data["sd0"]
            write_listp_buf(p32, _M.T1.T2, 0, 2, len, data_off)

            -- prevent copying trailing '\0'
            ffi_copy(p32 + pos / 4, data["sd0"], len)
            pos = pos + round8(len)
        end
        return pos - start + 24
    end,
    serialize = function(data, p8, size)
        if not p8 then
            size = _M.T1.T2.calc_size(data)

            p8 = get_str_buf(size)
        end
        ffi_fill(p8, size)
        local p32 = ffi_cast("int32_t *", p8)

        p32[0] = 0                                    -- 1 segment
        p32[1] = (size - 8) / 8

        write_structp(p32 + 2, _M.T1.T2, 0)               -- skip header
        _M.T1.T2.flat_serialize(data, p32 + 4)            -- skip header & struct pointer

        return ffi_string(p8, size)
    end,


    parse_struct_data = function(buf, data_word_count, pointer_count, header, tab)
        local s = tab

        s["f0"] = read_struct_field(buf, "float32", 32, 0, 0)
        s["f1"] = read_struct_field(buf, "float64", 64, 1, 0)
        local off, size, num = read_listp_struct(buf, header, _M.T1.T2, 0)
        if off and num then
            s["sd0"] = ffi.string(buf + (2 + 0 + 1 + off) * 2, num) -- dataWordCount + offset + pointerSize + off
        else
            s["sd0"] = nil
        end
        return s
    end,

    parse = function(bin, tab)
        if #bin < 16 then
            return nil, "message too short"
        end

        local header = new_tab(0, 4)
        local p = ffi_cast("uint32_t *", bin)
        header.base = p
        local nsegs = p[0] + 1
        header.seg_sizes = {}
        for i=1, nsegs do
            header.seg_sizes[i] = p[i]
        end

        local pos = round8(4 + nsegs * 4)

        header.header_size = pos / 8
        p = p + pos / 4

        if not tab then
            tab = new_tab(0, 8)
        end
        local off, dw, pw = read_struct_buf(p, header)
        if off and dw and pw then
            return _M.T1.T2.parse_struct_data(p + 2 + off * 2, dw, pw, header, tab)
        else
            return nil
        end
    end,

}
_M.T1.EnumType1 = {
    ["enum1"] = 0,
    ["enum2"] = 1,
    ["enum3"] = 2,
}
_M.T1.EnumType1Str = {
    [0] = "enum1",
    [1] = "enum2",
    [2] = "enum3",
}

_M.T1.g0 = {
    id = 10312822589529145224,
    displayName = "proto/example.capnp:T1.g0",
    dataWordCount = 5,
    pointerCount = 8,
    discriminantCount = 0,
    discriminantOffset = 0,
    isGroup = true,

    fields = {
        { name = "ui2", default = 0, ["type"] = "uint32" },
    },
    calc_size_struct = function(data)
        local size = 0
        return size
    end,

    -- size is included in the parent struct, so no need to calculate size here
    calc_size = function(data)
        local size = 16 -- header + root struct pointer
        return size + _M.T1.g0.calc_size_struct(data)
    end,
    flat_serialize = function(data, p32, pos)
        pos = pos and pos or 104
        local start = pos
        local dscrm
        if data["ui2"] and (type(data["ui2"]) == "number"
                or type(data["ui2"]) == "boolean") then

            write_struct_field(p32, data["ui2"], "uint32", 32, 6, 0)
        end
        return pos - start + 104
    end,

    parse_struct_data = function(buf, data_word_count, pointer_count, header, tab)
        local s = tab
        s["ui2"] = read_struct_field(buf, "uint32", 32, 6, 0)
        return s
    end,
}
_M.T1.u0 = {
    id = 12188145960292142197,
    displayName = "proto/example.capnp:T1.u0",
    dataWordCount = 5,
    pointerCount = 8,
    discriminantCount = 4,
    discriminantOffset = 14,
    isGroup = true,

    fields = {
        { name = "ui3", default = 0, ["type"] = "uint16" },
        { name = "uv1", default = "Void", ["type"] = "void" },
        { name = "ug0", default = nil, ["type"] = "group" },
        { name = "ut0", default = "", ["type"] = "data" },
    },
    calc_size_struct = function(data)
        local size = 0
        -- struct
        if data.ug0 then
            size = size + _M.T1.u0.ug0.calc_size_struct(data.ug0)
        end
        -- data
        if data.ut0 then
            size = size + round8(#data.ut0)
        end
        return size
    end,

    calc_size = function(data)
        local size = 16 -- header + root struct pointer
        return size + _M.T1.u0.calc_size_struct(data)
    end,
    flat_serialize = function(data, p32, pos)
        pos = pos and pos or 104
        local start = pos
        local dscrm
        if data["ui3"] then
            dscrm = 0
        end

        if data["ui3"] and (type(data["ui3"]) == "number"
                or type(data["ui3"]) == "boolean") then

            write_struct_field(p32, data["ui3"], "uint16", 16, 11, 0)
        end
        if data["uv1"] then
            dscrm = 1
        end

        if data["ug0"] then
            dscrm = 2
        end

        if data["ug0"] and type(data["ug0"]) == "table" then
            -- groups are just namespaces, field offsets are set within parent
            -- structs
            pos = pos + _M.T1.u0.ug0.flat_serialize(data["ug0"], p32, pos) - 104
        end

        if data["ut0"] then
            dscrm = 3
        end

        if data["ut0"] and type(data["ut0"]) == "string" then
            local data_off = get_data_off(_M.T1.u0, 7, pos)

            local len = #data["ut0"]
            write_listp_buf(p32, _M.T1.u0, 7, 2, len, data_off)

            -- prevent copying trailing '\0'
            ffi_copy(p32 + pos / 4, data["ut0"], len)
            pos = pos + round8(len)
        end
        if dscrm then
            _M.T1.u0.which(p32, 14, dscrm) --buf, discriminantOffset, discriminantValue
        end

        return pos - start + 104
    end,
    which = function(buf, offset, n)
        if n then
            -- set value
            write_struct_field(buf, n, "uint16", 16, offset)
        else
            -- get value
            return read_struct_field(buf, "uint16", 16, offset)
        end
    end,

    parse_struct_data = function(buf, data_word_count, pointer_count, header, tab)
        local s = tab

        local dscrm = _M.T1.u0.which(buf, 14) --buf, dscrmriminantOffset, dscrmriminantValue


        if dscrm == 0 then
        s["ui3"] = read_struct_field(buf, "uint16", 16, 11, 0)
        else
            s["ui3"] = nil
        end

        if dscrm == 1 then

        s["uv1"] = "Void"
        else
            s["uv1"] = nil
        end

        if dscrm == 2 then

        if not s["ug0"] then
            s["ug0"] = new_tab(0, 4)
        end
        _M.T1.u0["ug0"].parse_struct_data(buf, _M.T1.u0.dataWordCount, _M.T1.u0.pointerCount,
                header, s["ug0"])

        else
            s["ug0"] = nil
        end

        if dscrm == 3 then

        local off, size, num = read_listp_struct(buf, header, _M.T1.u0, 7)
        if off and num then
            s["ut0"] = ffi.string(buf + (5 + 7 + 1 + off) * 2, num) -- dataWordCount + offset + pointerSize + off
        else
            s["ut0"] = nil
        end

        else
            s["ut0"] = nil
        end
        return s
    end,
}
_M.T1.u0.ug0 = {
    id = 17270536655881866717,
    displayName = "proto/example.capnp:T1.u0.ug0",
    dataWordCount = 5,
    pointerCount = 8,
    discriminantCount = 0,
    discriminantOffset = 0,
    isGroup = true,

    fields = {
        { name = "ugv0", default = "Void", ["type"] = "void" },
        { name = "ugu0", default = 0, ["type"] = "uint32" },
    },
    calc_size_struct = function(data)
        local size = 0
        return size
    end,

    calc_size = function(data)
        local size = 16 -- header + root struct pointer
        return size + _M.T1.u0.ug0.calc_size_struct(data)
    end,
    flat_serialize = function(data, p32, pos)
        pos = pos and pos or 104
        local start = pos
        local dscrm
        if data["ugu0"] and (type(data["ugu0"]) == "number"
                or type(data["ugu0"]) == "boolean") then

            write_struct_field(p32, data["ugu0"], "uint32", 32, 8, 0)
        end
        return pos - start + 104
    end,
    parse_struct_data = function(buf, data_word_count, pointer_count, header, tab)
        local s = tab

        s["ugv0"] = "Void"
        s["ugu0"] = read_struct_field(buf, "uint32", 32, 8, 0)
        return s
    end,
}


_M.EnumType2 = {
    ["enum5"] = 0,
    ["enum6"] = 1,
    ["enum7"] = 2,
    ["UPPER-DASH"] = 3,
    ["lower_under_score"] = 4,
    ["UPPER_UNDER_SCORE"] = 5,
}


_M.EnumType2Str = {
    [0] = "enum5",
    [1] = "enum6",
    [2] = "enum7",
    [3] = "upper_dash",
    [4] = "lower_under_score",
    [5] = "upper_under_score",
}

return _M
