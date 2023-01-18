args={...}
if fs.exists("skynet") then
    sky = require "skynet"
elseif fs.exists("APM") then
    shell.run("APM install 19 -y")
    shell.run("skynet")
    print("telnet-tx has crashed plese restart the script!")
    return false
else
    print("Bootleg copy suspected!")
    print("Please install telnet-tx via APM!")
    shell.run("pastebin run sXHAFJJk update")
    shell.run("APM search telpack")
    shell.run("APM search telnet")
    shell.run("APM search telnet-tx")
    return "bootleg susprected script terminated"
end
if #args < 3 then
    print("telnet-tx <channel> <password> <command>")
else
    sky.send(args[1],args[2]..args[3])
    print("waiting for response...")
    ch,msg = sky.receive(args[1])
    print(msg)
end
