args = {...}
if fs.exists("skynet") then
    sky = require "skynet"
elseif fs.exists("APM") then
    shell.run("APM install 19 -y")
    shell.run("skynet")
    print("telnet-rx has crashed please restart the script!")
    return false
else
    print("Missing skynet and APM, please install either")
    return false
end
if #args < 3 then
    print("Too few arguments!")
    print("telnet-rx <channel> <mode> <password>")
    print("Avaible modes are")
    print("guest - the sender can verify that the server exists")
    print("normal - the sender can run existing files")
    print("admin - the sender can run pastebins")
    return false
end
while true do
    ch,data = sky.receive(args[1])
    print(data)
    if string.sub(data,1,string.len(args[3])) == args[3] then
        print("Sucsessfull login")
        if args[2] == "guest" then
            sky.send(ch,"i exist but im in guest mode!")
        elseif args[2] == "normal" then
            program = string.sub(data,string.len(args[3])+1,string.len(data))
            if fs.exists(program) then
                shell.run(program)
                sky.send(ch,"Done")
            else
                sky.send(ch,"no such program "..program)
            end
        else
            shell.run("pastebin run",string.sub(data,string.len(args[3])+1,string.len(data)))
            sky.send(ch,"Done")
        end
    end
    sleep(1)
end
