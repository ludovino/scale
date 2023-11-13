# SCALE
## No Job Too Big Or Small
A third person time trial clean-em-up.

### Game Loop
the player frantically runs around a house with a vacuum cleaner and a shrinking device, trying to hoover up dirt as quickly as possible while trying not to damage too many household items

### scoring
a level comes with a series of tasks each with a dollar value e.g. 
- [X] clean under sofa $20
- [ ] dust book shelf $30
- [X] clean bathroom $50
- [ ] get rid of rotten food $20
- [ ] clean gutters $100

each time a task is checked off, the dollar amount is added to the score, but the general sucking up of dirt also increases the score.

some items in the house are breakable, and breaking those items will deduct dollars from the total score


## CODE:
### Complete:
- prop
- dirt
- vacuum
- level controller
- score
- timer

### TODO:

- Breakable prop node
    - inherits from prop node
    - breaks if collided with
    - loses $ value if broken
    - breaks into pieces that can be sucked up
- Dirtpatch node
    - monitors child dirt nodes
    - when a % of dirt in the dirt group is collected, emit a signal and destroy the rest of the dirt
- kick
    - has trigger area affected by size
    - pushes props and rigidbodies away, force depends on size
- UI
    - task list
    - menu screen
    - level select
- Levels
    - one working level

## 3D
### Complete
- main character model

### TODO
- main character animation
    - walk / run (not vacuuming)
    - walk forward / back / strafe left + right while sucking
    - jump
    - land
    - jump + suck
    - kick
    - jump + kick
    - bump head

- design for main menu screen
- home layouts (as many as we can?)

## Sound
### Complete
- integrate FMOD

### TODO

- music
    - in level music slowly accelerates and raises in pitch with timer
- main character sounds
    - walk / run footsteps
    - vacuum power up
    - vacuum running
    - vacuum power off
    - vacuum swallow dirt
    - vacuum swallow object
    - jump
    - land
    - kick
    - bump head
- prop sounds:
    - large object impacts
        - wood
        - fabric (e.g. sofa cushion)
        - metal
    - small objects
        - wood
        - misc metal
        - glass
        - ceramic plates and cups
        - paper



## Level design
### Complete
- test level
### TODO
- lay out level 1
- lay out level 2
- lay out tutorial
- add 3d models to levels
- more levels?