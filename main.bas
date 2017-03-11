#include "fbgfx.bi"
#include "aulib.bi"

#include "snake.bas"
#include "food.bas"

using fb, aulib

randomize(timer())

'Application window
dim shared as AuWindow wnd
wnd = AuWindowInit(800, 600, 32, 1, 0, "Snake - by Auios")

'Globals
dim as boolean runApp = true
dim as string k
dim as integer cols = 24
dim as integer rows = 20
dim as integer col_size = wnd.wdth/cols
dim as integer row_size = wnd.hght/rows
const updateSpeed = 0.1
dim shared as double lastUpdateTime
lastUpdateTime = timer()

'Declares
declare function snakeFoodCheck(s as Snake, f as Food) as boolean

'Snake setup
dim as Snake s = Snake(cols, rows)
s.setSize(col_size, row_size)
s.setPosition(int((cols-1)*rnd()), int((rows-1)*rnd()))

'Food setup
dim as Food f
f.setSize(col_size, row_size)
f.setPosition(int((cols-1)*rnd()), int((rows-1)*rnd()))

'Create window
AuWindowCreate(wnd)

'Main game loop
do
    'Input
    k = inkey()
    if(k = chr(27)) then runApp = false
    if(multikey(sc_w)) then s.changeDirection(0)
    if(multikey(sc_s)) then s.changeDirection(1)
    if(multikey(sc_a)) then s.changeDirection(2)
    if(multikey(sc_d)) then s.changeDirection(3)
    
    'Update
    if((timer() - lastUpdateTime) > updateSpeed) then
        s.update()
        if(snakeFoodCheck(s, f)) then 
            s.eatFood()
            f.setPosition(int((cols-1)*rnd()), int((rows-1)*rnd()))
        end if
        lastUpdateTime = timer()
    end if
    
    'Render
    screenLock()
        cls()
        
        line(0,0)-(wnd.wdth,wnd.hght),rgb(75,75,75),bf
        s.render()
        f.render()
        
        draw string(5,5), "Score: " & s.length
    screenUnlock
    
    sleep(1,1)
loop until(runApp = false)

AuWindowDestroy(wnd)

'---------------------------
function snakeFoodCheck(s as Snake, f as Food) as boolean
    dim as boolean retVal = false
    if(s.position.x = f.position.x AND s.position.y = f.position.y) then retVal = true
    return retVal
end function
