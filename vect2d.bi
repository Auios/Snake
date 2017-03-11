#ifndef _VECT2D_BI_
#define _VECT2D_BI_

type Vect2d
    as integer x,y
    
    declare sub set(v as Vect2d)
    declare function equals
end type

sub Vect2d.set(v as Vect2d)
    this.x = v.x
    this.y = v.y
end sub

#endif