/*:
 # Layout
 - - - - - - - - - - - - - -
 
 * How is the space on-screen apportioned to the Views?
    1. Container Views "offer" space to the Views inside them
    2. Views then choose what size they want to be
    3. Container Views then position the Views inside of them
    4. (and based on that, Container Views choose their own size as per #2 above)
 
- - - - - - - - - -
*/
/*:
 ## `HStack` and `VStack`
 
 - Stacks are Combiner Views that divide up the space that is offered to them and then offer that to the Views inside. It offers space to its "least flexible" (with respect to sizing) subviews first...
 
 + Example of an "inflexible" View: `Image` (it wants to be a fixed size).
 + Another example (slightly more flexible): `Text` (always wants to size to exactly fit its text).
 + Example of a very flexible View: `RoundedRectangle` (always uses any space offered).
 
 - After an offered View(s) takes what it wants, __its size is removed from the space available.__
 - __Then the stack moves on to the next "least flexible" Views.__
 - Very flexible views (i.e., those that will take all offered space) will share evenly (mostly).
 - Rinse and repeat.
 
 + After the Views inside the stack choose their own sizes, the stack **sizes itself** to fit them.
 + If any of the Views in the stack are "very flexible", then the stack will also be "very flexible".
 */
/*:
There are a couple of really valuable Views for layout that are commonly put in stacks...
 1. `Spacer(minLength: CGFloat)`
    * Always takes all the space offered to it.
    * Draws nothing.
    * The minLength defaults to the most likely spacing you'd want on a given platform
 
 2. `Divider()`
    * Draws a dividing line cross-wise to the way the stack is laying out.
    * For example, in an `HStack`, `Divider` draws a vertical line.
    * Takes the minimum space needed to fit the line in the direction the stack is going.
 */
/*:
 Stack's choice of who to offer space to next can be overriden with `.layoutPriority(Double)`. In other words, `layoutPriority` trumps "least flexible".
 ```
 HStack {
    Text("Important").layoutPriority(100)   // any floating point number is okay
    Image(systemName: "arrow.up")           // the default layout priority is 0
    Text("Unimportant")
 }
 ```
 The Important Text will get the space it wants first. Then the Image would get its space (since it's less flexible that the Unimportant Text). Finally, Unimportant would have to try to fit itself into any remaining space.
 If a Text doesn't get enough space, it will elide (e.g., "Swift is..." instead of "Swift is great!").
 - - - - - - - - - - - - - -
 */
/*:
 ## `LazyHStack` and `LazyVStack`
 * These "lazy" versions of the stack are also combiner views but they **don't build any of their Views that are not visible**.
 * They also size themselves to fit their Views.
 * So they don't take up all the space offered to them even if they have flexible views inside. (e.g., in ScrollView space is infinity, so these lazy stacks have to limit themselves).
 * You'd use these when you have a stack that is in a ScrollView.
 
 - - - - - - - - - - - - - - - -
 
 ## `ScrollView`
 ScrollView takes all the space offered to it. The views inside it are sized to fit along the axis your scrolling on.
 
 - - - - - - - - - - - - - - - -
 
 ## `LazyHGrid` and `LazyVGrid`
 We've already seen how these lay out their Views.
 
 - - - - - - - - - - - - - - - -
 
 ## `List` and `Form` and `OutlineGroup`
 These are sort of like "really smart Vstacks". We'll visit them later.
 - - - - - - - - - - - - - - - -
 */
/*:
 ## `ZStack` and `.background` & `.overlay` modifiers
 - - - - - - - - - - - -
 * `ZStack`
    * ZStack sizes itself to fit its children
    * If even one of its children is fully flexible size, then the ZStack will be too.
 
 * .`background` modifier
    * `Text("Hello").background(Rectangle().foregroundColor(.red))`
    * This is similar to making a `ZStack` of this Text and Rectangle (with the Text in front).
    * However, there's a big difference in layout between this and using a `ZStack` to stack them.
    * In this case, the resultant View will be **sized to the Text** (the Rectangle is not involved).
    * In other words, the Text solely determines the layout of this "mini-ZStack of the two things".
 
 * `.overlay` modifier
    * Same layout rules as `.background`, but stacked the other way around.
    * `Circle().overlay(Text("Hello"), alignment: .center)`
    * This will be **sized to the Circle** (i.e., it will be fully-flexible sized).
    * The Text will be stacked on top of the Circle (With the specified alignment inside the Circle).
 - - - - - - - - - - - - - - - -
 */
/*:
 ## Modifiers
 - - - - - - - - - - - -
 - Remember that `View` modifier functions (like `.padding`) themselves return a `View`.
 - That `View`, conceptually anyway, "contains" the `View` it's modifying.
 
 + Many of them just pass the size offered to them along (like `.font` or `.foregroundColor`).
 + But it is possible for a modifier to be involved in the layout process itself.
 
 * For example the `View` returned by `.padding(10)` will offer the `View` that it is modifying a space that is the same size as it was offered, but reduced by 10 points on each side.
 * The `View` returned by `.padding(10)` would then choose a size for itself which is 10 points larger on all sides that the `View` it is modifying ended up choosing.
 
 - Another example is `.aspectRatio`
 - The `View` returned by the `.aspectRatio` modifier takes the space offered to it and picks a size for itself that is either smaller (`.fit`) to respect the ration or bigger (`.fill`) to use all the offered space (and more, potentially) and respect the ratio.
 - Yes! a `View` is allowed to choose a size for itself that is larger than the space it was offered!.
 - `.aspectRatio` then offers the space it chose to the `View` it is modifying (as its "container").
 
 
 ```
 HStack {   // aside: the default allignment here is .center (not .top, for example)
    ForEach(viewModel.cards) { card in
        CardView(card: Card).aspectRatio(2/3, contentMode: .fit)
    }
 }
    .foregroundColor(.orange)
    .padding(10)
 ```
 - The first View to be offered space here will be the View made by `.padding(10)` which will offer what is was offered minus 10 on all sides to the View from `.foregroundColor`
 - Which will in turn offer all of the space to the HStack
 - Which will then divide its space equally among the `.aspectRatio` Views in the ForEach.
 - Each `.aspectRatio` View will set its width to be its share of the HStack's width and pick a height for itself that respects the requested 2/3 aspect ratio.
 - Or it might be forced to take all of the offered height and choose its width using the ratio. (whichever fits).
 - The `.aspectRatio` then offers all of its chosen size to its CardView, which will use it all.
 - - - - - - - - - - - -
 */
/*:
### Views that take all the space offered to them
 + Most Views simply size themselves to take up all the space offered to them.
 + For example, Shapes usually draw themselves to fit (like RoundedRectangle).
 
 - Custom Views (like CardView) should do this too whenever sensible.
 - But they really should *adapt themselves* to any space offered to look as good as possible.
 - For example, CardView would want to pick a font size that makes its emoji fill the space.
 - - - - - - - - - - - - -

 + So how does a View know what space was offered to it so it can try to adapt?
 + Using a special View called a `GeometryReader`...
 
 ## GeometryReader
 
 You wrap this Geometry Reader View around what would normally appear your View's body
 ```
 var body: View {
    GeometryReader { geometry in        // using trailing closure syntax for content: parameter
        . . .
    }
 }
 ```
 
 The `geometry` parameter is a `GeometryProxy`
 ```
 struct GeometryProxy {
    var size: CGSize
    func frame(in: CoordinateSpace) -> CGRect
    var safeAreaInsets: EdgeInsets
 }
 ```
 
 The `size` var is the amount of space that is being "ofered" to us by our container. Now we can, for example, pick a font size appropriate to that sized space. GeometryReader itself (it's just a View) **always accepts all the space offered to it.**
 */
/*:
 ## Safe Area
 - - - - - - - - - - -
 * Generally, when a View is offered space, that space does not include "safe areas".
 * The most obvious "safe area" is the notch on an iPhone X, 11, 12
 * Surrounding Views might also introduce "safe areas" that Views inside shouldn't draw in.
 
 - But it is possible to ignore this and draw in those areas anyways on specified edges ...
 - `ZStack { ... }.edgesIgnoringSafeArea([.top])  // draw in 'safe area' on top edge`
 */
//: [Previous](@previous) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Next](@next)
