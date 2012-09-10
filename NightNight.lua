--# Main
----------------------------------------------------------------
----------------------------------------------------------------
--                       'Night Night'                        --
--                        Version 0.1                         --
----------------------------------------------------------------
----------------------------------------------------------------
-- Travis Carrigan, programmer


function setup()

   -- Project information
   saveProjectInfo("Description", "A simple grid syle shooting game.
Shoot the bad guy and save the hostages")
   saveProjectInfo("Author","Travis Carrigan")

   -- Set to fullscreen mode and get current orientation
   displayMode(FULLSCREEN_NO_BUTTONS)
   supportedOrientations(LANDSCAPE_LEFT)
   o = CurrentOrientation

   -- Define dimensions
   -- Do not change or menu will not work
   w = WIDTH
   h = HEIGHT

   nx = 15
   ny = 15

   dx = (w/nx)
   dy = (h/ny)

   -- Customize bandit respawn rate
   bt=3
   bt1=0

   -- Customize hostage respawn rate
   ht=3
   ht1=0

   -- Customize frame rate
   k=0.1
   k1=0

   -- Initialize classes and arrays
   cross = Cross(dx,dy,w,h)
   bandit = Bandit(dx,dy)
   hostage = Hostage(dx,dy)
   window = {}

   -- Begin game with menu
   currentLevel = 0

end


function touchingAtPos()

   if CurrentTouch.state == BEGAN or
      CurrentTouch.state == MOVING then
       return vec2( CurrentTouch.x, CurrentTouch.y )
   end

   return nil

end


function draw()

   -- Background color
   background(0, 0, 0, 255)

   -- Draw border
   pushStyle()
   strokeWidth(0.04*math.max(dx,dy))
   stroke(255, 255, 255, 255)
   noFill()
   rect(dx,dy,w-2*dx,h-2*dy)
   popStyle()

   -- Splash screen
   if currentLevel == 0 then

       -- Create window objects
       for i = 1, math.ceil(nx/4)-1 do
           window[i]={}
           for j = 1, math.ceil(ny/4)-1 do
               window[i][j] = Window(dx*(4*i-2),dy*(4*j-2),dx,dy)
               stroke(67, 67, 67, 255)
               fill(67, 67, 67, 255)
               window[i][j]:draw()
           end
       end

       cross:draw()
       bandit:draw()
       hostage:draw()

       pushStyle()
       fontSize(1.25*dx)
       fill(255, 255, 255, 255)
       textMode(CENTER)
       text("night", 11.5*dx, 12.1*dy)
       popStyle()

       pushStyle()
       fontSize(1.25*dx)
       fill(0, 0, 0, 255)
       textMode(CENTER)
       text("night", 11.5*dx, 12.05*dy)
       popStyle()

       pushStyle()
       fontSize(1.25*dx)
       fill(255, 255, 255, 255)
       textMode(CENTER)
       text("night", 11.5*dx, 11.25*dy)
       popStyle()

       pushStyle()
       fontSize(1.25*dx)
       fill(255, 0, 0, 255)
       textMode(CENTER)
       text("night", 11.5*dx, 11.2*dy)
       popStyle()

       pushStyle()
       fontSize(0.25*dx)
       fill(255, 255, 255, 255)
       textMode(CORNER)
       textWrapWidth(2*dx)
       text("This is your sight. Use it to aim.", 3*dx, 3*dy)
       text("This is a bad guy. Kill the bad guy.", 7*dx, 7*dy)
       text("This is a good guy. Don't kill the good guy.", 11*dx, 7*dy)
       popStyle()

       pushStyle()
       fontSize(0.5*dx)
       fill(255, 255, 255, 255)
       textMode(CENTER)
       text("Touch",7.5*dx,3.5*dy)
       popStyle()

       pushStyle()
       fontSize(0.5*dx)
       fill(255, 255, 255, 255)
       textMode(CENTER)
       text("iCade",11.5*dx,3.5*dy)
       popStyle()

       touch = touchingAtPos()
       if touch then

           if math.abs(touch:dist(window[2][1].position)) < 3*dx then
               TouchOrIcade = 0
               currentLevel = 1
           elseif math.abs(touch:dist(window[3][1].position)) < 3*dx then
               TouchOrIcade = 1
               i = iCade()
               currentLevel = 1
           end

       end

   else

       -- Create window objects
       for i = 1, math.ceil(nx/4)-1 do
           window[i]={}
           for j = 1, math.ceil(ny/4)-1 do
               window[i][j] = Window(dx*(4*i-2),dy*(4*j-2),dx,dy)
               window[i][j]:isOff()
               window[i][j]:draw()
           end
       end

       -- Randomly recalculate bandit position
       bt2 = ElapsedTime
       bdt = bt2 - bt1

       if bdt > bt then

           birandTmp = math.random(math.ceil(nx/4)-1)
           bjrandTmp = math.random(math.ceil(ny/4)-1)

           if birand == birandTmp and bjrand == bjrandTmp then
               birand = math.random(math.ceil(nx/4)-1)
               bjrand = math.random(math.ceil(ny/4)-1)
           else
               birand = birandTmp
               bjrand = bjrandTmp
           end

           bWindowLoc = window[birand][bjrand].position
           bandit.position =
vec2(bWindowLoc.x+math.random(0,2)*dx,bWindowLoc.y)

           banditRandX = math.random(0,2)

           bt1 = ElapsedTime

       end

       -- Randomly recalculate hostage position
       ht2 = ElapsedTime
       hdt = ht2 - ht1

       if hdt > ht then

           hirand = math.random(math.ceil(nx/4)-1)
           hjrand = math.random(math.ceil(ny/4)-1)
           hWindowLoc = window[hirand][hjrand].position
           hostage.position =
vec2(hWindowLoc.x+math.random(0,2)*dx,hWindowLoc.y)

           ht1 = ElapsedTime

       end

       -- Turn on the lights and move bandit
       if birand then

           if birand == hirand and
              bjrand == hjrand then

               if banditRandX == 1 then
                   banditRandX = 0
               end

               bandit.position = vec2(bWindowLoc.x+banditRandX*dx,bWindowLoc.y)
               bandit:draw()

           end

           window[birand][bjrand]:isOn()
           window[birand][bjrand]:draw()

           bandit:draw()

       end

       -- Turn on lights and move hostage
       if hirand then

           if birand == hirand and
              bjrand == hjrand then

               if banditRandX == 0 then
                   hostageRandX = 2
               else
                   hostageRandX = 0
               end

               hostage.position =
vec2(bWindowLoc.x+hostageRandX*dx,bWindowLoc.y)
               hostage:draw()

           else

               window[hirand][hjrand]:isOn()
               window[hirand][hjrand]:draw()

               hostage:draw()

           end

       end

   end

   -- Redraws scene if screen orientation changed
   if o ~= CurrentOrientation then
       setup()
   end

   -- Draw crosshairs
   if TouchOrIcade == 0 then

       touch = touchingAtPos()
       if touch then

           hit = 0
           dmx = 0.5*dx
           dmy = 0.5*dy

           move = touch - cross.position - vec2(0.5*dx,0.5*dy)
           moveAbsX = math.abs(move.x)
           moveAbsY = math.abs(move.y)

           k2 = ElapsedTime
           dk = k2 - k1

           if dk > k then

               if move.x < -dmx and
                  moveAbsX > moveAbsY then

                   cross.position.x = cross.position.x - dx
                   if cross.position.x > dx then
                       cross:draw()
                   else
                       cross.position.x = dx
                       cross:draw()
                   end

               elseif move.x > dmx and
                      moveAbsX > moveAbsY then

                   cross.position.x = cross.position.x + dx
                   if cross.position.x < w-2*dx then
                       cross:draw()
                   else
                       cross.position.x = w-2*dx
                       cross:draw()
                   end

               elseif move.y < -dmy and
                      moveAbsY > moveAbsX then

                   cross.position.y = cross.position.y - dy
                   if cross.position.y > dy then
                       cross:draw()
                   else
                       cross.position.y = dy
                       cross:draw()
                   end

               elseif move.y > dmy and
                      moveAbsY > moveAbsX then

                   cross.position.y = cross.position.y + dy
                   if cross.position.y < h-2*dy then
                       cross:draw()
                   else
                       cross.position.y = h-2*dy
                       cross:draw()
                   end

               end

               k1 = ElapsedTime

           end

       end

       cross:draw()

   elseif TouchOrIcade == 1 then

       k2 = ElapsedTime
       dk = k2 - k1

       if dk > k then

           if (i.su) then

               cross.position.y = cross.position.y + dy
               if cross.position.y < h-2*dy then
                   cross:draw()
               else
                   cross.position.y = h-2*dy
                   cross:draw()
               end

           elseif (i.sd) then

               cross.position.y = cross.position.y - dy
               if cross.position.y > dy then
                   cross:draw()
               else
                   cross.position.y = dy
                   cross:draw()
               end

           elseif (i.sl) then

               cross.position.x = cross.position.x - dx
               if cross.position.x > dx then
                   cross:draw()
               else
                   cross.position.x = dx
                   cross:draw()
               end

           elseif (i.sr) then

               cross.position.x = cross.position.x + dx
               if cross.position.x < w-2*dx then
                   cross:draw()
               else
                   cross.position.x = w-2*dx
                   cross:draw()
               end

            end

           k1 = ElapsedTime

       end

       cross:draw()

   end

   -- Shoot bad guy
   if math.abs(bandit.position:dist(cross.position)) < 0.001 then

       hit = hit + 1
       if hit == 1 then
           sound(DATA, "ZgNAVx0mPUBAUmVAAAAAAIwDwz6s3tY+fwBAf1dAQEBAe0BA")
           --pos = vec2(x+0.5*dx,y+0.5*dy)
           --crack = Crack()
       end

       currentLevel = 1

   end

   --if crack then
       --crack:draw()
       --if crack:isDone() then
           --crack = nil
           --currentLevel = 1
       --end
   --end

end


-- Records iCade keys
function keyboard(key)
   i:keyboard(key)
   hit = 0
end
--# Window
Window = class()

function Window:init(x,y,dx,dy)

   self.dx = dx
   self.dy = dy

   self.position = vec2(x,y)

end


function Window:isOff()

   stroke(30, 30, 30, 255)
   fill(30, 30, 30, 255)

end


function Window:isOn()

   stroke(190, 190, 190, 255)
   fill(190, 190, 190, 255)

end


function Window:draw()

   pushStyle()

   strokeWidth(0.05*math.max(self.dx,self.dy))
   rect(self.position.x,self.position.y,3*self.dx,3*self.dy)

   popStyle()

end
--# Cross
Cross = class()

function Cross:init(dx,dy,w,h)

   self.dx = dx
   self.dy = dy

   self.w = w
   self.h = h

   self.position = vec2(2*self.dx,2*self.dy)

end


function Cross:draw()

   pushStyle()

   strokeWidth(0.1*math.max(self.dx,self.dy))
   stroke(255, 0, 0, 255)
   noFill()
   rect(self.position.x,self.position.y,self.dx,self.dy)

   strokeWidth(0.075*math.max(self.dx,self.dy))
   stroke(255, 0, 0, 255)
   line(self.position.x,self.position.y+0.5*self.dy,0,self.position.y+0.5*self.dy)
   line(self.position.x+self.dx,self.position.y+0.5*self.dy,self.w,self.position.y+0.5*self.dy)
   line(self.position.x+0.5*self.dx,self.position.y,self.position.x+0.5*self.dx,0)
   line(self.position.x+0.5*self.dx,self.position.y+self.dy,self.position.x+0.5*self.dx,self.h)
   ellipse(self.position.x+0.5*self.dx,self.position.y+0.5*self.dy,0.1*math.min(self.dx,self.dy))

   popStyle()

end


--# Bandit
Bandit = class()

function Bandit:init(dx,dy)

   self.dx = dx
   self.dy = dy

   self.position = vec2(6*self.dx,6*self.dy)

end


function Bandit:hit()

   pushStyle()

   lineCapMode(SQUARE)
   strokeWidth(0.1*math.max(self.dx,self.dy))
   stroke(0, 0, 0, 255)

   pt1 = vec2(self.position.x+0.35*self.dx,self.position.y+0.75*self.dy)
   v1 = vec2(0,0.2*self.dy)

   pt1ln1 = pt1 + v1:rotate(math.rad(45))
   pt1ln2 = pt1 + v1:rotate(math.rad(135))
   pt1ln3 = pt1 + v1:rotate(math.rad(225))
   pt1ln4 = pt1 + v1:rotate(math.rad(315))

   line(pt1.x,pt1.y,pt1ln1.x,pt1ln1.y)
   line(pt1.x,pt1.y,pt1ln2.x,pt1ln2.y)
   line(pt1.x,pt1.y,pt1ln3.x,pt1ln3.y)
   line(pt1.x,pt1.y,pt1ln4.x,pt1ln4.y)

   pt2 = vec2(self.position.x+0.65*self.dx,self.position.y+0.75*self.dy)
   v2 = vec2(0,0.2*self.dy)

   pt2ln1 = pt2 + v2:rotate(math.rad(45))
   pt2ln2 = pt2 + v2:rotate(math.rad(135))
   pt2ln3 = pt2 + v2:rotate(math.rad(225))
   pt2ln4 = pt2 + v2:rotate(math.rad(315))

   line(pt2.x,pt2.y,pt2ln1.x,pt2ln1.y)
   line(pt2.x,pt2.y,pt2ln2.x,pt2ln2.y)
   line(pt2.x,pt2.y,pt2ln3.x,pt2ln3.y)
   line(pt2.x,pt2.y,pt2ln4.x,pt2ln4.y)

   popStyle()

end


function Bandit:draw()

   pushStyle()
   fill(0, 0, 0, 255)
   rect(self.position.x,self.position.y,self.dx,self.dy)
   fill(255, 255, 255, 255)
   rect(self.position.x,self.position.y+0.60*self.dy,self.dx,0.3*self.dy)
   fill(0, 0, 0, 255)
   ellipse(self.position.x+0.35*self.dx,self.position.y+0.75*self.dy,0.2*math.min(self.dx,self.dy))
   ellipse(self.position.x+0.65*self.dx,self.position.y+0.75*self.dy,0.2*math.min(self.dx,self.dy))
   popStyle()

end


--# Hostage
Hostage = class()

function Hostage:init(dx,dy)

   self.dx = dx
   self.dy = dy

   self.position = vec2(10*self.dx,6*self.dy)

end


function Hostage:hit()

   pushStyle()

   lineCapMode(SQUARE)
   strokeWidth(0.1*math.max(self.dx,self.dy))
   stroke(255, 255, 255, 255)

   pt1 = vec2(self.position.x+0.35*self.dx,self.position.y+0.75*self.dy)
   v1 = vec2(0,0.2*self.dy)

   pt1ln1 = pt1 + v1:rotate(math.rad(45))
   pt1ln2 = pt1 + v1:rotate(math.rad(135))
   pt1ln3 = pt1 + v1:rotate(math.rad(225))
   pt1ln4 = pt1 + v1:rotate(math.rad(315))

   line(pt1.x,pt1.y,pt1ln1.x,pt1ln1.y)
   line(pt1.x,pt1.y,pt1ln2.x,pt1ln2.y)
   line(pt1.x,pt1.y,pt1ln3.x,pt1ln3.y)
   line(pt1.x,pt1.y,pt1ln4.x,pt1ln4.y)

   pt2 = vec2(self.position.x+0.65*self.dx,self.position.y+0.75*self.dy)
   v2 = vec2(0,0.2*self.dy)

   pt2ln1 = pt2 + v2:rotate(math.rad(45))
   pt2ln2 = pt2 + v2:rotate(math.rad(135))
   pt2ln3 = pt2 + v2:rotate(math.rad(225))
   pt2ln4 = pt2 + v2:rotate(math.rad(315))

   line(pt2.x,pt2.y,pt2ln1.x,pt2ln1.y)
   line(pt2.x,pt2.y,pt2ln2.x,pt2ln2.y)
   line(pt2.x,pt2.y,pt2ln3.x,pt2ln3.y)
   line(pt2.x,pt2.y,pt2ln4.x,pt2ln4.y)

   popStyle()

end


function Hostage:draw()

   pushStyle()
   fill(0, 0, 0, 255)
   rect(self.position.x,self.position.y,self.dx,self.dy)
   fill(255, 255, 255, 255)
   ellipse(self.position.x+0.35*self.dx,self.position.y+0.75*self.dy,0.2*math.min(self.dx,self.dy))
   ellipse(self.position.x+0.65*self.dx,self.position.y+0.75*self.dy,0.2*math.min(self.dx,self.dy))
   popStyle()

end

--# Crack
Crack = class()

function Crack:init()

   self.position = pos
   self.opacity = 255
   self.time = 0
   self.lines = {}
   self.dx = dx
   self.dy = dy

   sound(DATA, "ZgNAVx0mPUBAUmVAAAAAAIwDwz6s3tY+fwBAf1dAQEBAe0BA")

   if self.dx <= self.dy then
       low = 0.25*self.dx
       high = 0.9*self.dx
   else
       low = 0.25*self.dy
       high = 0.9*self.dy
   end

   for i = 1,30 do
       dir = vec2(0,1)
       dir = dir:rotate( math.random(360) )
       val = dir*math.random(0,1)
       table.insert( self.lines, val )
   end

end


function Crack:isDone()
   return self.opacity <= 0
end


function Crack:draw()

   self.time = self.time + 2.0

   pushStyle()

   lineCapMode(SQUARE)
   strokeWidth(5)
   smooth()
   stroke(255, 0, 0, 255)

   p = self.position
   for i,v in ipairs(self.lines) do
       vt = p + v * self.time
       line(p.x, p.y, vt.x, vt.y)
   end

   self.opacity = 255 * (1 - (self.time/30));

   popStyle()

end

--# iCade
-- iCade class by Bortels http://home.bortels.us/decodea/results/iCade.html
iCade = class()

function iCade:init()
   showKeyboard()
   self.x=0
   self.y=0
   self.b1=false
   self.b2=false
   self.b3=false
   self.b4=false
   self.b5=false
   self.b6=false
   self.b7=false
   self.b8=false
   self.su=false
   self.sd=false
   self.sl=false
   self.sr=false
   self.action = {
       ["y"] = function () self.b1=true end,
       ["t"] = function () self.b1=false end,
       ["u"] = function () self.b2=true end,
       ["f"] = function () self.b2=false end,
       ["i"] = function () self.b3=true end,
       ["m"] = function () self.b3=false end,
       ["o"] = function () self.b4=true end,
       ["g"] = function () self.b4=false end,
       ["h"] = function () self.b5=true end,
       ["r"] = function () self.b5=false end,
       ["j"] = function () self.b6=true end,
       ["n"] = function () self.b6=false end,
       ["k"] = function () self.b7=true end,
       ["p"] = function () self.b7=false end,
       ["l"] = function () self.b8=true end,
       ["v"] = function () self.b8=false end,
       ["w"] = function () self.su=true end,
       ["e"] = function () self.su=false end,
       ["x"] = function () self.sd=true end,
       ["z"] = function () self.sd=false end,
       ["a"] = function () self.sl=true end,
       ["q"] = function () self.sl=false end,
       ["d"] = function () self.sr=true end,
       ["c"] = function () self.sr=false end,
   }
end

function iCade:keyboard(key)
   a = self.action[key]
   if (a) then a() end
end
