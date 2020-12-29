import os
import json
import re
env_dist = os.environ
with open(env_dist.get("GITHUB_EVENT_PATH")) as json_file:
    data = json.load(json_file)
    print(data)
    code=data["comment"]["body"]
    x = re.findall("public\s+class\s+(\S+)[\s{]" , code)
    className=x[0]
    
    id=str(data["comment"]["id"])
    if(not os.path.isdir(id)):
        os.mkdir(id)
    f = open(id+"/"+className+".as", "w")
    f.write(code)
    f.close()
    
    f = open(id+"/main.txt", "w")
    f.write(className)
    f.close()
