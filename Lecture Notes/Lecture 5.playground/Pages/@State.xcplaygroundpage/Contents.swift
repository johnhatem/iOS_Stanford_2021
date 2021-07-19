/*:
# @State
- - - - - - -

 * Your View is Read Only:
   * All View structs are completely read-only.
   * So ‘lets’ or computed ‘vars’ (which are read-only) make much sense on a View.
   * The exception is property wrappers like @ObservedObject which must be marked var.

 - Why!?
   * Views are created and tossed out all the time.
   * Only their “bodies” stick around very long.
   * So they don’t really live long enough to need to be mutable entities
 
 * No Worries!
   * This is actually a very wonderful restriction for you because Views are mostly supposed to be “stateless” (just drawing the Model all the time).
   * They don’t need any state of their own. So no need for them to be non-read-only! Mostly…

 + When do **Views** need **State?**
   * It turns out there are few rare times when a View needs some state.
   * Such storage is always temporary.
   * All permanent state belongs in your model.
 
 - Examples:
   * You’ve entered an “editing mode” and are collecting changes in preparation for an Intent.
   * You’ve displayed another View temporarily to gather information or notify the user.
   * You want an animation to kick off so you need to set that animation’s end point
 
 * @State
   * You must mark any vars used for this temporary state with **@state …**
   * `@state private var somethingTemporary: SomeType // Sometype can be any struct `
   * These are marked private because no one else can access them anyway
   * Changes to this @state var will *cause your View to rebuild its body!*
   * It’s sort of like an @ObservedObject but on a random piece of data instead of a ViewModel



 - How `@State` works
    * `@state private var somethingTemporary: SomeType`
    * This is actually going to make some space *in the heap* for this.
        * It has to do that because your View struct itself is read-only
    * When your read-only View gets rebuilt, the new version will continue to point to it. In other words, changes to your View (via its arguments) will not dump this state.
    * **Use @State sparingly:** @State is a "source of truth" so it had better not be something that belongs in your Model!
 */

//: [Next](@next)
