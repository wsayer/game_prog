--[[

  _      ___ _____              ____                    
 | | /| / (_) / (_)__ ___ _    / __/__ ___ _____ ____   
 | |/ |/ / / / / / _ `/  ' \  _\ \/ _ `/ // / -_) __/   
 |__/|__/_/_/_/_/\_,_/_/_/_/ /___/\_,_/\_, /\__/_/      
                                      /___/             

]]


-- Cette ligne permet d'afficher des traces dans la console pendant l'exécution
io.stdout:setvbuf('no')

-- empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour pixel art
love.graphics.setDefaultFilter("nearest")

pad = {} -- iniyialisation d'un tableau "pad" pour les variables suivantes
pad.x = 0 -- position de départ coin supérieur gauche à 0 pixel
pad.y = 0 -- position de départ coin supérieur gauche à 0 pixel
pad.largeur = 20 -- 20 pixel de largeur pour le pad (raquette)
pad.hauteur = 80 -- 80 pixel de hauteur pour le pad

balle = {} -- initialisation du tableau "balle" pour les variables suivantes
balle.x = 400 -- position horizontale de la balle dans la fenêtre 800x600
balle.y = 300 -- position verticale de la balle
balle.largeur = 20 -- largeur de la balle, 20 pixels
balle.hauteur = 20 -- hauteur de la balle, 20 pixels

balle.vitesse_x = 3 -- vitesse de la balle en horizontale de la gauche vers la droite
balle.vitesse_y = 3 -- vitesse de la balle en verticale de la gauche vers la droite

-- fonction pour recentrer la balle au milieu de l'écran 800x600 pixels lorsque l'on manque la cible
-- on perd et on recommence
function centreBalle()
  balle.x = love.graphics.getWidth() / 2 -- 800 / 2 = 400 pixels
  balle.x = balle.x - balle.largeur / 2 -- 400 - 20/2 = 390 pixels
  balle.y = love.graphics.getHeight() / 2 -- 600 / 2 = 300 pixels
  balle.y = balle.y - balle.hauteur / 2 -- 300 - 20/2 = 290 pixels
end

-- initialisation et chargement de la balle
function love.load()
  balle.x = love.graphics.getWidth() / 2
  balle.x = balle.x - balle.largeur / 2
  balle.y = love.graphics.getHeight() / 2
  balle.y = balle.y - balle.hauteur / 2
end

-- permet de bouger le pad avec les touches flèches haut et bas.
function love.update()
  if love.keyboard.isDown("down") and
    pad.y < love.graphics.getHeight() - pad.hauteur then
    pad.y = pad.y +3
  end
  if love.keyboard.isDown("up") and pad.y > 0 then
    pad.y = pad.y -3
  end
  balle.x = balle.x + balle.vitesse_x
  balle.y = balle.y + balle.vitesse_y
  
  -- évite que la balle sorte de l'écran du côté bas, la balle rebondi
  if balle.y > love.graphics.getHeight() - balle.hauteur then
    balle.vitesse_y = -balle.vitesse_y
  end
  
  -- évite que la balle sorte de l'écran du côté droit, la balle rebondi
  if balle.x > love.graphics.getWidth() - balle.largeur then
    balle.vitesse_x = -balle.vitesse_x
  end
  
  -- évite que la balle sorte de l'écran du côté haut, la balle rebondi
  if balle.y < 0 then
    balle.vitesse_y = -balle.vitesse_y
  end
  
  -- Tester si la balle atteint la raquette ?
  if balle.x < pad.x + pad.largeur then
    -- Tester si la balle est sur la raquette ou pas ?
    if balle.y + balle.hauteur > pad.y and balle.y < pad.y + pad.hauteur
    then
      balle.vitesse_x = -balle.vitesse_x
      -- Positionne la balle au bord de la raquette
      balle.x = pad.x + pad.largeur
    end
    if balle.x <= 0 then
      print("Perdu !")
      centreBalle() -- fonction pour recentrer la balle au centre et on recommence à jouer
    end
  end
end

-- fonction de dessiner le pad et la balle à l'écran
function love.draw()
  love.graphics.rectangle("fill", pad.x, pad.y, pad.largeur, pad.hauteur)
  love.graphics.rectangle( "fill" , balle.x, balle.y, balle.largeur, balle.hauteur)
end

