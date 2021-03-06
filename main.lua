-- Cette ligne permet d'afficher des traces dans la console pendant l'exécution
io.stdout:setvbuf('no')

local lander = {}
lander.x = 0
lander.y = 0
lander.angle = 270
lander.vx = 0
lander.vy = 0
lander.speed = 3
lander.img = love.graphics.newImage("images/ship.png")
lander.imgEngine = love.graphics.newImage("images/engine.png")
lander.engineOn = false

function love.load()
    largeur = love.graphics.getWidth()
    hauteur = love.graphics.getHeight()

    lander.x = largeur/2
    lander.y = hauteur/2
end

function love.update(dt)
    --lander.vy = lander.vy + (0.6 * dt)    

    if love.keyboard.isDown("right") then
        lander.angle = lander.angle + 90 * dt
        if lander.angle > 360 then
            lander.angle = 0
        end
    end
    if love.keyboard.isDown("left") then
        lander.angle = lander.angle - 90 * dt
        if lander.angle < 0 then
            lander.angle = 360
        end
    end
    if love.keyboard.isDown("up") then
        engineOn = true

        -- obtenir vx et vy en fonction de l'angle
        local angleRadian = math.rad(lander.angle)
        local forceX = math.cos(angleRadian) * (lander.speed * dt)
        local forceY = math.sin(angleRadian) * (lander.speed * dt)
        if math.abs(forceX) < 0.001 then forceX = 0 end
        if math.abs(forceY) < 0.001 then forceY = 0 end
        lander.vx = lander.vx + forceX
        lander.vy = lander.vy + forceY   
    else
        engineOn = false
    end

    lander.vy = lander.vy + (0.6 * dt)

    if math.abs(lander.vx) > 1 then
      if lander.vx > 0 then
        lander.vx = 1
      else
        lander.vx = -1
      end
    end
    if math.abs(lander.vy) > 1 then
      if lander.vy > 0 then
        lander.vy = 1
      else
        lander.vy = -1
      end
    end

    lander.x = lander.x + lander.vx
    lander.y = lander.y + lander.vy
end

function love.draw()
    love.graphics.draw(lander.img, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.img:getWidth()/2, lander.img:getHeight()/2)
    if engineOn then
        love.graphics.draw(lander.imgEngine, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.imgEngine:getWidth()/2, lander.imgEngine:getHeight()/2)
    end

    local sDebug = "Debug : "
    sDebug = sDebug.."Angle="..tostring(lander.angle)
    sDebug = sDebug.." Vx="..tostring(lander.vx)
    sDebug = sDebug.." Vy="..tostring(lander.vy)
    love.graphics.print(sDebug, 0, 0)
end