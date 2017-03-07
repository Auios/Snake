#include "fbgfx.bi"
#include "aulib.bi"

#include "Snake.bas"
#include "Food.bas"

using fb, aulib

randomize(timer())

'Application window
dim shared as AuWindow wnd
wnd = AuWindowInit(800, 600, 32, 1, 0, "Snake by Auios")

'Globals
dim shared as boolean runApp = true
dim shared as string k
const col_size = 8
const row_size = 8
dim shared as integer cols,rows
cols = wnd.wdth/col_size
rows = wnd.hght/row_size

'Snake setup
dim as Snake s
s.setSize(col_size, row_size)
s.setPosition(int(cols*rnd()), int(rows*rnd()))

'Create window
AuWindowCreate(wnd)

'Main game loop
do
    k = inkey()
    if(k = chr(27)) then runApp = false
    
    s.update()
    
    screenLock()
        cls()
        s.render()
    screenUnlock
    
    sleep(250,1)
loop until(runApp = false)

AuWindowDestroy(wnd)