#include once "vect2d.bi"

type Snake
    as Vect2d position
    as Vect2d scale
    as integer length
    as ubyte direction
    
    declare constructor()
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

sub Snake.update()
    'Move
    if(this.direction = 0) then
        this.position.y-=1
    elseif(this.direction = 1) then
        this.position.y+=1
    elseif(this.direction = 2) then
        this.position.x-=1
    elseif(this.direction = 3) then
        this.position.x+=1
    end if
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
end sub

sub Snake.changeDirection(direction as integer)
    if(this.direction = 0 AND direction <> 1) then this.direction = direction
    if(this.direction = 1 AND direction <> 0) then this.direction = direction
    if(this.direction = 2 AND direction <> 3) then this.direction = direction
    if(this.direction = 3 AND direction <> 2) then this.direction = direction
end sub

