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


``` (THE MISSION - from other readme when platform137 was made)
  The great mining exodus is amongst us and the numbers will be coming in fast from another popular known L1 named Ethereum. Eth, short for Ethereum, is dominant in the PoW computation battle and has chosen to switch over to PoS. This switch is leading to opportunities to capture and bring over a whole new diverse crowd of folks looking to mine. Bitcoin being ASIC supported isn't welcoming to us little folk as it is dominated by the privileged. The goal here is to make a tool so easy your grandmother could use it to mine. Anyone with a GPU, currently only nvidia, can launch the app and mine away Ergo. Not only can you mine Ergo, you can actively control your fans and clock your system. Not only that but you can do much more. You can set a power threshold so you save your house from being burnt down whilst away for a while. Amazing right? When I first started mining every tool was just okay. You had to run three to four different tools to clock, control fans, set power draws and so much more. Everything here is monolithic in the sense that it is all packaged into one app. Input your address and select a stake pool, then you are good to go! Buy your grandma a GPU because she will be able to start mining. Many things are coming in the future such as mobile connections to mine from the go. Cron-esque tabs for timed mines. From L2 payouts to future L1 to L1 payouts. The great mining exodus is amongst us. Let us build out the hardware to bring over anyone we can and let the little guy take part in mining and produce blocks to secure a decentralized SSI based future. 

```
