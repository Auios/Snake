#include once "vect2d.bi"

type Food
    as Vect2d position
    as Vect2d scale
    
    declare sub update()
    declare sub render()
    declare sub setSize(w as integer, h as integer)
    declare sub setPosition(x as integer, y as integer)
end type

sub Food.update()
    
end sub

sub Food.render()
    line(this.position.x*this.scale.x, this.position.y*this.scale.y)-(this.position.x*this.scale.x+this.scale.x, this.position.y*this.scale.y+this.scale.y),rgb(255, 255, 255),bf
    line(this.position.x*this.scale.x, this.position.y*this.scale.y)-(this.position.x*this.scale.x+this.scale.x, this.position.y*this.scale.y+this.scale.y),rgb(30, 200, 30),b
end sub

sub Food.setSize(w as integer, h as integer)
    this.scale.x = w
    this.scale.y = h
end sub

sub Food.setPosition(x as integer, y as integer)
    this.position.x = x
    this.position.y = y
end sub