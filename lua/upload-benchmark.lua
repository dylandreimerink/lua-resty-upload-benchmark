local ffi	    = require "ffi";
local ngx       = require "ngx"
local timec     = ffi.load("timeCFunc")

local upload                            = require "resty.upload"
local upload_with_complex_string_buffer = require "resty.upload-with-complex-string-buffer"
local upload_with_simple_string_buffer  = require "resty.upload-with-simple-string-buffer"
local upload_with_string_concat         = require "resty.upload-with-string-concat"
local upload_without_buffer             = require "resty.upload-without-buffer"

ffi.cdef[[
double getTime();
]];

local _M = {};

local function test(upload_lib) 
    local form, err = upload_lib:new(8192, 8192, true)
    if not form then
        ngx.log(ngx.ERR, "failed to new upload: ", err)
        ngx.exit(500)
    end

    form:set_timeout(1000) -- 1 sec

    local startTime = timec.getTime()

    while true do
        local typ, res, err = form:read()
        if not typ then
            ngx.say("failed to read: ", err)
            return
        end

        if typ == "eof" then
            break
        end
    end

    local endTime = timec.getTime()

    ngx.say((endTime - startTime) .. "µs");
end

function _M.test_base()
    test(upload)
end

function _M.test_with_complex_string_buffer()
    test(upload_with_complex_string_buffer)
end

function _M.test_with_simple_string_buffer()
    test(upload_with_simple_string_buffer)
end

function _M.test_with_string_concat()
    test(upload_with_string_concat)
end

function _M.test_without_buffer()
    test(upload_without_buffer)
end

return _M