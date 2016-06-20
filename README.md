[![Build Status](https://semaphoreci.com/api/v1/charlyraffellini/robot_war/branches/master/badge.svg)](https://semaphoreci.com/charlyraffellini/robot_war)


# Robot War REPL

This is a REPL for play Robot War

The commands which this understand are:

Be careful all index are 0-base

- **create a new Board:** new Board \<x size> \<y size>
- **create a new Robot:** new Robot \<x position> \<y position>
- **add new robot path:** \<robot id or name> : [P | N | M]*
- **run:** run

In order to avoid any ambiguity the _spin order_ follows the [right hand rule](https://en.wikipedia.org/wiki/Right-hand_rule):
- **P** means the robot spin one positive unit.
- **N** means the robot spin one negative unit.


[![Robot War Video](https://gifs.com/gif/nodejs-robot-war-repl-L9V8qj)](https://youtu.be/RwR9jAzHqe0)


---

### Used tools:

- Node.js v5.2.0
- Atom.io
- [ConsoleZ](https://github.com/cbucher/console)
