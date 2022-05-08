require 'ruby2d'

set title: "Monster Eating Circles"
set width: 800
set height: 600
set background: 'silver'

# Heartbeat traker for update loop which fires 60 times/second
tick = 0

# Score keeping
hits = 0
chances = 0
  
# Score display
score = Text.new('Score: 0 / 0', x: 340, y: 560, style: 'bold', size: 20, color: 'white', z: 1)

ballList=Array.new(100) {
    xball=rand (Window.width)
    yball=rand (Window.height)
    xv=rand(-0.5...0.5)
    yv=rand(-0.5...0.5)
    color=Color.new('random')
    ball=Square.new(x: xball, y:yball, size: 10, color: color)
  }

for i in 0...100
    ballList.at(i).remove
end


  # Load hammer image
monster=Sprite.new(
      'monster3-removebg-preview.png',
      width: 200,
      height: 200,
      clip_width: 120,
      clip_height: 120,
      x: 800, y: 600, z: 2,
      loop: true
  )
monster.play

# Move hammer with mouse pointer
on :mouse_move do |event|
  if monster!=nil
    monster.x = event.x - 15
    monster.y = event.y - 70
  end
end

  # When mouse is clicked, check for a hit
on :mouse_down do |event|
    for i in 0...100
      ball=ballList.at(i)
      if (ball.contains? event.x, event.y) && tick % 100 <= 80
        hits+= 1
      end
    end
end

update do
    # Make Ruby appear randomly in 1 of 9 locations every 5 seconds
    if tick % 100 == 0
      for i in 0...100
        ball=ballList.at(i)
        ball.x = rand(0...800)
        ball.y = rand(0...600)
        ball.color=Color.new('random')
        ball.add
      end
    end

    # Make Ruby disappear after 1 second and update score
    if tick % 100 == 80
      for i in 0...100
        ballList.at(i).remove
      end
      chances += 1
      score.text = "Score: #{hits} / #{chances}"
    end

    tick += 1
end

show
