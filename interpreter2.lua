i,m,o = input,math,output
ign,osn = i.getNumber,o.setNumber

savedValues,holding = {{},{},{},0},{false,false,false,false}
currentValues = {}

oldHdg,oldRol,oldPit = 0,0,0
oldC = {0,0,0}

disablePilot,pilot = false,{}

function onTick()
  um = ign(32)
  x,y,z,tF,tL = ign(5),ign(6),ign(7),ign(8),ign(9)
  hdg = m.atan(y-oldC[2],x-oldC[1])
  aspd = m.sqrt((x-oldC[1])^2+(y-oldC[2])^2+(z-oldC[3])^2)*60
  vspd = z-oldC[3]*60
  currentValues[1] = {tF,(z-oldC[3])*60,z}
  currentValues[2] = {tF,(z-oldC[3])*60,z}
  currentValues[3] = {tL,(tL-oldRol)*60,tL}
  currentValues[4] = aspd

  for j=1,4 do
    pilot[j]=ign(j)
  end

  if um==0 then
    disablePilot=false
    for j=1,3 do
      hold(j,-1,pilot[j])
    end
    hold(4,0,pilot[4])
  elseif um==1 then

    disablePilot=false
    ds={3,2,1,1}
    hold(4,0,pilot[4])
    for j=1,3 do
      if eeq(pilot[j],0,0.05)then
        if holding[j]==false then
          saveCurrentValue(j,ds[j])
          holding[j]=true
          hold(j,ds[j],savedValues[j][ds[j]])
        end
      else
        holding[j]=false
      end
    end

  elseif um==2 then
    -- hold alt,hdg,horizon | mix
    hold(3,1,0)
  elseif um==3 then
    -- navigate to airport
    -- then land, raise landed flag, change mode to 1
  elseif um == 4 then
    -- just go to given gps cords
    hold(3,1,0)
  end

  osn(14,savedValues[2][1])
  osn(11,aspd)
  osn(12,vspd)
  osn(13,hdg)
  oldC[1],oldC[2],oldC[3],oldHdg,oldRol,oldPit = x,y,z,hdg,tL,tF
  o.setBool(1,disablePilot)
end


function saveCurrentValue(axis,depth)
savedValues[axis][depth] = currentValues[axis][depth]
end

function hold(axis,depth,value)
osn(axis,value)osn(4+axis,depth)
end

function eeq(a,b,e)
  return a>b-e and a<b+e
end
-- axes 1234 - pitch yaw roll speed
-- depth 012 - tilt vspd alt, rate value, rate value, speed