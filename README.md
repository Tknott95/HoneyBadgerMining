# HoneyBadgerMining - Desktop App Clocking/Mining/Thresholds/Power/Etc (works with Aisling)
May have offline data emulation enabled, if so, just switch back to live data for analytics. If wanting mining analytics also, you must start mining to get analytics
(needs other gpu brand support). Will add if have time. 
(clocks/thresholds, etc and mines ergo). (after update to nvidia 3 fan drivers, I need to fix a script or two for setting fan speed, basic stuff.) Uses shell procs to handle everything regarding nvidia and  

three driver gpus were messing up nvidia fan grabs and index settings. I never implemented a system to grab fan count for each driver then spawned widgets approp regarding amount of fans.This need dynamism and it is good to go. (nvidia fixed this so I will update it soon.) This connects to aisling, a mobile app, to mine from far away. I will finish this when I have time as it was a hackathon project. All that needs to be added is a count for fans on each driver. if three then set approp. Will fix this later.   
HoneyBadgerMining


works with AISLING a mobile app that .ets you mine/clock/etc from anywhere.
you can throw up a server from where you run this, on any iot, and then use Aisling to control it from anywhere. 


- Finish thw obile app connecting to this
- There is a mobile extension if wanted to mine from the go


Some code was done on an airplane with no wifi. I will need to create a boolean to handle offline or online coding.

  # going to set all fans with only the gpu, by gpu #,  active for now nvidia-settings -a [gpu:0]/GPUFanControlState=1  -a [fan:2]/GPUTargetFanSpeed=39
