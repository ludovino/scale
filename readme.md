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

## TODOs

## Game Props and Interactions

#### Prop node
- inherits from Rigidbody 3d
- can be moved by kick or suck `min_move_size`
- can be sucked up if player is too big `min_suck_size`
- has a list of sibling rigidbodies that are also destroyed if sucked up (e.g. cabinet doors)
- has a $ value to lose if sucked up

#### breakable prop node
- inherits from prop node
- breaks if collided with
- loses $ value if broken
- breaks into pieces that can be sucked up

#### Dirt node
- has $ value
- can be sucked up

#### Dirtpatch node
- monitors child dirt nodes
- when a % of dirt in the dirt group is collected, emit a signal and destroy the rest of the dirt

#### Vaccuum
- has cone of force affected by player size
- toggle on / off func
- pulls props and dirt that have line of site and are small enough

#### Kick
- has trigger area affected by size
- pushes props and rigidbodies away, force depends on size

## UI

- task list
- current score
- timer
- menu screen
- level select ?


## Levels
- one working level
