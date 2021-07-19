/*:
  # Property Observers
 - - - - - - - - - - - - -
 
 * Property Observers
    * Swift is able to "detect" when a **struct** changes
    * You can take action when Swift detects this change
    * Property observers are essentially a way to "watch" a var and execute code when it changes


The syntax can look a lot like a computed var, but it is completely unrelated to that.
 ```
 var isFaceUp: Bool {
    willSet {
        if newValue {
            startUsingBonusTime()
        } else {
            stopUsingBonusTime()
        }
    }
 }
 ```

Inside here, `newValue` is a special variable (the value it's going to get set to). `willSet` happens before the var changes the value. There is also a `didSet` which happens after the var changes its value (inside `didSet`, we use `oldValue` which is what the value used to be).
 
 
 */

//: [Previous](@previous) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Next](@next)
