-- Cette ligne permet d'afficher des traces dans la console pendant l'exécution
io.stdout:setvbuf('no')

local lander = {}
lander.x = 0
lander.y = 0
lander.angle = -90
lander.vx = 0
lander.vy = 0
lander.img = love.graphics.newImage("images/ship.png")

function love.load()
    largeur = love.graphics.getWidth()
    hauteur = love.graphics.getHeight()

    lander.x = largeur/2
    lander.y = hauteur/2
end

function love.update(dt)
    lander.vy = lander.vy + (0.6 * dt)

    lander.x = lander.x + lander.vx
    lander.y = lander.y + lander.vy
end

function love.draw()
    love.graphics.draw(lander.img, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.img:getWidth()/2, lander.img:getHeight()/2)
end