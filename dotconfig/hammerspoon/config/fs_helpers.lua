function readFileContents(filePath)
    local file = assert(io.open(filePath, "rb"));
    local content = file:read("*all");
    file:close();
    return content;
end

function writeToFile(filePath, data)
    local file = io.open(filePath, "w");
    io.output(file);
    io.write(data);
    io.close(file);
end

function fileExists(filePath)
    local file = io.open(filePath, "r");
    if file ~= nil then
        io.close(file);
        return true;
    else
        return false;
    end;
 end