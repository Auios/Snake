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
    declare function collisionCheck() as boolean
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
    'Move body
    if(this.length = 1) then
        this.b[0] = this.position
    elseif(this.length > 1) then
        for i as integer = this.length-1 to 1 step -1
            this.b[i] = this.b[i-1]
        next i
        this.b[0] = this.position
    end if
    
    'Move head
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
    if(this.length) then
        for i as integer = 0 to this.length-1
            line(this.b[i].x*this.scale.x, this.b[i].y*this.scale.y)_
            -(this.b[i].x*this.scale.x+this.scale.x, this.b[i].y*this.scale.y+this.scale.y),rgb(200,50,50),bf
            line(this.b[i].x*this.scale.x, this.b[i].y*this.scale.y)_
            -(this.b[i].x*this.scale.x+this.scale.x, this.b[i].y*this.scale.y+this.scale.y),rgb(75,75,75),b
        next i
    end if
    
    line(this.position.x*this.scale.x, this.position.y*this.scale.y)_
    -(this.position.x*this.scale.x+this.scale.x, this.position.y*this.scale.y+this.scale.y),rgb(255,50,50),bf
    line(this.position.x*this.scale.x, this.position.y*this.scale.y)_
    -(this.position.x*this.scale.x+this.scale.x, this.position.y*this.scale.y+this.scale.y),rgb(255,255,255),b
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
        this.b[0] = this.position
    else
        dim as Vect2d ptr tb = new Vect2d[this.length]
        for i as integer = 0 to this.length-2
            tb[i] = this.b[i]
        next i
        tb[this.length-1] = this.position
        delete[] this.b
        this.b = tb
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

function Snake.collisionCheck() as boolean
    dim as boolean retVal = false
    if(this.length > 3) then
        for i as integer = 3 to this.length
