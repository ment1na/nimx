
import view
import animation
import times
import context
import font

export view

# Window type is defined in view module


#TODO: Window size has two notions. Think about it.

method init*(w: Window, frame: Rect) =
    procCall w.View.init(frame)
    w.window = w
    w.animations = @[]

method `title=`*(w: Window, t: string) = discard
method title*(w: Window): string = ""


method onResize*(w: Window, newSize: Size) =
    procCall w.View.setFrameSize(newSize)

proc fps(): int =
    var lastTime {.global.} = epochTime()
    var lastFrame {.global.} = 0.0
    let curTime = epochTime()
    let thisFrame = curTime - lastTime
    lastFrame = (lastFrame * 0.9 + thisFrame * 0.1)
    result = (1.0 / lastFrame).int
    lastTime = curTime

method drawWindow*(w: Window) =
    let c = currentContext()
    var pt = newPoint(w.frame.width - 80, 2)
    c.fillColor = newColor(0.5, 0, 0)
    c.drawText(systemFont(), pt, "FPS: " & $fps())

    w.recursiveDrawSubviews()

method enableAnimation*(w: Window, flag: bool) = discard

method startTextInput*(w: Window) = discard
method stopTextInput*(w: Window) = discard

proc runAnimations*(w: Window) =
    let t = epochTime()
    for a in w.animations:
        a.tick(t)

proc addAnimation*(w: Window, a: Animation) =
    w.animations.add(a)
    a.startTime = epochTime()

