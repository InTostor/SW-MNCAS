  i,m,s,w,h=input,math,screen,0,0

  increment = 0.01
  value = 0
  range = {0,1}

  function onTick()
    tX,tY,tP = i.getNumber(3),i.getNumber(4),i.getBool(1)
    if (i.getBool(3) or touch(0,0,w/2,h)) and value>range[1] then
      decrease()
    elseif (i.getBool(4) or touch(w/2,0,w/2,h)) and value<range[2] then
      increase()
    elseif i.getBool(5) then
      set(i.getNumber(7))
    end

    output.setNumber(1,clamp(value,range[1],range[2]))
  end

  function onDraw()
    w,h=s.getWidth(),s.getHeight()

    s.setColor(120,120,120)
    s.drawRect(1,1,w-2,h-2)
    s.setColor(40,40,40)
    s.drawRectF(2,h/2+h/4-2,w-4,4)
    s.drawText(1,1,"-")
    s.drawText(w-5,1,"+")

    s.setColor(20,20,20)
    for l=1,10 do
      ln = w/10*l
      s.drawLine(ln,0,ln,h)
    end

    drawLever()
  end

  function drawLever()
    lh = 7
    lm = 2
    lPos = rerange(value,range[1],range[2],0+lh/2,w-lh/2)

    s.setColor(120,120,120)
    s.drawRectF(lPos-lh/2, lm,lh,h-lm*2)
    s.drawTriangleF(lPos-lh/2,lm, lPos-lh/2,h-lm*2, lPos-lh/2-lm,h/2+h/8)
    s.drawTriangleF(lPos+lh/2,lm, lPos+lh/2,h-lm*2, lPos+lh/2+lm,h/2-h/8)

    s.setColor(80,80,80)
    s.drawRectF(lPos-(lh-2)/2,4,(lh-2),h-8)
  end

  function increase()
  value =value+increment
  end

  function decrease()
    value =value-increment
  end

  function set(val)
    value = val
  end

  function touch(rX, rY, rW, rH)return tX > rX and tY > rY and tX < rX+rW and tY < rY+rH and tP end
  function rerange(x,in_min,in_max,out_min,out_max)return (x-in_min)*(out_max-out_min)/(in_max-in_min)+out_min end
  function clamp(x,mi,ma)if x<mi then return mi elseif x>ma then return ma else return x end end