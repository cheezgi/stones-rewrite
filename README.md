# stones rewrite
I really need to prototype in an easier language before diving headfirst
into writing an interpreter.

* Why not Python?
    * I'm more comfortable in Lua.
* Why not Factor?
    * Factor concepts don't really translate well into other languages.
* Why not [insert lang here]
    * Meh. I've done an interpreter in Lua [bef](
      https://github.com/cheezgi/superfish)[ore.](
      https://github.com/cheezgi/juggle) It was nice.

see [this](https://github.com/cheezgi/stones)

TODO:
* [X] Set up skeleton
* [ ] Everything else
    * [X] Stack stuff
    * [ ] Control flow stuff
        * [X] `if`, `else`, `end`
        * [ ] `while`
    * [ ] Stone movement mechanics
        * [ ] Stones move each other around - Slightly less buggy than before,
        still needs some work though. Spooky action at a distance is mostly
        fixed.
        * [X] Weight of stones factors into wether or not anything happens

Hey, looks like I'm almost finished. This is currently the reference
interpreter for the stones programming language. Eventually I'll get around
to translating this version into Rust. To be honest, the original reason that
I restarted this project in lua was because I couldn't figure out the module
system. It's kind of convoluted in my opinion.

I really needed to plan it out before I started. From what I've learned in
writing a game for Löve, I need to break stuff up in to more modular parts. I
wouldn't go as crazy as those folks over at npm, though.

