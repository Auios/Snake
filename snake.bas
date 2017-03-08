#include once "vect2d.bi"

type Snake
    as Vect2d position
    as Vect2d scale
    as Vect2d max
    as Vect2d ptr b
    as integer length
    as ubyte direction
    as ubyte lastDirection
    
    declare constructor()
    declare constructor(maxX as integer, maxY as integer)
    declare destructor()
    declare sub update()
    declare sub render()
    declare sub setSize(w as integer, h as integer)
    declare sub setPosition(x as integer, y as integer)
    declare sub eatFood()
    declare sub changeDirection(direction as integer)
end type

constructor Snake()
    this.length = 0
    this.direction = int(4*rnd())
end constructor

constructor Snake(maxX as integer, maxY as integer)
    this.length = 0
    this.direction = int(4*rnd())
    this.max.x = maxX
    this.max.y = maxY
end constructor

destructor Snake()
    delete[] this.b
end destructor

sub Snake.update()
    'Move
    if(this.direction = 0) then
        if(this.position.y > 0) then this.position.y-=1
    elseif(this.direction = 1) then
        if(this.position.y < max.y-1) then this.position.y+=1
    elseif(this.direction = 2) then
        if(this.position.x > 0) then this.position.x-=1
    elseif(this.direction = 3) then
        if(this.position.x < max.x-1) then this.position.x+=1
    end if
    this.lastDirection = this.direction
end sub

sub Snake.render()
    line(this.position.x*this.scale.x, this.position.y*this.scale.y)-(this.position.x*this.scale.x+this.scale.x, this.position.y*this.scale.y+this.scale.y),rgb(255,255, 255),bf
    line(this.position.x*this.scale.x, this.position.y*this.scale.y)-(this.position.x*this.scale.x+this.scale.x, this.position.y*this.scale.y+this.scale.y),rgb(30, 30, 200),b
end sub

sub Snake.setSize(w as integer, h as integer)
    this.scale.x = w
    this.scale.y = h
end sub

sub Snake.setPosition(x as integer, y as integer)
    this.position.x = x
    this.position.y = y
end sub

sub Snake.eatFood()
    this.length+=1
    if(this.length = 1) then
        this.b = new Vect2d[1]
        this.b[0].x = this.position.x
        this.b[0].y = this.position.y
    end if
end sub

sub Snake.changeDirection(direction as integer)
    if(this.lastDirection = 0 AND direction <> 1) then
        this.direction = direction
    elseif(this.lastDirection = 1 AND direction <> 0) then
        this.direction = direction
    elseif(this.lastDirection = 2 AND direction <> 3) then
        this.direction = direction
    elseif(this.lastDirection = 3 AND direction <> 2) then
        this.direction = direction
    end if
end sub

